<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="实习任务"/>
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
<div class="portal-page">
    <%@ include file="/WEB-INF/views/common/nav_student.jsp"%>

    <div class="portal-body">
        <nav class="portal-breadcrumb">
            <a href="${ctx}/student/index">首页</a>
            <span>/</span>
            <span>${pageTitle}</span>
        </nav>

        <div class="portal-card">
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty taskList}">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>任务标题</th>
                                    <th>任务内容</th>
                                    <th>截止日期</th>
                                    <th>状态</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${taskList}" var="t">
                                    <tr data-id="${t.id}">
                                        <td>${t.title}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${fn:length(t.content) > 50}">${fn:substring(t.content, 0, 50)}...</c:when>
                                                <c:otherwise>${t.content}</c:otherwise>
                                            </c:choose>
                                        </td>
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
                                            <c:choose>
                                                <c:when test="${t.status eq 0}">
                                                    <button type="button" class="btn btn-primary btn-sm" onclick="updateTaskStatus(${t.id}, 1)">开始</button>
                                                </c:when>
                                                <c:when test="${t.status eq 1}">
                                                    <button type="button" class="btn btn-primary btn-sm" onclick="updateTaskStatus(${t.id}, 2)">完成</button>
                                                </c:when>
                                                <c:when test="${t.status eq 2}">
                                                    <span class="text-muted">已完成</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-inbox"></i>
                            <p>暂无任务</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="portal-footer">&copy; 2026 学生实习管理系统 · 工学部</div>
</div>

<script>
var contextPath = '${ctx}';
</script>
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js"></script>
<script>
function updateTaskStatus(id, status) {
    $.ajax({
        url: contextPath + '/student/task/updateStatus',
        type: 'POST',
        data: { taskId: id, status: status },
        dataType: 'json',
        success: function(result) {
            if (result && result.success) {
                if (typeof showAlert === 'function') {
                    showAlert('success', result.message || '操作成功');
                } else {
                    alert(result.message || '操作成功');
                }
                setTimeout(function() { window.location.reload(); }, 800);
            } else {
                if (typeof showAlert === 'function') {
                    showAlert('error', result && result.message ? result.message : '操作失败');
                } else {
                    alert(result && result.message ? result.message : '操作失败');
                }
            }
        },
        error: function(xhr) {
            if (typeof showAlert === 'function') {
                showAlert('error', '请求失败，请稍后重试');
            } else {
                alert('请求失败，请稍后重试');
            }
        }
    });
}
</script>
</body>
</html>
