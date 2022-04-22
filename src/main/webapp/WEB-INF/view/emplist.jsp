<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Sam
  Date: 2022/4/21
  Time: 16:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script rel="stylesheet" src="/static/js/jquery-3.6.0.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/static/bootstrap3.4.1/css/bootstrap.min.css" crossorigin="anonymous">
    <link href="/static/bootstrap3.4.1/css/bootstrap-theme.min.css">
    <script src="/static/bootstrap3.4.1/js/bootstrap.min.js"></script>

</head>
<body>
    <div class="container">
<%--        标题--%>
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>
<%--        按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary">添加</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>
<%--        表格数据--%>
        <div class="row">
            <table class="table table-hover">
                <tr>
                    <th>#</th>
                    <th>编号</th>
                    <th>名字</th>
                    <th>性别</th>
                    <th>年龄</th>
                    <th>部门</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <td>#</td>
                        <td>${emp.eid}</td>
                        <td>${emp.empName}</td>
                        <td>${emp.sex}</td>
                        <td>${emp.age}</td>
                        <td>${emp.dept.deptName}</td>
                        <td>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑
                            </button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
<%--        分页信息--%>
        <div class="row">
<%--            文字信息--%>
            <div class="col-md-6">
                当前 ${pageInfo.pageNum} 页 总共 ${pageInfo.pages} 页 共 ${pageInfo.total} 条
            </div>
<%--            分页条--%>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li><a href="/emps?page=1">首页</a></li>
                        <li>
                            <a href="/emps?page=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <c:forEach var="page" items="${pageInfo.navigatepageNums}">
                            <c:if test="${page==pageInfo.pageNum}">
                                <li class="active"><a href="/emps?page=${page}">${page}</a></li>
                            </c:if>
                            <c:if test="${page!=pageInfo.pageNum}">
                                <li><a href="/emps?page=${page}">${page}</a></li>
                            </c:if>
                        </c:forEach>
                        <li>
                            <a href="/emps?page=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                        <li><a href="/emps?page=${pageInfo.pages}">末页</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</body>
</html>
