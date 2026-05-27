<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="学生管理"/>
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
                    <h3><i class="fas fa-user-graduate"></i> 学生列表</h3>
                    <a href="${ctx}/admin/student/add" class="btn btn-primary">新增学生</a>
                </div>
                <div class="panel-body">
                    <form action="${ctx}/admin/students" method="get" class="search-bar">
                        <input type="text" name="name" class="form-control" placeholder="姓名" value="${name}">
                        <input type="text" name="studentNo" class="form-control" placeholder="学号" value="${studentNo}">
                        <input type="text" name="major" class="form-control" placeholder="专业" value="${major}">
                        <input type="hidden" name="pageNum" value="1">
                        <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i> 搜索</button>
                    </form>

                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>学号</th>
                                <th>姓名</th>
                                <th>性别</th>
                                <th>班级</th>
                                <th>专业</th>
                                <th>学院</th>
                                <th>联系电话</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty pageInfo.list}">
                                    <c:forEach items="${pageInfo.list}" var="s">
                                        <tr>
                                            <td>${s.studentNo}</td>
                                            <td>${s.name}</td>
                                            <td>${s.gender}</td>
                                            <td>${s.className}</td>
                                            <td>${s.major}</td>
                                            <td>${s.college}</td>
                                            <td>${s.phone}</td>
                                            <td class="actions">
                                                <a href="${ctx}/admin/student/edit/${s.id}" class="btn btn-primary btn-sm">编辑</a>
                                                <a href="javascript:void(0)" onclick="confirmDelete('${ctx}/admin/student/delete/${s.id}')" class="btn btn-danger btn-sm">删除</a>
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
                            <c:set var="baseUrl" value="${ctx}/admin/students"/>
                            <c:set var="queryParams" value=""/>
                            <c:if test="${not empty name}"><c:set var="queryParams" value="${queryParams}&name=${name}"/></c:if>
                            <c:if test="${not empty studentNo}"><c:set var="queryParams" value="${queryParams}&studentNo=${studentNo}"/></c:if>
                            <c:if test="${not empty major}"><c:set var="queryParams" value="${queryParams}&major=${major}"/></c:if>
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
    if (confirm('确定要删除该学生吗？')) {
        window.location.href = url;
    }
}
</script>
</body>
</html>
