<%--
  Created by IntelliJ IDEA.
  User: Sam
  Date: 2022/4/21
  Time: 21:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="shortcut icon" href="#"/>
    <title>list</title>
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
        <table class="table table-hover" id="empsTable">
            <thead>
                <tr>
                    <th>编号</th>
                    <th>名字</th>
                    <th>性别</th>
                    <th>年龄</th>
                    <th>部门</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>

            </tbody>

        </table>
    </div>
    <%--        分页信息--%>
    <div class="row">
        <%--            文字信息--%>
        <div class="col-md-6" id="page_info">
        </div>
        <%--            分页条--%>
        <div class="col-md-6" id="page_nav">

        </div>
    </div>
</div>
    <script>
        // 页面加载完成后，直接发送ajax请求，获取json数据
        $(function (){
           $.ajax({
              url:"/emps",
              data:"page=3",
              type:"get",
               success:function (result){
                   // 1. 解析员工数据
                   build_emps_table(result);
                   //2. 解析分页信息
                   build_page_info(result);
                   // 3. 解析导航条
                   build_page_nav(result);

               }
           });
        });
        function build_emps_table(result){
            // 获取json数据
            var emps = result.extend.pageInfo.list;
            // 遍历员工集合
            let each = $.each(emps,function (index, item){
                // 创建单元格
                var Tdempid = $("<td></td>").append(item.eid);
                var TdempName = $("<td></td>").append(item.empName);
                var Tdesex = $("<td></td>").append(item.sex);
                var Tdage = $("<td></td>").append(item.age);
                var TddeptName = $("<td></td>").append(item.dept.deptName);
                // 创建按钮
                var editBtn = $("<button></button>")
                    .addClass("btn btn-primary btn-sm")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                        .append("编辑");
                var delBtn = $("<button></button>")
                    .addClass("btn btn-danger btn-sm")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                    .append("编辑");
                // 创建按钮单元格
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                // 将单元格添加入行
                $("<tr></tr>")
                    .append(Tdempid)
                    .append(TdempName)
                    .append(Tdesex)
                    .append(Tdage)
                    .append(TddeptName)
                    .append(btnTd)
                    .appendTo("#empsTable tbody");// 添加到哪里

            });
        }
        function build_page_info(result){
            //当前  页 总共  页 共  条
            $("#page_info").append(
                "当前第 "+result.extend.pageInfo.pageNum
                +" 页"+" 总共 "+result.extend.pageInfo.pages+" 页"
                +" 共计 "+result.extend.pageInfo.total+" 条")
        }
        function build_page_nav(result){
            // ul
            var ul = $("<ul><ul>").addClass("pagination");
            // 首页 上一页
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","/emps?"+result.extend.pageInfo.pageNum-1));
            ul.append(firstPageLi).append(prePageLi);// 添加首页和上一页
            // 数字页码
            $.each(result.extend.pageInfo.navigatepageNums,function (index,item){
                var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","/emps?"+item));
                ul.append(numLi); // 添加数字页码
            });
            // 下一页 ，尾页
            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","/emps?"+result.extend.pageInfo.pageNum+1));
            var endPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
            ul.append(nextPageLi).append(endPageLi); // 添加下一页和尾页
            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav");
        }

    </script>
</body>
</html>
