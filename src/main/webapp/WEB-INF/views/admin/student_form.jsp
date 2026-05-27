<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="${not empty student ? '编辑学生' : '新增学生'}"/>
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
                    <h3><i class="fas fa-user-graduate"></i> ${pageTitle}</h3>
                    <a href="${ctx}/admin/students" class="btn btn-default">返回列表</a>
                </div>
                <div class="panel-body">
                    <form action="${ctx}/admin/student/save" method="post" class="form-container">
                        <c:if test="${not empty student}">
                            <input type="hidden" name="id" value="${student.id}">
                        </c:if>
                        <div class="form-group">
                            <label>学号 <span class="required">*</span></label>
                            <input type="text" name="studentNo" class="form-control" value="${student.studentNo}" required placeholder="请输入学号">
                        </div>
                        <div class="form-group">
                            <label>姓名 <span class="required">*</span></label>
                            <input type="text" name="name" class="form-control" value="${student.name}" required placeholder="请输入姓名">
                        </div>
                        <div class="form-group">
                            <label>性别</label>
                            <div>
                                <label><input type="radio" name="gender" value="男" ${empty student || student.gender eq '男' ? 'checked' : ''}> 男</label>
                                <label style="margin-left:20px;"><input type="radio" name="gender" value="女" ${student.gender eq '女' ? 'checked' : ''}> 女</label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>年龄</label>
                            <input type="number" name="age" class="form-control" value="${student.age}" min="1" max="150" placeholder="请输入年龄">
                        </div>
                        <div class="form-group">
                            <label>班级</label>
                            <input type="text" name="className" class="form-control" value="${student.className}" placeholder="请输入班级">
                        </div>
                        <div class="form-group">
                            <label>专业</label>
                            <input type="text" name="major" class="form-control" value="${student.major}" placeholder="请输入专业">
                        </div>
                        <div class="form-group">
                            <label>学院</label>
                            <input type="text" name="college" class="form-control" value="${student.college}" placeholder="请输入学院">
                        </div>
                        <div class="form-group">
                            <label>联系电话</label>
                            <input type="text" name="phone" class="form-control" value="${student.phone}" placeholder="请输入联系电话">
                        </div>
                        <div class="form-group">
                            <label>邮箱</label>
                            <input type="email" name="email" class="form-control" value="${student.email}" placeholder="请输入邮箱">
                        </div>
                        <div class="form-group">
                            <label>地址</label>
                            <input type="text" name="address" class="form-control" value="${student.address}" placeholder="请输入地址">
                        </div>
                        <c:if test="${empty student}">
                            <div class="form-group">
                                <label>登录用户名 <span class="required">*</span></label>
                                <input type="text" name="username" class="form-control" required placeholder="用于创建登录账号">
                            </div>
                        </c:if>
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">提交</button>
                            <a href="${ctx}/admin/students" class="btn btn-default">取消</a>
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
