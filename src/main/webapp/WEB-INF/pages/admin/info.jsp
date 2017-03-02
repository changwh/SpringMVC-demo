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
    <link href="http://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css" rel="stylesheet">
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
    /*创建一个空白的模态弹窗框*/
    function BDialog(){
        this.showS=function(BName,BValue){
            BUI.use('bui/overlay',function(Overlay){
                var dialog = new Overlay.Dialog({
                    title:'用户详情',
                    width:650,
                    height:'auto',
                    mask:true,
                    align:{
                        points:['tc','bc']
                    }
                });
                effect={
                    effect:slide,
                    duration:400
                };
                dialog.set('effect',effect);
                dialog.set(BName,BValue);
                dialog.show();
            });
            $(".bui-ext-close").hide();
        };
        this.showD=function(BName,BValue,BName2,BValue2){
            BUI.use('bui/overlay',function(Overlay){
                var dialog = new Overlay.Dialog({
                    title:'用户详情',
                    width:650,
                    height:'auto',
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
            $("#addInfo").addClass("display");
            $("#addInfo").show();
        });
    });
</script>
<body>
    <div class="header">
        <div class="dl-title" style="background-color: #205081;">
            <h1><div id="tab"></div></h1>
        </div>
    </div>
    <hr style="margin-top: 10px;margin-bottom: 10px"/>

    <div id="info" class="display">
        <div class="container">
            <h1>所有信息<button class="addB button button-primary" style="margin-left: 20px"><i class="icon-white icon-plus"></i>添加</button></h1>
            <div class="panel">
                <%--Info表为空--%>
                <div>
                    <c:if test="${empty infoList}">
                        <h2>Info表为空，请<button class="addB button button-primary" style="margin-left: 20px"><i class="icon-white icon-plus"></i>添加</button></h2>
                    </c:if>
                </div>
                <%--Info表不为空--%>
                <div>
                    <c:if test="${!empty infoList}">
                        <table cellspacing="0" class="table table-head-bordered">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>用户</th>
                                    <th>电话</th>
                                    <th>地址</th>
                                    <th>邮箱</th>
                                    <th>手机</th>
                                    <th style="width: 100px">操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${infoList}" var="info">
                                    <tr>
                                        <td>${info.id}</td>
                                        <td>${info.userByUserId.name}</td>
                                        <td>${info.phone}</td>
                                        <td style="word-break : break-all; overflow:hidden; width: 300px">${info.address}</td>
                                        <td>${info.email}</td>
                                        <td>${info.mobile}</td>
                                        <td>
                                            <button id="showB${info.id}" class="button button-info" style="margin-left: 20px"><i class="icon-white icon-th-list"></i>详情</button>
                                            <script>
                                                BUI.use('bui/overlay',function(Overlay){
                                                    $("#showB${info.id}").click(function () {
                                                        bDialog=new BDialog();
                                                        loader={
                                                            url:'/admin/info/show/${info.id}',
                                                            autoLoad:false,
                                                            lazyLoad:{
                                                                event:'show',
                                                                repeat:true
                                                            }
                                                        };
                                                        buttons=[{
                                                            text:'关闭',
                                                            elCls:'button button-primary',
                                                            handler:function(){
                                                                this.close();
                                                                location.reload();
                                                            }
                                                        }];
                                                        bDialog.showD('loader',loader,'buttons',buttons);
                                                    })
                                                })
                                            </script>
                                            <button id="updateB${info.id}" class="button button-warning" style="margin-left: 20px"><i class="icon-white icon-edit"></i>修改</button>
                                            <script>
                                                BUI.use('bui/overlay',function(Overlay){
                                                    $("#updateB${info.id}").click(function () {
                                                        bDialog=new BDialog();
                                                        loader={
                                                            url:'/admin/info/update/${info.id}',
                                                            autoLoad:false,
                                                            lazyLoad:{
                                                                event:'show',
                                                                repeat:true
                                                            }
                                                        };
                                                        buttons=[{
                                                            text:'关闭',
                                                            elCls:'button button-primary',
                                                            handler:function(){
                                                                this.close();
                                                                location.reload();
                                                            }
                                                        }]
                                                        bDialog.showD('loader',loader,'buttons',buttons);
                                                    })
                                                })
                                            </script>
                                            <button id="deleteB${info.id}" class="button button-danger" style="margin-left: 20px"><i class="icon-white icon-trash"></i>删除</button>
                                            <script>
                                                BUI.use('bui/overlay',function(Overlay){
                                                    $("#deleteB${info.id}").click(function () {
                                                        bDialog=new BDialog();
                                                        bodyContent='<div style="display:table;vertical-align:middle;height:100px;text-align: center">确认删除用户${info.userByUserId.name}的信息：${info.id}？</div>';
                                                        success=function(){
                                                            $.ajax({
                                                                url:"/admin/info/delete/${info.id}",
                                                                async:false,
                                                                global:false,
                                                                type:"GET",
                                                                dataType:"html",
                                                                error:function(){
                                                                    <%--bodyContent='<div style="display:table;vertical-align:middle;height:100px;text-align: center">删除用户：${user.name}失败！</div>';--%>
                                                                    alert("删除用户${info.userByUserId.name}的信息：${info.id}失败！");
                                                                },
                                                                success:function () {
                                                                    location.reload();
                                                                }
                                                            });
                                                        }
                                                        bDialog.showD('bodyContent',bodyContent,'success',success);
                                                    })
                                                })
                                            </script>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    <div id="addInfo" style="display: none">
        <div class="container">
            <form id="J_Form" class="form-horizontal bui-form bui-form-field-container" action="/admin/info/addP" method="post" commandName="info" role="form">
                <div class="control-group">
                    <label class="control-label">用户：</label>
                    <%--选择用户--%>
                    <div class="controls bui-form-group-select">
                        <select class="input-middle" name="userByUserId.id">
                            <c:forEach items="${userList}" var="user">
                                <option value="${user.id}">${user.name},${user.sex},${user.age}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">电话：</label>
                    <div class="controls">
                        <input class="input-middle" name="phone" placeholder="Enter phone number:" data-rules="{number:true,maxlength:20}"/>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">地址：</label>
                    <div class="controls">
                        <input class="input-large" name="address" placeholder="Enter address:" data-rules="{maxlength:255}"/>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">邮箱：</label>
                    <div class="controls">
                        <input class="input-large" name="email" placeholder="Enter email:" data-rules="{email:true,maxlength:45}"/>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">手机：</label>
                    <div class="controls">
                        <input class="input-middle" name="mobile" placeholder="Enter mobilephone number:" data-rules="{mobile:true}"/>
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
