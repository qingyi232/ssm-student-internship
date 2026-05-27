<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="个人信息"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - 学生实习管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<div class="portal-page">
    <%@ include file="/WEB-INF/views/common/nav_student.jsp"%>
    <div class="portal-body">
        <div class="portal-breadcrumb">
            <a href="${ctx}/student/index">首页</a>
            <span>/</span>
            ${pageTitle}
        </div>
        <div class="portal-card">
            <div class="card-head">
                <h3><i class="fas fa-user"></i> ${pageTitle}</h3>
                <button type="button" id="btnEdit" class="btn btn-primary"><i class="fas fa-edit"></i> 编辑</button>
            </div>
            <div class="card-body">
                <c:if test="${not empty student}">
                    <div id="profileView" class="portal-profile-grid">
                        <div class="pf-item">
                            <span class="pf-label">学号</span>
                            <span class="pf-value">${student.studentNo}</span>
                        </div>
                        <div class="pf-item">
                            <span class="pf-label">姓名</span>
                            <span class="pf-value">${student.name}</span>
                        </div>
                        <div class="pf-item">
                            <span class="pf-label">性别</span>
                            <span class="pf-value">${student.gender}</span>
                        </div>
                        <div class="pf-item">
                            <span class="pf-label">年龄</span>
                            <span class="pf-value">${student.age}</span>
                        </div>
                        <div class="pf-item">
                            <span class="pf-label">班级</span>
                            <span class="pf-value">${student.className}</span>
                        </div>
                        <div class="pf-item">
                            <span class="pf-label">专业</span>
                            <span class="pf-value">${student.major}</span>
                        </div>
                        <div class="pf-item">
                            <span class="pf-label">学院</span>
                            <span class="pf-value">${student.college}</span>
                        </div>
                        <div class="pf-item">
                            <span class="pf-label">联系电话</span>
                            <span class="pf-value">${student.phone}</span>
                        </div>
                        <div class="pf-item">
                            <span class="pf-label">邮箱</span>
                            <span class="pf-value">${student.email}</span>
                        </div>
                        <div class="pf-item">
                            <span class="pf-label">家庭住址</span>
                            <span class="pf-value">${student.address}</span>
                        </div>
                    </div>

                    <div id="editFormWrapper" style="display:none; margin-top: 24px; padding-top: 24px; border-top: 1px solid var(--border-light);">
                        <form action="${ctx}/student/profile/update" method="post" class="form-container">
                            <input type="hidden" name="id" value="${student.id}">
                            <div class="form-group">
                                <label>联系电话</label>
                                <input type="text" name="phone" class="form-control" value="${student.phone}" placeholder="请输入联系电话">
                            </div>
                            <div class="form-group">
                                <label>邮箱</label>
                                <input type="email" name="email" class="form-control" value="${student.email}" placeholder="请输入邮箱">
                            </div>
                            <div class="form-group">
                                <label>家庭住址</label>
                                <input type="text" name="address" class="form-control" value="${student.address}" placeholder="请输入家庭住址">
                            </div>
                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary">保存</button>
                                <button type="button" id="btnCancel" class="btn btn-default">取消</button>
                            </div>
                        </form>
                    </div>
                </c:if>
                <c:if test="${empty student}">
                    <div class="empty-state">
                        <i class="fas fa-user"></i>
                        <p>暂无个人信息</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    <div class="portal-footer">&copy; 2026 学生实习管理系统 · 工学部</div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js"></script>
<script>
$(function(){
    $('#btnEdit').click(function(){
        $('#editFormWrapper').slideDown();
    });
    $('#btnCancel').click(function(){
        $('#editFormWrapper').slideUp();
    });
});
</script>
</body>
</html>
