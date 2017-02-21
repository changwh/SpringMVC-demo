<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            addInfo=$.ajax({
                url:"/admin/info/add",
                async:false,
                global:false,
                type:"GET",
                data:({
                    id:this.getAttribute('content')
                }),
                dataType:"jsp"
            });
            $(".panel").html(addInfo.responseText);
        });
    });
</script>
<body>
    <div id="content">
        <%--<h1>信息管理</h1>--%>
        <%--<hr/>--%>
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
                                    <th>用户姓名</th>
                                    <th>电话</th>
                                    <th>地址</th>
                                    <th>邮箱</th>
                                    <th>手机</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <c:forEach items="${infoList}" var="info">
                                <tbody>
                                    <tr>
                                        <td>${info.id}</td>
                                        <td>${info.userByUserId.name}</td>
                                        <td>${info.phone}</td>
                                        <td>${info.address}</td>
                                        <td>${info.email}</td>
                                        <td>${info.mobile}</td>
                                        <td>
                                            <button class="showB${info.id} button button-info" style="margin-left: 20px"><i class="icon-white icon-th-list"></i>详情</button>
                                            <script>
                                                $(".showB${info.id}").click(function () {
                                                    showInfo=$.ajax({
                                                        url:"/admin/info/show/${info.id}",
                                                        async:false,
                                                        global:false,
                                                        type:"GET",
                                                        data:({
                                                            id:this.getAttribute("content")
                                                        }),
                                                        dataType:"jsp"
                                                    });
                                                    $(".panel").html(showInfo.responseText);
                                                });
                                            </script>
                                            <button class="updateB${info.id} button button-warning" style="margin-left: 20px"><i class="icon-white icon-edit"></i>修改</button>
                                            <script>
                                                $(".updateB${info.id}").click(function () {
                                                    updateInfo=$.ajax({
                                                        url:"/admin/info/update/${info.id}",
                                                        async:false,
                                                        global:false,
                                                        type:"GET",
                                                        data:({
                                                            id:this.getAttribute("content")
                                                        }),
                                                        dataType:"jsp"
                                                    });
                                                    $(".panel").html(updateInfo.responseText);
                                                });
                                            </script>
                                            <a href="/admin/info/delete/${info.id}"><button class="deleteB button button-danger" style="margin-left: 20px"><i class="icon-white icon-trash"></i>删除</button></a>
                                            <script>
                                                $(".deleteB${info.id}").click(function () {
                                                    deleteInfo=$.ajax({
                                                        url:"/admin/info/delete/${info.id}",
                                                        async:false,
                                                        global:false,
                                                        type:"GET",
                                                        data:({
                                                            id:this.getAttribute("content")
                                                        }),
                                                        dataType:"jsp"
                                                    });
                                                    $(".panel").html(deleteInfo.responseText);
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
</body>
</html>
