<%@ page import="java.sql.Connection" %>
<%@ page import="jdbc.DataBaseBean" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.awt.*" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: 27438
  Date: 2018/6/22
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改个人信息</title>
    <!-- Standard Meta -->
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

    <!-- Site Properties -->
    <title>Login Example - Semantic</title>
    <link rel="stylesheet" type="text/css" href="../dist/components/reset.css">
    <link rel="stylesheet" type="text/css" href="../dist/components/site.css">

    <link rel="stylesheet" type="text/css" href="../dist/components/container.css">
    <link rel="stylesheet" type="text/css" href="../dist/components/grid.css">
    <link rel="stylesheet" type="text/css" href="../dist/components/header.css">
    <link rel="stylesheet" type="text/css" href="../dist/components/image.css">
    <link rel="stylesheet" type="text/css" href="../dist/components/menu.css">

    <link rel="stylesheet" type="text/css" href="../dist/components/divider.css">
    <link rel="stylesheet" type="text/css" href="../dist/components/segment.css">
    <link rel="stylesheet" type="text/css" href="../dist/components/form.css">
    <link rel="stylesheet" type="text/css" href="../dist/components/input.css">
    <link rel="stylesheet" type="text/css" href="../dist/components/button.css">
    <link rel="stylesheet" type="text/css" href="../dist/components/list.css">
    <link rel="stylesheet" type="text/css" href="../dist/components/message.css">
    <link rel="stylesheet" type="text/css" href="../dist/components/icon.css">

    <script src="assets/library/jquery.min.js"></script>
    <script src="../dist/components/form.js"></script>
    <script src="../dist/components/transition.js"></script>
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
    <script>
        $(document)
            .ready(function() {
                $('.ui.form')
                    .form({
                        fields: {
                            email: {
                                identifier  : 'registeruname',
                                rules: [
                                    {
                                        type   : 'empty',
                                        prompt : '请输入用户名'
                                    },

                                ]
                            },
                            password: {
                                identifier  : 'registerpwd',
                                rules: [
                                    {
                                        type   : 'empty',
                                        prompt : '请输入密码'
                                    },
                                    {
                                        type   : 'length[6]',
                                        prompt : '密码必须大于6位'
                                    }
                                ]
                            }
                        }
                    })
                ;
            })
        ;
    </script>
</head>
<body>
<%
    String users= String.valueOf(session.getAttribute("user"));
    int user=Integer.parseInt(users);
    String sql="select u.utel,a.acity,a.adetail,a.aname from user u left join addr a using(uid) where uid=?";
    Connection connection= DataBaseBean.getConnection();
    PreparedStatement preparedStatement=DataBaseBean.getPreparedStatement(connection,sql);
    preparedStatement.setInt(1,user);
    ResultSet resultSet=preparedStatement.executeQuery();
    resultSet.next();

%>
<div class="ui inverted segment">
    &nbsp;
    <button class="ui green button" onclick="window.location.href='/show.jsp'">返回</button>

</div>
<div class="ui middle aligned center aligned grid">
    <div class="column">
        <h2 class="ui teal image header">
            <img src="assets/images/logo.png" class="image">
            <div class="content">
                信息修改
            </div>
        </h2>
        <form class="ui large form" action="ChangeInfo">
            <div class="ui stacked segment">
                <div class="field">
                    <div class="ui left icon input">
                        <i class="lock icon"></i>
                        <input type="password" name="changepwd" placeholder="密码:">
                    </div>
                </div>
                <div class="field">
                    <div class="ui left icon input">
                        <i class="user icon"></i>
                        <input type="text" name="changephone" placeholder="电话号码:<%
                        out.print(resultSet.getInt("utel"));
                        %>">
                    </div>
                </div>
                <div class="field">
                    <div class="ui left icon input">
                        <i class="user icon"></i>
                        <input type="text" name="changecity" placeholder="城市:<%
                        out.print(resultSet.getString("acity"));
                        %>">
                    </div>
                </div>
                <div class="field">
                    <div class="ui left icon input">
                        <i class="user icon"></i>
                        <input type="text" name="changeaddr" placeholder="地址:<%
                        out.print(resultSet.getString("adetail"));
                        %>">
                    </div>
                </div>
                <div class="field">
                    <div class="ui left icon input">
                        <i class="user icon"></i>
                        <input type="text" name="changename" placeholder="姓名:<%
                        out.print(resultSet.getString("aname"));
                        %>">
                    </div>
                </div>
                <div class="ui fluid large teal submit button">修改</div>
            </div>

            <div class="ui error message"></div>

        </form>

    </div>
</div>
<%
    DataBaseBean.CloseResustSet(resultSet);
    DataBaseBean.ClosePreparedStatement(preparedStatement);
    DataBaseBean.CloseConnection(connection);
%>
</body>

</html>
