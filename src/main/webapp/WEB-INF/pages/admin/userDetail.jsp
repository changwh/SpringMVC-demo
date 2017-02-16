<%--
  Created by IntelliJ IDEA.
  User: changwh1
  Date: 2017/2/15
  Time: 15:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户详情</title>
</head>
<body>
    <h1>用户详情</h1>
    <hr/>
    <table>
        <tr>
            <th>ID</th>
            <td>${user.id}</td>
        </tr>
        <tr>
            <th>Name</th>
            <td>${user.name}</td>
        </tr>
        <tr>
            <th>Sex</th>
            <td>${user.sex}</td>
        </tr>
        <tr>
            <th>Age</th>
            <td>${user.age}</td>
        </tr>
    </table>
</body>
</html>
