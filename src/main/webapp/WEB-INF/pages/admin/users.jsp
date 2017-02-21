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
            addUser=$.ajax({
                url:"/admin/users/add",
                async:false,
                global:false,
                type:"GET",
                data:({
                    id:this.getAttribute('content')
                }),
                dataType:"jsp"
            });
            $(".panel").html(addUser.responseText);
        });
    });
</script>
<body>
    <div id="content" class="panel">
            <%--<h1>用户管理</h1>--%>
            <%--<hr/>--%>
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
                                            <button class="showB${user.id} button button-info" style="margin-left: 20px"><i class="icon-white icon-th-list"></i>详情</button>
                                            <script>
                                                $(".showB${user.id}").click(function () {
                                                    showUser=$.ajax({
                                                        url:"/admin/users/show/${user.id}",
                                                        async:false,
                                                        global:false,
                                                        type:"GET",
                                                        data:({
                                                            id:this.getAttribute("content")
                                                        }),
                                                        dataType:"html"
                                                    });
                                                    $(".panel").html(showUser.responseText);
                                                });
                                            </script>
                                            <button class="updateB${user.id} button button-warning" style="margin-left: 20px"><i class="icon-white icon-edit"></i>修改</button>
                                            <script>
                                                $(".updateB${user.id}").click(function () {
                                                    updateUser=$.ajax({
                                                        url:"/admin/users/update/${user.id}",
                                                        async:false,
                                                        global:false,
                                                        type:"GET",
                                                        data:({
                                                            id:this.getAttribute("content")
                                                        }),
                                                        dataType:"html"
                                                    });
                                                    $(".panel").html(updateUser.responseText);
                                                });
                                            </script>
                                            <button class="deleteB${user.id} button button-danger" style="margin-left: 20px"><i class="icon-white icon-trash"></i>删除</button>
                                            <script>
                                                $(".deleteB${user.id}").click(function () {
                                                    deleteUser=$.ajax({
                                                        url:"/admin/users/delete/${user.id}",
                                                        async:false,
                                                        global:false,
                                                        type:"GET",
                                                        data:({
                                                            id:this.getAttribute("content")
                                                        }),
                                                        dataType:"html"
                                                    });
                                                    $(".panel").html(deleteUser.responseText);
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
