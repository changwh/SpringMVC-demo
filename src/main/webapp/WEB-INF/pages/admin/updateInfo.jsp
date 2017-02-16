<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: changwh1
  Date: 2017/2/16
  Time: 18:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
    <head>
        <title>修改信息</title>
        <meta charset="utf-8">
    </head>
    <body>
        <div>
            <h1>修改信息</h1>
            <hr/>
            <form:form action="/admin/info/updateP" method="post" commandName="infoP" role="form">
                <div>
                    <label>Name</label>
                    <select name="userByUserId.Id">
                        <c:forEach items="${userList}" var="user">
                            <c:if test="${user.id==info.userByUserId.id}">
                                <option value="${user.id}" selected="selected">${user.name},${user.sex},${user.age}</option>
                            </c:if>
                            <c:if test="${user.id!=info.userByUserId.id}">
                                <option value="${user.id}">${user.name},${user.sex},${user.age}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label>Phone:</label>
                    <input name="phone" value="${info.phone}"/>
                </div>
                <div>
                    <label>Address:</label>
                    <input name="address" value="${info.address}"/>
                </div>
                <div>
                    <label>Email:</label>
                    <input name="email" value="${info.email}"/>
                </div>
                <div>
                    <label>Mobile:</label>
                    <input name="mobile" value="${info.mobile}"/>
                </div>
                <input type="hidden" name="id" value="${info.id}"/>
                <div>
                    <button type="submit">提交</button>
                </div>
            </form:form>
        </div>
    </body>
</html>
