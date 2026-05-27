<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="${not empty teacher ? '编辑教师' : '新增教师'}"/>
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
                    <h3><i class="fas fa-chalkboard-teacher"></i> ${pageTitle}</h3>
                    <a href="${ctx}/admin/teachers" class="btn btn-default">返回列表</a>
                </div>
                <div class="panel-body">
                    <form action="${ctx}/admin/teacher/save" method="post" class="form-container">
                        <c:if test="${not empty teacher}">
                            <input type="hidden" name="id" value="${teacher.id}">
                        </c:if>
                        <div class="form-group">
                            <label>工号 <span class="required">*</span></label>
                            <input type="text" name="teacherNo" class="form-control" value="${teacher.teacherNo}" required placeholder="请输入工号">
                        </div>
                        <div class="form-group">
                            <label>姓名 <span class="required">*</span></label>
                            <input type="text" name="name" class="form-control" value="${teacher.name}" required placeholder="请输入姓名">
                        </div>
                        <div class="form-group">
                            <label>性别</label>
                            <div>
                                <label><input type="radio" name="gender" value="男" ${empty teacher || teacher.gender eq '男' ? 'checked' : ''}> 男</label>
                                <label style="margin-left:20px;"><input type="radio" name="gender" value="女" ${teacher.gender eq '女' ? 'checked' : ''}> 女</label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>职称</label>
                            <input type="text" name="title" class="form-control" value="${teacher.title}" placeholder="如：讲师、副教授">
                        </div>
                        <div class="form-group">
                            <label>学院</label>
                            <input type="text" name="college" class="form-control" value="${teacher.college}" placeholder="请输入学院">
                        </div>
                        <div class="form-group">
                            <label>联系电话</label>
                            <input type="text" name="phone" class="form-control" value="${teacher.phone}" placeholder="请输入联系电话">
                        </div>
                        <div class="form-group">
                            <label>邮箱</label>
                            <input type="email" name="email" class="form-control" value="${teacher.email}" placeholder="请输入邮箱">
                        </div>
                        <c:if test="${empty teacher}">
                            <div class="form-group">
                                <label>登录用户名 <span class="required">*</span></label>
                                <input type="text" name="username" class="form-control" required placeholder="用于创建登录账号">
                            </div>
                        </c:if>
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">提交</button>
                            <a href="${ctx}/admin/teachers" class="btn btn-default">取消</a>
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
