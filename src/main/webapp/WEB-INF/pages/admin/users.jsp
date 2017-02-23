<%--
  Created by IntelliJ IDEA.
  User: changwh1
  Date: 2017/2/15
  Time: 14:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <title>用户管理</title>
    <meta charset="utf-8">
    <link href="http://img.chinanetcenter.com/lib/bui/1.1.21/css/bs3/dpl.css" rel="stylesheet">
    <link href="http://img.chinanetcenter.com/lib/bui/1.1.21/css/bs3/bui.css" rel="stylesheet">
    <link href="http://img.chinanetcenter.com/wsfe/1.0.0/prd/styles/wsfe.css" rel="stylesheet">
    <style type="text/css">
        body {
            background-color: #fff;
        }
    </style>
</head>
<script src="http://img.chinanetcenter.com/js/jquery/jquery-1.8.1.min.js"></script>
<script src="http://img.chinanetcenter.com/lib/bui/1.1.21/seed-min.js"></script>
<script src="http://img.chinanetcenter.com/wsfe/1.0.0/prd/scripts/wsfe.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $(".addB").click(function(){
            $(".display").hide();
            $(".display").removeClass("display");
            $("#addUser").addClass("display");
            $("#addUser").show();
        });
//        window.dialog;
//        BUI.use('bui/overlay',function(Overlay){
//            dialog = new Overlay.Dialog({
//                title:'用户信息',
//                width:500,
//                height:250,
//                closeAction:'destroy',
//                mask:true
//            });
//        });
    });
</script>
<body>
    <div class="header">
        <div class="dl-title" style="background-color: #205081;">
            <h1><a href="/" style="text-decoration: none;color: white">Demo首页</a></h1>
        </div>
    </div>
    <hr style="margin-top: 10px;margin-bottom: 10px"/>

    <div id="users" class="display">
        <div class="container">
            <h1>所有用户<button class="addB button button-primary" style="margin-left: 20px"><i class="icon-white icon-plus"></i>添加</button></h1>
            <div class="panel">
                <%--如果用户列表为空--%>
                <div>
                    <c:if test="${empty userList}">
                        <h2>User表为空，请<button class="addB button button-primary" style="margin-left: 20px"><i class="icon-white icon-plus"></i>添加</button></h2>
                    </c:if>
                </div>
                <%--如果用户列表非空--%>
                <div>
                    <c:if test="${!empty userList}">
                        <table cellspacing="0" class="table table-head-bordered">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>姓名</th>
                                    <th>性别</th>
                                    <th>年龄</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <c:forEach items="${userList}" var="user">
                                <tbody>
                                    <tr>
                                        <td>${user.id}</td>
                                        <td>${user.name}</td>
                                        <td>${user.sex}</td>
                                        <td>${user.age}</td>
                                        <td>
                                            <button id="showB${user.id}" class="button button-info" style="margin-left: 20px"><i class="icon-white icon-th-list"></i>详情</button>

                                                <%----%>
                                                <%--数据交换方式最好改为json，不应该加载整个页面。之后进行修改。--%>
                                                <%----%>


                                            <script type="text/javascript">
                                                BUI.use('bui/overlay',function(Overlay){
                                                    var dialog = new Overlay.Dialog({
                                                        title:'用户详情',
                                                        width:500,
                                                        height:250,
//                                                            closeAction:'destroy',
                                                        mask:true,
                                                        loader:{
                                                            url:'/admin/users/show/${user.id}',
                                                            autoLoad:false,
                                                            lazyLoad:{
                                                                event:'show',
                                                                repeat:true
                                                            }
                                                        }
                                                    });
                                                    $("#showB${user.id}").click(function () {
                                                        dialog.show();
                                                    });
                                                })
                                            </script>
                                            <button id="updateB${user.id}" class="button button-warning" style="margin-left: 20px"><i class="icon-white icon-edit"></i>修改</button>
                                            <script>
                                                BUI.use('bui/overlay',function(Overlay){
                                                    var dialog1 = new Overlay.Dialog({
                                                        title:'用户详情',
                                                        width:500,
                                                        height:250,
//                                                            closeAction:'destroy',
                                                        mask:true,
                                                        buttons:[],
                                                        loader:{
                                                            url:'/admin/users/update/${user.id}',
                                                            autoLoad:false,
                                                            lazyLoad:{
                                                                event:'show',
                                                                repeat:false
                                                            }
                                                        }
                                                    });
                                                    $("#updateB${user.id}").click(function () {
                                                        dialog1.show();
                                                    });
                                                })
                                                <%--$("#updateB${user.id}").click(function () {--%>
                                                    <%--updateInfo=$.ajax({--%>
                                                        <%--url:"/admin/users/update/${user.id}",--%>
                                                        <%--async:false,--%>
                                                        <%--global:false,--%>
                                                        <%--type:"GET",--%>
                                                        <%--dataType:"html"--%>
                                                    <%--});--%>
                                                    <%--$(".display").html(updateInfo.responseText);--%>
                                                <%--});--%>
                                                <%--$("#updateB${user.id}").click(function () {--%>
                                                    <%--$(".display").hide();--%>
                                                    <%--$(".display").removeClass("display");--%>
                                                    <%--$("#updateUser").addClass("display");--%>
                                                    <%--$("#updateUser").show();--%>

                                                <%--});--%>
                                            </script>
                                            <button id="deleteB${user.id}" class="button button-danger" style="margin-left: 20px"><i class="icon-white icon-trash"></i>删除</button>
                                            <script>
                                                    BUI.use('bui/overlay',function(Overlay){
                                                        var dialog2 = new Overlay.Dialog({
                                                            title:'警告',
                                                            width:500,
                                                            height:250,
//                                                            closeAction:'destroy',
                                                            mask:true,
                                                            bodyContent:'<div style="display:table;vertical-align:middle;height:100px;text-align: center">确认删除用户：${user.name}？</div>',
                                                            success:function () {
                                                                $.ajax({
                                                                    url:"/admin/users/delete/${user.id}",
                                                                    async:false,
                                                                    global:false,
                                                                    type:"GET",
                                                                    dataType:"html"
                                                                });
                                                                location.reload();
                                                            }
                                                        });
                                                        $('#deleteB${user.id}').on('click',function () {
                                                            dialog2.show();
                                                        });
                                                    });
                                            </script>
                                        </td>
                                    </tr>
                                </tbody>
                            </c:forEach>
                        </table>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    <div id="addUser" style="display: none">
        <%--<h1>添加用户</h1>--%>
        <%--<hr/>--%>
        <div class="container">
            <form id="J_Form" class="form-horizontal bui-form bui-form-field-container" action="/admin/users/addP" method="post" commandName="user" >
                <div class="control-group">
                    <label class="control-label"><s>*</s>Name:</label>
                    <div class="controls">
                        <input class="input-small" type="text" name="name" placeholder="Enter name:" data-rules="{required : true,name}"/>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label"><s>*</s>Sex:</label>
                    <div class="controls bui-form-group-select">
                        <select class="input-small" name="sex">
                            <option>男</option>
                            <option>女</option>
                        </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label"><s>*</s>Age:</label>
                    <div class="controls">
                        <input class="input-small" type="text" name="age" placeholder="Enter age:" data-rules="{required : true,max:[120,'请输入有效年龄！'],min:[0,'请输入有效年龄！'],number:true}"/>
                    </div>
                </div>
                <div class="row">
                    <div class="form-actions span13 offset3">
                        <button type="submit" class="button button-primary">Submit</button>
                        <button type="reset" class="button">Reset</button>
                    </div>
                </div>
            </form>
            <script type="text/javascript">
                BUI.use('bui/form',function(Form){
                    //添加 名字为 sid的校验规则
                    Form.Rules.add({
                        name : 'name',  //规则名称
                        msg : '请输入正确的名字！',//默认显示的错误信息
                        validator : function(value,baseValue,formatMsg){ //验证函数，验证值、基准值、格式化后的错误信息
                            var regexp = new RegExp('((?=[\\x21-\\x7e]+)[^A-Za-z])|[\\uFE30-\\uFFA0]|[\\u3002\\uff1b\\uff0c\\uff1a\\u201c\\u2018\\u201d\\uff08\\uff09\\u3001\\uff1f\\u300a\\u300b\\u2026\\u2014]');
                            //筛选键盘上的大多数符号（ 。 ；  ， ： “ ”（ ） 、 ？ 《 》 … —）以及数字
                            if(value && regexp.test(value)){
                                return formatMsg;
                            }
                        }
                    });
                    new Form.Form({
                        srcNode : '#J_Form'
                    }).render();
                });
            </script>
        </div>
    </div>
</body>
</html>
