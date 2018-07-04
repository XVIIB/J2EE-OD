<%@ page import="java.sql.Connection" %>
<%@ page import="jdbc.DataBaseBean" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: 27438
  Date: 2018/6/20
  Time: 12:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>订餐系统</title>
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
<button class="ui green button" onclick="window.location.href='/OrderComit'">提交订单</button>
&nbsp;&nbsp;
<button class="ui blue button" onclick="window.location.href='/selectOrders.jsp'">查询订单</button>
    &nbsp;&nbsp;
    <button class="ui violet button" onclick="window.location.href='/changInfo.jsp'">修改个人信息</button>
&nbsp;&nbsp;

</div>
<div class="ui teal message"><%
    HttpSession hs=request.getSession();
    out.print(hs.getAttribute("finished"));
%></div>
<%
    int a=0;
    String sql="select s.sname,s.saddr,c.cname,c.cid,c.cprice,c.cnum from shop s left join commodity c using(sid);";
    Connection connection= DataBaseBean.getConnection();
    Statement statement=DataBaseBean.getStatement(connection);
    ResultSet resultSet=DataBaseBean.getResultset(statement,sql);
    out.print("<table class=\"ui selectable inverted table\">");
    out.print("<tr><td></td><td>店铺</td><td>地址</td><td>商品</td><td>编号</td><td>价格</td><td>数量</td><td>购买</td></tr>");
    while (resultSet.next()){
        out.print("<tr>");
        out.println("<td><a><img src='icon/"+resultSet.getInt("cid")+".jpg' width='80' height='80'></a></td><td>"+resultSet.getString("sname")+"</td><td>"+resultSet.getString("saddr")+"</td><td>"+resultSet.getString("cname")+"</td><td>"+resultSet.getInt("cid")+"</td><td>"+resultSet.getInt("cprice")+"</td><td>"+resultSet.getInt("cnum")+"</td><td>");
        out.print("<button class=\"ui inverted blue button\" onclick=\"window.location.href='/AddCar'\">加入购物车</button></td>");
        out.print("</tr>");
    }
    out.print("</table>");
%>
<div class="ui inverted segment">
<form action="/AddCar">
    <div class="ui input focus">
        <input type="text" placeholder="请输入商品id" name="input1">
    </div>
    &nbsp;&nbsp;
    <button type="submit" class="ui inverted violet basic button">加入购物车</button>
</form>
</div>
<%
    DataBaseBean.CloseResustSet(resultSet);
    DataBaseBean.CloseStatement(statement);
    DataBaseBean.CloseConnection(connection);
%>
</body>
</html>
