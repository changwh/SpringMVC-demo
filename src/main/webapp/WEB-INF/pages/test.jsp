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
                            return '<button id="showB" class="button button-info" style="margin-left: 20px"><i class="icon-white icon-th-list"></i>详情</button><button id="updateB}" class="button button-warning" style="margin-left: 20px"><i class="icon-white icon-edit"></i>修改</button><button id="deleteB" class="button button-danger" style="margin-left: 20px"><i class="icon-white icon-trash"></i>删除</button>'
                        }}
                    ];

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
            var store = new Store({
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