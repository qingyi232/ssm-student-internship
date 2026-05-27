/**
 * 学生实习管理系统 - 公共JS
 */

$(document).ready(function () {
    highlightCurrentMenu();
});

function highlightCurrentMenu() {
    var path = window.location.pathname;
    $('.sidebar-menu a').each(function () {
        var href = $(this).attr('href');
        if (href && path.indexOf(href) !== -1) {
            $(this).addClass('active');
        }
    });
}

function confirmDelete(url) {
    if (confirm('确定要删除吗？此操作不可撤销！')) {
        window.location.href = url;
    }
}

function showAlert(type, message) {
    var alertHtml = '<div class="alert alert-' + type + '" style="position:fixed;top:70px;right:24px;z-index:9999;min-width:300px;">' +
        message + '</div>';
    $('body').append(alertHtml);
    setTimeout(function () {
        $('.alert').fadeOut(300, function () {
            $(this).remove();
        });
    }, 3000);
}

function ajaxPost(url, data, callback) {
    $.ajax({
        url: url,
        type: 'POST',
        data: data,
        dataType: 'json',
        success: function (result) {
            if (callback) {
                callback(result);
            }
        },
        error: function (xhr) {
            if (xhr.status === 401) {
                window.location.href = contextPath + '/login';
            } else {
                showAlert('error', '请求失败，请稍后重试');
            }
        }
    });
}
