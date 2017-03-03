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
                title:'添加信息',
                width:600,
                contentId:'addInfo',
                buttons:[],
                closeAction:'destroy',
                align : {
                    //node : '',//对齐的元素，由于使用了trigger，默认跟trigger对齐
                    points : ['tc','tc'], //对齐方式
                    offset : [0,100] //偏移量
                },
            });
            dialog.show();
        });
    })
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
                    <form id="D_Form" class="form-horizontal form-horizontal-simple">
                        <div class="control-group">
                            <label class="control-label">用户名：</label>
                            <div class="controls">
                                <span class="control-text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">性别：</label>
                            <div class="controls">
                                <span class="control-text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">年龄：</label>
                            <div class="controls">
                                <span class="control-text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">电话：</label>
                            <div class="controls">
                                <span class="control-text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">地址：</label>
                            <div class="controls">
                                <span class="control-text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">邮箱：</label>
                            <div class="controls">
                                <span class="control-text"></span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">手机：</label>
                            <div class="controls">
                                <span class="control-text"></span>
                            </div>
                        </div>
                    </form>
                </div>

                <div id="updateInfo" class="hide">
                    <form id="U_Form" class="form-horizontal bui-form bui-form-field-container" action="/admin/info/updateP" method="post" commandName="infoP" role="form">
                        <div class="control-group">
                            <label class="control-label"><s>*</s>用户：</label>
                            <div class="controls">
                                <input class="input-middle" readonly="readonly" type="text" id="show" name="userName" data-rules="{required:true}">
                                <input class="needReset" type="hidden" id="hide" name="userId">
                            </div>
                            <script type="text/javascript">
                                BUI.use(['bui/picker','bui/grid','bui/data'],function(Picker,Grid,Data){

                                    var columns = [
                                                {title : 'id',dataIndex :'id', width:'25%'},
                                                {title : '姓名',dataIndex :'name', width:'25%'},
                                                {title : '性别',dataIndex :'sex', width:'25%'},
                                                {title : '年龄',dataIndex : 'age',width:'25%'}
                                            ];
                                    var store=new Data.Store({
                                        url:'usersP',
                                        autoLoad:true
                                    }),
                                    grid = new Grid.SimpleGrid({
                                        idField : 'id',
                                        columns : columns,
                                        textGetter: function(item){ //返回选中的文本
                                            return item.name;
                                        },
                                        store:store
                                    }),
                                    picker = new Picker.ListPicker({
                                        trigger : '#show',
                                        valueField : '#hide', //如果需要列表返回的value，放在隐藏域，那么指定隐藏域
                                        width:300,  //指定宽度
                                        height:300,
                                        children : [grid] //配置picker内的列表
                                    });
                                    picker.render();
                                });
                            </script>
                        </div>
                        <div class="control-group">
                            <label class="control-label">电话：</label>
                            <div class="controls">
                                <input class="input-middle" type="text" name="phone" data-rules="{number:true,maxlength:20}"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">地址：</label>
                            <div class="controls">
                                <input class="input-large" type="text" name="address" data-rules="{maxlength:255}"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">邮箱：</label>
                            <div class="controls">
                                <input class="input-large" type="text" name="email" data-rules="{email:true,maxlength:45}"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">手机：</label>
                            <div class="controls">
                                <input class="input-middle" type="text" name="mobile" data-rules="{mobile:true}"/>
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

                <script type="text/javascript">
                    BUI.use(['bui/grid','bui/data'],function(Grid,Data){
                        var Grid = Grid,
                                Store = Data.Store,
                                columns = [
                                    {title : 'ID',dataIndex :'id', width:'4%'},
                                    {title : '用户姓名',dataIndex :'userName', width:'8%'},
                                    {title : '电话',dataIndex : 'phone',width:'10%'},
                                    {title:'地址',dataIndex:'address',width:'20%'},
                                    {title:'邮箱',dataIndex:'email',width:'20%'},
                                    {title:'手机',dataIndex:'mobile',width:'10%'},
                                    {title:'操作',width:'28%',renderer:function () {
                                        return '<span class="button button-info btn-detail" style="margin-left: 9px"><i class="icon-white icon-th-list btn-detail"></i>详情</span>' +
                                                '<span class="button button-warning btn-edit" style="margin-left: 9px"><i class="icon-white icon-edit btn-edit"></i>编辑</span>' +
                                                '<span class="button button-danger btn-delete" style="margin-left: 9px"><i class="icon-white icon-trash btn-delete"></i>删除</span>';
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
                                    contentId : 'updateInfo', //设置隐藏的Dialog内容
                                    triggerCls : 'btn-edit', //触发显示Dialog的样式
                                    editor : {
                                        title : '修改信息',
                                        width : 600,
                                        form:{
                                            srcNode : '#U_Form',
                                            submitType:'ajax'
                                        },
                                        buttons:[]
                                    },
                                    align : {
                                        //node : '',//对齐的元素，由于使用了trigger，默认跟trigger对齐
                                        points : ['tc','tc'], //对齐方式
                                        offset : [0,100] //偏移量
                                    },
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

                        function deleteWarming(infoId,userName){
                            BUI.Message.Alert('确定删除用户“'+userName+'”信息？',function () {
                                $.ajax({
                                    url:"/admin/info/deleteP",
                                    type:"post",
                                    dataType:"json",
                                    data:{"id":infoId},
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

                        function showDetailInfo(userId,infoId) {
                            alert(userId+","+infoId);
                            //将这两个参数传到后端，重新读取数据后传回用户名、性别、年龄、电话、地址、邮箱、手机
                            BUI.use(['bui/overlay','bui/form'],function(Overlay,Form) {
                                var form=new Form.Form({
                                    srcNode : '#D_Form',

                                }).render();


                                var dialog=new Overlay.Dialog({
                                    title:'添加信息',
                                    width:600,
                                    contentId:'showInfo',
                                    buttons:[],
                                    closeAction:'destroy',
                                    align : {
                                        //node : '',//对齐的元素，由于使用了trigger，默认跟trigger对齐
                                        points : ['tc','tc'], //对齐方式
                                        offset : [0,100] //偏移量
                                    },
                                });
                                dialog.show();
                            });
//
//                            参考以上代码将弹窗显示出来，在通过js向列表中指定位置赋值（innerHtml）
//                            http://www.cnblogs.com/Zjingwen/p/4657127.html
                        }

                        grid.on('cellclick',function  (ev) {
                            record = ev.record, //点击行的记录
                                    field = ev.field, //点击对应列的dataIndex
                                    target = $(ev.domTarget); //点击的元素
                            if(target.hasClass('btn-delete')){
                                deleteWarming(record.id,record.userName);
                            }
                            if(target.hasClass('btn-detail')){
                                showDetailInfo(record.userId,record.id);
                            }
                        });
                    });
                </script>
            </div>
        </div>
    </div>

    <div id="addInfo" class="hide">
        <form id="A_Form" class="form-horizontal bui-form bui-form-field-container" action="/admin/info/addP" method="post" commandName="info" role="form">
            <div class="control-group">
                <label class="control-label"><s>*</s>用户：</label>
                <div class="controls">
                    <input class="input-middle" readonly="readonly" type="text" id="aShow" name="userName">
                    <input class="needReset" type="hidden" id="aHide" name="userId" data-rules="{required:true}">
                </div>
                <script type="text/javascript">
                    BUI.use(['bui/picker','bui/grid','bui/data'],function(Picker,Grid,Data){

                        var columns = [
                            {title : 'id',dataIndex :'id', width:'25%'},
                            {title : '姓名',dataIndex :'name', width:'25%'},
                            {title : '性别',dataIndex :'sex', width:'25%'},
                            {title : '年龄',dataIndex : 'age',width:'25%'}
                        ];
                        var store=new Data.Store({
                                    url:'usersP',
                                    autoLoad:true
                                }),
                                grid = new Grid.SimpleGrid({
                                    idField : 'id',
                                    columns : columns,
                                    textGetter: function(item){ //返回选中的文本
                                        return item.name;
                                    },
                                    store:store
                                }),
                                picker = new Picker.ListPicker({
                                    trigger : '#aShow',
                                    valueField : '#aHide', //如果需要列表返回的value，放在隐藏域，那么指定隐藏域
                                    width:300,  //指定宽度
                                    height:300,
                                    children : [grid] //配置picker内的列表
                                });
                        picker.render();
                    });
                </script>
            </div>
            <div class="control-group">
                <label class="control-label">电话：</label>
                <div class="controls">
                    <input class="input-middle" type="text" name="phone" data-rules="{number:true,maxlength:20}"/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">地址：</label>
                <div class="controls">
                    <input class="input-large" type="text" name="address" data-rules="{maxlength:255}"/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">邮箱：</label>
                <div class="controls">
                    <input class="input-large" type="text" name="email" data-rules="{email:true,maxlength:45}"/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">手机：</label>
                <div class="controls">
                    <input class="input-middle" type="text" name="mobile" data-rules="{mobile:true}"/>
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
</body>
</html>
