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
    <link rel="stylesheet" href="/static/bootstrap3.4.1/css/bootstrap.min.css">
    <link href="/static/bootstrap3.4.1/css/bootstrap-theme.min.css">
    <script src="/static/bootstrap3.4.1/js/bootstrap.min.js"></script>
    <script>
        $(function (){
            alert("aaa");
        });
    </script>
</head>
<body>
<form>
    <div class="form-group">
        <label for="exampleInputEmail1">Email address</label>
        <input type="email" class="form-control" id="exampleInputEmail1" placeholder="Email">
    </div>
    <div class="form-group">
        <label for="exampleInputPassword1">Password</label>
        <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
    </div>
    <div class="form-group">
        <label for="exampleInputFile">File input</label>
        <input type="file" id="exampleInputFile">
        <p class="help-block">Example block-level help text here.</p>
    </div>
    <div class="checkbox">
        <label>
            <input type="checkbox"> Check me out
        </label>
    </div>
    <button type="submit" class="btn btn-default">Submit</button>
</form>
</body>
</html>
