<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加用户</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/lib/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" ></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wenjuan.css" >
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/lay/modules/form.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.9.1.js"></script>
</head>
<body >
    <div class="container" >
        <form class="layui-form layui-form-pane" >
            <div class="layui-form-item">
                <label class="layui-form-label">用户名</label>
                <div class="layui-input-block">
                    <input type="text" readonly="true" name="username" id="studentName" value="${sessionScope.loginStu.studentName}" required  lay-verify="required"  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">新密码</label>
                <div class="layui-input-block">
                    <input type="password" name="password" id="password" required  lay-verify="required"  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">确认密码</label>
                <div class="layui-input-block">
                    <input type="password" name="repwd" id="repwd" required  lay-verify="required"  autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <input class="layui-btn" value="修改密码" id="user_submit">
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
    </div>
</body>

<script>
    //Demo
    layui.use(['form','jquery','layer'], function() {
        var form = layui.form(),
            $ = layui.jquery,
            layer = layui.layer;


        $(function () {
            $("#user_submit").click(function () {
                var studentName = $("#studentName").val();
                //获取两次输入的密码
                var password = $("#password").val();
                var repwd = $("#repwd").val();
                if(!password || !repwd){
                    layer.alert("请将信息完善");
                    return;
                }
                if(password != repwd) {
                    layer.alert("两次输入密码不一致！");
                    return;
                }
                $.post("${pageContext.request.contextPath}/rest/student/updateStudentPassword",{password:password},function (result) {
                    if(result){
                       //密码修改成功
                        layer.msg('密码修改成功', {
                            icon: 1,
                            time: 1000 //2秒关闭（如果不配置，默认是3秒）
                        },function () {
                            window.open("${pageContext.request.contextPath}/rest/stu_home","_top");
                        });
                    }else{
                        //密码修改成功
                        layer.msg('密码修改失败', {
                            icon: 1,
                            time: 1000 //2秒关闭（如果不配置，默认是3秒）
                        });
                    }

                })

            })
        })

    });

</script>
</html>
