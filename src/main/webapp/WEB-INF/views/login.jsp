<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>学员登录</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../../lib/layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="../../css/login.css" />
</head>
<body class="beg-login-bg">
<div class="beg-login-box">
    <header>
        <h1>学员登录</h1>
    </header>
    <div class="beg-login-main">
        <form action="/rest/student/login" id="loginForm" class="layui-form" method="POST">
            <div class="layui-form-item">
                <label class="beg-login-icon">
                    <i class="layui-icon">&#xe612;</i>
                </label>
                <input type="text" name="studentName" lay-verify="userName" autocomplete="off" placeholder="这里输入登录名" class="layui-input">
            </div>
            <div class="layui-form-item">
                <label class="beg-login-icon">
                    <i class="layui-icon">&#xe612;</i>
                </label>
                <input type="text" name="studentNo"  autocomplete="off" placeholder="这里输入学号" class="layui-input">
            </div>
            <div class="layui-form-item">
                <label class="beg-login-icon">
                    <i class="layui-icon">&#xe642;</i>
                </label>
                <input type="password" name="password" lay-verify="password" autocomplete="off" placeholder="这里输入密码" class="layui-input">
            </div>
            <div class="layui-form-item">
                <input type="hidden" name="classid" value="${param.classid}">
                <div class="beg-pull-left beg-login-remember">
                    <label>记住帐号？</label>
                    <input type="checkbox" name="rememberMe" value="true" lay-skin="switch" checked title="记住帐号">
                </div>
                <div class="beg-pull-right">
                    <button class="layui-btn layui-btn-primary" lay-submit lay-filter="login">
                        <i class="layui-icon">&#xe650;</i> 登录
                    </button>
                </div>
                <div class="beg-clear"></div>
            </div>
        </form>
    </div>
    <footer>
        <p>sh.java</p>
    </footer>
</div>
<script type="text/javascript" src="../../lib/layui/layui.js"></script>
<script>
    layui.use(['layer', 'form'], function() {
        var layer = layui.layer,
                $ = layui.jquery,
                form = layui.form();

        form.on('submit(login)',function(data){
            $('#loginForm').submit();
            //location.href='index.html';
            return false;
        });

        if('${requestScope.message}') {
            layer.alert('${requestScope.message}', {
                skin: 'layui-layer-molv' //样式类名
                ,closeBtn: 0
            });
        }
        if('${param.registMsg}') {
            layer.alert('${param.registMsg}', {
                skin: 'layui-layer-molv' //样式类名
                ,closeBtn: 0
            });
        }

    });
</script>
</body>
</html>
