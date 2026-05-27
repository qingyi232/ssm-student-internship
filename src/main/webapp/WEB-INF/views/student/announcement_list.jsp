<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="系统公告"/>
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
            <span>系统公告</span>
        </nav>

        <div class="portal-card">
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty pageInfo.list}">
                        <div class="announcement-cards">
                            <c:forEach items="${pageInfo.list}" var="ann">
                                <a href="${ctx}/student/announcement/${ann.id}" class="announcement-card">
                                    <h4>${ann.title}</h4>
                                    <div class="ann-meta">
                                        <fmt:formatDate value="${ann.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                                        <c:if test="${not empty ann.publisherName}"> · ${ann.publisherName}</c:if>
                                    </div>
                                    <div class="ann-preview">
                                        <c:choose>
                                            <c:when test="${not empty ann.content && fn:length(ann.content) > 100}">${fn:substring(ann.content, 0, 100)}...</c:when>
                                            <c:otherwise>${ann.content}</c:otherwise>
                                        </c:choose>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>

                        <c:if test="${pageInfo.pages > 0}">
                            <div class="pagination">
                                <c:set var="baseUrl" value="${ctx}/student/announcements"/>
                                <c:choose>
                                    <c:when test="${pageInfo.isFirstPage}">
                                        <span class="disabled">上一页</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${baseUrl}?pageNum=${pageInfo.pageNum - 1}">上一页</a>
                                    </c:otherwise>
                                </c:choose>
                                <c:forEach begin="1" end="${pageInfo.pages}" var="p">
                                    <c:choose>
                                        <c:when test="${p eq pageInfo.pageNum}">
                                            <span class="active">${p}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${baseUrl}?pageNum=${p}">${p}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <c:choose>
                                    <c:when test="${pageInfo.isLastPage}">
                                        <span class="disabled">下一页</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${baseUrl}?pageNum=${pageInfo.pageNum + 1}">下一页</a>
                                    </c:otherwise>
                                </c:choose>
                                <span class="page-info">共 ${pageInfo.total} 条</span>
                            </div>
                        </c:if>
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

    <div class="portal-footer">&copy; 2026 学生实习管理系统 · 工学部</div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</body>
</html>
