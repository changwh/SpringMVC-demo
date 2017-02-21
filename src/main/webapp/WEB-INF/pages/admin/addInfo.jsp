<%--<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: changwh1
  Date: 2017/2/16
  Time: 17:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <title>添加信息</title>
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
        <%--<h1>添加信息</h1>--%>
        <%--<hr/>--%>
        <div class="container">
            <form id="J_Form" class="form-horizontal bui-form bui-form-field-container" action="/admin/info/addP" method="post" commandName="info" role="form">
                <div class="control-group">
                    <label class="control-label"><s></s>User:</label>
                        <%--选择用户--%>
                    <div class="controls bui-form-group-select">
                        <select class="input-middle" name="userByUserId.id">
                            <c:forEach items="${userList}" var="user">
                                <option value="${user.id}">${user.name},${user.sex},${user.age}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label"><s></s>Phone:</label>
                    <div class="controls">
                        <input class="input-middle" name="phone" placeholder="Enter phone number:"/>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label"><s></s>Address:</label>
                    <div class="controls">
                        <input class="input-large" name="address" placeholder="Enter address:"/>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label"><s></s>Email:</label>
                    <div class="controls">
                        <input class="input-large" name="email" placeholder="Enter email:"/>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label"><s></s>Mobile:</label>
                    <div class="controls">
                        <input class="input-middle" name="mobile" placeholder="Enter mobilephone number:"/>
                    </div>
                </div>
                <div class="row">
                    <div class="form-actions span13 offset3">
                        <button type="submit" class="button button-primary">Submit</button>
                        <button type="reset" class="button">Reset</button>
                    </div>
                </div>
            </form>
            <script type="text/javascript">
                BUI.use('bui/form',function(Form){
                    new Form.Form({
                        srcNode : '#J_Form'
                    }).render();
                });
            </script>
        </div>

    </div>


</body>
</html>
