<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录 - 学生实习管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
<div class="login-wrapper">
    <div class="login-brand">
        <div class="login-brand-content">
            <div class="brand-icon">
                <i class="fas fa-graduation-cap"></i>
            </div>
            <h1>学生实习管理系统</h1>
            <p>高效管理学生实习全流程，助力人才培养</p>

            <div class="brand-features">
                <div class="brand-feature">
                    <i class="fas fa-users"></i>
                    <span>多角色管理 — 管理员、教师、学生三端协同</span>
                </div>
                <div class="brand-feature">
                    <i class="fas fa-chart-line"></i>
                    <span>数据分析 — 实习数据可视化，辅助决策</span>
                </div>
                <div class="brand-feature">
                    <i class="fas fa-shield-alt"></i>
                    <span>安全可靠 — 权限控制与数据加密保障</span>
                </div>
                <div class="brand-feature">
                    <i class="fas fa-tasks"></i>
                    <span>流程跟踪 — 任务分配、报告审核一站式管理</span>
                </div>
            </div>
        </div>
    </div>

    <div class="login-form-side">
        <div class="login-box">
            <h2>欢迎登录</h2>
            <p class="subtitle">请输入您的账号信息以继续</p>

            <c:if test="${not empty error}">
                <div class="error-msg">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/doLogin" method="post">
                <div class="form-group">
                    <label>用户名</label>
                    <input type="text" name="username" placeholder="请输入用户名" required autofocus>
                </div>
                <div class="form-group">
                    <label>密码</label>
                    <input type="password" name="password" placeholder="请输入密码" required>
                </div>
                <button type="submit" class="btn-login">
                    <span>登 录</span>
                </button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
