<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: changwh1
  Date: 2017/2/16
  Time: 16:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>信息管理</title>
</head>
<body>
    <div>
        <h1>信息管理</h1>
        <hr/>
        <h3>所有信息<a href="/admin/info/add">添加</a></h3>

        <c:if test="${empty infoList}">
            <div>Blog表为空，请<a href="/admin/info/add">添加</a></div>
        </c:if>

        <c:if test="${!empty infoList}">
            <table>
                <tr>
                    <th>ID</th>
                    <td>用户姓名</td>
                    <th>电话</th>
                    <th>地址</th>
                    <th>邮箱</th>
                    <th>手机</th>
                    <th>操作</th>
                </tr>

                <c:forEach items="${infoList}" var="info">
                    <tr>
                        <td>${info.id}</td>
                        <td>${info.userByUserId.name}</td>
                        <td>${info.phone}</td>
                        <td>${info.address}</td>
                        <td>${info.email}</td>
                        <td>${info.mobile}</td>
                        <td>
                            <a href="/admin/info/show/${info.id}">详情</a>
                            <a href="/admin/info/update/${info.id}">修改</a>
                            <a href="/admin/info/delete/${info.id}">删除</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
    </div>

</body>
</html>
