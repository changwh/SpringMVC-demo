<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: changwh1
  Date: 2017/2/16
  Time: 17:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加信息</title>
</head>
<body>
    <div>
        <h1>添加信息</h1>
        <hr/>
        <form:form action="/admin/info/addP" method="post" commandName="info" role="form">
            <div>
                <label>User:</label>
                <select name="userByUserId.id">
                    <c:forEach items="${userList}" var="user">
                        <option value="${user.id}">${user.name},${user.sex},${user.age}</option>
                    </c:forEach>
                </select>
            </div>
            <div>
                <label>Phone:</label>
                <input name="phone" placeholder="Enter phone number:"/>
            </div>
            <div>
                <label>Address:</label>
                <input name="address" placeholder="Enter address:"/>
            </div>
            <div>
                <label>Email：</label>
                <input name="email" placeholder="Enter email:"/>
            </div>
            <div>
                <label>Mobile：</label>
                <input name="mobile" placeholder="Enter mobilephone number:"/>
            </div>
            <div>
                <button type="submit">提交</button>
            </div>
        </form:form>
    </div>


</body>
</html>
