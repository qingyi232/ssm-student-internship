package com.internship.controller;

import com.internship.entity.*;
import com.internship.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 教师控制器
 */
@Controller
@RequestMapping("/teacher")
public class TeacherController {

    @Autowired
    private TeacherService teacherService;
    @Autowired
    private StudentService studentService;
    @Autowired
    private InternshipService internshipService;
    @Autowired
    private TaskService taskService;
    @Autowired
    private ReportService reportService;
    @Autowired
    private LogService logService;
    @Autowired
    private AnnouncementService announcementService;

    /**
     * 教师首页
     */
    @GetMapping("/index")
    public String index(HttpSession session, Model model) {
        Teacher teacher = (Teacher) session.getAttribute("loginTeacher");
        if (teacher == null) {
            return "redirect:/login";
        }

        List<Internship> internships = internshipService.findByTeacherId(teacher.getId());
        int internshipCount = internships != null ? internships.size() : 0;

        List<Integer> studentIds = new ArrayList<>();
        if (internships != null) {
            for (Internship i : internships) {
                if (i.getStudentId() != null && !studentIds.contains(i.getStudentId())) {
                    studentIds.add(i.getStudentId());
                }
            }
        }
        int studentCount = studentIds.size();

        int pendingReportCount = 0;
        if (internships != null) {
            for (Internship i : internships) {
                List<InternshipReport> reports = reportService.findByInternshipId(i.getId());
                if (reports != null) {
                    for (InternshipReport r : reports) {
                        if (r.getStatus() != null && r.getStatus() == 0) {
                            pendingReportCount++;
                        }
                    }
                }
            }
        }

        List<Announcement> announcements = announcementService.findByStatus(1);
        if (announcements != null && announcements.size() > 5) {
            announcements = announcements.subList(0, 5);
        }

        model.addAttribute("studentCount", studentCount);
        model.addAttribute("internshipCount", internshipCount);
        model.addAttribute("pendingReportCount", pendingReportCount);
        model.addAttribute("announcementList", announcements != null ? announcements : new ArrayList<>());
        return "teacher/index";
    }

    /**
     * 指导的学生列表
     */
    @GetMapping("/students")
    public String studentList(HttpSession session, Model model) {
        Teacher teacher = (Teacher) session.getAttribute("loginTeacher");
        if (teacher == null) {
            return "redirect:/login";
        }

        List<Internship> internships = internshipService.findByTeacherId(teacher.getId());
        model.addAttribute("internshipList", internships != null ? internships : new ArrayList<>());
        return "teacher/student_list";
    }

    /**
     * 实习列表
     */
    @GetMapping("/internships")
    public String internshipList(HttpSession session, Model model) {
        Teacher teacher = (Teacher) session.getAttribute("loginTeacher");
        if (teacher == null) {
            return "redirect:/login";
        }

        List<Internship> internships = internshipService.findByTeacherId(teacher.getId());
        model.addAttribute("internshipList", internships != null ? internships : new ArrayList<>());
        return "teacher/internship_list";
    }

    /**
     * 实习详情
     */
    @GetMapping("/internship/detail/{id}")
    public String internshipDetail(@PathVariable Integer id, HttpSession session, Model model) {
        Teacher teacher = (Teacher) session.getAttribute("loginTeacher");
        if (teacher == null) {
            return "redirect:/login";
        }

        Internship internship = internshipService.findById(id);
        if (internship == null || !teacher.getId().equals(internship.getTeacherId())) {
            return "redirect:/teacher/internships";
        }

        List<InternshipTask> tasks = taskService.findByInternshipId(id);
        List<InternshipReport> reports = reportService.findByInternshipId(id);
        List<InternshipLog> logs = logService.findByInternshipId(id);

        model.addAttribute("internship", internship);
        model.addAttribute("taskList", tasks != null ? tasks : new ArrayList<>());
        model.addAttribute("reportList", reports != null ? reports : new ArrayList<>());
        model.addAttribute("logList", logs != null ? logs : new ArrayList<>());
        return "teacher/internship_detail";
    }

    /**
     * 任务列表
     */
    @GetMapping("/tasks")
    public String taskList(HttpSession session, Model model) {
        Teacher teacher = (Teacher) session.getAttribute("loginTeacher");
        if (teacher == null) {
            return "redirect:/login";
        }

        List<Internship> internships = internshipService.findByTeacherId(teacher.getId());
        List<InternshipTask> allTasks = new ArrayList<>();
        if (internships != null) {
            for (Internship i : internships) {
                List<InternshipTask> tasks = taskService.findByInternshipId(i.getId());
                if (tasks != null) {
                    for (InternshipTask t : tasks) {
                        String label = (i.getStudentName() != null ? i.getStudentName() : "") +
                                " - " + (i.getCompanyName() != null ? i.getCompanyName() : "");
                        t.setInternshipLabel(label);
                        allTasks.add(t);
                    }
                }
            }
        }

        model.addAttribute("taskList", allTasks);
        model.addAttribute("internshipList", internships != null ? internships : new ArrayList<>());
        return "teacher/task_list";
    }

    @GetMapping("/task/add")
    public String taskAddForm(HttpSession session, Model model) {
        Teacher teacher = (Teacher) session.getAttribute("loginTeacher");
        if (teacher == null) {
            return "redirect:/login";
        }
        model.addAttribute("internshipList", internshipService.findByTeacherId(teacher.getId()));
        return "teacher/task_form";
    }

    @GetMapping("/task/edit/{id}")
    public String taskEditForm(@PathVariable Integer id, HttpSession session, Model model) {
        Teacher teacher = (Teacher) session.getAttribute("loginTeacher");
        if (teacher == null) {
            return "redirect:/login";
        }

        InternshipTask task = taskService.findById(id);
        if (task == null) {
            return "redirect:/teacher/tasks";
        }
        Internship internship = internshipService.findById(task.getInternshipId());
        if (internship == null || !teacher.getId().equals(internship.getTeacherId())) {
            return "redirect:/teacher/tasks";
        }

        model.addAttribute("task", task);
        model.addAttribute("internshipList", internshipService.findByTeacherId(teacher.getId()));
        return "teacher/task_form";
    }

    @PostMapping("/task/save")
    public String taskSave(@ModelAttribute InternshipTask task, HttpSession session) {
        Teacher teacher = (Teacher) session.getAttribute("loginTeacher");
        if (teacher == null) {
            return "redirect:/login";
        }
        Internship internship = internshipService.findById(task.getInternshipId());
        if (internship == null || !teacher.getId().equals(internship.getTeacherId())) {
            return "redirect:/teacher/tasks";
        }
        if (task.getId() == null) {
            task.setCreateTime(new Date());
            task.setUpdateTime(new Date());
            if (task.getStatus() == null) {
                task.setStatus(0);
            }
            taskService.addTask(task);
        } else {
            task.setUpdateTime(new Date());
            taskService.updateTask(task);
        }
        return "redirect:/teacher/tasks";
    }

    @GetMapping("/task/delete/{id}")
    public String taskDelete(@PathVariable Integer id, HttpSession session) {
        Teacher teacher = (Teacher) session.getAttribute("loginTeacher");
        if (teacher != null) {
            InternshipTask task = taskService.findById(id);
            if (task != null) {
                Internship internship = internshipService.findById(task.getInternshipId());
                if (internship != null && teacher.getId().equals(internship.getTeacherId())) {
                    taskService.deleteTask(id);
                }
            }
        }
        return "redirect:/teacher/tasks";
    }

    /**
     * 报告列表
     */
    @GetMapping("/reports")
    public String reportList(HttpSession session, Model model) {
        Teacher teacher = (Teacher) session.getAttribute("loginTeacher");
        if (teacher == null) {
            return "redirect:/login";
        }

        List<Internship> internships = internshipService.findByTeacherId(teacher.getId());
        List<InternshipReport> allReports = new ArrayList<>();
        if (internships != null) {
            for (Internship i : internships) {
                List<InternshipReport> reports = reportService.findByInternshipId(i.getId());
                if (reports != null) {
                    allReports.addAll(reports);
                }
            }
        }

        model.addAttribute("reportList", allReports);
        return "teacher/report_list";
    }

    @GetMapping("/report/detail/{id}")
    public String reportDetail(@PathVariable Integer id, HttpSession session, Model model) {
        Teacher teacher = (Teacher) session.getAttribute("loginTeacher");
        if (teacher == null) {
            return "redirect:/login";
        }

        InternshipReport report = reportService.findById(id);
        if (report == null) {
            return "redirect:/teacher/reports";
        }
        Internship internship = internshipService.findById(report.getInternshipId());
        if (internship == null || !teacher.getId().equals(internship.getTeacherId())) {
            return "redirect:/teacher/reports";
        }

        model.addAttribute("report", report);
        return "teacher/report_detail";
    }

    @PostMapping("/report/review")
    public String reportReview(@RequestParam Integer id,
                              @RequestParam Integer status,
                              @RequestParam(required = false) String feedback,
                              @RequestParam(required = false) Integer score,
                              HttpSession session) {
        Teacher teacher = (Teacher) session.getAttribute("loginTeacher");
        if (teacher == null) {
            return "redirect:/login";
        }

        InternshipReport report = reportService.findById(id);
        if (report != null) {
            Internship internship = internshipService.findById(report.getInternshipId());
            if (internship != null && teacher.getId().equals(internship.getTeacherId())) {
                reportService.reviewReport(id, status, feedback, score);
            }
        }
        return "redirect:/teacher/reports";
    }
}
