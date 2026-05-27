<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<div class="sidebar">
    <div class="sidebar-header">
        <div class="logo-icon"><i class="fas fa-graduation-cap"></i></div>
        <div>
            <h3>实习管理系统</h3>
            <p>学生中心</p>
        </div>
    </div>
    <ul class="sidebar-menu">
        <li class="menu-label">概览</li>
        <li><a href="${ctx}/student/index"><i class="fas fa-th-large"></i>学生首页</a></li>

        <li class="menu-label">个人中心</li>
        <li><a href="${ctx}/student/profile"><i class="fas fa-id-card"></i>个人信息</a></li>
        <li><a href="${ctx}/student/internship"><i class="fas fa-briefcase"></i>实习信息</a></li>

        <li class="menu-label">实习工作</li>
        <li><a href="${ctx}/student/tasks"><i class="fas fa-clipboard-list"></i>实习任务</a></li>
        <li><a href="${ctx}/student/reports"><i class="fas fa-file-signature"></i>实习报告</a></li>
        <li><a href="${ctx}/student/logs"><i class="fas fa-pen-fancy"></i>实习日志</a></li>

        <li class="menu-label">信息</li>
        <li><a href="${ctx}/student/announcements"><i class="fas fa-bell"></i>系统公告</a></li>

        <li class="menu-label">系统</li>
        <li><a href="${ctx}/password"><i class="fas fa-lock"></i>修改密码</a></li>
    </ul>
</div>
