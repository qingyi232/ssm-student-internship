package com.internship.controller;

import com.internship.entity.User;
import com.internship.service.UserService;
import com.internship.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * 密码修改控制器
 */
@Controller
public class PasswordController {

    @Autowired
    private UserService userService;

    /**
     * 修改密码页面
     */
    @GetMapping("/password")
    public String passwordPage() {
        return "common/password";
    }

    /**
     * 执行密码修改
     */
    @PostMapping("/password/update")
    @ResponseBody
    public Result updatePassword(@RequestParam String oldPassword,
                                 @RequestParam String newPassword,
                                 HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return Result.error("请先登录");
        }

        if (newPassword == null || newPassword.isEmpty()) {
            return Result.error("新密码不能为空");
        }

        boolean success = userService.updatePassword(loginUser.getId(), oldPassword, newPassword);
        if (success) {
            return Result.success("密码修改成功");
        } else {
            return Result.error("原密码错误");
        }
    }
}
