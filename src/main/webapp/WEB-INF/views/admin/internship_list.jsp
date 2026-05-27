<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="实习管理"/>
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
    <%@ include file="/WEB-INF/views/common/sidebar_admin.jsp"%>
    <div class="main-content">
        <%@ include file="/WEB-INF/views/common/header.jsp"%>
        <div class="content-wrapper">
            <div class="panel">
                <div class="panel-header">
                    <h3><i class="fas fa-briefcase"></i> 实习列表</h3>
                    <a href="${ctx}/admin/internship/add" class="btn btn-primary">新增实习</a>
                </div>
                <div class="panel-body">
                    <form action="${ctx}/admin/internships" method="get" class="search-bar">
                        <input type="text" name="studentName" class="form-control" placeholder="学生姓名" value="${studentName}">
                        <input type="text" name="companyName" class="form-control" placeholder="实习单位" value="${companyName}">
                        <select name="status" class="form-control">
                            <option value="">全部状态</option>
                            <option value="0" ${status eq 0 ? 'selected' : ''}>待审核</option>
                            <option value="1" ${status eq 1 ? 'selected' : ''}>进行中</option>
                            <option value="2" ${status eq 2 ? 'selected' : ''}>已完成</option>
                            <option value="3" ${status eq 3 ? 'selected' : ''}>已取消</option>
                        </select>
                        <input type="hidden" name="pageNum" value="1">
                        <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i> 搜索</button>
                    </form>

                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>学生姓名</th>
                                <th>实习单位</th>
                                <th>指导教师</th>
                                <th>实习岗位</th>
                                <th>开始日期</th>
                                <th>结束日期</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty pageInfo.list}">
                                    <c:forEach items="${pageInfo.list}" var="item">
                                        <tr>
                                            <td>${item.studentName}</td>
                                            <td>${item.companyName}</td>
                                            <td>${item.teacherName}</td>
                                            <td>${item.position}</td>
                                            <td><fmt:formatDate value="${item.startDate}" pattern="yyyy-MM-dd"/></td>
                                            <td><fmt:formatDate value="${item.endDate}" pattern="yyyy-MM-dd"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${item.status eq 0}"><span class="status-tag pending">待审核</span></c:when>
                                                    <c:when test="${item.status eq 1}"><span class="status-tag ongoing">进行中</span></c:when>
                                                    <c:when test="${item.status eq 2}"><span class="status-tag completed">已完成</span></c:when>
                                                    <c:when test="${item.status eq 3}"><span class="status-tag cancelled">已取消</span></c:when>
                                                    <c:otherwise><span class="status-tag">未知</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="actions">
                                                <a href="${ctx}/admin/internship/edit/${item.id}" class="btn btn-primary btn-sm">编辑</a>
                                                <a href="javascript:void(0)" onclick="confirmDelete('${ctx}/admin/internship/delete/${item.id}')" class="btn btn-danger btn-sm">删除</a>
                                                <c:if test="${item.status eq 0}">
                                                    <form action="${ctx}/admin/internship/approve/${item.id}" method="post" style="display:inline;">
                                                        <button type="submit" class="btn btn-success btn-sm">审核通过</button>
                                                    </form>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr><td colspan="8" class="empty-state"><i class="fas fa-inbox"></i><p>暂无数据</p></td></tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>

                    <c:if test="${not empty pageInfo.list && pageInfo.pages > 0}">
                        <div class="pagination">
                            <c:set var="baseUrl" value="${ctx}/admin/internships"/>
                            <c:set var="queryParams" value=""/>
                            <c:if test="${not empty studentName}"><c:set var="queryParams" value="${queryParams}&studentName=${studentName}"/></c:if>
                            <c:if test="${not empty companyName}"><c:set var="queryParams" value="${queryParams}&companyName=${companyName}"/></c:if>
                            <c:if test="${status != null}"><c:set var="queryParams" value="${queryParams}&status=${status}"/></c:if>
                            <c:choose>
                                <c:when test="${pageInfo.isFirstPage}">
                                    <span class="disabled">上一页</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${baseUrl}?pageNum=${pageInfo.pageNum - 1}${queryParams}">上一页</a>
                                </c:otherwise>
                            </c:choose>
                            <c:forEach begin="1" end="${pageInfo.pages}" var="p">
                                <c:choose>
                                    <c:when test="${p eq pageInfo.pageNum}">
                                        <span class="active">${p}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${baseUrl}?pageNum=${p}${queryParams}">${p}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <c:choose>
                                <c:when test="${pageInfo.isLastPage}">
                                    <span class="disabled">下一页</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${baseUrl}?pageNum=${pageInfo.pageNum + 1}${queryParams}">下一页</a>
                                </c:otherwise>
                            </c:choose>
                            <span class="page-info">共 ${pageInfo.total} 条</span>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
function confirmDelete(url) {
    if (confirm('确定要删除该实习记录吗？')) {
        window.location.href = url;
    }
}
</script>
</body>
</html>
