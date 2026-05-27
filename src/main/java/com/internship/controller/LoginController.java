package com.internship.controller;

import com.internship.entity.Student;
import com.internship.entity.Teacher;
import com.internship.entity.User;
import com.internship.service.StudentService;
import com.internship.service.TeacherService;
import com.internship.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 * 登录控制器
 */
@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private TeacherService teacherService;

    /**
     * 登录页面
     */
    @GetMapping("/login")
    public String login() {
        return "login";
    }

    /**
     * 执行登录
     */
    @PostMapping("/doLogin")
    public String doLogin(@RequestParam String username,
                          @RequestParam String password,
                          HttpSession session,
                          Model model) {
        User user = userService.login(username, password);
        if (user == null) {
            model.addAttribute("error", "用户名或密码错误");
            return "login";
        }

        session.setAttribute("loginUser", user);

        // 根据角色查询并存储角色相关信息
        if (user.getRole() != null) {
            if (user.getRole() == 3) {
                // 学生：查询学生信息
                Student student = studentService.findByUserId(user.getId());
                if (student != null) {
                    session.setAttribute("loginStudent", student);
                }
            } else if (user.getRole() == 2) {
                // 教师：查询教师信息
                Teacher teacher = teacherService.findByUserId(user.getId());
                if (teacher != null) {
                    session.setAttribute("loginTeacher", teacher);
                }
            }
        }

        // 根据角色重定向
        if (user.getRole() != null) {
            switch (user.getRole()) {
                case 1:
                    return "redirect:/admin/index";
                case 2:
                    return "redirect:/teacher/index";
                case 3:
                    return "redirect:/student/index";
                default:
                    return "redirect:/login";
            }
        }

        return "redirect:/login";
    }

    /**
     * 退出登录
     */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
