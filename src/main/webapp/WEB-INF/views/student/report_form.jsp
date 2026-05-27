<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="${not empty report ? '编辑报告' : '提交报告'}"/>
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
            <a href="${ctx}/student/reports">实习报告</a>
            <span>/</span>
            <span>${not empty report ? '编辑报告' : '提交报告'}</span>
        </nav>

        <div class="portal-card">
            <div class="card-body">
                <form action="${ctx}/student/report/save" method="post" enctype="multipart/form-data" class="form-container">
                    <c:if test="${not empty report}">
                        <input type="hidden" name="id" value="${report.id}">
                    </c:if>

                    <div class="form-group">
                        <label>关联实习 <span class="required">*</span></label>
                        <select name="internshipId" class="form-control" required>
                            <option value="">请选择实习</option>
                            <c:forEach items="${internshipList}" var="i">
                                <option value="${i.id}" ${(not empty report && report.internshipId eq i.id) ? 'selected' : ''}>${i.studentName}-${i.companyName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>报告标题 <span class="required">*</span></label>
                        <input type="text" name="title" class="form-control" value="${report.title}" required placeholder="请输入报告标题">
                    </div>

                    <div class="form-group">
                        <label>报告内容 <span class="required">*</span></label>
                        <textarea name="content" class="form-control" rows="8" required placeholder="请输入报告内容">${report.content}</textarea>
                    </div>

                    <div class="form-group">
                        <label>附件上传</label>
                        <c:if test="${not empty report && not empty report.filePath}">
                            <div class="current-file" style="margin-bottom: 8px;">
                                <i class="fas fa-paperclip"></i> 当前附件：
                                <a href="${ctx}${report.filePath}" target="_blank">下载</a>
                            </div>
                        </c:if>
                        <input type="file" name="attachment" class="form-control" accept=".pdf,.doc,.docx,.zip,.rar">
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> 提交</button>
                        <a href="${ctx}/student/reports" class="btn btn-default">取消</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="portal-footer">&copy; 2026 学生实习管理系统 · 工学部</div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</body>
</html>
