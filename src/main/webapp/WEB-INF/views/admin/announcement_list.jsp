<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="公告管理"/>
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
                    <h3><i class="fas fa-bullhorn"></i> 公告列表</h3>
                    <a href="${ctx}/admin/announcement/add" class="btn btn-primary">新增公告</a>
                </div>
                <div class="panel-body">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>标题</th>
                                <th>状态</th>
                                <th>发布人</th>
                                <th>发布时间</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty pageInfo.list}">
                                    <c:forEach items="${pageInfo.list}" var="a">
                                        <tr>
                                            <td>${a.title}</td>
                                            <td>
                                                <span class="status-tag ${a.status eq 1 ? 'enabled' : 'pending'}">${a.status eq 1 ? '已发布' : '草稿'}</span>
                                            </td>
                                            <td>${a.publisherName}</td>
                                            <td><fmt:formatDate value="${a.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                                            <td class="actions">
                                                <a href="${ctx}/admin/announcement/edit/${a.id}" class="btn btn-primary btn-sm">编辑</a>
                                                <a href="javascript:void(0)" onclick="confirmDelete('${ctx}/admin/announcement/delete/${a.id}')" class="btn btn-danger btn-sm">删除</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr><td colspan="5" class="empty-state"><i class="fas fa-inbox"></i><p>暂无数据</p></td></tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>

                    <c:if test="${not empty pageInfo.list && pageInfo.pages > 0}">
                        <div class="pagination">
                            <c:set var="baseUrl" value="${ctx}/admin/announcements"/>
                            <c:choose>
                                <c:when test="${pageInfo.isFirstPage}">
                                    <span class="disabled">上一页</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${baseUrl}?pageNum=${pageInfo.pageNum - 1}">上一页</a>
                                </c:otherwise>
                            </c:choose>
                            <c:forEach begin="1" end="${pageInfo.pages}" var="p">
                                <c:choose>
                                    <c:when test="${p eq pageInfo.pageNum}">
                                        <span class="active">${p}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${baseUrl}?pageNum=${p}">${p}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <c:choose>
                                <c:when test="${pageInfo.isLastPage}">
                                    <span class="disabled">下一页</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${baseUrl}?pageNum=${pageInfo.pageNum + 1}">下一页</a>
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
    if (confirm('确定要删除该公告吗？')) {
        window.location.href = url;
    }
}
</script>
</body>
</html>
