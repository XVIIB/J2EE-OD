<%--
  Created by IntelliJ IDEA.
  User: 27438
  Date: 2018/6/22
  Time: 17:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商品管理</title>
    <link rel="stylesheet" type="text/css" href="dist/components/reset.css">
    <link rel="stylesheet" type="text/css" href="dist/components/site.css">

    <link rel="stylesheet" type="text/css" href="dist/components/container.css">
    <link rel="stylesheet" type="text/css" href="dist/components/grid.css">
    <link rel="stylesheet" type="text/css" href="dist/components/header.css">
    <link rel="stylesheet" type="text/css" href="dist/components/image.css">
    <link rel="stylesheet" type="text/css" href="dist/components/menu.css">

    <link rel="stylesheet" type="text/css" href="dist/components/divider.css">
    <link rel="stylesheet" type="text/css" href="dist/components/segment.css">
    <link rel="stylesheet" type="text/css" href="dist/components/form.css">
    <link rel="stylesheet" type="text/css" href="dist/components/input.css">
    <link rel="stylesheet" type="text/css" href="dist/components/button.css">
    <link rel="stylesheet" type="text/css" href="dist/components/list.css">
    <link rel="stylesheet" type="text/css" href="dist/components/message.css">
    <link rel="stylesheet" type="text/css" href="dist/components/icon.css">


    <!--- Site CSS -->
    <link rel="stylesheet" type="text/css" href="dist/components/reset.css">
    <link rel="stylesheet" type="text/css" href="dist/components/site.css">
    <link rel="stylesheet" type="text/css" href="dist/components/grid.css">

    <!--- Component CSS -->
    <link rel="stylesheet" type="text/css" href="dist/components/icon.css">
    <link rel="stylesheet" type="text/css" href="dist/components/table.css">
    <link rel="stylesheet" type="text/css" href="dist/components/button.css">
    <link rel="stylesheet" type="text/css" href="dist/components/transition.css">
    <link rel="stylesheet" type="text/css" href="dist/components/popup.css">

    <!-- Loading Bootstrap -->
    <link href="dist/css/vendor/bootstrap.min.css" rel="stylesheet">

    <!-- Loading Flat UI -->
    <link href="dist/css/flat-ui.css" rel="stylesheet">

    <!-- Loading DOC css -->
    <link href="assets/css/docs.css" rel="stylesheet">

    <script src="assets/library/jquery.min.js"></script>
    <script src="dist/components/form.js"></script>
    <script src="dist/components/transition.js"></script>
    <style type="text/css">
        body {
            background-color: #DADADA;
        }
        body > .grid {
            height: 100%;
        }
        .image {
            margin-top: -100px;
        }
        .column {
            max-width: 450px;
        }
    </style>
</head>
<body>
<div class="ui inverted segment">
    &nbsp;
    <button class="ui green button" onclick="window.location.href='show.jsp'">首页</button>

</div>
<form action="PublishC">
    <table class="ui selectable inverted table">
        <tr><td>商品名</td><td><div class="ui input focus">
            <input type="text" name="pcname">
        </div></td></tr>
        <tr><td>价格</td><td><div class="ui input focus">
            <input type="text" name="pcprice">
        </div></td></tr>
        <tr><td>数量</td><td><div class="ui input focus">
            <input type="text" name="pcnum">
        </div></td></tr>
        <tr><td>商店编号</td><td><div class="ui input focus">
            <input type="text" name="psid">
        </div></td></tr>
    </table>
    <button type="submit" class="ui black button">插入商品</button>
</form>
</br>
<form action="DelateC">
    <table class="ui selectable inverted table">
        <tr><td>商品编号</td><td><div class="ui input focus">
            <input type="text" name="pdelate">
        </div></td></tr>
    </table>
    <button type="submit" class="ui black button">删除商品</button>
</form>
</br>
<form action="UpdateC">
    <table class="ui selectable inverted table">
        <tr><td>商品名</td><td><div class="ui input focus">
            <input type="text" name="upcname">
        </div></td></tr>
        <tr><td>价格</td><td><div class="ui input focus">
            <input type="text" name="upcprice">
        </div></td></tr>
        <tr><td>数量</td><td><div class="ui input focus">
            <input type="text" name="upcnum">
        </div></td></tr>
        <tr><td>商品编号</td><td><div class="ui input focus">
            <input type="text" name="upcid">
        </div></td></tr>
        <tr><td>商店编号</td><td><div class="ui input focus">
            <input type="text" name="upsid">
        </div></td></tr>
    </table>
    <button type="submit" class="ui black button">
        更新商品</button>
</form>
</body>
</html>
