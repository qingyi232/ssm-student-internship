package com.internship.interceptor;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.internship.util.Result;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

/**
 * 登录拦截器
 */
public class LoginInterceptor implements org.springframework.web.servlet.HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();

        if (session != null && session.getAttribute("loginUser") != null) {
            return true;
        }

        boolean isAjax = "XMLHttpRequest".equalsIgnoreCase(request.getHeader("X-Requested-With"));

        if (isAjax) {
            response.setContentType("application/json;charset=UTF-8");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            Result result = Result.error("未登录或登录已过期，请重新登录");
            ObjectMapper mapper = new ObjectMapper();
            String json = mapper.writeValueAsString(result);
            try (PrintWriter writer = response.getWriter()) {
                writer.write(json);
                writer.flush();
            }
            return false;
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
    }
}
