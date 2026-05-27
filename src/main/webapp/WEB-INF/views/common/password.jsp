<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="修改密码"/>
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

<c:choose>
    <c:when test="${sessionScope.loginUser.role == 3}">
        <div class="portal-page">
            <%@ include file="/WEB-INF/views/common/nav_student.jsp"%>
            <div class="portal-body">
                <div class="portal-breadcrumb">
                    <a href="${ctx}/student/index">首页</a><span>/</span>修改密码
                </div>
                <div class="portal-card" style="max-width:600px;">
                    <div class="card-head">
                        <h3><i class="fas fa-lock"></i> 修改密码</h3>
                    </div>
                    <div class="card-body">
                        <div id="msgBox" style="display:none;" class="alert"></div>
                        <form id="passwordForm" class="form-container">
                            <div class="form-group">
                                <label>原密码 <span class="required">*</span></label>
                                <input type="password" name="oldPassword" id="oldPassword" class="form-control" placeholder="请输入原密码" required>
                            </div>
                            <div class="form-group">
                                <label>新密码 <span class="required">*</span></label>
                                <input type="password" name="newPassword" id="newPassword" class="form-control" placeholder="请输入新密码" required>
                            </div>
                            <div class="form-group">
                                <label>确认新密码 <span class="required">*</span></label>
                                <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" placeholder="请再次输入新密码" required>
                            </div>
                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary">提交修改</button>
                                <button type="reset" class="btn btn-default">重置</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="portal-footer">&copy; 2026 学生实习管理系统 · 工学部</div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="main-wrapper">
            <c:if test="${sessionScope.loginUser.role == 1}">
                <%@ include file="/WEB-INF/views/common/sidebar_admin.jsp"%>
            </c:if>
            <c:if test="${sessionScope.loginUser.role == 2}">
                <%@ include file="/WEB-INF/views/common/sidebar_teacher.jsp"%>
            </c:if>
            <div class="main-content">
                <%@ include file="/WEB-INF/views/common/header.jsp"%>
                <div class="content-wrapper">
                    <div class="panel">
                        <div class="panel-header">
                            <h3><i class="fas fa-lock"></i> ${pageTitle}</h3>
                        </div>
                        <div class="panel-body">
                            <div id="msgBox" style="display:none;" class="alert"></div>
                            <form id="passwordForm" class="form-container">
                                <div class="form-group">
                                    <label>原密码 <span class="required">*</span></label>
                                    <input type="password" name="oldPassword" id="oldPassword" class="form-control" placeholder="请输入原密码" required>
                                </div>
                                <div class="form-group">
                                    <label>新密码 <span class="required">*</span></label>
                                    <input type="password" name="newPassword" id="newPassword" class="form-control" placeholder="请输入新密码" required>
                                </div>
                                <div class="form-group">
                                    <label>确认新密码 <span class="required">*</span></label>
                                    <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" placeholder="请再次输入新密码" required>
                                </div>
                                <div class="form-actions">
                                    <button type="submit" class="btn btn-primary">提交修改</button>
                                    <button type="reset" class="btn btn-default">重置</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js"></script>
<script>
$(function() {
    $('#passwordForm').on('submit', function(e) {
        e.preventDefault();
        var newPwd = $('#newPassword').val();
        var confirmPwd = $('#confirmPassword').val();
        if (newPwd !== confirmPwd) {
            showMsg('两次输入的新密码不一致', 'error');
            return;
        }
        if (newPwd.length < 6) {
            showMsg('新密码长度不能少于6位', 'error');
            return;
        }
        $.ajax({
            url: '${ctx}/password/update',
            type: 'POST',
            data: { oldPassword: $('#oldPassword').val(), newPassword: newPwd },
            dataType: 'json',
            success: function(res) {
                if (res.success) {
                    showMsg('密码修改成功，即将跳转重新登录...', 'success');
                    setTimeout(function() { window.location.href = '${ctx}/logout'; }, 1500);
                } else {
                    showMsg(res.message || '修改失败，请检查原密码是否正确', 'error');
                }
            },
            error: function() {
                showMsg('请求失败，请稍后重试', 'error');
            }
        });
    });

    function showMsg(text, type) {
        var cls = type === 'success' ? 'alert-success' : 'alert-error';
        $('#msgBox').removeClass('alert-success alert-error alert-warning alert-info')
            .addClass(cls).html('<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + '"></i> ' + text).show();
    }
});
</script>
</body>
</html>
