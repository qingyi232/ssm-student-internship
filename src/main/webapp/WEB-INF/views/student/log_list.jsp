<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="实习日志"/>
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
            <span>实习日志</span>
        </nav>

        <div class="portal-page-head">
            <h2><i class="fas fa-book"></i> ${pageTitle}</h2>
            <a href="${ctx}/student/log/add" class="btn btn-primary"><i class="fas fa-plus"></i> 写日志</a>
        </div>

        <div class="portal-card">
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty pageInfo.list}">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>日志标题</th>
                                    <th>日志日期</th>
                                    <th>创建时间</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${pageInfo.list}" var="log">
                                    <tr>
                                        <td>${log.title}</td>
                                        <td><fmt:formatDate value="${log.logDate}" pattern="yyyy-MM-dd"/></td>
                                        <td><fmt:formatDate value="${log.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                                        <td class="actions">
                                            <a href="${ctx}/student/log/edit/${log.id}" class="btn btn-primary btn-sm">编辑</a>
                                            <a href="javascript:void(0)" onclick="if(confirm('确定要删除吗？此操作不可撤销！'))location.href='${ctx}/student/log/delete/${log.id}'" class="btn btn-danger btn-sm">删除</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <c:if test="${pageInfo.pages > 0}">
                            <div class="pagination">
                                <c:set var="baseUrl" value="${ctx}/student/logs"/>
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
                            <p>暂无日志</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="portal-footer">&copy; 2026 学生实习管理系统 · 工学部</div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js"></script>
</body>
</html>
