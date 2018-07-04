<%--
  Created by IntelliJ IDEA.
  User: 27438
  Date: 2018/6/19
  Time: 14:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
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
<div class="ui inverted segment">
    &nbsp;
    <button class="ui green button" onclick="window.location.href='/login.jsp'">登录</button>

</div>
<div class="ui middle aligned center aligned grid">
    <div class="column">
        <h2 class="ui teal image header">
            <img src="assets/images/logo.png" class="image">
            <div class="content">
                注册
            </div>
        </h2>
        <form class="ui large form" action="/Register">
            <div class="ui stacked segment">
                <div class="field">
                    <div class="ui left icon input">
                        <i class="user icon"></i>
                        <input type="text" name="registeruname" placeholder="用户名<%
                        out.print(session.getAttribute("registerinfo"));
                        %>">
                    </div>
                </div>
                <div class="field">
                    <div class="ui left icon input">
                        <i class="user icon"></i>
                        <input type="text" name="registerphone" placeholder="电话号码">
                    </div>
                </div>
                <div class="field">
                    <div class="ui left icon input">
                        <i class="lock icon"></i>
                        <input type="password" name="registerpwd" placeholder="密码">
                    </div>
                </div>
                <div class="ui fluid large teal submit button">注册</div>
            </div>

            <div class="ui error message"></div>

        </form>

    </div>
</div>

</body>

</html>
