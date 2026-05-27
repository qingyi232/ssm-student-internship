<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="报告审核"/>
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
            <div class="panel">
                <div class="panel-header">
                    <h3><i class="fas fa-file-alt"></i> 报告审核</h3>
                </div>
                <div class="panel-body">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>报告标题</th>
                                <th>学生姓名</th>
                                <th>提交时间</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty reportList}">
                                    <c:forEach items="${reportList}" var="r">
                                        <tr>
                                            <td>${r.title}</td>
                                            <td>${r.studentName}</td>
                                            <td><fmt:formatDate value="${r.submitTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${r.status eq 0}"><span class="status-tag pending">待审核</span></c:when>
                                                    <c:when test="${r.status eq 1}"><span class="status-tag completed">已通过</span></c:when>
                                                    <c:when test="${r.status eq 2}"><span class="status-tag cancelled">已退回</span></c:when>
                                                    <c:otherwise><span class="status-tag">未知</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="actions">
                                                <c:choose>
                                                    <c:when test="${r.status eq 0}">
                                                        <a href="${ctx}/teacher/report/detail/${r.id}" class="btn btn-primary btn-sm">审核</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="${ctx}/teacher/report/detail/${r.id}" class="btn btn-default btn-sm">查看</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr><td colspan="5" class="empty-state"><i class="fas fa-inbox"></i><p>暂无报告</p></td></tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js"></script>
</body>
</html>
