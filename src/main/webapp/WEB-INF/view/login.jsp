<%--
  Created by IntelliJ IDEA.
  User: Sam
  Date: 2022/4/21
  Time: 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <%--    引入jQuery--%>
    <script src="/static/js/jquery-3.6.0.js"></script>
    <%--    引入样式--%>
    <link rel="stylesheet" type="text/css" href="/static/css/styles.css">
</head>
<body>
<div class="htmleaf-container">
    <div class="wrapper">
        <div class="container">
            <h1>Welcome</h1>

            <form class="form" method="post" action="/login">
                <input type="text" placeholder="empName" value="张三" name="empName">
                <input type="password" placeholder="eid" value="1" name="eid">
                <button type="submit" id="login-button">Login</button>
            </form>
        </div>

        <ul class="bg-bubbles">
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
</div>

<script src="/static/js/jquery-3.6.0.js" type="text/javascript"></script>
<script>
    $('#login-button').click(function (event) {
        event.preventDefault();
        var form = $('form').fadeOut(500);
        $('.wrapper').addClass('form-success');
        form.submit();
    });
</script>

<div style="text-align:center;margin:50px 0; font:normal 14px/24px 'MicroSoft YaHei';color:#000000">
    <h1>数据管理系统</h1>
</div>
</body>
</html>
