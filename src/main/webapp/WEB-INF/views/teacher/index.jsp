<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="教师首页"/>
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
    <%@ include file="/WEB-INF/views/common/sidebar_teacher.jsp"%>
    <div class="main-content">
        <%@ include file="/WEB-INF/views/common/header.jsp"%>
        <div class="content-wrapper">
            <div class="stat-cards">
                <div class="stat-card">
                    <div class="stat-icon bg-blue"><i class="fas fa-user-graduate"></i></div>
                    <div class="stat-info">
                        <h4>指导学生数</h4>
                        <div class="stat-number">${studentCount}</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon bg-cyan"><i class="fas fa-briefcase"></i></div>
                    <div class="stat-info">
                        <h4>实习记录</h4>
                        <div class="stat-number">${internshipCount}</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon bg-orange"><i class="fas fa-file-alt"></i></div>
                    <div class="stat-info">
                        <h4>待审报告</h4>
                        <div class="stat-number">${pendingReportCount}</div>
                    </div>
                </div>
            </div>

            <div class="panel">
                <div class="panel-header">
                    <h3><i class="fas fa-bullhorn"></i> 最近公告</h3>
                </div>
                <div class="panel-body">
                    <c:choose>
                        <c:when test="${not empty announcementList}">
                            <ul class="announcement-list">
                                <c:forEach items="${announcementList}" var="a">
                                    <li>
                                        <span class="ann-title">${a.title}</span>
                                        <span class="ann-date"><fmt:formatDate value="${a.createTime}" pattern="yyyy-MM-dd HH:mm"/></span>
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
