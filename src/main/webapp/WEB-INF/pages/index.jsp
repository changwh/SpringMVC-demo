<%--
  Created by IntelliJ IDEA.
  User: changwh1
  Date: 2017/2/16
  Time: 13:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Demo首页</title>
    <link href="http://img.chinanetcenter.com/lib/bui/1.1.21/css/bs3/dpl.css" rel="stylesheet">
    <link href="http://img.chinanetcenter.com/lib/bui/1.1.21/css/bs3/bui.css" rel="stylesheet">
    <link href="http://img.chinanetcenter.com/wsfe/1.0.0/prd/styles/wsfe.css" rel="stylesheet">
    <style type="text/css">
        body {
            background-color: #fff;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="dl-title" style="background-color: #205081;">
            <h1><a href="/" style="text-decoration: none;color: white">Demo首页</a></h1>
        </div>
    </div>
    <hr style="margin-top: 10px;margin-bottom: 10px"/>
    <h3 style="text-align: center">
        <a href="/admin/users"><button id="label1" class="button button-primary"><i class="icon-white icon-user"></i>用户管理</button></a>
        <a href="/admin/info"><button id="label2" class="button button-primary"><i class="icon-white icon-info-sign"></i>信息管理</button></a>
    </h3>
</body>
</html>
