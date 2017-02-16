<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: changwh1
  Date: 2017/2/15
  Time: 16:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <title>更新用户</title>
    <meta charset="utf-8">
</head>
<body>
    <h1>更新用户</h1>
    <hr/>
    <form:form action="/admin/users/updateP" method="post" commandName="userP" role="form">
        <div>
            <div>
                <label>Name</label>
                <input type="text" name="name" placeholder="Enter name:" value="${user.name}"/>
            </div>
            <div>
                <label>Sex</label>
                <input type="text" name="sex" placeholder="Enter sex:" value="${user.sex}"/>
            </div>
            <div>
                <label>Age</label>
                <input type="text" name="age" placeholder="Enter age:" value="${user.age}"/>
            </div>
            <div>
                <input type="hidden" name="id" value="${user.id}"/>
            </div>
            <div>
                <button type="submit">提交</button>
            </div>
        </div>
    </form:form>
</body>
</html>
