<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="实习管理"/>
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
                    <h3><i class="fas fa-briefcase"></i> 实习管理</h3>
                </div>
                <div class="panel-body">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>学生姓名</th>
                                <th>实习单位</th>
                                <th>实习岗位</th>
                                <th>开始日期</th>
                                <th>结束日期</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty internshipList}">
                                    <c:forEach items="${internshipList}" var="item">
                                        <tr>
                                            <td>${item.studentName}</td>
                                            <td>${item.companyName}</td>
                                            <td>${item.position}</td>
                                            <td><fmt:formatDate value="${item.startDate}" pattern="yyyy-MM-dd"/></td>
                                            <td><fmt:formatDate value="${item.endDate}" pattern="yyyy-MM-dd"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${item.status eq 0}"><span class="status-tag pending">待审核</span></c:when>
                                                    <c:when test="${item.status eq 1}"><span class="status-tag ongoing">进行中</span></c:when>
                                                    <c:when test="${item.status eq 2}"><span class="status-tag completed">已完成</span></c:when>
                                                    <c:when test="${item.status eq 3}"><span class="status-tag cancelled">已取消</span></c:when>
                                                    <c:otherwise><span class="status-tag">未知</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="actions">
                                                <a href="${ctx}/teacher/internship/detail/${item.id}" class="btn btn-primary btn-sm">查看详情</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr><td colspan="7" class="empty-state"><i class="fas fa-inbox"></i><p>暂无数据</p></td></tr>
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
