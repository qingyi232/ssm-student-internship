<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="${not empty internship ? '编辑实习' : '新增实习'}"/>
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
                    <h3><i class="fas fa-briefcase"></i> ${pageTitle}</h3>
                    <a href="${ctx}/admin/internships" class="btn btn-default">返回列表</a>
                </div>
                <div class="panel-body">
                    <form action="${ctx}/admin/internship/save" method="post" class="form-container">
                        <c:if test="${not empty internship}">
                            <input type="hidden" name="id" value="${internship.id}">
                        </c:if>
                        <div class="form-group">
                            <label>学生 <span class="required">*</span></label>
                            <select name="studentId" class="form-control" required>
                                <option value="">请选择学生</option>
                                <c:forEach items="${studentList}" var="s">
                                    <option value="${s.id}" ${internship.studentId eq s.id ? 'selected' : ''}>${s.name} (${s.studentNo})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>实习单位 <span class="required">*</span></label>
                            <select name="companyId" class="form-control" required>
                                <option value="">请选择实习单位</option>
                                <c:forEach items="${companyList}" var="c">
                                    <option value="${c.id}" ${internship.companyId eq c.id ? 'selected' : ''}>${c.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>指导教师 <span class="required">*</span></label>
                            <select name="teacherId" class="form-control" required>
                                <option value="">请选择指导教师</option>
                                <c:forEach items="${teacherList}" var="t">
                                    <option value="${t.id}" ${internship.teacherId eq t.id ? 'selected' : ''}>${t.name} (${t.teacherNo})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>实习岗位</label>
                            <input type="text" name="position" class="form-control" value="${internship.position}" placeholder="请输入实习岗位">
                        </div>
                        <c:set var="startDateVal" value=""/>
                        <c:if test="${not empty internship.startDate}"><fmt:formatDate value="${internship.startDate}" pattern="yyyy-MM-dd" var="startDateVal"/></c:if>
                        <c:set var="endDateVal" value=""/>
                        <c:if test="${not empty internship.endDate}"><fmt:formatDate value="${internship.endDate}" pattern="yyyy-MM-dd" var="endDateVal"/></c:if>
                        <div class="form-group">
                            <label>开始日期</label>
                            <input type="date" name="startDate" class="form-control" value="${startDateVal}" placeholder="yyyy-MM-dd">
                        </div>
                        <div class="form-group">
                            <label>结束日期</label>
                            <input type="date" name="endDate" class="form-control" value="${endDateVal}" placeholder="yyyy-MM-dd">
                        </div>
                        <div class="form-group">
                            <label>状态</label>
                            <select name="status" class="form-control">
                                <option value="0" ${empty internship || internship.status eq 0 ? 'selected' : ''}>待审核</option>
                                <option value="1" ${internship.status eq 1 ? 'selected' : ''}>进行中</option>
                                <option value="2" ${internship.status eq 2 ? 'selected' : ''}>已完成</option>
                                <option value="3" ${internship.status eq 3 ? 'selected' : ''}>已取消</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>备注</label>
                            <textarea name="remark" class="form-control" rows="4" placeholder="请输入备注">${internship.remark}</textarea>
                        </div>
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">提交</button>
                            <a href="${ctx}/admin/internships" class="btn btn-default">取消</a>
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
