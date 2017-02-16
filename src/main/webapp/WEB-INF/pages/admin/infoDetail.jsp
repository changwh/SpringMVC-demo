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
</head>
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
