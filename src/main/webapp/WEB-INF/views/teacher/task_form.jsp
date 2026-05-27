<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="${not empty task ? '编辑任务' : '新增任务'}"/>
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
                    <h3><i class="fas fa-tasks"></i> ${pageTitle}</h3>
                    <a href="${ctx}/teacher/tasks" class="btn btn-default">返回列表</a>
                </div>
                <div class="panel-body">
                    <form action="${ctx}/teacher/task/save" method="post" class="form-container">
                        <c:if test="${not empty task}">
                            <input type="hidden" name="id" value="${task.id}">
                        </c:if>
                        <div class="form-group">
                            <label>所属实习 <span class="required">*</span></label>
                            <select name="internshipId" class="form-control" required>
                                <option value="">请选择实习</option>
                                <c:forEach items="${internshipList}" var="i">
                                    <option value="${i.id}" ${(param.internshipId eq i.id or (not empty task and task.internshipId eq i.id)) ? 'selected' : ''}>${i.studentName}-${i.companyName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>任务标题 <span class="required">*</span></label>
                            <input type="text" name="title" class="form-control" value="${task.title}" required placeholder="请输入任务标题">
                        </div>
                        <div class="form-group">
                            <label>任务内容</label>
                            <textarea name="content" class="form-control" rows="5" placeholder="请输入任务内容">${task.content}</textarea>
                        </div>
                        <c:set var="deadlineVal" value=""/>
                        <c:if test="${not empty task.deadline}"><fmt:formatDate value="${task.deadline}" pattern="yyyy-MM-dd" var="deadlineVal"/></c:if>
                        <div class="form-group">
                            <label>截止日期</label>
                            <input type="date" name="deadline" class="form-control" value="${deadlineVal}" placeholder="yyyy-MM-dd">
                        </div>
                        <div class="form-group">
                            <label>状态</label>
                            <select name="status" class="form-control">
                                <option value="0" ${empty task || task.status eq 0 ? 'selected' : ''}>未开始</option>
                                <option value="1" ${task.status eq 1 ? 'selected' : ''}>进行中</option>
                                <option value="2" ${task.status eq 2 ? 'selected' : ''}>已完成</option>
                            </select>
                        </div>
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">提交</button>
                            <a href="${ctx}/teacher/tasks" class="btn btn-default">取消</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js"></script>
<script>
$(function() {
    var paramInternshipId = '${param.internshipId}';
    if (paramInternshipId && !$('select[name="internshipId"]').val()) {
        $('select[name="internshipId"]').val(paramInternshipId);
    }
});
</script>
</body>
</html>
