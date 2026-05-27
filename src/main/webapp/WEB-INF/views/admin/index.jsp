<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="系统首页"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - 学生实习管理系统</title>
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
<div class="main-wrapper">
    <%@ include file="/WEB-INF/views/common/sidebar_admin.jsp"%>
    <div class="main-content">
        <%@ include file="/WEB-INF/views/common/header.jsp"%>
        <div class="content-wrapper">
            <div class="welcome-msg">
                <h2>您好，${sessionScope.loginUser.realName}</h2>
                <p>欢迎回到学生实习管理系统，以下是系统运行概况</p>
            </div>

            <div class="stat-cards">
                <div class="stat-card">
                    <div class="stat-icon bg-blue"><i class="fas fa-user-graduate"></i></div>
                    <div class="stat-info">
                        <h4>学生总数</h4>
                        <div class="stat-number">${studentCount}</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon bg-purple"><i class="fas fa-chalkboard-teacher"></i></div>
                    <div class="stat-info">
                        <h4>教师总数</h4>
                        <div class="stat-number">${teacherCount}</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon bg-cyan"><i class="fas fa-building"></i></div>
                    <div class="stat-info">
                        <h4>实习单位</h4>
                        <div class="stat-number">${companyCount}</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon bg-green"><i class="fas fa-briefcase"></i></div>
                    <div class="stat-info">
                        <h4>实习总数</h4>
                        <div class="stat-number">${internshipCount}</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon bg-orange"><i class="fas fa-hourglass-half"></i></div>
                    <div class="stat-info">
                        <h4>待审核</h4>
                        <div class="stat-number">${pendingCount}</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon bg-blue"><i class="fas fa-spinner"></i></div>
                    <div class="stat-info">
                        <h4>进行中</h4>
                        <div class="stat-number">${ongoingCount}</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon bg-green"><i class="fas fa-check-circle"></i></div>
                    <div class="stat-info">
                        <h4>已完成</h4>
                        <div class="stat-number">${completedCount}</div>
                    </div>
                </div>
            </div>

            <div class="panel">
                <div class="panel-header">
                    <h3><i class="fas fa-bullhorn"></i> 最近公告</h3>
                    <a href="${ctx}/admin/announcements" class="btn btn-default btn-sm">查看全部 <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="panel-body">
                    <c:choose>
                        <c:when test="${not empty recentAnnouncements}">
                            <ul class="announcement-list">
                                <c:forEach items="${recentAnnouncements}" var="a">
                                    <li>
                                        <a href="${ctx}/admin/announcement/edit/${a.id}">
                                            <span class="ann-title">${a.title}</span>
                                            <span class="ann-date"><fmt:formatDate value="${a.createTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-inbox"></i>
                                <p>暂无公告</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js"></script>
</body>
</html>
