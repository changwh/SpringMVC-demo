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
</head>
<body>
    <h1>用户管理</h1>
    <hr/>
    <h3>所有用户<a href="/admin/users/add">添加</a> </h3>

    <%--如果用户列表为空--%>
    <c:if test="${empty userList}">
        <div>
            User表为空，请<a href="/admin/users/add">添加</a>
        </div>
    </c:if>

    <%--如果用户列表非空--%>
    <c:if test="${!empty userList}">
        <table>
            <tr>
                <th>ID</th>
                <th>姓名</th>
                <th>性别</th>
                <th>年龄</th>
                <th>操作</th>
            </tr>

            <c:forEach items="${userList}" var="user">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.name}</td>
                    <td>${user.sex}</td>
                    <td>${user.age}</td>
                    <td>
                        <a href="/admin/users/show/${user.id}">详情</a>
                        <a href="/admin/users/update/${user.id}">修改</a>
                        <a href="/admin/users/delete/${user.id}">删除</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
</body>
</html>
