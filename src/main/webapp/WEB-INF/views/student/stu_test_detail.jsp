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
    <form id="answerForm" class="layui-form layui-form-pane" action="" method="post">
        <div class="site-tips">
            <span style="font-size: 20px" id="stuTestName"></span>
        </div>
        <div id="itemArea" style="margin-left: 10px">

        </div>
        <div class="layui-form-item">
            <input type="button" id="submitTest" class="layui-btn " value="立即交卷">
            <button class="layui-btn "   type="reset" >重做</button>
        </div>
    </form>
</div>

<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script src="/lib/jquery-1.8.3.js"></script>
<script src="${pageContext.request.contextPath }/lib/jquery.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath }/lib/jquery.ext.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath }/lib/jquery.form.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/datas/itemContentTemplate.js"></script>

<script>
    layui.use(['laypage', 'layer','laydate','jquery','form','layedit'],function() {
        var laydate = layui.laydate;
        var laypage = layui.laypage;
        var form = layui.form();
        var $ = layui.jquery;
        var layedit = layui.layedit;
        layedit.build('codeItemSiLu'); //建立编辑器
        layedit.build('codeItemAnswer'); //建立编辑器


        //页面初始化的时候加载分页数据
        $(function(){
            //alert("页面初始化了.......");

            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/rest/test_source/showStuTest?testId=${loginStu.testId}",
                //记得加双引号  T_T
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    if(!data){
                        $("#submitTest").attr({"disabled":"disabled"});
                        form.render();
                    }

                    if(data && data.error) {
                        //墨绿深蓝风
                        //回显，把按钮禁用掉
                        $("#submitTest").attr({"disabled":"disabled"});
                        $("#submitTest").val("没有测试");
                        form.render();
                        layer.alert(data.error, {
                            skin: 'layui-layer-molv' //样式类名
                            ,closeBtn: 0
                        });

                        return;
                    }

                    if(data && data.testSource == 0) {
                        //window.open("${pageContext.request.contextPath}/rest/primary_test", "_parent");
                        location.href = "${pageContext.request.contextPath}/rest/primary_test";
                        return;

                    }else if(data && data.testSource == 1) {
                       // window.open("${pageContext.request.contextPath}/rest/primary_test", "_parent");
                        location.href = "${pageContext.request.contextPath}/rest/senior_test";
                        return;
                    }
                    $("#stuTestName").html(data.testSource.testName);
                    var items = data.itemInfoList;
                    if(items && items.length>0) {
                        var count = 1;
                        for(var i = 0;i<items.length;i++){
                            //创建编程题
                            if(items[i].itemType == '0') {
                                createCodeItem(items[i],count);
                                count++;
                            }else if(items[i].itemType == '1') {
                                createSingleChoiceItem(items[i],count);
                                count++;
                            }else if(items[i].itemType == '2') {
                                createMultiChoiceItem(items[i],count);
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
        function createCodeItem(items,count) {

            console.log(items);

            var _div = $("<div class='itemAnswerArea' itemType= '0' id="+items.id+" >\n" +
                "            <div class=\"site-title\">\n" +
                "                <fieldset><legend><a >第"+count+"题</a></legend></fieldset>\n" +
                "            </div>\n" +
                "            <div class=\"site-item\">\n" +
                "               "+ items.itemContent+"\n" +
                "            </div>\n" +
                "            <div>\n" +
                "\n" +
                "                <div class=\"layui-form-item layui-form-text\">\n" +
                "                    <label class=\"layui-form-label\">请在写下你的做题思路（步骤）：</label>\n" +
                "                    <div class=\"layui-input-block\">\n" +
                "                        <textarea placeholder=\"请输入思路\" class=\"layui-textarea silu\"></textarea>\n" +
                "                    </div>\n" +
                "                </div>\n" +
                "            </div>\n" +
                "            <div>\n" +
                "\n" +
                "                <div class=\"layui-form-item layui-form-text\">\n" +
                "                    <label class=\"layui-form-label\">请将你的答案粘贴到下边的文本域中：</label>\n" +
                "                    <div class=\"layui-input-block\">\n" +
                "                        <textarea placeholder=\"请输入答案\" class=\"layui-textarea answer\"></textarea>\n" +
                "                    </div>\n" +
                "                </div>\n" +
                "       上传zip附件：<input type='file' name='fileUpload' class='layui-input' onchange="+'uploadZip('+items.id+')'+">  <input name='zipPath' id="+'zipPath'+items.id+" type='hidden'> </div>\n" +
                "        </div>");

            _div.appendTo($("#itemArea"));
        }


        /**
         * 创建单选题
         */
        function createSingleChoiceItem( items,count){
            console.log(items);
            var singleItemArea = $('  <div class="itemAnswerArea" itemType= "1"  id='+items.id+' >\n' +
                '                \n' +
                '            </div>');
            var itemTitle = $('<div class="site-title">\n' +
                '                    <fieldset><legend><a>第'+count+'题</a></legend></fieldset>\n' +
                '                </div>\n' +
                '                <div class="site-item">\n' +
                '                    \n' +items.itemContent+
                '                </div>');
            var itemAnswerOption = items.itemAnswerOption;
            var optionDiv;
            if(itemAnswerOption) {
                var itemOptions = itemAnswerOption.split(',');
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
            }

            itemTitle.appendTo(singleItemArea);
            optionDiv.appendTo(singleItemArea);
            singleItemArea.appendTo($("#itemArea"));
            form.render();
        }


        /**
         * 创建多选题
         */
        function createMultiChoiceItem( items,count){
            console.log(items);
            var singleItemArea = $('  <div class="itemAnswerArea" itemType= "2"  id='+items.id+' >\n' +
                '                \n' +
                '            </div>');
            var itemTitle = $('<div class="site-title">\n' +
                '                    <fieldset><legend><a>第'+count+'题</a></legend></fieldset>\n' +
                '                </div>\n' +
                '                <div class="site-item">\n' +
                '                    \n' +items.itemContent+
                '                </div>');
            var itemAnswerOption = items.itemAnswerOption;
            var optionDiv;
            if(itemAnswerOption) {
                var itemOptions = itemAnswerOption.split(',');
                console.log(itemOptions);
                if(itemOptions && itemOptions.length>=4) {
                    optionDiv = $('<div></div>');
                    var opt0 = $('<div >\n' +
                        '      <span style="font-size: 25px">\n' +
                        '          <input type="checkbox"  name="q1" value="A" title="A">\n' +
                        '      </span>\n' +
                        '     <lable>'+itemOptions[0]+'</lable>\n' +
                        '    </div>');
                    var opt1 = $('<div >\n' +
                        '      <span style="font-size: 25px">\n' +
                        '          <input type="checkbox"  name="q1" value="B" title="B">\n' +
                        '      </span>\n' +
                        '     <lable>'+itemOptions[1]+'</lable>\n' +
                        '    </div>');
                    var opt2 = $('<div >\n' +
                        '      <span style="font-size: 25px">\n' +
                        '          <input type="checkbox"  name="q1" value="C" title="C">\n' +
                        '      </span>\n' +
                        '     <lable>'+itemOptions[2]+'</lable>\n' +
                        '    </div>');
                    var opt3 = $('<div >\n' +
                        '      <span style="font-size: 25px">\n' +
                        '          <input type="checkbox"  name="q1" value="D" title="D">\n' +
                        '      </span>\n' +
                        '     <lable>'+itemOptions[3]+'</lable>\n' +
                        '    </div>');
                    opt0.appendTo(optionDiv);
                    opt1.appendTo(optionDiv);
                    opt2.appendTo(optionDiv);
                    opt3.appendTo(optionDiv);
                }
            }

            itemTitle.appendTo(singleItemArea);
            optionDiv.appendTo(singleItemArea);
            singleItemArea.appendTo($("#itemArea"));
            form.render();
        }



        $(function () {
            $("#submitTest").click(function () {
                //获取提交的答案信息
                //alert(123);
                var _divs=$(".itemAnswerArea");
                var itemAnswers = new Array();
                //封装答案信息
                var stuId = ${loginStu.id};
                var classId = ${loginStu.classId};
                if(_divs){
                    _divs.each(function () {
                        //判断题型
                        var itemType = $(this).attr("itemType");
                        //编程题
                        if('0'== itemType) {
                            var id = $(this).attr('id');
                            var silu = $(this).find('textarea')[0].value;
                            var answer = $(this).find('textarea')[1].value;
                            var zipPath = $(this).find('input')[1].value;
                            var itemAnswer = {};
                            itemAnswer.stuId=stuId;
                            itemAnswer.classId=classId;
                            itemAnswer.itemId=id;
                            itemAnswer.silu = silu;
                            itemAnswer.answer = answer;
                            itemAnswer.zipPath = zipPath;
                            itemAnswer.testName = $("#stuTestName").html();
                            itemAnswers.push(itemAnswer);
                            console.log(itemAnswer);
                        }else if('1' == itemType) {
                            var id = $(this).attr('id');
                           // var answer = $(this).find('radio selected').value;
                            var answer =  $('input:radio:checked').val();
                            var itemAnswer = {};
                            itemAnswer.stuId=stuId;
                            itemAnswer.classId=classId;
                            itemAnswer.itemId=id;
                            itemAnswer.answer = answer;
                            itemAnswer.testName = $("#stuTestName").html();
                            itemAnswers.push(itemAnswer);
                            console.log(itemAnswer);
                        }else if('2' == itemType) {
                            var id = $(this).attr('id');
//                            var answers = $(this).find('checkbox selected').value;
                            var answer = "";
                            var answers =  $('input:checkbox:checked');
                            if(answers && answers.length>0) {
                                for(var i=0;i<answers.length;i++) {
                                    if(i<answers.length-1) {
                                        answer =answer+ answers[i].value + ",";
                                    }else{
                                        answer =answer+ answers[i].value + "";
                                    }
                                }
                            }

                            var itemAnswer = {};
                            itemAnswer.stuId=stuId;
                            itemAnswer.classId=classId;
                            itemAnswer.itemId=id;
                            itemAnswer.answer = answer;
                            itemAnswer.testName = $("#stuTestName").html();
                            itemAnswers.push(itemAnswer);
                            console.log(itemAnswer);
                        }

                    })
                }


                console.log(itemAnswers);
              //  itemAnswersInfo = JSON.serialize(itemAnswersInfo);
                itemAnswers = JSON.stringify(itemAnswers);
                $.post("${pageContext.request.contextPath}/rest/answer/addAnswerInfo",{answerInfo:itemAnswers},function (result) {
                    if(result.result){
                        //回显，把按钮禁用掉
                        $("#submitTest").attr({"disabled":"disabled"});
                        $("#submitTest").val("已交卷");
                        form.render();
                        layer.alert('交卷成功，请等待助教老师批阅试卷！', {
                            skin: 'layui-layer-molv' //样式类名
                            ,closeBtn: 0
                        });
                    }

                });
            })
        })


    });

    //上传附件
    function  uploadZip(itemId) {
        var options = {
            url : "/rest/uploadZip.do",
            type : "post",
            dataType : "json",
            success : function(data) {
                console.log("上传的视频地址："+data.zipPath);
                //设置图片的在表单提交后的值
                $("#zipPath"+itemId).val(data.zipPath);
            }
        };
        $("#answerForm").ajaxSubmit(options);
    }



</script>
</body>
</html>
