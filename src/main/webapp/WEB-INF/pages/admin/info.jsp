<%--
  Created by IntelliJ IDEA.
  User: changwh1
  Date: 2017/2/16
  Time: 16:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <title>信息管理</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <link href="http://img.chinanetcenter.com/lib/bui/1.1.21/css/bs3/dpl.css" rel="stylesheet">
    <link href="http://img.chinanetcenter.com/lib/bui/1.1.21/css/bs3/bui.css" rel="stylesheet">
    <link href="http://img.chinanetcenter.com/wsfe/1.0.0/prd/styles/wsfe.css" rel="stylesheet">
</head>
<body>
    <header class="ws-header">
        <div class="header pull-left">
            <a href="#" class="ws-logo"><img src="//img.chinanetcenter.com/wsfe/img/logo.png" /></a>
            <ul class="top-nav">
                <li><a href="/"><i class="icon-white icon-user"></i>用户管理</a></li>
                <li><a href="/admin/info" class="current"><i class="icon-white icon-info-sign"></i>信息管理</a></li>
            </ul>
        </div>
    </header>
    <div id="ws-main row-fluid">
        <aside class="span4 span-first ws-sidebar ws-submenu" style="height: 100%">
            <ul class="ul-item">
                <li><a href="#" class="current">概览</a></li>
                <li>
                    <a href="javascript:;" class="close">自助配置</a>
                    <ul>
                        <li><a href="#">带宽</a></li>
                        <li><a href="#" class="current">流量</a></li>
                        <li><a href="#">请求数</a></li>
                    </ul>
                </li>
                <li>
                    <a href="javascript:;" class="open">统计分析</a>
                    <ul>
                        <li><a href="#">带宽</a></li>
                        <li><a href="#" class="current">流量</a></li>
                        <li><a href="#">请求数</a></li>
                    </ul>
                </li>
            </ul>
        </aside>
        <div class="span20 ws-content">
            <div class="panel" style="width: 1100px">
                <div class="panel-body">
                    <h1>
                        所有信息
                        <button class="addB button button-primary" style="margin-left: 20px">
                            <i class="icon-white icon-plus"></i>
                            添加
                        </button>
                        <button class="deleteB button button-danger" style="margin-left: 20px">
                            <i class="icon-white icon-trash"></i>
                            批量删除
                        </button>
                    </h1>
                    <div id="info">
                        <div>
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
                                            <span class="control-text" id="showName"></span>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">性别：</label>
                                        <div class="controls">
                                            <span class="control-text" id="showSex"></span>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">年龄：</label>
                                        <div class="controls">
                                            <span class="control-text" id="showAge"></span>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">电话：</label>
                                        <div class="controls">
                                            <span class="control-text" id="showPhone"></span>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">地址：</label>
                                        <div class="controls">
                                            <span class="control-text" id="showAddress"></span>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">邮箱：</label>
                                        <div class="controls">
                                            <span class="control-text" id="showEmail"></span>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">手机：</label>
                                        <div class="controls">
                                            <span class="control-text" id="showMobile"></span>
                                        </div>
                                    </div>
                                </form>
                            </div>

                            <div id="updateInfo" class="hide">
                                <form id="U_Form" class="form-horizontal bui-form bui-form-field-container" action="/admin/info/updateP" method="post" commandName="infoP" role="form">
                                    <div class="control-group">
                                        <label class="control-label"><s>*</s>用户：</label>
                                        <div class="controls">
                                            <input class="input-middle showV" readonly="readonly" type="text"  name="userName" data-rules="{required:true}">
                                            <input class="needReset hideV" type="hidden" name="userId">
                                        </div>
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
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="addInfo" class="hide">
        <form id="A_Form" class="form-horizontal bui-form bui-form-field-container" action="/admin/info/addP" method="post" commandName="info" role="form">
            <div class="control-group">
                <label class="control-label"><s>*</s>用户：</label>
                <div class="controls">
                    <input class="input-middle showV" readonly="readonly" type="text" name="userName">
                    <input class="needReset hideV" type="hidden" name="userId" data-rules="{required:true}">
                </div>
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
    <script src="http://img.chinanetcenter.com/js/jquery/jquery-1.8.1.min.js"></script>
    <script src="http://img.chinanetcenter.com/lib/bui/1.1.21/seed-min.js"></script>
    <script src="http://img.chinanetcenter.com/wsfe/1.0.0/prd/scripts/wsfe.js"></script>
    <script type="text/javascript">
        //在初始化时注册重置按钮，使隐藏域中的value也被重置
        $(document).ready(function(){
            $(".resetBtn").click(function () {
                $(".needReset").attr("value","");
            });
        });

        //生成添加信息窗口，先生成表单，后生成窗口包含表单
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
        });

        //在添加和修改信息的对话框中对用户进行查询，使用列表将所有用户显示出来以供选择
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
                        idField : 'id',//放入picker中valueField的值
                        columns : columns,
                        textGetter: function(item){ //返回选中的文本到输入框中,过滤掉其他无用信息
                            return item.name;
                        },
                        store:store
                    }),
                    picker = new Picker.ListPicker({
                        trigger : '.showV',
                        valueField : '.hideV', //如果需要列表返回的value，放在隐藏域，那么指定隐藏域
                        width:300,
                        children : [grid] //配置picker内的列表
                    });
            picker.render();
        });

        //显示全部信息，在store中获取数据，填入grid中；使用编辑对话框，在对话框中添加修改信息的表单；使用多选框实现批量删除功能；删除信息时的提示框；显示消息详情对话框
        BUI.use(['bui/grid','bui/data'],function(Grid,Data){
            var Grid = Grid,
                    Store = Data.Store,
                    columns = [
                        {title : 'ID',dataIndex :'id', width:'6%'},
                        {title : '用户姓名',dataIndex :'userName', width:'8%'},
                        {title : '电话',dataIndex : 'phone',width:'10%'},
                        {title:'地址',dataIndex:'address',width:'20%'},
                        {title:'邮箱',dataIndex:'email',width:'20%'},
                        {title:'手机',dataIndex:'mobile',width:'10%'},
                        {title:'操作',width:'26%',renderer:function () {
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
                        plugins:[editing,Grid.Plugins.CheckSelection,Grid.Plugins.ColumnChecked],
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
                                BUI.Message.Alert('删除成功',function () {
                                    location.reload();
                                },'success');
                            }
                        }
                    })
                },'warning');
            }

            function showDetailInfo(infoId) {
                $.ajax({
                    url:"/admin/info/show",
                    type:"post",
                    dataType:"json",
                    data:{"id":infoId},
                    success:function(res){
                        $("#showName").text(res.name);
                        $("#showSex").text(res.sex);
                        $("#showAge").text(res.age);
                        $("#showPhone").text(res.phone);
                        $("#showAddress").text(res.address);
                        $("#showEmail").text(res.email);
                        $("#showMobile").text(res.mobile);
                    }
                });

                BUI.use(['bui/overlay','bui/form'],function(Overlay,Form) {
                    var form=new Form.Form({
                        srcNode : '#D_Form'
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
            }

            grid.on('cellclick',function  (ev) {
                record = ev.record, //点击行的记录
                        field = ev.field, //点击对应列的dataIndex
                        target = $(ev.domTarget); //点击的元素
                if(target.hasClass('btn-delete')){
                    deleteWarming(record.id,record.userName);
                    return false;
                }
                if(target.hasClass('btn-detail')){
                    showDetailInfo(record.id);
                    return false;
                }
            });

            function delSelected() {
                var selections = grid.getSelection();
                var json="{";
                var length=selections.length-1;
                for(var i=0;i<selections.length-1;i++){
                    json+="\"id"+i+"\":"+selections[i].id+",";
                }
                json+="\"id"+length+"\":"+selections[selections.length-1].id+"}";

                var send = eval('(' + json + ')');
                BUI.Message.Alert('确定删除选定信息？',function () {
                    $.ajax({
                        url:"/admin/info/deleteSelected",
                        type:"post",
                        data:JSON.stringify(send),
                        contentType:"text/xml",
                        dataType:"json",
                        success:function (res) {
                            if(res.noError){
                                BUI.Message.Alert('删除成功',function () {
                                    location.reload();
                                },'success');
                            }else {
                                res=eval(res.errorList);
                                BUI.Message.Alert('信息id:'+res+'删除失败','error');
                            }
                        }
                    })
                },'warning');
            };
            $(".deleteB").click(function () {
                delSelected();
            });
        });

    </script>
</body>
</html>
