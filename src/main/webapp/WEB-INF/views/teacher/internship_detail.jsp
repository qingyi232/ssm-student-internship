<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="实习详情"/>
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
                    <h3><i class="fas fa-briefcase"></i> 实习基本信息</h3>
                    <a href="${ctx}/teacher/internships" class="btn btn-default">返回列表</a>
                </div>
                <div class="panel-body">
                    <table class="data-table detail-table">
                        <tbody>
                            <tr><th>学生姓名</th><td>${internship.studentName}</td></tr>
                            <tr><th>实习单位</th><td>${internship.companyName}</td></tr>
                            <tr><th>实习岗位</th><td>${internship.position}</td></tr>
                            <tr><th>指导教师</th><td>${internship.teacherName}</td></tr>
                            <tr><th>开始日期</th><td><fmt:formatDate value="${internship.startDate}" pattern="yyyy-MM-dd"/></td></tr>
                            <tr><th>结束日期</th><td><fmt:formatDate value="${internship.endDate}" pattern="yyyy-MM-dd"/></td></tr>
                            <tr><th>状态</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${internship.status eq 0}"><span class="status-tag pending">待审核</span></c:when>
                                        <c:when test="${internship.status eq 1}"><span class="status-tag ongoing">进行中</span></c:when>
                                        <c:when test="${internship.status eq 2}"><span class="status-tag completed">已完成</span></c:when>
                                        <c:when test="${internship.status eq 3}"><span class="status-tag cancelled">已取消</span></c:when>
                                        <c:otherwise><span class="status-tag">未知</span></c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr><th>备注</th><td>${internship.remark}</td></tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="panel">
                <div class="panel-header">
                    <h3><i class="fas fa-tasks"></i> 实习任务列表</h3>
                    <a href="${ctx}/teacher/task/add?internshipId=${internship.id}" class="btn btn-primary">添加任务</a>
                </div>
                <div class="panel-body">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>任务标题</th>
                                <th>内容</th>
                                <th>截止日期</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty taskList}">
                                    <c:forEach items="${taskList}" var="t">
                                        <tr>
                                            <td>${t.title}</td>
                                            <td>${t.content}</td>
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
                                                <a href="${ctx}/teacher/task/edit/${t.id}" class="btn btn-primary btn-sm">编辑</a>
                                                <a href="javascript:void(0)" onclick="confirmDelete('${ctx}/teacher/task/delete/${t.id}')" class="btn btn-danger btn-sm">删除</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr><td colspan="5" class="empty-state"><i class="fas fa-inbox"></i><p>暂无任务</p></td></tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="panel">
                <div class="panel-header">
                    <h3><i class="fas fa-file-alt"></i> 实习报告列表</h3>
                </div>
                <div class="panel-body">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>报告标题</th>
                                <th>提交时间</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty reportList}">
                                    <c:forEach items="${reportList}" var="r">
                                        <tr>
                                            <td>${r.title}</td>
                                            <td><fmt:formatDate value="${r.submitTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${r.status eq 0}"><span class="status-tag pending">待审核</span></c:when>
                                                    <c:when test="${r.status eq 1}"><span class="status-tag completed">已通过</span></c:when>
                                                    <c:when test="${r.status eq 2}"><span class="status-tag cancelled">已退回</span></c:when>
                                                    <c:otherwise><span class="status-tag">未知</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="actions">
                                                <a href="${ctx}/teacher/report/detail/${r.id}" class="btn btn-primary btn-sm">查看</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr><td colspan="4" class="empty-state"><i class="fas fa-inbox"></i><p>暂无报告</p></td></tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="panel">
                <div class="panel-header">
                    <h3><i class="fas fa-book"></i> 实习日志列表</h3>
                </div>
                <div class="panel-body">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>日志标题</th>
                                <th>日期</th>
                                <th>内容摘要</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty logList}">
                                    <c:forEach items="${logList}" var="l">
                                        <tr>
                                            <td>${l.title}</td>
                                            <td><fmt:formatDate value="${l.logDate}" pattern="yyyy-MM-dd"/></td>
                                            <td>${l.content}</td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr><td colspan="3" class="empty-state"><i class="fas fa-inbox"></i><p>暂无日志</p></td></tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js"></script>
<script>
function confirmDelete(url) {
    if (confirm('确定要删除该任务吗？')) {
        window.location.href = url;
    }
}
</script>
</body>
</html>
