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
                    $("#stuName").html("${loginStu.studentName}");
                    if(answerInfos && answerInfos.length>0) {
                        var count = 1;
                        for(var i = 0;i<answerInfos.length;i++){
                            //根据itemId查询 item信息
                           var itemId =  answerInfos[i].itemId;
                           var itemType = answerInfos[i].itemType;
                            if(itemType == 0) {
                                createCodeItem(count,answerInfos[i]);
                                count++;
                            }else{
                                createSingleChoiceItem(count, answerInfos[i]);
                                count++;
                            }

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
            var scoreSpan = $("<img style='height:auto' src="+answer.picPath+"></img>");
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

        /*显示单选题
       * */
        function createSingleChoiceItem(count,item) {
            var itemType = "";
            if(item.itemType == 1) {
                itemType = "【单选题】";
            }else{
                itemType = "【多选题】";
            }
            var itemAnswer = $("<div class='itemAnswerArea' id="+item.id+"></div>");
            var itemContent = $('<div class="site-title">\n' +
                '                    <fieldset><legend><a>第'+count+'题('+item.itemScore+'分)</a></legend></fieldset>\n' +
                '                </div>\n' +
                '                <div class="site-item">\n' +
                '                    \n' +itemType+item.itemContent+
                '                </div>');
            var answerOptions = item.itemAnswerOption;
            var optionDiv;
            if(answerOptions && answerOptions.length>0) {
                var itemOptions = answerOptions.split(',');

                console.log(itemOptions);
                if(itemOptions && itemOptions.length>=4) {
                    optionDiv = $('<div></div>');
                    var opt0 = $('<div >\n' +
                        '      <span style="font-size: 25px">\n' +
                        '          <input type="radio"  name="q1" value="A" title="A">\n' +
                        '      </span>\n' +
                        '     <lable>'+itemOptions[0]+'</lable>\n' +
                        '    </div>');
                    var opt1 = $('<div >\n' +
                        '      <span style="font-size: 25px">\n' +
                        '          <input type="radio"  name="q1" value="B" title="B">\n' +
                        '      </span>\n' +
                        '     <lable>'+itemOptions[1]+'</lable>\n' +
                        '    </div>');
                    var opt2 = $('<div >\n' +
                        '      <span style="font-size: 25px">\n' +
                        '          <input type="radio"  name="q1" value="C" title="C">\n' +
                        '      </span>\n' +
                        '     <lable>'+itemOptions[2]+'</lable>\n' +
                        '    </div>');
                    var opt3 = $('<div >\n' +
                        '      <span style="font-size: 25px">\n' +
                        '          <input type="radio"  name="q1" value="D" title="D">\n' +
                        '      </span>\n' +
                        '     <lable>'+itemOptions[3]+'</lable>\n' +
                        '    </div>');
                    opt0.appendTo(optionDiv);
                    opt1.appendTo(optionDiv);
                    opt2.appendTo(optionDiv);
                    opt3.appendTo(optionDiv);
                }

                //判断得分
                var thisItemSocre = 0;
                var thisItemAnas;
                if(item.itemAnswer == item.answer) {
                    thisItemSocre = item.itemScore;
                }

                if(thisItemSocre) {
                    thisItemAnas = $(' <div >\n' +
                        '                    <blockquote class="layui-elem-quote">学员答案：<font color="#20b2aa" size="5">'+item.answer+'</font> <i class="layui-icon" style="font-size: 30px; color: #1E9FFF;">&#xe618;</i>参考答案：<font color="red" size="5">'+item.itemAnswer+'</font> </blockquote>\n' +
                        '                </div>');
                }else{
                    thisItemAnas = $(' <div >\n' +
                        '                    <blockquote class="layui-elem-quote">学员答案：<font color="#20b2aa" size="5">'+item.answer+'</font> <i class="layui-icon" style="font-size: 30px; color: #1E9FFF;">&#x1006;</i>参考答案：<font color="red" size="5">'+item.itemAnswer+'</font> </blockquote>\n' +
                        '                </div>');
                }
            }

            //思路解析
            var scoreSpan = $("<img style='height:auto' src="+item.picPath+"></img>");
            var siluAnswerSite = $("<div class='site-item' style='color: red;font-size: large'>思路解析</div>");


            //分析学员判断

            var itemScore = $(' <div class="layui-form-item">\n' +
                '                    <label class="layui-form-label">得分</label>\n' +
                '                    <div class="layui-input-inline">\n' +
                '                        <input type="number" readonly="readonly" value='+thisItemSocre+' name="itemScore" lay-verify="required" placeholder="请输入" autocomplete="off" class="layui-input">\n' +
                '                    </div>\n' +
                '                </div>');


            itemContent.appendTo(itemAnswer);
            optionDiv.appendTo(itemAnswer);
            thisItemAnas.appendTo(itemAnswer);
            siluAnswerSite.appendTo(itemAnswer);
            scoreSpan.appendTo(itemAnswer);
            itemScore.appendTo(itemAnswer);
            itemAnswer.appendTo($("#itemArea"));
            form.render();

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
