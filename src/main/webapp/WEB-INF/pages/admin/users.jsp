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
    /*创建一个空白的模态弹窗框*/
    function BDialog(){
        this.showD=function(BName,BValue,BName2,BValue2){
            BUI.use('bui/overlay',function(Overlay){
                var dialog = new Overlay.Dialog({
                    title:'用户详情',
                    width:500,
                    height:250,
                    closeAction:'destroy',
                    mask:true,
                    align:{
                        points:['tc','bc']
                    }
                });
                effect={
                    effect:'slide',
                    duration:400
                };
                dialog.set('effect',effect);
                dialog.set(BName,BValue);
                dialog.set(BName2,BValue2);
                dialog.show();
            });
            $(".bui-ext-close").hide();
        }
    }
    $(document).ready(function(){
        $(".addB").click(function(){
            $(".display").hide();
            $(".display").removeClass("display");
            $("#addUser").addClass("display");
            $("#addUser").show();
        });
    });
    function hello() {
        alert("hello");
    }
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
                <div class="noUser" style="display: none">
                    <h2>User表为空，请<button class="addB button button-primary" style="margin-left: 20px"><i class="icon-white icon-plus"></i>添加</button></h2>
                </div>
                <%--如果用户列表不为空--%>
                <div class="userExist">
                    <div class="row">
                        <div id="grid">
                        </div>
                    </div>
                </div>

                <script type="text/javascript">
                    BUI.use(['bui/grid','bui/data'],function(Grid,Data){
                        var Grid = Grid,
                            Store = Data.Store,
                            columns = [
                                {title : 'ID',dataIndex :'id', width:'16%'},
                                {title : '姓名',dataIndex :'name', width:'16%'},
                                {title : '性别',dataIndex : 'sex',width:'16%'},
                                {title:'年龄',dataIndex:'age',width:'16%'},
                                {title:'操作',width:'36%',renderer:function () {
                                    return '<button id="showB" class="button button-info" style="margin-left: 20px"><i class="icon-white icon-th-list"></i>详情</button>' +
                                            '<button id="updateB" class="button button-warning" style="margin-left: 20px"><i class="icon-white icon-edit"></i>修改</button>' +
                                            '<button id="deleteB" class="button button-danger" style="margin-left: 20px"><i class="icon-white icon-trash"></i>删除</button>'
                                }}
                            ];

                        var store = new Store({
                            url : 'usersP',
                            autoLoad:true, //自动加载数据
                            params : { //配置初始请求的参数
                                id : 'id',
                                name : 'name',
                                sex:'sex',
                                age:'age'
                            },
                            pageSize:10,	// 配置分页数目
                            proxy : {
                                ajaxOptions : { //ajax的配置项，不要覆盖success,和error方法
                                    traditional : true,
                                    type : 'get',
                                    dataType:'json',
                                    success:function (data) {
                                        window.jsonData=data;
                                        if(jsonData.results==0) {
                                            $(".noUser").show();
                                            $(".userExist").hide();
                                        }
                                        alert(jsonData.rows[0].id);
                                    }
                                }
                            },
                        }),
                        grid = new Grid.Grid({
                            render:'#grid',
                            columns : columns,
                            width:'auto',
                            loadMask: true, //加载数据时显示屏蔽层
                            store: store,
                            // 底部工具栏
                            bbar:{
                                // pagingBar:表明包含分页栏
                                pagingBar:true
                            }
                        });

                        grid.render();

                    });
                </script>
                <%--如果用户列表非空--%>
                <%--<div>--%>
                    <%--<c:if test="${!empty userList}">--%>
                        <%--<table cellspacing="0" class="table table-head-bordered">--%>
                            <%--<thead>--%>
                                <%--<tr>--%>
                                    <%--<th>ID</th>--%>
                                    <%--<th>姓名</th>--%>
                                    <%--<th>性别</th>--%>
                                    <%--<th>年龄</th>--%>
                                    <%--<th>操作</th>--%>
                                <%--</tr>--%>
                            <%--</thead>--%>
                            <%--<tbody>--%>
                                <%--<c:forEach items="${userList}" var="user">--%>
                                    <%--<tr>--%>
                                        <%--<td>${user.id}</td>--%>
                                        <%--<td>${user.name}</td>--%>
                                        <%--<td>${user.sex}</td>--%>
                                        <%--<td>${user.age}</td>--%>
                                        <%--<td>--%>
                                            <%--<button id="showB${user.id}" class="button button-info" style="margin-left: 20px"><i class="icon-white icon-th-list"></i>详情</button>--%>

                                            <%--&lt;%&ndash;&ndash;%&gt;--%>
                                            <%--&lt;%&ndash;数据交换方式最好改为json，不应该加载整个页面。之后进行修改。&ndash;%&gt;--%>
                                            <%--&lt;%&ndash;&ndash;%&gt;--%>

                                            <%--&lt;%&ndash;&ndash;%&gt;--%>
                                            <%--&lt;%&ndash;出现弹窗数大于两个的情况时，不能再打开新的弹窗。考虑将js进行封装，之后通过点击按键传入参数id进行触发，关闭弹窗时：closeAction:'destroy'&ndash;%&gt;--%>
                                            <%--&lt;%&ndash;&ndash;%&gt;--%>

                                            <%--&lt;%&ndash;&ndash;%&gt;--%>
                                            <%--&lt;%&ndash;以上方式尝试后发现没有效果，暂时使用强制刷新跳过此BUG&ndash;%&gt;--%>
                                            <%--&lt;%&ndash;&ndash;%&gt;--%>

                                            <%--<script type="text/javascript">--%>
                                                <%--BUI.use('bui/overlay',function(Overlay){--%>
                                                    <%--$("#showB").on('click',function () {--%>
                                                        <%--bDialog=new BDialog();--%>
                                                        <%--loader={--%>
                                                            <%--url:'/admin/users/show/${user.id}',--%>
                                                            <%--autoLoad:false,--%>
                                                            <%--lazyLoad:{--%>
                                                                <%--event:'show',--%>
                                                                <%--repeat:true--%>
                                                            <%--}--%>
                                                        <%--};--%>
                                                        <%--buttons=[{--%>
                                                            <%--text:'关闭',--%>
                                                            <%--elCls:'button button-primary',--%>
                                                            <%--handler:function(){--%>
                                                                <%--this.close();--%>
                                                                <%--location.reload();--%>
                                                            <%--}--%>
                                                        <%--}];--%>
                                                        <%--bDialog.showD('loader',loader,'buttons',buttons);--%>
                                                    <%--})--%>
                                                <%--})--%>
                                            <%--</script>--%>
                                            <%--<button id="updateB${user.id}" class="button button-warning" style="margin-left: 20px"><i class="icon-white icon-edit"></i>修改</button>--%>
                                            <%--<script>--%>
                                                <%--BUI.use('bui/overlay',function(Overlay){--%>
                                                    <%--$("#updateB${user.id}").on('click',function () {--%>
                                                        <%--bDialog=new BDialog();--%>
                                                        <%--loader={--%>
                                                            <%--url:'/admin/users/update/${user.id}',--%>
                                                            <%--autoLoad:false,--%>
                                                            <%--lazyLoad:{--%>
                                                                <%--event:'show',--%>
                                                                <%--repeat:true--%>
                                                            <%--}--%>
                                                        <%--};--%>
                                                        <%--buttons=[{--%>
                                                            <%--text:'关闭',--%>
                                                            <%--elCls:'button button-primary',--%>
                                                            <%--handler:function(){--%>
                                                                <%--this.close();--%>
                                                                <%--location.reload();--%>
                                                            <%--}--%>
                                                        <%--}]--%>
                                                        <%--bDialog.showD('loader',loader,'buttons',buttons);--%>
                                                    <%--})--%>
                                                <%--})--%>
                                            <%--</script>--%>
                                            <%--<button id="deleteB${user.id}" class="button button-danger" style="margin-left: 20px"><i class="icon-white icon-trash"></i>删除</button>--%>
                                            <%--<script>--%>
                                                <%--&lt;%&ndash;&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;删除失败提示框为系统自带，有时间可更换为BUI&ndash;%&gt;--%>
                                                <%--&lt;%&ndash;&ndash;%&gt;--%>
                                                <%--BUI.use('bui/overlay',function(Overlay){--%>
                                                    <%--$("#deleteB${user.id}").on('click',function () {--%>
                                                        <%--bDialog=new BDialog();--%>
                                                        <%--bodyContent='<div style="display:table;vertical-align:middle;height:100px;text-align: center">确认删除用户：${user.name}？</div>';--%>

                                                        <%--success=function(){--%>
                                                            <%--$.ajax({--%>
                                                                <%--url:"/admin/users/delete/${user.id}",--%>
                                                                <%--async:false,--%>
                                                                <%--global:false,--%>
                                                                <%--type:"GET",--%>
                                                                <%--dataType:"html",--%>
                                                                <%--error:function(){--%>
                                                                    <%--&lt;%&ndash;bodyContent='<div style="display:table;vertical-align:middle;height:100px;text-align: center">删除用户：${user.name}失败！</div>';&ndash;%&gt;--%>
                                                                    <%--alert("删除用户：${user.name} 失败！");--%>
                                                                <%--},--%>
                                                                <%--success:function () {--%>
                                                                    <%--location.reload();--%>
                                                                <%--}--%>
                                                            <%--});--%>
                                                        <%--}--%>
                                                        <%--bDialog.showD('bodyContent',bodyContent,'success',success);--%>
                                                    <%--})--%>
                                                <%--})--%>
                                            <%--</script>--%>
                                        <%--</td>--%>
                                    <%--</tr>--%>
                                <%--</c:forEach>--%>
                            <%--</tbody>--%>
                        <%--</table>--%>
                    <%--</c:if>--%>
                <%--</div>--%>
            </div>
        </div>
    </div>
    <div id="content" class="hide">
        <form class="form-horizontal">
            <div class="row">
                <div class="control-group span8">
                    <label class="control-label"><s>*</s>文本：</label>
                    <div class="controls">
                        <input name="a" type="text" data-rules="{required:true}" class="input-normal control-text">
                    </div>
                </div>
                <div class="control-group span8">
                    <label class="control-label"><s>*</s>数字：</label>
                    <div class="controls">
                        <input name="b" type="text" data-rules="{required:true,number : true}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group span8 ">
                    <label class="control-label">日期：</label>
                    <div id="range" class="controls">
                        <input name="c" class="calendar" type="text">
                    </div>
                </div>
                <div class="control-group span8">
                    <label class="control-label">选择：</label>
                    <div class="controls">
                        <select name="d" class="input-normal">
                            <option value="">请选择</option>
                            <option value="1">选项一</option>
                            <option value="2">选项二</option>
                        </select>
                    </div>
                </div>

            </div>
            <div class="row">
                <div class="control-group span12">
                    <label class="control-label">多选：</label>
                    <div class="controls bui-form-field-select" data-select="{multipleSelect:true,items : [{text:'选项一',value:'1'},{text:'选项二',value:'2'},{text:'选项三',value:'3'}]}">
                        <input type="hidden" name="e">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group span15">
                    <label class="control-label">备注：</label>
                    <div class="controls control-row4">
                        <textarea name="f" class="input-large" type="text"></textarea>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div id="addUser" style="display: none">
        <div class="container">
            <form id="J_Form" class="form-horizontal bui-form bui-form-field-container" action="/admin/users/addP" method="post" commandName="user" role="form" >
                <div class="control-group">
                    <label class="control-label"><s>*</s>姓名：</label>
                    <div class="controls">
                        <input class="input-small" type="text" name="name" placeholder="Enter name:" data-rules="{required : true,name}"/>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label"><s>*</s>性别：</label>
                    <div class="controls bui-form-group-select">
                        <select class="input-small" name="sex">
                            <option>男</option>
                            <option>女</option>
                        </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label"><s>*</s>年龄：</label>
                    <div class="controls">
                        <input class="input-small" type="text" name="age" placeholder="Enter age:" data-rules="{required : true,max:[120,'请输入有效年龄！'],min:[0,'请输入有效年龄！'],number:true}"/>
                    </div>
                </div>
                <div class="row">
                    <div class="form-actions span13 offset3">
                        <button type="submit" class="button button-primary">提交</button>
                        <button type="reset" class="button">重置</button>
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
                        srcNode : '#J_Form',
                        submitType:'ajax'
                    }).render();
                });
            </script>
        </div>
    </div>
</body>
</html>
