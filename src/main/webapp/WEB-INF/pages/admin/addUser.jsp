<%--<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>--%>
<%--
  Created by IntelliJ IDEA.
  User: changwh1
  Date: 2017/2/15
  Time: 15:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <title>添加用户</title>
    <meta charset="utf-8">
    <link href="http://img.chinanetcenter.com/lib/bui/1.1.21/css/bs3/dpl.css" rel="stylesheet">
    <link href="http://img.chinanetcenter.com/lib/bui/1.1.21/css/bs3/bui.css" rel="stylesheet">
    <link href="http://img.chinanetcenter.com/wsfe/1.0.0/prd/styles/wsfe.css" rel="stylesheet">
    <style type="text/css">
        body {
            background-color: #fff;
        }
    </style>
    <script src="http://img.chinanetcenter.com/js/jquery/jquery-1.8.1.min.js"></script>
    <script src="http://img.chinanetcenter.com/lib/bui/1.1.21/seed-min.js"></script>
    <script src="http://img.chinanetcenter.com/wsfe/1.0.0/prd/scripts/wsfe.js"></script>
</head>
<body>
    <div id="content">
        <%--<h1>添加用户</h1>--%>
        <%--<hr/>--%>
        <div class="container">
            <form id="J_Form" class="form-horizontal bui-form bui-form-field-container" action="/admin/users/addP" method="post" commandName="user" >
                <div class="control-group">
                    <label class="control-label"><s>*</s>Name:</label>
                    <div class="controls">
                        <input class="input-small" type="text" name="name" placeholder="Enter name:" data-rules="{required : true}"/>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label"><s>*</s>Sex:</label>
                    <div class="controls bui-form-group-select">
                        <select class="input-small" name="sex">
                            <option>男</option>
                            <option>女</option>
                        </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label"><s>*</s>Age:</label>
                    <div class="controls">
                        <input class="input-small" type="text" name="age" placeholder="Enter age:" data-rules="{required : true}"/>
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
