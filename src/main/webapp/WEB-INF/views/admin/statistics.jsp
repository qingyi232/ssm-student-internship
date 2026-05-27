<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="pageTitle" value="数据统计"/>
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
            <div class="stat-cards">
                <div class="stat-card">
                    <div class="stat-icon bg-blue"><i class="fas fa-user-graduate"></i></div>
                    <div class="stat-info">
                        <h4>学生总数</h4>
                        <div class="stat-number">${studentCount}</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon bg-purple"><i class="fas fa-chalkboard-teacher"></i></div>
                    <div class="stat-info">
                        <h4>教师总数</h4>
                        <div class="stat-number">${teacherCount}</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon bg-cyan"><i class="fas fa-building"></i></div>
                    <div class="stat-info">
                        <h4>实习单位</h4>
                        <div class="stat-number">${companyCount}</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon bg-red"><i class="fas fa-briefcase"></i></div>
                    <div class="stat-info">
                        <h4>实习总数</h4>
                        <div class="stat-number">${internshipCount}</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon bg-orange"><i class="fas fa-clock"></i></div>
                    <div class="stat-info">
                        <h4>待审核</h4>
                        <div class="stat-number">${pendingCount}</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon bg-blue"><i class="fas fa-spinner"></i></div>
                    <div class="stat-info">
                        <h4>进行中</h4>
                        <div class="stat-number">${ongoingCount}</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon bg-green"><i class="fas fa-check-circle"></i></div>
                    <div class="stat-info">
                        <h4>已完成</h4>
                        <div class="stat-number">${completedCount}</div>
                    </div>
                </div>
            </div>

            <div class="chart-container">
                <div class="chart-box">
                    <h4><i class="fas fa-chart-pie"></i> 实习状态分布</h4>
                    <canvas id="pieChart" height="280"></canvas>
                </div>
                <div class="chart-box">
                    <h4><i class="fas fa-chart-bar"></i> 专业分布统计</h4>
                    <canvas id="barChart" height="280"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/Chart.js/3.7.1/chart.min.js"></script>
<script>
$(function() {
    $.get('${ctx}/admin/statistics/data', function(data) {
        if (typeof data === 'string') {
            data = JSON.parse(data);
        }
        var statusData = data.internshipStatus || {};
        var majorData = data.studentByMajor || {};
        
        // 实习状态饼图
        var pieCtx = document.getElementById('pieChart').getContext('2d');
        new Chart(pieCtx, {
            type: 'pie',
            data: {
                labels: Object.keys(statusData),
                datasets: [{
                    data: Object.values(statusData),
                    backgroundColor: ['#fa8c16', '#1890ff', '#52c41a', '#ff4d4f'],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { position: 'bottom' }
                }
            }
        });
        
        // 专业分布柱状图
        var barCtx = document.getElementById('barChart').getContext('2d');
        new Chart(barCtx, {
            type: 'bar',
            data: {
                labels: Object.keys(majorData),
                datasets: [{
                    label: '人数',
                    data: Object.values(majorData),
                    backgroundColor: 'rgba(24, 144, 255, 0.7)',
                    borderColor: 'rgba(24, 144, 255, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: { stepSize: 1 }
                    }
                }
            }
        });
    });
});
</script>
</body>
</html>
