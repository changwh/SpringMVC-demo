<%--
  Created by IntelliJ IDEA.
  User: changwh1
  Date: 2017/2/15
  Time: 14:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <title>用户管理</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <link href="//img.chinanetcenter.com/lib/bui/1.1.21/css/bs3/dpl.css" rel="stylesheet">
    <link href="//img.chinanetcenter.com/lib/bui/1.1.21/css/bs3/bui.css" rel="stylesheet">
    <link href="//img.chinanetcenter.com/wsfe/1.0.0/prd/styles/wsfe.css" rel="stylesheet">
    <%--修复选择框的向下箭头位置偏移的问题--%>
    <style type="text/css">
        .icon-caret-down{
            margin-top: 10px;
        }
    </style>
</head>

<body>
    <header class="ws-header">
        <div class="pull-left">
            <a href="#" class="ws-logo"><img src="//img.chinanetcenter.com/wsfe/img/logo.png" /></a>
            <ul class="top-nav">
                <li><a href="/" class="current"><i class="icon-white icon-user"></i>用户管理</a></li>
                <li><a href="/admin/info"><i class="icon-white icon-info-sign"></i>信息管理</a></li>
            </ul>
        </div>
    </header>
    <div id="ws-main row-fluid">
        <aside class="span4 span-first ws-sidebar ws-submenu" style="height: 100%">
            <ul class="ul-item">
                <li><a href="/" class="current">概览</a></li>
                <li>
                    <a href="javascript:;" class="open">统计分析</a>
                    <ul>
                        <li><a href="/admin/users/ageData">年龄分布</a></li>
                        <li><a href="/admin/users/sexData">性别占比</a></li>
                    </ul>
                </li>
            </ul>
        </aside>
        <div class="span20 ws-content">
            <div class="panel" style="width: 1100px">
                <div class="panel-body">
                    <h1>
                        所有用户
                        <button class="addB button button-primary" style="margin-left: 20px">
                            <i class="icon-white icon-plus"></i>
                            添加
                        </button>
                        <button class="deleteB button button-danger" style="margin-left: 20px">
                            <i class="icon-white icon-trash"></i>
                            批量删除
                        </button>
                    </h1>
                    <div id="users">
                        <div>
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
                            <div id="updateUser" class="hide">
                                <form id="U_Form" class="form-horizontal bui-form bui-form-field-container" action="/admin/users/updateP" method="post" commandName="userP" role="form">
                                    <div class="control-group">
                                        <label class="control-label"><s>*</s>姓名：</label>
                                        <div class="controls">
                                            <input class="input-small" type="text" name="name" placeholder="Enter name:" data-rules="{required : true,name}"/>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><s>*</s>性别：</label>
                                        <div class="controls bui-form-field-select" data-items="{'男':'男','女':'女'}" data-rules="{required:true}">
                                            <input type="hidden" id="hide" name="sex" value="" class="needReset">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"><s>*</s>年龄：</label>
                                        <div class="controls">
                                            <input class="input-small" type="text" name="age" placeholder="Enter age:" data-rules="{required : true,max:[120,'请输入有效年龄！'],min:[0,'请输入有效年龄！'],number:true}"/>
                                        </div>
                                    </div>
                                    <div>
                                        <input type="hidden" name="id"/>
                                    </div>
                                    <div class="row">
                                        <div class="form-actions span13 offset3">
                                            <button type="submit" class="button button-primary">提交</button>
                                            <button type="reset" class="button resetBtn">重置</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="addUser" class="hide">
        <form id="A_Form" class="form-horizontal bui-form bui-form-field-container" action="/admin/users/addP" method="post" commandName="user" role="form" >
            <div class="control-group">
                <label class="control-label"><s>*</s>姓名：</label>
                <div class="controls">
                    <input class="input-small" type="text" name="name" placeholder="Enter name:" data-rules="{required : true,name}"/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label"><s>*</s>性别：</label>
                <div class="controls bui-form-field-select" data-items="{'男':'男','女':'女'}" data-rules="{required:true}">
                    <input class="needReset" type="hidden" name="sex" value="">
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
                    <button type="reset" class="button resetBtn">重置</button>
                </div>
            </div>
        </form>
    </div>

    <script src="//img.chinanetcenter.com/js/jquery/jquery-1.8.1.min.js"></script>
    <script src="//img.chinanetcenter.com/lib/bui/1.1.21/seed-min.js"></script>
    <script src="//img.chinanetcenter.com/wsfe/1.0.0/prd/scripts/wsfe.js"></script>
    <script type="text/javascript">
        //在初始化时注册重置按钮，使隐藏域中的value也被重置
        $(document).ready(function(){
            $(".resetBtn").click(function () {
                $(".needReset").attr("value","");
            });
        });

        //生成添加用户窗口，先生成表单，后生成窗口包含表单
        BUI.use(['bui/overlay','bui/form'],function(Overlay,Form) {
            var form=new Form.Form({
                srcNode : '#A_Form',
                submitType:'ajax',
                callback:function(data){
                    if(data.status==302){
                        location.herf=data.location;
                        location.reload();
                    }
                }
            }).render();

            $(".addB").click(function () {
                var dialog=new Overlay.Dialog({
                    title:'添加用户',
                    width:600,
                    contentId:'addUser',
                    buttons:[],
                    closeAction:'destroy'
                });
                dialog.show();
            });
        });

        //显示全部用户，在store中获取数据，填入grid中；使用编辑对话框，在对话框中添加修改用户的表单；使用多选框实现批量删除功能；删除用户时的提示框
        BUI.use(['bui/grid','bui/data'],function(Grid,Data){
            var Grid = Grid,
                    Store = Data.Store,
                    columns = [
                        {title : 'ID',dataIndex :'id', width:'18%'},
                        {title : '姓名',dataIndex :'name', width:'18%'},
                        {title : '性别',dataIndex : 'sex',width:'18%'},
                        {title:'年龄',dataIndex:'age',width:'18%'},
                        {title:'操作',width:'28%',renderer:function () {
                            return '<span class="button button-warning btn-edit" style="margin-left: 20px"><i class="icon-white icon-edit btn-edit"></i>编辑</span>' +
                                    '<span class="button button-danger btn-delete" style="margin-left: 20px"><i class="icon-white icon-trash btn-delete"></i>删除</span>';
                        }}
                    ];

            var store = new Store({
                        url : 'admin/usersP',
                        autoLoad:true, //自动加载数据
                        pageSize:10,	// 配置分页数目
                        proxy : {
                            ajaxOptions : { //ajax的配置项，不要覆盖success,和error方法
                                traditional : true,
                                type : 'get',
                                dataType:'json',
                                success:function (data) {
                                    if(data.results==0) {
                                        $(".noUser").show();
                                        $(".userExist").hide();
                                    }
                                }
                            }
                        }
                    }),
                    editing = new Grid.Plugins.DialogEditing({
                        triggerSelected : false,
                        contentId : 'updateUser', //设置隐藏的Dialog内容
                        triggerCls : 'btn-edit', //触发显示Dialog的样式（按键的样式）
                        editor : {
                            title : '修改用户',
                            width : 600,
                            form:{
                                srcNode : '#U_Form',
                                submitType:'ajax'
                            },
                            buttons:[]
                        }
                    }),
                    grid = new Grid.Grid({
                        render:'#grid',
                        columns : columns,
                        width:'auto',
                        loadMask: true, //加载数据时显示屏蔽层
                        store: store,
                        plugins:[editing,Grid.Plugins.CheckSelection,Grid.Plugins.ColumnChecked],
                        // 底部工具栏
                        bbar:{
                            // pagingBar:表明包含分页栏
                            pagingBar:true
                        }
                    });

            grid.render();

            function deleteWarming(userId,userName){
                BUI.Message.Alert('确定删除用户:'+userName+'？',function () {
                    $.ajax({
                        url:"/admin/users/deleteP",
                        type:"post",
                        dataType:"json",
                        data:{"id":userId},
                        success:function (res) {
                            if(res.error){
                                BUI.Message.Alert(res.error,'error');
                            }else {
                                BUI.Message.Alert('删除成功',function () {
                                    location.reload();
                                },'success');
                            }
                        }
                    })
                },'warning');
            }

            //点击事件对该行数据进行取值
            grid.on('cellclick',function  (ev) {
                record = ev.record, //点击行的记录
                        field = ev.field, //点击对应列的dataIndex
                        target = $(ev.domTarget); //点击的元素
                if(target.hasClass('btn-delete')){
                    deleteWarming(record.id,record.name);
                    //点击后不被勾选
                    return false;
                }
            });

            function delSelected() {
                //获取被选定行的数据
                var selections = grid.getSelection();

                //拼接将要传回后端的json
                var json="{";
                var length=selections.length-1;
                for(var i=0;i<selections.length-1;i++){
                    json+="\"id"+i+"\":"+selections[i].id+",";
                }
                json+="\"id"+length+"\":"+selections[selections.length-1].id+"}";

                //对象化
                var send = eval('(' + json + ')');

                BUI.Message.Alert('确定删除选定用户？',function () {
                    $.ajax({
                        url:"/admin/users/deleteSelected",
                        type:"post",
                        data:JSON.stringify(send),
                        contentType:"text/xml",//避免传回后端的文本为url编码
                        dataType:"json",
                        success:function (res) {
                            if(res.noError){
                                BUI.Message.Alert('删除成功',function(){
                                    location.reload();
                                },'success');
                            }else {
                                res=eval(res.errorList);
                                BUI.Message.Alert('用户id“'+res+'”删除失败','error');
                            }
                        }
                    })
                },'warning');
            };
            $(".deleteB").click(function () {
                delSelected();
            });
        });

        //添加 名字为name的校验规则
        BUI.use('bui/form',function(Form){
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
        });

    </script>
</body>
</html>
