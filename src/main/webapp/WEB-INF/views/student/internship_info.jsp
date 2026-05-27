<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="实习信息"/>
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

        <c:choose>
            <c:when test="${not empty internship}">
                <div class="portal-info-banner">
                    <div class="ib-icon">
                        <i class="fas fa-building"></i>
                    </div>
                    <div class="ib-text">
                        <h3>${internship.companyName}</h3>
                        <p>${internship.position}</p>
                    </div>
                </div>

                <div class="portal-card">
                    <div class="card-head">
                        <h3><i class="fas fa-briefcase"></i> 实习详情</h3>
                    </div>
                    <div class="card-body">
                        <div class="portal-profile-grid">
                            <div class="pf-item">
                                <span class="pf-label">实习单位</span>
                                <span class="pf-value">${internship.companyName}</span>
                            </div>
                            <div class="pf-item">
                                <span class="pf-label">实习岗位</span>
                                <span class="pf-value">${internship.position}</span>
                            </div>
                            <div class="pf-item">
                                <span class="pf-label">指导教师</span>
                                <span class="pf-value">${internship.teacherName}</span>
                            </div>
                            <div class="pf-item">
                                <span class="pf-label">开始日期</span>
                                <span class="pf-value"><fmt:formatDate value="${internship.startDate}" pattern="yyyy-MM-dd"/></span>
                            </div>
                            <div class="pf-item">
                                <span class="pf-label">结束日期</span>
                                <span class="pf-value"><fmt:formatDate value="${internship.endDate}" pattern="yyyy-MM-dd"/></span>
                            </div>
                            <div class="pf-item">
                                <span class="pf-label">状态</span>
                                <span class="pf-value">
                                    <c:choose>
                                        <c:when test="${internship.status eq 0}"><span class="status-tag pending">未开始</span></c:when>
                                        <c:when test="${internship.status eq 1}"><span class="status-tag ongoing">进行中</span></c:when>
                                        <c:when test="${internship.status eq 2}"><span class="status-tag completed">已完成</span></c:when>
                                        <c:otherwise><span class="status-tag">${internship.status}</span></c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="pf-item" style="grid-column: 1 / -1;">
                                <span class="pf-label">备注</span>
                                <span class="pf-value">${internship.remark}</span>
                            </div>
                        </div>
                    </div>
                </div>

                <c:if test="${not empty internshipList && internshipList.size() > 1}">
                    <div class="portal-card">
                        <div class="card-head">
                            <h3><i class="fas fa-list"></i> 全部实习记录</h3>
                        </div>
                        <div class="card-body" style="padding: 0;">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>实习单位</th>
                                        <th>实习岗位</th>
                                        <th>指导教师</th>
                                        <th>开始日期</th>
                                        <th>结束日期</th>
                                        <th>状态</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${internshipList}" var="item">
                                    <tr>
                                        <td>${item.companyName}</td>
                                        <td>${item.position}</td>
                                        <td>${item.teacherName}</td>
                                        <td><fmt:formatDate value="${item.startDate}" pattern="yyyy-MM-dd"/></td>
                                        <td><fmt:formatDate value="${item.endDate}" pattern="yyyy-MM-dd"/></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${item.status eq 0}"><span class="status-tag pending">未开始</span></c:when>
                                                <c:when test="${item.status eq 1}"><span class="status-tag ongoing">进行中</span></c:when>
                                                <c:when test="${item.status eq 2}"><span class="status-tag completed">已完成</span></c:when>
                                                <c:otherwise><span class="status-tag">${item.status}</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="portal-card">
                    <div class="card-body">
                        <div class="empty-state">
                            <i class="fas fa-briefcase"></i>
                            <p>暂未分配实习</p>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="portal-footer">&copy; 2026 学生实习管理系统 · 工学部</div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js"></script>
</body>
</html>
