<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<div class="top-header">
    <div class="page-title">${pageTitle}</div>
    <div class="user-info">
        <div class="user-avatar">
            <c:choose>
                <c:when test="${sessionScope.loginUser.role == 1}"><i class="fas fa-user-shield"></i></c:when>
                <c:when test="${sessionScope.loginUser.role == 2}"><i class="fas fa-user-tie"></i></c:when>
                <c:otherwise><i class="fas fa-user"></i></c:otherwise>
            </c:choose>
        </div>
        <div>
            <div class="user-name">${sessionScope.loginUser.realName}</div>
            <div class="user-role">
                <c:choose>
                    <c:when test="${sessionScope.loginUser.role == 1}">系统管理员</c:when>
                    <c:when test="${sessionScope.loginUser.role == 2}">指导教师</c:when>
                    <c:otherwise>学生</c:otherwise>
                </c:choose>
            </div>
        </div>
        <a href="${ctx}/logout" class="btn-logout"><i class="fas fa-sign-out-alt"></i>退出</a>
    </div>
</div>
