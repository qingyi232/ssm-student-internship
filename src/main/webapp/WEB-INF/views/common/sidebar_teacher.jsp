<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<div class="sidebar">
    <div class="sidebar-header">
        <div class="logo-icon"><i class="fas fa-graduation-cap"></i></div>
        <div>
            <h3>实习管理系统</h3>
            <p>教师工作台</p>
        </div>
    </div>
    <ul class="sidebar-menu">
        <li class="menu-label">概览</li>
        <li><a href="${ctx}/teacher/index"><i class="fas fa-th-large"></i>教师首页</a></li>

        <li class="menu-label">教学管理</li>
        <li><a href="${ctx}/teacher/students"><i class="fas fa-users"></i>学生列表</a></li>
        <li><a href="${ctx}/teacher/internships"><i class="fas fa-briefcase"></i>实习管理</a></li>

        <li class="menu-label">任务与审核</li>
        <li><a href="${ctx}/teacher/tasks"><i class="fas fa-clipboard-list"></i>任务管理</a></li>
        <li><a href="${ctx}/teacher/reports"><i class="fas fa-file-signature"></i>报告审核</a></li>

        <li class="menu-label">系统</li>
        <li><a href="${ctx}/password"><i class="fas fa-lock"></i>修改密码</a></li>
    </ul>
</div>
