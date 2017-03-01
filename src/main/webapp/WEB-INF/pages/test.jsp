<%--
  Created by IntelliJ IDEA.
  User: changwh1
  Date: 2017/2/28
  Time: 11:49
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <title>异步加载数据,分页</title>
    <!-- 此文件为了显示Demo样式，项目中不需要引入 -->
    <link href="../../assets/code/demo.css" rel="stylesheet">

    <link href="http://g.alicdn.com/bui/bui/1.1.21/css/bs3/dpl.css" rel="stylesheet">
    <link href="http://g.alicdn.com/bui/bui/1.1.21/css/bs3/bui.css" rel="stylesheet">
    <link rel="stylesheet" href="//10.8.203.190/wsfe/1.0.0/prd/styles/wsfe.css">
    <style type="text/css">
        body {
            background-color: #fff;
        }
    </style>
</head>
<body>
<div class="demo-content">
    <div class="row">
        <div class="span16">
            <div id="grid">

            </div>
        </div>
    </div>


    <div id="content" class="hide">
        <form id="J_Form" class="form-horizontal" action="/admin/users/updateP" method="post" commandName="userP" role="form">
            <div class="control-group">
                <label class="control-label"><s>*</s>姓名：</label>
                <div class="controls">
                    <input class="input-small" type="text" name="name" placeholder="Enter name:" value="${user.name}" data-rules="{required : true,name}"/>
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
                    <input class="input-small" type="text" name="age" placeholder="Enter age:" value="${user.age}" data-rules="{required : true,max:[120,'请输入有效年龄！'],min:[0,'请输入有效年龄！'],number:true}"/>
                </div>
            </div>
            <div>
                <input type="hidden" name="id" value="${user.id}"/>
            </div>
            <div class="row">
                <div class="form-actions span13 offset3">
                    <button type="submit" class="button button-primary">提交</button>
                    <button type="reset" class="button">重置</button>
                </div>
            </div>
        </form>
    </div>
    <!-- 使用seajs方式 -->

    <script src="http://g.tbcdn.cn/fi/bui/jquery-1.8.1.min.js"></script>
    <script src="http://g.alicdn.com/bui/bui/1.1.21/seed-min.js"></script>

    <!-- script start -->
    <script type="text/javascript">
        BUI.use(['bui/grid','bui/data'],function(Grid,Data){
            var Grid = Grid,
                    Store = Data.Store,
                    columns = [
                        {title : 'ID',dataIndex :'id', width:100},
                        {title : '姓名',dataIndex :'name', width:100},
                        {title : '性别',dataIndex : 'sex',width:100},
                        {title:'年龄',dataIndex:'age',width:100},
                        {title:'操作',width:300,renderer:function () {
//                            return '<button id="showB" class="button button-info" style="margin-left: 20px"><i class="icon-white icon-th-list"></i>详情</button><button id="updateB}" class="button button-warning" style="margin-left: 20px"><i class="icon-white icon-edit"></i>修改</button><button id="deleteB" class="button button-danger" style="margin-left: 20px"><i class="icon-white icon-trash"></i>删除</button>'
                            return '<span class="button button-warning btn-edit"><i class="icon-white icon-edit"></i>编辑</span>'
                        }}
                    ];
//                    data=[{id:'1',name:'test',sex:'男',age:'11'}];


//            var isAddRemote = false,
                    editing = new Grid.Plugins.DialogEditing({
                        contentId : 'content', //设置隐藏的Dialog内容
                        triggerCls : 'btn-edit', //触发显示Dialog的样式
                        editor : {
                            title : '自定义',
                            width : 600,
                            form:{
                                srcNode : '#J_Form',
                                submitType:'ajax'
                            },
//                            listeners : {
//                                show : function(){
//                                    var form = this.get('form');
//                                    if(!isAddRemote){
//                                        var bField = form.getField('id');
//                                        bField.set('remote',{
//                                            url : 'admin/usersP',
//                                            dataType:'json',//默认为字符串
//                                            callback : function(data){
//                                                if(data.success){
//                                                    alert("success");
//                                                    return '';
//                                                }else{
//                                                    return data.msg;
//                                                }
//                                            }
//                                        });
//                                        isAddRemote = true;
//                                    }
//                                    //TO DO
//                                }
//                            }
                        }
                    }),
            /**
             * 自动发送的数据格式：
             *  1. start: 开始记录的起始数，如第 20 条,从0开始
             *  2. limit : 单页多少条记录
             *  3. pageIndex : 第几页，同start参数重复，可以选择其中一个使用
             *
             * 返回的数据格式：
             *  {
             *     "rows" : [{},{}], //数据集合
             *     "results" : 100, //记录总数
             *     "hasError" : false, //是否存在错误
             *     "error" : "" // 仅在 hasError : true 时使用
             *   }
             *
             */
            store = new Store({
                url : 'admin/usersP',
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
                        type : 'get'
                    }
                },
            }),
            grid = new Grid.Grid({
                render:'#grid',
                columns : columns,
                width:'800',
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
        });
    </script>
    <!-- script end -->
</div>
</body>
</html>