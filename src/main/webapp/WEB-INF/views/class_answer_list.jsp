<%--
  Created by IntelliJ IDEA.
  User: yst
  Date: 2017/7/20
  Time: 0:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <title>组卷管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css" media="all">
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/lay/modules/laypage.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/common.js"></script>
</head>
<body>
<!-- 列表面板 -->
<div class="layui-form-pane" style="margin-top: 15px;">
    <form class="layui-form layui-form-pane" action="${pageContext.request.contextPath}/rest/test_source/createTestForStudent" method="post">


        <div>
            <table class="layui-table" style="height: 58px;" lay-even="" lay-skin="row" id="personTable">
                <colgroup>
                    <col width="40">
                    <col width="400">
                    <col width="400">
                    <col width="200">
                </colgroup>
                <thead>
                <tr>
                    <th align="center"style="padding: 0;text-align: center">序号</th>
                    <th align="center">班级名称</th>
                    <th align="center">试卷名称</th>
                    <th align="center">查看详情</th>
                </tr>
                </thead>
                <tbody id="tbody">
                </tbody>
            </table>
        </div>
        <div id="demo5" align="center"></div>
        <%--<div class="layui-form-item">
            <input type="button" id="createTestSourceId" class="layui-btn"  value="安排试卷">
            <button class="layui-btn"   type="reset" >重置</button>
        </div>--%>
    </form>

</div>
<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.js"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    layui.use(['laypage', 'layer','laydate','jquery','form'],function() {
        var laydate = layui.laydate;
        var laypage = layui.laypage;
        var form = layui.form();
        var $ = layui.jquery;


        //创建itemList的列表table
        //页面初始化的时候加载分页数据
        $(function(){

            //加载试卷;
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/rest/answer/queryAnswerInfoListByClassId?classId=${param.classId}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    nums = data.pagesize; //每页出现的数量
                    pageData = data;
                    var pages = Math.ceil(data.results.length / nums); //得到总页数
                    //调用分页
                    laypage({
                        cont: 'demo5',
                        pages: pages,
                        jump: function (obj) {
                            thisDate(obj.curr)
                            console.log( thisDate(obj.curr));
                            form.render();
                        }
                    })
                    return;
                },
                error: function (err) {
                    alert(err + "err");
                }
            });
        })

        //分页数据
        var pageData ;
        var nums = 1; //每页出现的数量
        var pages = 1;
        var thisDate = function (curr) {
            //此处只是演示，实际场景通常是返回已经当前页已经分组好的数据
            data = pageData.results;
            var str = '', last = curr * nums - 1;
            last = last >= data.length ? (data.length - 1) : last;
            var table = $("#tbody");
            $("#tbody tr").empty();//每次进来先清空table
            for (var i = (curr * nums - nums); i <= last; i++) {
                // str += '<li>' + data[i] + '</li>';
                var tr=$("<tr></tr>");
                var className;
                var classId = data[i].classId;
                var classNo = classId.substring(0, classId.length - 1);
                if(classId && '0' == classId.substring(classId.length-1,classId.length)){
                    className = "黑马基础班第" + classNo + "期";
                }else{
                    className = "黑马就业班第" + classNo + "期";
                }

                var testId = data[i].testId;
                var testName;
                //根据id查询试卷信息
                $.ajax({
                    type: "GET",
                    url: "${pageContext.request.contextPath}/rest/test_source/getTestSourceById?id="+testId,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async:false,
                    success: function (data) {
                        console.log(data);
                        testName = data.testName;
                    },
                    error: function (err) {
                        alert(err + "err");
                    }
                });

                 var td0 = $("<td align='center' >"+i+"</td>")
                var td1 = $("<td align='center'>"+className+"</td>")
                var td2 = $("<td align='center'>"+testName+"</td>")
                var td3 = $("<td align='center'><a href="+"/rest/class_answer_detail?classId="+classId+"&testId="+testId+"&testName="+testName+"><input type='button' class='layui-btn' value='查看详情'/></a></td>");
                td0.appendTo(tr);
                td1.appendTo(tr);
                td2.appendTo(tr);
                td3.appendTo(tr);
                tr.appendTo(table);
            }

            return table;
        };

        $(function () {
            $("#createTestSourceId").click(function () {
                var testIds = $('input:checkbox[name=classid]:checked');
                if(testIds && testIds.length>1) {
                    layer.alert('只能选择一套试卷，亲', {
                        skin: 'layui-layer-molv' //样式类名
                        ,closeBtn: 0
                    });
                    return;
                }

                $("form").submit();
            })
        })






    });

</script>
</body>
</html>
