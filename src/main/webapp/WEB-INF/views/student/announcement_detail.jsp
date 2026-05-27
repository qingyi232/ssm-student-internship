<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="公告详情"/>
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
<div class="portal-page">
    <%@ include file="/WEB-INF/views/common/nav_student.jsp"%>

    <div class="portal-body">
        <nav class="portal-breadcrumb">
            <a href="${ctx}/student/index">首页</a>
            <span>/</span>
            <a href="${ctx}/student/announcements">系统公告</a>
            <span>/</span>
            <span>公告详情</span>
        </nav>

        <div class="portal-card">
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty announcement}">
                        <div class="announcement-detail">
                            <h2>${announcement.title}</h2>
                            <div class="detail-meta">
                                <i class="fas fa-clock"></i>
                                <fmt:formatDate value="${announcement.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                                <c:if test="${not empty announcement.publisherName}"> · ${announcement.publisherName}</c:if>
                            </div>
                            <div class="detail-content">
                                ${announcement.content}
                            </div>
                        </div>
                        <div class="form-actions" style="margin-top: 24px; border-top: none; padding-top: 0;">
                            <a href="${ctx}/student/announcements" class="btn btn-default"><i class="fas fa-arrow-left"></i> 返回</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-bullhorn"></i>
                            <p>公告不存在</p>
                            <a href="${ctx}/student/announcements" class="btn btn-primary" style="margin-top: 16px;">返回公告列表</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="portal-footer">&copy; 2026 学生实习管理系统 · 工学部</div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</body>
</html>
