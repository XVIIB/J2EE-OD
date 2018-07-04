<%@ page import="java.sql.Connection" %>
<%@ page import="jdbc.DataBaseBean" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: 27438
  Date: 2018/6/22
  Time: 14:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>订单操作</title>
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
    <button class="ui green button" onclick="window.location.href='show.jsp'">返回</button>
    &nbsp;&nbsp;

</div>
<div class="ui teal message"><%
    HttpSession hs=request.getSession();
    out.print(hs.getAttribute("deleted"));
%></div>
<%
    String users= String.valueOf(session.getAttribute("user"));
    int user=Integer.parseInt(users);
    Connection connection= DataBaseBean.getConnection();
    String sql="select o.oid,o.odate,o.oprice,c.cname,od.dprice from orders o " +
            "left join orderdetail od using(oid) " +
            "left join commodity c on od.cid=c.cid where o.uid=?";
    PreparedStatement preparedStatement=DataBaseBean.getPreparedStatement(connection,sql);
    preparedStatement.setInt(1,user);
    ResultSet resultSet=DataBaseBean.getResultset(preparedStatement);
    out.print("<table class=\"ui selectable inverted table\">");
    out.print("<tr><td>订单编号</td><td>订单日期</td><td>订单总额</td><td>商品名称</td><td>商品价格</td><td>删除</td></tr>");
    while (resultSet.next()){
        out.print("<tr>");
        out.println("<td>"+resultSet.getInt("oid")+"</td><td>"+resultSet.getString("odate")+"</td><td>"+resultSet.getInt("oprice")+"</td><td>"+resultSet.getString("cname")+"</td><td>"+resultSet.getInt("dprice")+"</td><td>");
        out.print("<button class=\"ui inverted red button\" >删除</button></td>");
        out.print("</tr>");
    }
    out.print("</table>");
%>
<div class="ui inverted segment">
<form action="/DeleteOrders">
    <div class="ui input focus">
        <input type="text" placeholder="请输入订单编号" name="delete1">
    </div>
    &nbsp;&nbsp;
    <button type="submit" class="ui inverted red button">删除</button>
</form>
</div>
<%
    DataBaseBean.CloseResustSet(resultSet);
    DataBaseBean.ClosePreparedStatement(preparedStatement);
    DataBaseBean.CloseConnection(connection);
%>
</body>
</html>
