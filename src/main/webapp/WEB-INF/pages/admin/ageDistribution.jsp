<%--
  Created by IntelliJ IDEA.
  User: changwh1
  Date: 2017/3/10
  Time: 11:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <title>年龄分布统计</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <link href="//img.chinanetcenter.com/lib/bui/1.1.21/css/bs3/dpl.css" rel="stylesheet">
    <link href="//img.chinanetcenter.com/lib/bui/1.1.21/css/bs3/bui.css" rel="stylesheet">
    <link href="//img.chinanetcenter.com/wsfe/1.0.0/prd/styles/wsfe.css" rel="stylesheet">
</head>

<body>
<header class="ws-header">
    <div class="pull-left">
        <a href="#" class="ws-logo"><img src="//img.chinanetcenter.com/wsfe/img/logo.png" /></a>
        <ul class="top-nav">
            <li><a href="/" class="current"><i class="icon-white icon-user"></i>用户管理</a></li>
            <li><a href="/admin/info"><i class="icon-white icon-info-sign"></i>信息管理</a></li>
        </ul>
    </div>
</header>
<div id="ws-main row-fluid">
    <aside class="span4 span-first ws-sidebar ws-submenu" style="height: 100%">
        <ul class="ul-item">
            <li><a href="/">概览</a></li>
            <li>
                <a href="javascript:;" class="close">统计分析</a>
                <ul>
                    <li><a href="/admin/users/ageData" class="current">年龄分布</a></li>
                    <li><a href="/admin/users/sexData">性别占比</a></li>
                </ul>
            </li>
        </ul>
    </aside>
    <div class="span20 ws-content">
        <div id="container" style="width:1100px;height:500px"></div>
    </div>
</div>

<script src="//img.chinanetcenter.com/js/jquery/jquery-1.8.1.min.js"></script>
<script src="//img.chinanetcenter.com/lib/bui/1.1.21/seed-min.js"></script>
<script src="//img.chinanetcenter.com/wsfe/1.0.0/prd/scripts/wsfe.js"></script>
<script src="http://cdn.hcharts.cn/highcharts/highcharts.js"></script>
<script src="http://cdn.hcharts.cn/highcharts/modules/exporting.js"></script>
<script src="https://img.hcharts.cn/highcharts-plugins/highcharts-zh_CN.js"></script>
<script>
    $(function () {
        $.getJSON('/admin/users/getAgeData',function (data) {
            $('#container').highcharts({
                title: {
                    text: '用户年龄分布',
                    x: -20
                },
//                subtitle: {
//                    text: '数据来源: WorldClimate.com',
//                    x: -20
//                },
                xAxis: {
                    categories: ['0-9岁', '10-19岁', '20-29岁', '30-39岁', '40-49岁', '50-59岁', '60-69岁', '70-79岁', '80-89岁', '90-99岁', '100岁以上']
                },
                yAxis: {
                    title: {
                        text: '人数'
                    },
                    //坐标轴y的参数
                    plotLines: [{
                        value: 0,
                        width: 1,
                        color: '#808080'
                    }]
                },
                //图上的tips
                tooltip: {
                    valueSuffix: '人'
                },
                //图示
                legend: {
                    layout: 'vertical',
                    align: 'right',
                    verticalAlign: 'middle',
                    borderWidth: 0
                },
                series:data
            });
        });
    });
</script>
</body>
</html>