<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="portal-nav">
    <a href="${ctx}/student/index" class="nav-brand">
        <div class="brand-dot"><i class="fas fa-graduation-cap"></i></div>
        <span>实习管理系统</span>
    </a>
    <ul class="nav-links">
        <li><a href="${ctx}/student/index" class="${pageTitle eq '学生首页' ? 'active' : ''}"><i class="fas fa-home"></i> 首页</a></li>
        <li><a href="${ctx}/student/profile" class="${pageTitle eq '个人信息' ? 'active' : ''}"><i class="fas fa-user"></i> 个人中心</a></li>
        <li><a href="${ctx}/student/internship" class="${pageTitle eq '实习信息' ? 'active' : ''}"><i class="fas fa-briefcase"></i> 实习信息</a></li>
        <li><a href="${ctx}/student/tasks" class="${pageTitle eq '实习任务' ? 'active' : ''}"><i class="fas fa-tasks"></i> 实习任务</a></li>
        <li><a href="${ctx}/student/reports" class="${pageTitle eq '实习报告' ? 'active' : ''}"><i class="fas fa-file-alt"></i> 实习报告</a></li>
        <li><a href="${ctx}/student/logs" class="${pageTitle eq '实习日志' ? 'active' : ''}"><i class="fas fa-pen-fancy"></i> 实习日志</a></li>
        <li><a href="${ctx}/student/announcements" class="${pageTitle eq '系统公告' ? 'active' : ''}"><i class="fas fa-bullhorn"></i> 公告</a></li>
    </ul>
    <div class="nav-user">
        <div class="user-tag">
            <div class="avatar"><i class="fas fa-user"></i></div>
            <span class="name">${sessionScope.loginUser.realName}</span>
        </div>
        <a href="${ctx}/logout" class="btn-logout-sm"><i class="fas fa-sign-out-alt"></i> 退出</a>
    </div>
</nav>
