<%--
  Created by IntelliJ IDEA.
  User: changwh1
  Date: 2017/3/10
  Time: 11:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <title>性别比例统计</title>
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
            <li><a href="#">概览</a></li>
            <li>
                <a href="javascript:;" class="open">自助配置</a>
                <ul>
                    <li><a href="#">带宽</a></li>
                    <li><a href="#">流量</a></li>
                    <li><a href="#">请求数</a></li>
                </ul>
            </li>
            <li>
                <a href="javascript:;" class="close">统计分析</a>
                <ul>
                    <li><a href="#">年龄</a></li>
                    <li><a href="/admin/users/sexData" class="current">性别占比</a></li>
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
        // Make monochrome colors and set them as default for all pies
        Highcharts.getOptions().plotOptions.pie.colors = (function () {
            var colors = [],
                    base = Highcharts.getOptions().colors[0],
                    i;
            for (i = 0; i < 10; i += 1) {
                // Start out with a darkened base color (negative brighten), and end
                // up with a much brighter color
                colors.push(Highcharts.Color(base).brighten((i - 3) / 7).get());
            }
            return colors;
        }());
        // Build the chart
        $(function () {
            $.getJSON('/admin/users/getSexData',function (data) {
                $('#container').highcharts({
                    chart: {
                        plotBackgroundColor: null,
                        plotBorderWidth: null,
                        plotShadow: false
                    },
                    title: {
                        text: '用户性别占比'
                    },
                    tooltip: {
                        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                    },
                    plotOptions: {
                        pie: {
                            allowPointSelect: true,
                            cursor: 'pointer',
                            dataLabels: {
                                enabled: true,
                                format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                                style: {
                                    color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                                }
                            }
                        }
                    },
                    series: [{
                        type: 'pie',
                        name: '用户性别占比',
                        data: data
                    }]
                });
            })
        })
    });
</script>
</body>
</html>

