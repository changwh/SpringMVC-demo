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
    <body>
        <div id="content">
            <%--<h1>修改信息</h1>--%>
            <%--<hr/>--%>
            <div class="container">
                <form id="J_Form" class="form-horizontal bui-form bui-form-field-container" action="/admin/info/updateP" method="post" commandName="infoP" role="form">
                    <div class="control-group">
                        <label class="control-label">Name</label>
                        <%--选择用户--%>
                        <div class="controls bui-form-group-select">
                            <select class="input-middle" name="userByUserId.Id">
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
                    </div>
                    <div class="control-group">
                        <label class="control-label">Phone:</label>
                        <div class="controls">
                            <input class="input-middle" name="phone" value="${info.phone}"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">Address:</label>
                        <div class="controls">
                            <input class="input-large" name="address" value="${info.address}"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">Email:</label>
                        <div class="controls">
                        <input class="input-large" name="email" value="${info.email}"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">Mobile:</label>
                        <div class="controls">
                            <input class="input-middle" name="mobile" value="${info.mobile}"/>
                        </div>
                    </div>
                    <input type="hidden" name="id" value="${info.id}"/>
                    <div class="row">
                        <div class="form-actions span13 offset3">
                            <button type="submit" class="button button-primary">Submit</button>
                            <button type="reset" class="button">Reset</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
