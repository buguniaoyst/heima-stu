<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <title>试卷管理列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css" media="all">
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/lay/modules/laypage.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/common.js"></script>
</head>
<body>
<div style=" margin: 40px auto 6px 0px;" >
    <form class="layui-form layui-form-pane" action="" method="post">
        <div class="site-tips">
            试卷名：<span style="font-size: 20px" id="stuTestName" ></span>&nbsp;&nbsp;&nbsp;&nbsp;
            姓名：<span style="font-size: 20px" id="stuName" ></span>
        </div>
        <div id="itemArea" style="margin-left: 10px">

        </div>
    </form>
</div>

<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script src="/lib/jquery-1.8.3.js"></script>
<script>
    layui.use(['laypage', 'layer','laydate','jquery','form','layedit','code'],function() {
        var laydate = layui.laydate;
        var laypage = layui.laypage;
        var form = layui.form();
        var $ = layui.jquery;
         layui.code();
        var layedit = layui.layedit;
        layedit.build('codeItemSiLu'); //建立编辑器
        layedit.build('codeItemAnswer'); //建立编辑器
        var start = {
            max : '2099-06-16 23:59:59',
            istoday : false,
            choose : function(datas) {
                end.min = datas; //开始日选好后，重置结束日的最小日期
                end.start = datas //将结束日的初始值设定为开始日
            }
        };

        var end = {
            max : '2099-06-16 23:59:59',
            istoday : false,
            choose : function(datas) {
                start.max = datas; //结束日选好后，重置开始日的最大日期
            }
        };


        //页面初始化的时候加载分页数据
        $(function(){
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/rest/records/showDetailAll?testId=${param.testId}&stuId=${param.stuId}",
                //记得加双引号  T_T
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (answerInfos) {
                    console.log(answerInfos);
                    $("#stuTestName").html("${param.testName}");
                    $("#stuName").html("${loginUser.username}");
                    if(answerInfos && answerInfos.length>0) {
                        var count = 1;
                        for(var i = 0;i<answerInfos.length;i++){
                            //根据itemId查询 item信息
                           var itemId =  answerInfos[i].itemId;
                            createCodeItem(count,answerInfos[i]);
                            count++;
                        }
                    }

                },
                error: function (err) {
                    alert(err + "err");
                }
            });

        })

        //创建编程题
        function createCodeItem(count,answer) {
            var _div = $("<div class='itemAnswerArea'   id="+answer.itemId+" >\n" +
                "            <div class=\"site-title\">\n" +
                "                <fieldset><legend><a >第"+count+"题(得分："+"<font color='red'>"+answer.score+"</font>"+"分)</a></legend></fieldset>\n" +
                "            </div>\n" +
                "            <div class=\"site-item\" style='font-size: large'>\n" +"题目："+
                "               "+ answer.itemContent+"\n" +"(总分："+answer.itemScore+")"+
                "            </div>\n" +
                "            <div>\n" +
                "\n" +
                "                <div class=\"layui-form-item layui-form-text\">\n" +
                "                    <label class=\"layui-form-label\" style='color: #1aa094;font-size: large'>你的思路（步骤）：</label>\n" +
                "                    <div class=\"layui-input-block\">\n" +
                "                        <pre placeholder=\"请输入思路\" style='height:auto' class=\"layui-code silu\">"+answer.silu+"</pre>\n" +
                "                    </div>\n" +
                "                </div>\n" +
                "            </div>\n" +
                "            <div>\n" +
                "\n" +
                "                <div class=\"layui-form-item layui-form-text\">\n" +
                "                    <label class=\"layui-form-label\" style='color: #1aa094;font-size: large'>你的答案：</label>\n" +
                "                    <div class=\"layui-input-block\">\n" +
                "                        <pre  placeholder=\"请输入答案\" style='height:auto' class=\"layui-code answer\">"+answer.answer+"</pre>\n" +
                "                    </div>\n" +
                "                </div>\n" +
                "            </div>\n" +
                "        </div>");
            var scoreSpan = $("<img style='height:400px' src="+answer.picPath+"></img>");
            var siluAnswerSite = $("<div class='site-item' style='color: red;font-size: large'>思路解析</div>");
            var cankaoAnswer = $("<div class='site-item' style='color: red;font-size: large'>参考答案</div><div class='layui-form-item'><pre  style='height:auto' class='layui-code'><font color='red'>"+answer.itemAnswer+"</font></pre></div>");
            _div.appendTo($("#itemArea"));
            siluAnswerSite.appendTo(_div);
            scoreSpan.appendTo(_div);
            cankaoAnswer.appendTo(_div);
            var _video = $('<video src='+answer.videoPath+' controls="controls">\n' +
                '您的浏览器不支持 video 标签。\n' +
                '</video>')
            var videoDiv = $("<div><input type='button' class='layui-btn' value='【视频讲解】'></input></div>")
            videoDiv.appendTo(_div);
            _video.appendTo(_div);
        }


        $(function () {
            $("#submitTest").click(function () {
                var submitTestFlag = true;
                //获取提交的答案信息
                alert(123);
                var _divs=$(".itemAnswerArea");
                var scoreInfos = new Array();
                //封装答案信息
                var stuId =  $("#stuName").attr("stuId");
                if(_divs){
                    _divs.each(function () {
                        var itemId = $(this).attr('id');
                        var itemScore = $(_divs.get(0)).find('input')[0].value;
                        if(!itemScore){
                            submitTestFlag = false;
                            layer.alert('有未批阅的题目，请检查！', {
                                skin: 'layui-layer-molv' //样式类名
                                ,closeBtn: 0
                            });
                            return;
                        }
                        var scoreInfo = {};
                        var testId = $("#stuTestName").attr("testId");
                        scoreInfo.stuId=stuId;
                        scoreInfo.itemId=itemId;
                        scoreInfo.itemScore=itemScore;
                        scoreInfo.testId = testId;
                        scoreInfos.push(scoreInfo);
                        console.log(scoreInfos);
                    })
                }
                console.log(scoreInfos);
              //  itemAnswersInfo = JSON.serialize(itemAnswersInfo);
                scoreInfos = JSON.stringify(scoreInfos);
                if(submitTestFlag){
                    $.post("${pageContext.request.contextPath}/rest/score/submitScoreInfo",{scoreInfos:scoreInfos},function (result) {
                        if(result.result){
                            alert("批改成功");
                            var testName = $("#stuTestName").html();
                            var testId = $("#stuTestName").attr("testId");
                            var classId =  $("#stuName").attr("classId");
                            location.href = "/rest/class_answer_detail?classId="+classId+"&testId="+testId+"&testName="+testName;
                        }

                    });
                }

            })
        })


    });


</script>
</body>
</html>
