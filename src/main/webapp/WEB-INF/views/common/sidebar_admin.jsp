<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<div class="sidebar">
    <div class="sidebar-header">
        <div class="logo-icon"><i class="fas fa-graduation-cap"></i></div>
        <div>
            <h3>实习管理系统</h3>
            <p>管理员控制台</p>
        </div>
    </div>
    <ul class="sidebar-menu">
        <li class="menu-label">概览</li>
        <li><a href="${ctx}/admin/index"><i class="fas fa-th-large"></i>系统首页</a></li>

        <li class="menu-label">信息管理</li>
        <li><a href="${ctx}/admin/students"><i class="fas fa-user-graduate"></i>学生管理</a></li>
        <li><a href="${ctx}/admin/teachers"><i class="fas fa-chalkboard-teacher"></i>教师管理</a></li>
        <li><a href="${ctx}/admin/companies"><i class="fas fa-building"></i>实习单位</a></li>

        <li class="menu-label">业务管理</li>
        <li><a href="${ctx}/admin/internships"><i class="fas fa-briefcase"></i>实习管理</a></li>
        <li><a href="${ctx}/admin/announcements"><i class="fas fa-bullhorn"></i>公告管理</a></li>

        <li class="menu-label">数据分析</li>
        <li><a href="${ctx}/admin/statistics"><i class="fas fa-chart-pie"></i>数据统计</a></li>

        <li class="menu-label">系统</li>
        <li><a href="${ctx}/password"><i class="fas fa-lock"></i>修改密码</a></li>
    </ul>
</div>
