<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="${not empty company ? '编辑实习单位' : '新增实习单位'}"/>
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
                    <h3><i class="fas fa-building"></i> ${pageTitle}</h3>
                    <a href="${ctx}/admin/companies" class="btn btn-default">返回列表</a>
                </div>
                <div class="panel-body">
                    <form action="${ctx}/admin/company/save" method="post" class="form-container">
                        <c:if test="${not empty company}">
                            <input type="hidden" name="id" value="${company.id}">
                        </c:if>
                        <div class="form-group">
                            <label>单位名称 <span class="required">*</span></label>
                            <input type="text" name="name" class="form-control" value="${company.name}" required placeholder="请输入单位名称">
                        </div>
                        <div class="form-group">
                            <label>联系人</label>
                            <input type="text" name="contactPerson" class="form-control" value="${company.contactPerson}" placeholder="请输入联系人">
                        </div>
                        <div class="form-group">
                            <label>联系电话</label>
                            <input type="text" name="contactPhone" class="form-control" value="${company.contactPhone}" placeholder="请输入联系电话">
                        </div>
                        <div class="form-group">
                            <label>地址</label>
                            <input type="text" name="address" class="form-control" value="${company.address}" placeholder="请输入地址">
                        </div>
                        <div class="form-group">
                            <label>简介描述</label>
                            <textarea name="description" class="form-control" rows="4" placeholder="请输入单位简介">${company.description}</textarea>
                        </div>
                        <div class="form-group">
                            <label>状态</label>
                            <select name="status" class="form-control">
                                <option value="1" ${empty company || company.status eq 1 ? 'selected' : ''}>启用</option>
                                <option value="0" ${company.status eq 0 ? 'selected' : ''}>停用</option>
                            </select>
                        </div>
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">提交</button>
                            <a href="${ctx}/admin/companies" class="btn btn-default">取消</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</body>
</html>
