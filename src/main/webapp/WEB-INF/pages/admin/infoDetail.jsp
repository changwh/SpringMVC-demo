<%--
  Created by IntelliJ IDEA.
  User: changwh1
  Date: 2017/2/16
  Time: 17:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <title>信息详情</title>
    <meta charset="utf-8">
    <link href="http://img.chinanetcenter.com/lib/bui/1.1.21/css/bs3/dpl.css" rel="stylesheet">
    <link href="http://img.chinanetcenter.com/lib/bui/1.1.21/css/bs3/bui.css" rel="stylesheet">
    <link href="http://img.chinanetcenter.com/wsfe/1.0.0/prd/styles/wsfe.css" rel="stylesheet">
</head>
<script src="http://img.chinanetcenter.com/js/jquery/jquery-1.8.1.min.js"></script>
<script src="http://img.chinanetcenter.com/lib/bui/1.1.21/seed-min.js"></script>
<script src="http://img.chinanetcenter.com/wsfe/1.0.0/prd/scripts/wsfe.js"></script>
<body>
    <div>
        <h1>信息详情</h1>
        <hr/>
        <table>
            <tr>
                <th>ID</th>
                <td>${info.id}</td>
            </tr>
            <tr>
                <th>Name</th>
                <td>${info.userByUserId.name}</td>
            </tr>
            <tr>
                <th>Sex</th>
                <td>${info.userByUserId.sex}</td>
            </tr>
            <tr>
                <th>Age</th>
                <td>${info.userByUserId.age}</td>
            </tr>
            <tr>
                <th>Phone</th>
                <td>${info.phone}</td>
            </tr>
            <tr>
                <th>Address</th>
                <td>${info.address}</td>
            </tr>
            <tr>
                <th>Email</th>
                <td>${info.email}</td>
            </tr>
            <tr>
                <th>Mobile</th>
                <td>${info.mobile}</td>
            </tr>
        </table>
    </div>
</body>
</html>
