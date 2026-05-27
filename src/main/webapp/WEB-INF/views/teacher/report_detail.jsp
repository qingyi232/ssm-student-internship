<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="报告详情"/>
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
                    <h3><i class="fas fa-file-alt"></i> 报告详情</h3>
                    <a href="${ctx}/teacher/reports" class="btn btn-default">返回列表</a>
                </div>
                <div class="panel-body">
                    <table class="data-table detail-table">
                        <tbody>
                            <tr><th>报告标题</th><td>${report.title}</td></tr>
                            <tr><th>学生姓名</th><td>${report.studentName}</td></tr>
                            <tr><th>报告内容</th><td><div class="report-content">${report.content}</div></td></tr>
                            <tr><th>附件</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty report.filePath}">
                                            <a href="${ctx}${report.filePath}" class="btn btn-primary btn-sm"><i class="fas fa-download"></i> 下载附件</a>
                                        </c:when>
                                        <c:otherwise>无</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr><th>提交时间</th><td><fmt:formatDate value="${report.submitTime}" pattern="yyyy-MM-dd HH:mm"/></td></tr>
                            <tr><th>状态</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${report.status eq 0}"><span class="status-tag pending">待审核</span></c:when>
                                        <c:when test="${report.status eq 1}"><span class="status-tag completed">已通过</span></c:when>
                                        <c:when test="${report.status eq 2}"><span class="status-tag cancelled">已退回</span></c:when>
                                        <c:otherwise><span class="status-tag">未知</span></c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <c:if test="${report.status ne 0}">
                                <tr><th>反馈</th><td>${report.feedback}</td></tr>
                                <tr><th>分数</th><td>${report.score}</td></tr>
                            </c:if>
                        </tbody>
                    </table>

                    <c:if test="${report.status eq 0}">
                        <div class="panel-section">
                            <h4><i class="fas fa-edit"></i> 审核报告</h4>
                            <form action="${ctx}/teacher/report/review" method="post" class="form-container">
                                <input type="hidden" name="id" value="${report.id}">
                                <div class="form-group">
                                    <label>审核结果 <span class="required">*</span></label>
                                    <select name="status" class="form-control" required>
                                        <option value="1">通过</option>
                                        <option value="2">退回</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>分数 (0-100)</label>
                                    <input type="number" name="score" class="form-control" min="0" max="100" value="${report.score}" placeholder="请输入分数">
                                </div>
                                <div class="form-group">
                                    <label>反馈意见</label>
                                    <textarea name="feedback" class="form-control" rows="4" placeholder="请输入审核反馈">${report.feedback}</textarea>
                                </div>
                                <div class="form-actions">
                                    <button type="submit" class="btn btn-primary">提交审核</button>
                                    <a href="${ctx}/teacher/reports" class="btn btn-default">取消</a>
                                </div>
                            </form>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js"></script>
</body>
</html>
