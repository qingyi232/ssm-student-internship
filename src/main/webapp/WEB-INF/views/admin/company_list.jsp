<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="实习单位管理"/>
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
                    <h3><i class="fas fa-building"></i> 实习单位列表</h3>
                    <a href="${ctx}/admin/company/add" class="btn btn-primary">新增单位</a>
                </div>
                <div class="panel-body">
                    <form action="${ctx}/admin/companies" method="get" class="search-bar">
                        <input type="text" name="name" class="form-control" placeholder="单位名称" value="${name}">
                        <select name="status" class="form-control">
                            <option value="">全部状态</option>
                            <option value="1" ${status eq 1 ? 'selected' : ''}>启用</option>
                            <option value="0" ${status eq 0 ? 'selected' : ''}>停用</option>
                        </select>
                        <input type="hidden" name="pageNum" value="1">
                        <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i> 搜索</button>
                    </form>

                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>单位名称</th>
                                <th>联系人</th>
                                <th>联系电话</th>
                                <th>地址</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty pageInfo.list}">
                                    <c:forEach items="${pageInfo.list}" var="c">
                                        <tr>
                                            <td>${c.name}</td>
                                            <td>${c.contactPerson}</td>
                                            <td>${c.contactPhone}</td>
                                            <td>${c.address}</td>
                                            <td>
                                                <span class="status-tag ${c.status eq 1 ? 'enabled' : 'disabled'}">${c.status eq 1 ? '启用' : '停用'}</span>
                                            </td>
                                            <td class="actions">
                                                <a href="${ctx}/admin/company/edit/${c.id}" class="btn btn-primary btn-sm">编辑</a>
                                                <a href="javascript:void(0)" onclick="confirmDelete('${ctx}/admin/company/delete/${c.id}')" class="btn btn-danger btn-sm">删除</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr><td colspan="6" class="empty-state"><i class="fas fa-inbox"></i><p>暂无数据</p></td></tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>

                    <c:if test="${not empty pageInfo.list && pageInfo.pages > 0}">
                        <div class="pagination">
                            <c:set var="baseUrl" value="${ctx}/admin/companies"/>
                            <c:set var="queryParams" value=""/>
                            <c:if test="${not empty name}"><c:set var="queryParams" value="${queryParams}&name=${name}"/></c:if>
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
    if (confirm('确定要删除该实习单位吗？')) {
        window.location.href = url;
    }
}
</script>
</body>
</html>
