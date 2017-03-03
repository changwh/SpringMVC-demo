<%--
  Created by IntelliJ IDEA.
  User: changwh1
  Date: 2017/2/16
  Time: 16:57
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <title>信息管理</title>
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
        $(".resetBtn").click(function () {
            $(".needReset").attr("value","");
        });
    });

    BUI.use('bui/tab',function(Tab){
        var tab = new Tab.Tab({
            render : '#tab',
            elCls : 'link-tabs',
            autoRender: true,
            children:[
                {text:'<i class="icon-white icon-user"></i>用户管理',value:'1',href:'/'},
                {text:'<i class="icon-white icon-info-sign"></i>信息管理',value:'2',href:'/admin/info'}
            ],
            itemTpl : '<a href="{href}">{text}</a>'
        });
        tab.setSelected(tab.getItemAt(1));
    });

</script>
<body>
    <div class="header">
        <div class="dl-title" style="background-color: #205081;">
            <h1><div id="tab"></div></h1>
        </div>
    </div>
    <hr style="margin-top: 10px;margin-bottom: 10px"/>

    <div id="info">
        <div class="container">
            <h1>所有信息<button class="addB button button-primary" style="margin-left: 20px"><i class="icon-white icon-plus"></i>添加</button></h1>
            <div class="panel">
                <%--Info表为空--%>
                <div class="noInfo" style="display: none">
                    <h2>Info表为空，请<button class="addB button button-primary" style="margin-left: 20px"><i class="icon-white icon-plus"></i>添加</button></h2>
                </div>
                <%--Info表不为空--%>
                <div class="infoExist">
                    <div class="row">
                        <div id="grid">
                        </div>
                    </div>
                </div>

                <div id="showInfo" class="hide">

                </div>

                <div id="updateInfo" class="hide">

                </div>

                <script type="text/javascript">
                    BUI.use(['bui/grid','bui/data'],function(Grid,Data){
                        var Grid = Grid,
                                Store = Data.Store,
                                columns = [
                                    {title : 'ID',dataIndex :'id', width:'18%'},
                                    {title : '用户姓名',dataIndex :'userName', width:'18%'},
                                    {title : '电话',dataIndex : 'phone',width:'18%'},
                                    {title:'地址',dataIndex:'address',width:'18%'},
                                    {title:'邮箱',dataIndex:'email',width:'18%'},
                                    {title:'手机',dataIndex:'mobile',width:'18%'},
                                    {title:'操作',width:'28%',renderer:function () {
                                        return '<span class="button button-warning btn-edit" style="margin-left: 20px"><i class="icon-white icon-edit btn-edit"></i>编辑</span>' +
                                                '<span class="button button-danger btn-delete" style="margin-left: 20px"><i class="icon-white icon-trash btn-delete"></i>删除</span>';
                                    }}
                                ];

                        var store = new Store({
                                    url : 'infoP',
                                    autoLoad:true, //自动加载数据
                                    pageSize:10,	// 配置分页数目
                                    proxy : {
                                        ajaxOptions : { //ajax的配置项，不要覆盖success,和error方法
                                            traditional : true,
                                            type : 'get',
                                            dataType:'json',
                                            success:function (data) {
                                                if(data.results==0) {
                                                    $(".noInfo").show();
                                                    $(".infoExist").hide();
                                                }
                                            }
                                        }
                                    }
                                }),
                                editing = new Grid.Plugins.DialogEditing({
                                    contentId : 'updateUser', //设置隐藏的Dialog内容
                                    triggerCls : 'btn-edit', //触发显示Dialog的样式
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
                                    plugins:[editing],
                                    // 底部工具栏
                                    bbar:{
                                        // pagingBar:表明包含分页栏
                                        pagingBar:true
                                    }
                                });

                        grid.render();

                        function deleteWarming(userID){
                            BUI.Message.Alert('确定删除此用户？',function () {
                                $.ajax({
                                    url:"/admin/users/deleteP",
                                    type:"post",
                                    dataType:"json",
                                    data:{"id":userID},
                                    success:function (res) {
                                        if(res.error){
                                            BUI.Message.Alert(res.error,'error');
                                        }else {
                                            location.reload();
                                        }
                                    }
                                })
                            },'warning');
                        }

                        grid.on('cellclick',function  (ev) {
                            record = ev.record, //点击行的记录
                                    field = ev.field, //点击对应列的dataIndex
                                    target = $(ev.domTarget); //点击的元素
                            if(target.hasClass('btn-delete')){
                                deleteWarming(record.id);
                            }

                        });
                    });
                </script>
            </div>
        </div>
    </div>
    <%--<div id="addInfo" style="display: none">--%>
        <%--<div class="container">--%>
            <%--<form id="J_Form" class="form-horizontal bui-form bui-form-field-container" action="/admin/info/addP" method="post" commandName="info" role="form">--%>
                <%--<div class="control-group">--%>
                    <%--<label class="control-label">用户：</label>--%>
                    <%--&lt;%&ndash;选择用户&ndash;%&gt;--%>
                    <%--<div class="controls bui-form-group-select">--%>
                        <%--<select class="input-middle" name="userByUserId.id">--%>
                            <%--<c:forEach items="${userList}" var="user">--%>
                                <%--<option value="${user.id}">${user.name},${user.sex},${user.age}</option>--%>
                            <%--</c:forEach>--%>
                        <%--</select>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="control-group">--%>
                    <%--<label class="control-label">电话：</label>--%>
                    <%--<div class="controls">--%>
                        <%--<input class="input-middle" name="phone" placeholder="Enter phone number:" data-rules="{number:true,maxlength:20}"/>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="control-group">--%>
                    <%--<label class="control-label">地址：</label>--%>
                    <%--<div class="controls">--%>
                        <%--<input class="input-large" name="address" placeholder="Enter address:" data-rules="{maxlength:255}"/>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="control-group">--%>
                    <%--<label class="control-label">邮箱：</label>--%>
                    <%--<div class="controls">--%>
                        <%--<input class="input-large" name="email" placeholder="Enter email:" data-rules="{email:true,maxlength:45}"/>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="control-group">--%>
                    <%--<label class="control-label">手机：</label>--%>
                    <%--<div class="controls">--%>
                        <%--<input class="input-middle" name="mobile" placeholder="Enter mobilephone number:" data-rules="{mobile:true}"/>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="row">--%>
                    <%--<div class="form-actions span13 offset3">--%>
                        <%--<button type="submit" class="button button-primary">Submit</button>--%>
                        <%--<button type="reset" class="button">Reset</button>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</form>--%>
            <%--<script type="text/javascript">--%>
                <%--BUI.use('bui/form',function(Form){--%>
                    <%--new Form.Form({--%>
                        <%--srcNode : '#J_Form',--%>
                        <%--submitType:'ajax'--%>
                    <%--}).render();--%>
                <%--});--%>
            <%--</script>--%>
        <%--</div>--%>

    <%--</div>--%>
</body>
</html>
