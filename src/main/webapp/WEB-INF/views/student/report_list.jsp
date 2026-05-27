<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="实习报告"/>
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
            <span>${pageTitle}</span>
        </nav>

        <div class="portal-page-head">
            <h2><i class="fas fa-file-alt"></i> ${pageTitle}</h2>
            <a href="${ctx}/student/report/add" class="btn btn-primary"><i class="fas fa-plus"></i> 提交报告</a>
        </div>

        <div class="portal-card">
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty pageInfo.list}">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>报告标题</th>
                                    <th>提交时间</th>
                                    <th>状态</th>
                                    <th>评分</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${pageInfo.list}" var="r">
                                    <tr>
                                        <td>${r.title}</td>
                                        <td><fmt:formatDate value="${r.submitTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${r.status eq 0}"><span class="status-tag pending">待审核</span></c:when>
                                                <c:when test="${r.status eq 1}"><span class="status-tag completed">已通过</span></c:when>
                                                <c:when test="${r.status eq 2}"><span class="status-tag cancelled">已退回</span></c:when>
                                                <c:otherwise><span class="status-tag">未知</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${not empty r.score ? r.score : '-'}</td>
                                        <td class="actions">
                                            <a href="${ctx}/student/report/detail/${r.id}" class="btn btn-primary btn-sm"><i class="fas fa-eye"></i> 查看</a>
                                            <c:if test="${r.status eq 2}">
                                                <a href="${ctx}/student/report/edit/${r.id}" class="btn btn-default btn-sm"><i class="fas fa-edit"></i> 编辑</a>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <c:if test="${not empty pageInfo.list && pageInfo.pages > 0}">
                            <div class="pagination">
                                <c:set var="baseUrl" value="${ctx}/student/reports"/>
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
                            <p>暂无报告</p>
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
