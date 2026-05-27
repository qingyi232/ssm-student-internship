<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="学生首页"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生门户 - 学生实习管理系统</title>
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
<div class="portal-page">
    <%@ include file="/WEB-INF/views/common/nav_student.jsp"%>

    <div class="portal-hero">
        <div class="hero-inner">
            <div class="hero-greeting">Hi，欢迎回来</div>
            <h1 class="hero-title">你好，${sessionScope.loginStudent.name}！</h1>
            <p class="hero-subtitle">实习是成长的起点，认真记录每一天的收获与进步。</p>
            <div class="hero-stats">
                <div class="hero-stat">
                    <div class="hs-icon green"><i class="fas fa-briefcase"></i></div>
                    <div class="hs-value">
                        <c:choose>
                            <c:when test="${internship != null && internship.status eq 1}">进行中</c:when>
                            <c:when test="${internship != null && internship.status eq 0}">待审核</c:when>
                            <c:when test="${internship != null && internship.status eq 2}">已完成</c:when>
                            <c:otherwise>暂无</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="hs-label">当前实习状态</div>
                </div>
                <div class="hero-stat">
                    <div class="hs-icon orange"><i class="fas fa-clipboard-list"></i></div>
                    <div class="hs-value">${pendingTaskCount}</div>
                    <div class="hs-label">待完成任务</div>
                </div>
                <div class="hero-stat">
                    <div class="hs-icon blue"><i class="fas fa-file-alt"></i></div>
                    <div class="hs-value">${reportCount}</div>
                    <div class="hs-label">已提交报告</div>
                </div>
            </div>
        </div>
    </div>

    <div class="portal-body">
        <div class="portal-shortcuts">
            <a href="${ctx}/student/profile" class="portal-shortcut">
                <div class="sc-icon bg-blue"><i class="fas fa-id-card"></i></div>
                <span class="sc-label">个人信息</span>
            </a>
            <a href="${ctx}/student/internship" class="portal-shortcut">
                <div class="sc-icon bg-green"><i class="fas fa-building"></i></div>
                <span class="sc-label">实习信息</span>
            </a>
            <a href="${ctx}/student/tasks" class="portal-shortcut">
                <div class="sc-icon bg-orange"><i class="fas fa-tasks"></i></div>
                <span class="sc-label">我的任务</span>
            </a>
            <a href="${ctx}/student/report/add" class="portal-shortcut">
                <div class="sc-icon bg-purple"><i class="fas fa-plus-circle"></i></div>
                <span class="sc-label">提交报告</span>
            </a>
            <a href="${ctx}/student/logs" class="portal-shortcut">
                <div class="sc-icon bg-cyan"><i class="fas fa-pen-fancy"></i></div>
                <span class="sc-label">实习日志</span>
            </a>
            <a href="${ctx}/student/announcements" class="portal-shortcut">
                <div class="sc-icon bg-pink"><i class="fas fa-bullhorn"></i></div>
                <span class="sc-label">系统公告</span>
            </a>
            <a href="${ctx}/student/reports" class="portal-shortcut">
                <div class="sc-icon bg-blue"><i class="fas fa-folder-open"></i></div>
                <span class="sc-label">我的报告</span>
            </a>
            <a href="${ctx}/password" class="portal-shortcut">
                <div class="sc-icon bg-orange"><i class="fas fa-key"></i></div>
                <span class="sc-label">修改密码</span>
            </a>
        </div>

        <div class="portal-grid-2">
            <div class="portal-card">
                <div class="card-head">
                    <h3><i class="fas fa-bullhorn"></i> 最新公告</h3>
                    <a href="${ctx}/student/announcements" class="btn btn-default btn-sm">查看全部</a>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty announcementList}">
                            <c:forEach items="${announcementList}" var="a">
                                <a href="${ctx}/student/announcement/${a.id}" class="portal-ann-item">
                                    <div class="ann-dot"></div>
                                    <div class="ann-info">
                                        <div class="ann-t">${a.title}</div>
                                        <div class="ann-d"><fmt:formatDate value="${a.createTime}" pattern="yyyy-MM-dd HH:mm"/></div>
                                    </div>
                                </a>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state" style="padding:30px">
                                <i class="fas fa-inbox"></i>
                                <p>暂无公告</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="portal-card">
                <div class="card-head">
                    <h3><i class="fas fa-briefcase"></i> 实习概况</h3>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${internship != null}">
                            <div class="portal-profile-grid">
                                <div class="pf-item">
                                    <div class="pf-label">实习单位</div>
                                    <div class="pf-value">${internship.companyName}</div>
                                </div>
                                <div class="pf-item">
                                    <div class="pf-label">实习岗位</div>
                                    <div class="pf-value">${internship.position}</div>
                                </div>
                                <div class="pf-item">
                                    <div class="pf-label">开始日期</div>
                                    <div class="pf-value"><fmt:formatDate value="${internship.startDate}" pattern="yyyy-MM-dd"/></div>
                                </div>
                                <div class="pf-item">
                                    <div class="pf-label">结束日期</div>
                                    <div class="pf-value"><fmt:formatDate value="${internship.endDate}" pattern="yyyy-MM-dd"/></div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state" style="padding:30px">
                                <i class="fas fa-briefcase"></i>
                                <p>暂无实习信息</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <div class="portal-footer">
        &copy; 2026 学生实习管理系统 · 工学部
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</body>
</html>
