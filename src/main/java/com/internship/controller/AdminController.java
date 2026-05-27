package com.internship.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageInfo;
import com.internship.entity.*;
import com.internship.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * 管理员控制器
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private StudentService studentService;
    @Autowired
    private TeacherService teacherService;
    @Autowired
    private CompanyService companyService;
    @Autowired
    private InternshipService internshipService;
    @Autowired
    private AnnouncementService announcementService;
    @Autowired
    private UserService userService;

    /**
     * 管理员首页
     */
    @GetMapping("/index")
    public String index(Model model) {
        int studentCount = studentService.count();
        int teacherCount = teacherService.count();
        int companyCount = companyService.count();
        int internshipCount = internshipService.count();
        int pendingCount = internshipService.countByStatus(0);
        int ongoingCount = internshipService.countByStatus(1);
        int completedCount = internshipService.countByStatus(2);

        model.addAttribute("studentCount", studentCount);
        model.addAttribute("teacherCount", teacherCount);
        model.addAttribute("companyCount", companyCount);
        model.addAttribute("internshipCount", internshipCount);
        model.addAttribute("pendingCount", pendingCount);
        model.addAttribute("ongoingCount", ongoingCount);
        model.addAttribute("completedCount", completedCount);

        List<Announcement> recentAnnouncements = announcementService.findByStatus(1);
        if (recentAnnouncements != null && recentAnnouncements.size() > 5) {
            recentAnnouncements = recentAnnouncements.subList(0, 5);
        }
        model.addAttribute("recentAnnouncements", recentAnnouncements != null ? recentAnnouncements : new ArrayList<>());

        return "admin/index";
    }

    // ==================== 学生管理 ====================

    @GetMapping("/students")
    public String studentList(@RequestParam(defaultValue = "1") int pageNum,
                             @RequestParam(defaultValue = "10") int pageSize,
                             @RequestParam(required = false) String name,
                             @RequestParam(required = false) String studentNo,
                             @RequestParam(required = false) String major,
                             Model model) {
        PageInfo<Student> pageInfo = studentService.findByCondition(name, studentNo, major, pageNum, pageSize);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("name", name);
        model.addAttribute("studentNo", studentNo);
        model.addAttribute("major", major);
        return "admin/student_list";
    }

    @GetMapping("/student/add")
    public String studentAddForm(Model model) {
        return "admin/student_form";
    }

    @GetMapping("/student/edit/{id}")
    public String studentEditForm(@PathVariable Integer id, Model model) {
        Student student = studentService.findById(id);
        if (student != null) {
            model.addAttribute("student", student);
        }
        return "admin/student_form";
    }

    @PostMapping("/student/save")
    public String studentSave(@ModelAttribute Student student,
                             @RequestParam(required = false) String username,
                             @RequestParam(required = false) String realName,
                             @RequestParam(required = false) String phone,
                             @RequestParam(required = false) String email) {
        if (student.getId() == null) {
            User user = new User();
            user.setUsername(username);
            user.setPassword("123456");
            user.setRealName(realName != null ? realName : student.getName());
            user.setRole(3);
            user.setPhone(phone);
            user.setEmail(email);
            user.setStatus(1);
            user.setCreateTime(new Date());
            user.setUpdateTime(new Date());
            userService.addUser(user);
            student.setUserId(user.getId());
            student.setCreateTime(new Date());
            student.setUpdateTime(new Date());
            studentService.addStudent(student);
        } else {
            student.setUpdateTime(new Date());
            studentService.updateStudent(student);
        }
        return "redirect:/admin/students";
    }

    @GetMapping("/student/delete/{id}")
    public String studentDelete(@PathVariable Integer id) {
        Student student = studentService.findById(id);
        if (student != null && student.getUserId() != null) {
            studentService.deleteStudent(id);
            userService.deleteUser(student.getUserId());
        }
        return "redirect:/admin/students";
    }

    // ==================== 教师管理 ====================

    @GetMapping("/teachers")
    public String teacherList(@RequestParam(defaultValue = "1") int pageNum,
                             @RequestParam(defaultValue = "10") int pageSize,
                             @RequestParam(required = false) String name,
                             @RequestParam(required = false) String teacherNo,
                             Model model) {
        PageInfo<Teacher> pageInfo = teacherService.findByCondition(name, teacherNo, pageNum, pageSize);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("name", name);
        model.addAttribute("teacherNo", teacherNo);
        return "admin/teacher_list";
    }

    @GetMapping("/teacher/add")
    public String teacherAddForm(Model model) {
        return "admin/teacher_form";
    }

    @GetMapping("/teacher/edit/{id}")
    public String teacherEditForm(@PathVariable Integer id, Model model) {
        Teacher teacher = teacherService.findById(id);
        if (teacher != null) {
            model.addAttribute("teacher", teacher);
        }
        return "admin/teacher_form";
    }

    @PostMapping("/teacher/save")
    public String teacherSave(@ModelAttribute Teacher teacher,
                             @RequestParam(required = false) String username,
                             @RequestParam(required = false) String realName,
                             @RequestParam(required = false) String phone,
                             @RequestParam(required = false) String email) {
        if (teacher.getId() == null) {
            User user = new User();
            user.setUsername(username);
            user.setPassword("123456");
            user.setRealName(realName != null ? realName : teacher.getName());
            user.setRole(2);
            user.setPhone(phone);
            user.setEmail(email);
            user.setStatus(1);
            user.setCreateTime(new Date());
            user.setUpdateTime(new Date());
            userService.addUser(user);
            teacher.setUserId(user.getId());
            teacher.setCreateTime(new Date());
            teacher.setUpdateTime(new Date());
            teacherService.addTeacher(teacher);
        } else {
            teacher.setUpdateTime(new Date());
            teacherService.updateTeacher(teacher);
        }
        return "redirect:/admin/teachers";
    }

    @GetMapping("/teacher/delete/{id}")
    public String teacherDelete(@PathVariable Integer id) {
        Teacher teacher = teacherService.findById(id);
        if (teacher != null && teacher.getUserId() != null) {
            teacherService.deleteTeacher(id);
            userService.deleteUser(teacher.getUserId());
        }
        return "redirect:/admin/teachers";
    }

    // ==================== 企业管理 ====================

    @GetMapping("/companies")
    public String companyList(@RequestParam(defaultValue = "1") int pageNum,
                             @RequestParam(defaultValue = "10") int pageSize,
                             @RequestParam(required = false) String name,
                             @RequestParam(required = false) Integer status,
                             Model model) {
        PageInfo<Company> pageInfo = companyService.findByCondition(name, status, pageNum, pageSize);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("name", name);
        model.addAttribute("status", status);
        return "admin/company_list";
    }

    @GetMapping("/company/add")
    public String companyAddForm() {
        return "admin/company_form";
    }

    @GetMapping("/company/edit/{id}")
    public String companyEditForm(@PathVariable Integer id, Model model) {
        Company company = companyService.findById(id);
        if (company != null) {
            model.addAttribute("company", company);
        }
        return "admin/company_form";
    }

    @PostMapping("/company/save")
    public String companySave(@ModelAttribute Company company) {
        if (company.getId() == null) {
            company.setCreateTime(new Date());
            company.setUpdateTime(new Date());
            companyService.addCompany(company);
        } else {
            company.setUpdateTime(new Date());
            companyService.updateCompany(company);
        }
        return "redirect:/admin/companies";
    }

    @GetMapping("/company/delete/{id}")
    public String companyDelete(@PathVariable Integer id) {
        companyService.deleteCompany(id);
        return "redirect:/admin/companies";
    }

    // ==================== 实习管理 ====================

    @GetMapping("/internships")
    public String internshipList(@RequestParam(defaultValue = "1") int pageNum,
                                @RequestParam(defaultValue = "10") int pageSize,
                                @RequestParam(required = false) String studentName,
                                @RequestParam(required = false) String companyName,
                                @RequestParam(required = false) Integer status,
                                Model model) {
        PageInfo<Internship> pageInfo = internshipService.findByCondition(studentName, companyName, status, pageNum, pageSize);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("studentName", studentName);
        model.addAttribute("companyName", companyName);
        model.addAttribute("status", status);
        return "admin/internship_list";
    }

    @GetMapping("/internship/add")
    public String internshipAddForm(Model model) {
        model.addAttribute("studentList", studentService.findAll());
        model.addAttribute("companyList", companyService.findAll());
        model.addAttribute("teacherList", teacherService.findAll());
        return "admin/internship_form";
    }

    @GetMapping("/internship/edit/{id}")
    public String internshipEditForm(@PathVariable Integer id, Model model) {
        Internship internship = internshipService.findById(id);
        if (internship != null) {
            model.addAttribute("internship", internship);
        }
        model.addAttribute("studentList", studentService.findAll());
        model.addAttribute("companyList", companyService.findAll());
        model.addAttribute("teacherList", teacherService.findAll());
        return "admin/internship_form";
    }

    @PostMapping("/internship/save")
    public String internshipSave(@ModelAttribute Internship internship) {
        if (internship.getId() == null) {
            internship.setCreateTime(new Date());
            internship.setUpdateTime(new Date());
            internshipService.addInternship(internship);
        } else {
            internship.setUpdateTime(new Date());
            internshipService.updateInternship(internship);
        }
        return "redirect:/admin/internships";
    }

    @GetMapping("/internship/delete/{id}")
    public String internshipDelete(@PathVariable Integer id) {
        internshipService.deleteInternship(id);
        return "redirect:/admin/internships";
    }

    @PostMapping("/internship/approve/{id}")
    public String internshipApprove(@PathVariable Integer id) {
        Internship internship = internshipService.findById(id);
        if (internship != null) {
            internship.setStatus(1);
            internship.setUpdateTime(new Date());
            internshipService.updateInternship(internship);
        }
        return "redirect:/admin/internships";
    }

    // ==================== 公告管理 ====================

    @GetMapping("/announcements")
    public String announcementList(@RequestParam(defaultValue = "1") int pageNum,
                                   @RequestParam(defaultValue = "10") int pageSize,
                                   Model model) {
        PageInfo<Announcement> pageInfo = announcementService.findAll(pageNum, pageSize);
        model.addAttribute("pageInfo", pageInfo);
        return "admin/announcement_list";
    }

    @GetMapping("/announcement/add")
    public String announcementAddForm() {
        return "admin/announcement_form";
    }

    @GetMapping("/announcement/edit/{id}")
    public String announcementEditForm(@PathVariable Integer id, Model model) {
        Announcement announcement = announcementService.findById(id);
        if (announcement != null) {
            model.addAttribute("announcement", announcement);
        }
        return "admin/announcement_form";
    }

    @PostMapping("/announcement/save")
    public String announcementSave(@ModelAttribute Announcement announcement, HttpSession session) {
        if (announcement.getId() == null) {
            User user = (User) session.getAttribute("loginUser");
            if (user != null) {
                announcement.setPublisherId(user.getId());
            }
            announcement.setCreateTime(new Date());
            announcement.setUpdateTime(new Date());
            announcementService.addAnnouncement(announcement);
        } else {
            announcement.setUpdateTime(new Date());
            announcementService.updateAnnouncement(announcement);
        }
        return "redirect:/admin/announcements";
    }

    @GetMapping("/announcement/delete/{id}")
    public String announcementDelete(@PathVariable Integer id) {
        announcementService.deleteAnnouncement(id);
        return "redirect:/admin/announcements";
    }

    // ==================== 统计 ====================

    @GetMapping("/statistics")
    public String statistics(Model model) {
        model.addAttribute("studentCount", studentService.count());
        model.addAttribute("teacherCount", teacherService.count());
        model.addAttribute("companyCount", companyService.count());
        model.addAttribute("internshipCount", internshipService.count());
        model.addAttribute("pendingCount", internshipService.countByStatus(0));
        model.addAttribute("ongoingCount", internshipService.countByStatus(1));
        model.addAttribute("completedCount", internshipService.countByStatus(2));
        return "admin/statistics";
    }

    @GetMapping("/statistics/data")
    @ResponseBody
    public String statisticsData() throws JsonProcessingException {
        Map<String, Object> data = new HashMap<>();
        Map<String, Integer> statusDist = new LinkedHashMap<>();
        statusDist.put("待审核", internshipService.countByStatus(0));
        statusDist.put("进行中", internshipService.countByStatus(1));
        statusDist.put("已完成", internshipService.countByStatus(2));
        data.put("internshipStatus", statusDist);

        List<Student> students = studentService.findAll();
        Map<String, Integer> majorDist = new LinkedHashMap<>();
        if (students != null) {
            for (Student s : students) {
                String major = (s.getMajor() != null && !s.getMajor().isEmpty()) ? s.getMajor() : "未设置";
                majorDist.merge(major, 1, Integer::sum);
            }
        }
        data.put("studentByMajor", majorDist);

        ObjectMapper mapper = new ObjectMapper();
        return mapper.writeValueAsString(data);
    }
}
