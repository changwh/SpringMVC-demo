<%--
  Created by IntelliJ IDEA.
  User: changwh1
  Date: 2017/2/28
  Time: 11:49
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>标准简单列表</title>
    <!-- 此文件为了显示Demo样式，项目中不需要引入 -->
    <%--<link href="../../assets/code/demo.css" rel="stylesheet">--%>

    <link href="http://g.alicdn.com/bui/bui/1.1.21/css/bs3/dpl.css" rel="stylesheet">
    <link href="http://g.alicdn.com/bui/bui/1.1.21/css/bs3/bui.css" rel="stylesheet">
    <link rel="stylesheet" href="//10.8.203.190/wsfe/1.0.0/prd/styles/wsfe.css">
    <%--<style type="text/css">--%>
        <%--body {--%>
            <%--background-color: #fff;--%>
        <%--}--%>
        <%--.icon-caret-down{--%>
            <%--margin-top: 10px;--%>
        <%--}--%>
    <%--</style>--%>
</head>
<body>
<%--<form id="J_Form" action="" class="form-horizontal">--%>
    <%--<div class="control-group">--%>
        <%--<label class="control-label">模拟单选下拉</label>--%>
        <%--<div class="controls bui-form-field-select" data-items="{'1':'1班','2' : '2班','3' : '3班'}">--%>
            <%--<input name="d" type="hidden" value="1">--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</form>--%>
<script src="http://g.tbcdn.cn/fi/bui/jquery-1.8.1.min.js"></script>
<script src="http://g.alicdn.com/bui/bui/1.1.21/seed-min.js"></script>
<script>
    $(document).ready(function(){
        $.ajax({
            url:"http://10.8.203.42:8080/doc/demo/list/data/list.json",
//            type:"post",
//            data:JSON.stringify(send),
//            contentType:"text/xml",//避免传回后端的文本为url编码
//            dataType:"json",
            success:function (res) {
//                if(res.noError){
//                    BUI.Message.Alert('删除成功',function(){
//                        location.reload();
//                    },'success');
//                }else {
//                    res=eval(res.errorList);
//                    BUI.Message.Alert('用户id“'+res+'”删除失败','error');
//                }
                console.log(res);
            }
        })
    });

</script>
</body>
</html>