<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="${not empty announcement ? '编辑公告' : '新增公告'}"/>
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
    <%@ include file="/WEB-INF/views/common/sidebar_admin.jsp"%>
    <div class="main-content">
        <%@ include file="/WEB-INF/views/common/header.jsp"%>
        <div class="content-wrapper">
            <div class="panel">
                <div class="panel-header">
                    <h3><i class="fas fa-bullhorn"></i> ${pageTitle}</h3>
                    <a href="${ctx}/admin/announcements" class="btn btn-default">返回列表</a>
                </div>
                <div class="panel-body">
                    <form action="${ctx}/admin/announcement/save" method="post" class="form-container">
                        <c:if test="${not empty announcement}">
                            <input type="hidden" name="id" value="${announcement.id}">
                        </c:if>
                        <c:if test="${not empty sessionScope.loginUser}">
                            <input type="hidden" name="publisherId" value="${sessionScope.loginUser.id}">
                        </c:if>
                        <div class="form-group">
                            <label>标题 <span class="required">*</span></label>
                            <input type="text" name="title" class="form-control" value="${announcement.title}" required placeholder="请输入公告标题">
                        </div>
                        <div class="form-group">
                            <label>内容</label>
                            <textarea name="content" class="form-control" rows="8" placeholder="请输入公告内容">${announcement.content}</textarea>
                        </div>
                        <div class="form-group">
                            <label>状态</label>
                            <select name="status" class="form-control">
                                <option value="0" ${empty announcement || announcement.status eq 0 ? 'selected' : ''}>草稿</option>
                                <option value="1" ${announcement.status eq 1 ? 'selected' : ''}>已发布</option>
                            </select>
                        </div>
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">提交</button>
                            <a href="${ctx}/admin/announcements" class="btn btn-default">取消</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</body>
</html>
