<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: changwh1
  Date: 2017/2/15
  Time: 15:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加用户</title>
</head>
<body>
    <h1>添加用户</h1>
    <hr/>
    <form:form action="/admin/users/addP" method="post" commandName="user" role="form">
        <div>
            <label>Name</label>
            <input type="text" id="name" name="name" placeholder="Enter name:"/>
        </div>
        <div>
            <label>Sex</label>
            <input type="text" id="sex" name="sex" placeholder="Enter sex:"/>
        </div>
        <div>
            <label>Age</label>
            <input type="text" id="age" name="age" placeholder="Enter age:"/>
        </div>
        <div>
            <button type="submit">提交</button>
        </div>
    </form:form>
</body>
</html>
