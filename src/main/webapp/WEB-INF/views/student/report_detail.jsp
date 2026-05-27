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
<div class="portal-page">
    <%@ include file="/WEB-INF/views/common/nav_student.jsp"%>

    <div class="portal-body">
        <nav class="portal-breadcrumb">
            <a href="${ctx}/student/index">首页</a>
            <span>/</span>
            <a href="${ctx}/student/reports">实习报告</a>
            <span>/</span>
            <span>${pageTitle}</span>
        </nav>

        <c:if test="${not empty report}">
            <div class="portal-card">
                <div class="card-head">
                    <h3><i class="fas fa-file-alt"></i> 报告信息</h3>
                    <a href="${ctx}/student/reports" class="btn btn-default btn-sm"><i class="fas fa-arrow-left"></i> 返回</a>
                </div>
                <div class="card-body">
                    <div class="portal-profile-grid">
                        <div class="pf-item">
                            <div class="pf-label">报告标题</div>
                            <div class="pf-value">${report.title}</div>
                        </div>
                        <div class="pf-item">
                            <div class="pf-label">提交时间</div>
                            <div class="pf-value"><fmt:formatDate value="${report.submitTime}" pattern="yyyy-MM-dd HH:mm"/></div>
                        </div>
                        <div class="pf-item">
                            <div class="pf-label">状态</div>
                            <div class="pf-value">
                                <c:choose>
                                    <c:when test="${report.status eq 0}"><span class="status-tag pending">待审核</span></c:when>
                                    <c:when test="${report.status eq 1}"><span class="status-tag completed">已通过</span></c:when>
                                    <c:when test="${report.status eq 2}"><span class="status-tag cancelled">已退回</span></c:when>
                                    <c:otherwise><span class="status-tag">未知</span></c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="pf-item">
                            <div class="pf-label">评分</div>
                            <div class="pf-value">${not empty report.score ? report.score : '-'}</div>
                        </div>
                        <div class="pf-item">
                            <div class="pf-label">审核时间</div>
                            <div class="pf-value"><c:choose><c:when test="${not empty report.reviewTime}"><fmt:formatDate value="${report.reviewTime}" pattern="yyyy-MM-dd HH:mm"/></c:when><c:otherwise>-</c:otherwise></c:choose></div>
                        </div>
                        <div class="pf-item">
                            <div class="pf-label">审核反馈</div>
                            <div class="pf-value">${not empty report.feedback ? report.feedback : '-'}</div>
                        </div>
                    </div>

                    <c:if test="${not empty report.filePath}">
                        <div style="margin-top: 20px; padding-top: 16px; border-top: 1px solid var(--border-light);">
                            <a href="${ctx}${report.filePath}" class="btn btn-primary btn-sm"><i class="fas fa-download"></i> 下载附件</a>
                        </div>
                    </c:if>
                </div>
            </div>

            <div class="portal-card">
                <div class="card-head">
                    <h3><i class="fas fa-align-left"></i> 报告内容</h3>
                </div>
                <div class="card-body">
                    <div class="report-content" style="white-space: pre-wrap; line-height: 1.8;">${report.content}</div>
                </div>
            </div>
        </c:if>

        <c:if test="${empty report}">
            <div class="portal-card">
                <div class="card-body">
                    <div class="empty-state">
                        <i class="fas fa-file-alt"></i>
                        <p>报告不存在</p>
                        <a href="${ctx}/student/reports" class="btn btn-default" style="margin-top: 16px;">返回列表</a>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <div class="portal-footer">&copy; 2026 学生实习管理系统 · 工学部</div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</body>
</html>
