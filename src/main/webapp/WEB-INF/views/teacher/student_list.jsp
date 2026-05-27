<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="学生列表"/>
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
                    <h3><i class="fas fa-users"></i> 学生列表</h3>
                </div>
                <div class="panel-body">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>学号</th>
                                <th>姓名</th>
                                <th>性别</th>
                                <th>班级</th>
                                <th>专业</th>
                                <th>联系电话</th>
                                <th>实习单位</th>
                                <th>实习岗位</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty internshipList}">
                                    <c:forEach items="${internshipList}" var="item">
                                        <tr>
                                            <td>${item.studentNo}</td>
                                            <td>${item.studentName}</td>
                                            <td>${item.gender}</td>
                                            <td>${item.className}</td>
                                            <td>${item.major}</td>
                                            <td>${item.phone}</td>
                                            <td>${item.companyName}</td>
                                            <td>${item.position}</td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:when test="${not empty studentList}">
                                    <c:forEach items="${studentList}" var="s">
                                        <tr>
                                            <td>${s.studentNo}</td>
                                            <td>${s.name}</td>
                                            <td>${s.gender}</td>
                                            <td>${s.className}</td>
                                            <td>${s.major}</td>
                                            <td>${s.phone}</td>
                                            <td>-</td>
                                            <td>-</td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr><td colspan="8" class="empty-state"><i class="fas fa-inbox"></i><p>暂无数据</p></td></tr>
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
