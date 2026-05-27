<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="任务管理"/>
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
                    <h3><i class="fas fa-tasks"></i> 任务管理</h3>
                    <a href="${ctx}/teacher/task/add" class="btn btn-primary">添加任务</a>
                </div>
                <div class="panel-body">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>任务标题</th>
                                <th>所属实习(学生名-公司名)</th>
                                <th>截止日期</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty taskList}">
                                    <c:forEach items="${taskList}" var="t">
                                        <tr>
                                            <td>${t.title}</td>
                                            <td>${t.internshipLabel}</td>
                                            <td><fmt:formatDate value="${t.deadline}" pattern="yyyy-MM-dd"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${t.status eq 0}"><span class="status-tag pending">未开始</span></c:when>
                                                    <c:when test="${t.status eq 1}"><span class="status-tag ongoing">进行中</span></c:when>
                                                    <c:when test="${t.status eq 2}"><span class="status-tag completed">已完成</span></c:when>
                                                    <c:otherwise><span class="status-tag">未知</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="actions">
                                                <a href="${ctx}/teacher/task/edit/${t.id}" class="btn btn-primary btn-sm">编辑</a>
                                                <a href="${ctx}/teacher/task/delete/${t.id}" class="btn btn-danger btn-sm" onclick="return confirm('确认删除该任务？')">删除</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr><td colspan="5" class="empty-state"><i class="fas fa-inbox"></i><p>暂无任务</p></td></tr>
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
