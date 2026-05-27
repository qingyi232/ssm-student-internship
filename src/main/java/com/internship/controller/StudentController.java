package com.internship.controller;

import com.github.pagehelper.PageInfo;
import com.internship.entity.*;
import com.internship.service.*;
import com.internship.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 学生控制器
 */
@Controller
@RequestMapping("/student")
public class StudentController {

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
     * 学生首页
     */
    @GetMapping("/index")
    public String index(HttpSession session, Model model) {
        Student student = (Student) session.getAttribute("loginStudent");
        if (student == null) {
            return "redirect:/login";
        }

        List<Internship> internships = internshipService.findByStudentId(student.getId());
        Internship currentInternship = null;
        if (internships != null && !internships.isEmpty()) {
            for (Internship i : internships) {
                if (i.getStatus() != null && i.getStatus() == 1) {
                    currentInternship = i;
                    break;
                }
            }
            if (currentInternship == null) {
                currentInternship = internships.get(0);
            }
        }

        int pendingTaskCount = 0;
        if (currentInternship != null) {
            List<InternshipTask> tasks = taskService.findByInternshipId(currentInternship.getId());
            if (tasks != null) {
                for (InternshipTask t : tasks) {
                    if (t.getStatus() != null && t.getStatus() != 2) {
                        pendingTaskCount++;
                    }
                }
            }
        }

        List<Announcement> announcements = announcementService.findByStatus(1);
        List<Announcement> latestAnnouncements = new ArrayList<>();
        if (announcements != null && announcements.size() > 5) {
            latestAnnouncements = announcements.subList(0, 5);
        } else if (announcements != null) {
            latestAnnouncements = announcements;
        }

        int reportCount = 0;
        if (currentInternship != null) {
            List<InternshipReport> reports = reportService.findByInternshipId(currentInternship.getId());
            if (reports != null) {
                reportCount = reports.size();
            }
        }

        model.addAttribute("internship", currentInternship);
        model.addAttribute("pendingTaskCount", pendingTaskCount);
        model.addAttribute("reportCount", reportCount);
        model.addAttribute("announcementList", latestAnnouncements);
        return "student/index";
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        Student student = (Student) session.getAttribute("loginStudent");
        if (student == null) {
            return "redirect:/login";
        }
        student = studentService.findById(student.getId());
        if (student != null) {
            session.setAttribute("loginStudent", student);
            model.addAttribute("student", student);
        }
        return "student/profile";
    }

    @PostMapping("/profile/update")
    public String profileUpdate(@ModelAttribute Student formStudent, HttpSession session) {
        Student loginStudent = (Student) session.getAttribute("loginStudent");
        if (loginStudent == null) {
            return "redirect:/login";
        }
        Student dbStudent = studentService.findById(loginStudent.getId());
        if (dbStudent == null) {
            return "redirect:/login";
        }
        dbStudent.setPhone(formStudent.getPhone());
        dbStudent.setEmail(formStudent.getEmail());
        dbStudent.setAddress(formStudent.getAddress());
        dbStudent.setUpdateTime(new Date());
        studentService.updateStudent(dbStudent);
        session.setAttribute("loginStudent", studentService.findById(dbStudent.getId()));
        return "redirect:/student/profile";
    }

    @GetMapping("/internship")
    public String internshipInfo(HttpSession session, Model model) {
        Student student = (Student) session.getAttribute("loginStudent");
        if (student == null) {
            return "redirect:/login";
        }

        List<Internship> internships = internshipService.findByStudentId(student.getId());
        Internship currentInternship = null;
        if (internships != null && !internships.isEmpty()) {
            for (Internship i : internships) {
                if (i.getStatus() != null && i.getStatus() == 1) {
                    currentInternship = i;
                    break;
                }
            }
            if (currentInternship == null) {
                currentInternship = internships.get(0);
            }
        }
        model.addAttribute("internship", currentInternship);
        model.addAttribute("internshipList", internships != null ? internships : new ArrayList<>());
        return "student/internship_info";
    }

    // ==================== 任务管理 ====================

    @GetMapping("/tasks")
    public String taskList(HttpSession session,
                           @RequestParam(defaultValue = "1") int pageNum,
                           @RequestParam(defaultValue = "10") int pageSize,
                           Model model) {
        Student student = (Student) session.getAttribute("loginStudent");
        if (student == null) {
            return "redirect:/login";
        }

        List<Internship> internships = internshipService.findByStudentId(student.getId());
        List<InternshipTask> allTasks = new ArrayList<>();
        Integer internshipId = null;
        if (internships != null && !internships.isEmpty()) {
            for (Internship i : internships) {
                List<InternshipTask> tasks = taskService.findByInternshipId(i.getId());
                if (tasks != null) {
                    allTasks.addAll(tasks);
                    if (internshipId == null && i.getStatus() != null && i.getStatus() == 1) {
                        internshipId = i.getId();
                    }
                }
            }
        }

        model.addAttribute("taskList", allTasks);
        return "student/task_list";
    }

    @PostMapping("/task/updateStatus")
    @ResponseBody
    public Result taskUpdateStatus(@RequestParam Integer taskId,
                                  @RequestParam Integer status,
                                  HttpSession session) {
        Student student = (Student) session.getAttribute("loginStudent");
        if (student == null) {
            return Result.error("请先登录");
        }

        InternshipTask task = taskService.findById(taskId);
        if (task == null) {
            return Result.error("任务不存在");
        }

        List<Internship> internships = internshipService.findByStudentId(student.getId());
        boolean hasAccess = false;
        if (internships != null) {
            for (Internship i : internships) {
                if (i.getId().equals(task.getInternshipId())) {
                    hasAccess = true;
                    break;
                }
            }
        }
        if (!hasAccess) {
            return Result.error("无权限操作此任务");
        }

        task.setStatus(status);
        task.setUpdateTime(new Date());
        if (taskService.updateTask(task)) {
            return Result.success();
        }
        return Result.error("更新失败");
    }

    // ==================== 报告管理 ====================

    @GetMapping("/reports")
    public String reportList(HttpSession session,
                             @RequestParam(defaultValue = "1") int pageNum,
                             @RequestParam(defaultValue = "10") int pageSize,
                             Model model) {
        Student student = (Student) session.getAttribute("loginStudent");
        if (student == null) {
            return "redirect:/login";
        }

        PageInfo<InternshipReport> pageInfo = reportService.findByStudentId(student.getId(), pageNum, pageSize);
        model.addAttribute("pageInfo", pageInfo);
        return "student/report_list";
    }

    @GetMapping("/report/add")
    public String reportAddForm(HttpSession session, Model model) {
        Student student = (Student) session.getAttribute("loginStudent");
        if (student == null) {
            return "redirect:/login";
        }
        List<Internship> internships = internshipService.findByStudentId(student.getId());
        model.addAttribute("internshipList", internships != null ? internships : new ArrayList<>());
        return "student/report_form";
    }

    @GetMapping("/report/edit/{id}")
    public String reportEditForm(@PathVariable Integer id, HttpSession session, Model model) {
        Student student = (Student) session.getAttribute("loginStudent");
        if (student == null) {
            return "redirect:/login";
        }

        InternshipReport report = reportService.findById(id);
        if (report == null || !report.getStudentId().equals(student.getId())) {
            return "redirect:/student/reports";
        }

        model.addAttribute("report", report);
        List<Internship> internships = internshipService.findByStudentId(student.getId());
        model.addAttribute("internshipList", internships != null ? internships : new ArrayList<>());
        return "student/report_form";
    }

    @PostMapping("/report/save")
    public String reportSave(@ModelAttribute InternshipReport report,
                             @RequestParam(required = false) MultipartFile attachment,
                             HttpSession session,
                             HttpServletRequest request) throws IOException {
        Student student = (Student) session.getAttribute("loginStudent");
        if (student == null) {
            return "redirect:/login";
        }

        report.setStudentId(student.getId());

        if (attachment != null && !attachment.isEmpty()) {
            String uploadPath = request.getServletContext().getRealPath("/upload/");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            String originalFilename = attachment.getOriginalFilename();
            String suffix = "";
            if (originalFilename != null && originalFilename.contains(".")) {
                suffix = originalFilename.substring(originalFilename.lastIndexOf("."));
            }
            String fileName = "report_" + System.currentTimeMillis() + suffix;
            File destFile = new File(uploadDir, fileName);
            attachment.transferTo(destFile);
            report.setFilePath("/upload/" + fileName);
        }

        if (report.getId() == null) {
            report.setStatus(0);
            report.setSubmitTime(new Date());
            report.setCreateTime(new Date());
            if (report.getInternshipId() == null && student != null) {
                List<Internship> internships = internshipService.findByStudentId(student.getId());
                if (internships != null && !internships.isEmpty()) {
                    report.setInternshipId(internships.get(0).getId());
                }
            }
            reportService.addReport(report);
        } else {
            InternshipReport existing = reportService.findById(report.getId());
            if (existing != null && existing.getStudentId().equals(student.getId())) {
                if (report.getFilePath() == null && existing.getFilePath() != null) {
                    report.setFilePath(existing.getFilePath());
                }
                reportService.updateReport(report);
            }
        }
        return "redirect:/student/reports";
    }

    @GetMapping("/report/detail/{id}")
    public String reportDetail(@PathVariable Integer id, HttpSession session, Model model) {
        Student student = (Student) session.getAttribute("loginStudent");
        if (student == null) {
            return "redirect:/login";
        }

        InternshipReport report = reportService.findById(id);
        if (report == null || !report.getStudentId().equals(student.getId())) {
            return "redirect:/student/reports";
        }

        model.addAttribute("report", report);
        return "student/report_detail";
    }

    // ==================== 日志管理 ====================

    @GetMapping("/logs")
    public String logList(HttpSession session,
                         @RequestParam(defaultValue = "1") int pageNum,
                         @RequestParam(defaultValue = "10") int pageSize,
                         Model model) {
        Student student = (Student) session.getAttribute("loginStudent");
        if (student == null) {
            return "redirect:/login";
        }

        PageInfo<InternshipLog> pageInfo = logService.findByStudentId(student.getId(), pageNum, pageSize);
        model.addAttribute("pageInfo", pageInfo);
        return "student/log_list";
    }

    @GetMapping("/log/add")
    public String logAddForm(HttpSession session, Model model) {
        Student student = (Student) session.getAttribute("loginStudent");
        if (student == null) {
            return "redirect:/login";
        }
        List<Internship> internships = internshipService.findByStudentId(student.getId());
        model.addAttribute("internshipList", internships != null ? internships : new ArrayList<>());
        return "student/log_form";
    }

    @GetMapping("/log/edit/{id}")
    public String logEditForm(@PathVariable Integer id, HttpSession session, Model model) {
        Student student = (Student) session.getAttribute("loginStudent");
        if (student == null) {
            return "redirect:/login";
        }

        InternshipLog log = logService.findById(id);
        if (log == null || !log.getStudentId().equals(student.getId())) {
            return "redirect:/student/logs";
        }

        model.addAttribute("log", log);
        List<Internship> internships = internshipService.findByStudentId(student.getId());
        model.addAttribute("internshipList", internships != null ? internships : new ArrayList<>());
        return "student/log_form";
    }

    @PostMapping("/log/save")
    public String logSave(@ModelAttribute InternshipLog log, HttpSession session) {
        Student student = (Student) session.getAttribute("loginStudent");
        if (student == null) {
            return "redirect:/login";
        }

        log.setStudentId(student.getId());
        if (log.getInternshipId() == null) {
            List<Internship> internships = internshipService.findByStudentId(student.getId());
            if (internships != null && !internships.isEmpty()) {
                log.setInternshipId(internships.get(0).getId());
            }
        }

        if (log.getId() == null) {
            log.setCreateTime(new Date());
            logService.addLog(log);
        } else {
            InternshipLog existing = logService.findById(log.getId());
            if (existing != null && existing.getStudentId().equals(student.getId())) {
                logService.updateLog(log);
            }
        }
        return "redirect:/student/logs";
    }

    @GetMapping("/log/delete/{id}")
    public String logDelete(@PathVariable Integer id, HttpSession session) {
        Student student = (Student) session.getAttribute("loginStudent");
        if (student != null) {
            InternshipLog log = logService.findById(id);
            if (log != null && log.getStudentId().equals(student.getId())) {
                logService.deleteLog(id);
            }
        }
        return "redirect:/student/logs";
    }

    // ==================== 公告 ====================

    @GetMapping("/announcements")
    public String announcementList(@RequestParam(defaultValue = "1") int pageNum,
                                  @RequestParam(defaultValue = "10") int pageSize,
                                  Model model) {
        PageInfo<Announcement> pageInfo = announcementService.findByStatus(1, pageNum, pageSize);
        model.addAttribute("pageInfo", pageInfo);
        return "student/announcement_list";
    }

    @GetMapping("/announcement/{id}")
    public String announcementDetail(@PathVariable Integer id, Model model) {
        Announcement announcement = announcementService.findById(id);
        if (announcement != null) {
            model.addAttribute("announcement", announcement);
        }
        return "student/announcement_detail";
    }
}
