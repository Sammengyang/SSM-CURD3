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
    <script>
        var totalRecord;

        // 页面加载完成后，直接发送ajax请求，获取json数据
        $(function (){
            to_page(1);
        });

        function to_page(page){
            $.ajax({
                url:"/emps",
                data:"page="+page,
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
        }

        function build_emps_table(result){
            // 清空 table
            $("#empsTable tbody").empty();

            // 获取json数据
            var emps = result.extend.pageInfo.list;
            // 遍历员工集合
            let each = $.each(emps,function (index, item){
                // 创建单元格
                var checkbox = $("<td></td>").append($("<input type='checkbox' class='check_item'>"));
                var Tdempid = $("<td></td>").append(item.eid);
                var TdempName = $("<td></td>").append(item.empName);
                var Tdesex = $("<td></td>").append(item.sex);
                var Tdage = $("<td></td>").append(item.age);
                var TddeptName = $("<td></td>").append(item.dept.deptName);
                // 创建按钮
                var delBtn = $("<button></button>")
                    .addClass("btn btn-danger btn-sm del_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                    .append("删除");
                // 添加自定义属性，用来标识当前员工id
                delBtn.attr("del_id",item.eid);
                var editBtn = $("<button></button>")
                    .addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                    .append("编辑");
                // 添加自定义属性，用来标识当前员工id
                editBtn.attr("edit_id",item.eid);
                // 创建按钮单元格
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                // 将单元格添加入行
                $("<tr></tr>")
                    .append(checkbox)
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
            // 清空 分页信息
            $("#page_info").empty();
            //当前  页 总共  页 共  条
            $("#page_info").append(
                "当前第 "+result.extend.pageInfo.pageNum
                +" 页"+" 总共 "+result.extend.pageInfo.pages+" 页"
                +" 共计 "+result.extend.pageInfo.total+" 条")
            totalRecord = result.extend.pageInfo.total;
        }
        function build_page_nav(result){
            // 清空分页导航
            $("#page_nav").empty();
            // ul
            var ul = $("<ul><ul>").addClass("pagination");
            // 首页 上一页
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
            ul.append(firstPageLi).append(prePageLi);// 添加首页和上一页
            // 数字页码
            $.each(result.extend.pageInfo.navigatepageNums,function (index,item){
                var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
                if (result.extend.pageInfo.pageNum == item){
                    numLi.addClass("active");// 当前页码标识
                }
                numLi.click(function (){ //点击去那一页
                    to_page(item);
                });
                ul.append(numLi); // 添加数字页码
            });
            // 下一页 ，尾页
            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
            var endPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
            ul.append(nextPageLi).append(endPageLi); // 添加下一页和尾页
            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav");

            // 添加翻页事件
            // 元素添加翻页事件
            firstPageLi.click(function (){
                to_page(1);
            });
            prePageLi.click(function (){
                to_page(result.extend.pageInfo.pageNum-1);
            });
            endPageLi.click(function (){
                to_page(result.extend.pageInfo.pages);
            });
            nextPageLi.click(function (){
                to_page(result.extend.pageInfo.pageNum+1);
            });
        }
        // 添加员工
        $("#emp_add_modal_btn").click(function (){
            // 清除表单数据，重置表单
            clean_add_form($("#emp_add_modal form"));

            // 发送ajax请求，查询部门信息，显示在下拉框
            getDepts($("#dept_add_select"));
            // 添加员工模态框展示
            $('#emp_add_modal').modal({
                backdrop:"static"
            });
        });
        // 清除表单数据以及样式
        function clean_add_form(ele){
            // 清除数据
            ele[0].reset();
            // 清除表单样式
            ele.find("*").removeClass("has-error has-success");
            // 清除提示信息
            ele.find(".help-block").text("");
        }
        // 查询部门信息展示在下拉框种
        function getDepts(ele){
            // 清空部门展示框
            $(ele).empty();
            $.ajax({
                url:"/depts",
                type: "GET",
                success:function (result){
                    // 获取到部门信息 json数据
                    // 显示在下拉菜单
                    // 遍历部门信息
                    $.each(result.extend.depts,function (){
                        var optionEle = $("<option></option>").append(this.deptName).attr("value",this.did);
                        optionEle.appendTo(ele);
                    })
                }

            });
        }

        // 检测添加提交表单数据
        function check_add_form(){
            // 1. 获取到校验数据，使用正则表达四校验
            var empName = $("#empName_add_input").val();
            var regName = /(^[a-zA-Z0-9\u2E80-\u9FFF]{3,16}$)/; // 中文编码
            var isExit = regName.test(empName);
            if(regName.test(empName)){
                show_check_msg("#empName_add_input","success","");
            }else {
                show_check_msg("#empName_add_input","error","用户名可以是3-16位英文、数字、中文组合");
            }
            return true;
        }
        // 传入修改的标签，检测状态，和检测信息
        function show_check_msg(ele,status,msg){
            // 清除当前元素校验状态
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");
            if (status == "success"){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg)
                $("#emp_add_btn").attr("ajax_check","success"); // 保存按钮添加一个属性，用于判断是否可以保存
            }else if ("error" == status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
                $("#emp_add_btn").attr("ajax_check","error"); // 保存按钮添加一个属性，用于判断是否可以保存
            }
        }
        // 为用户名文本框添加修改事件,检测用户名是否可以使用
        $("#empName_add_input").change(function (){
            // 发送ajax请求，校验用户名
            var name = this.value;
            $.ajax({
                url:"/checkName",
                data:"empName="+name,
                type:"POST",
                success:function (result){
                    if (result.code == 100){ // 返回100成功
                        show_check_msg("#empName_add_input","success","");
                        $("#emp_add_btn").attr("ajax_check","success"); // 保存按钮添加一个属性，用于判断是否可以保存
                    }else{ // 不可用
                        show_check_msg("#empName_add_input","error",result.extend.check_msg);
                        $("#emp_add_btn").attr("ajax_check","error"); // 保存按钮添加一个属性，用于判断是否可以保存
                    }
                }
            });
        });
        // 保存添加
        $("#emp_add_btn").click(function (){
            // 序列化表单获取表单数据
            var data = $("#add_emp_form").serialize();
            if ($("#emp_add_btn").attr("ajax_check") == "success"){ // 判断保存按钮是否有
                // 1. 提交表单数据
                // 2. 发送ajax请求，保存员工
                $.ajax({
                    url:"/emp",
                    type:"POST",
                    data: data,
                    success:function (result){
                        alert(result.msg);
                        // 添加成功
                        // 1. 关闭模态框
                        $('#emp_add_modal').modal("hide");
                        // 2. 跳转尾页
                        // 发送ajax请求显示最后一页数据
                        /** 利用分页插件的合理化设置：大于最大页数的数值都会显示最后一页
                         *  1. 跳转一个很大的数值页
                         *  2. 用总记录数作为该数值,总记录永远比页码大
                         */
                        to_page(totalRecord);
                    }
                });
            }else{
                return false;
            }
        });
        // 修改员工信息
        $(document).on("click",".edit_btn",(function (){
            // 发送ajax请求，查询部门信息，显示在下拉框
            getDepts($("#dept_edit_sclect"));
            // 将个人信息展示在模态框中
            getEmp($(this).attr("edit_id"));
            // 添加员工模态框展示
            $("#emp_edit_btn").attr("edit_id",$(this).attr("edit_id"));
            $('#emp_edit_modal').modal({
                backdrop:"static"
            });
        }));
        // 获取员工信息
        function getEmp(id){
            $.ajax({
                url:"/emp/"+id,
                type:"GET",
                success:function (result){
                    var emp = result.extend.emp;
                    $("#empName_edit_input").text(emp.empName);
                    $("#age_edit_input").val(emp.age);
                    // 单选框被选中
                    $("#emp_edit_modal input[name='sex']").val([emp.sex]);
                    // 下拉列表展示
                    $("#emp_edit_modal select").val([emp.did]);
                }
            })
        }
        // 给更新按钮绑定单击事件
        $("#emp_edit_btn").click(function (){

            // 发送ajax请求更新员工信息
            $.ajax({
                url:"/emp/"+$(this).attr("edit_id"),
                type:"POST",
                data:$("#edit_emp_form").serialize()+"&_method=put",
                success:function (result){
                    alert(result.msg);
                }
            });
            // 跳转到第一页
            to_page(1);
            // 关闭模态框
            $('#emp_edit_modal').modal("hide");
        });
        // 给删除按钮添加点击事件
        $(document).on("click",".del_btn",function (){
            // 弹出是否确认删除对话框
            var empName = $(this).parents("tr").find("td:eq(2)").text();
            alert(empName);
            if (confirm("是否确认删除【"+empName+"】")){ // 跳出弹框确认是否删除
                // 发送ajax请求
                $.ajax({
                    url:"/emp/"+$(this).attr("del_id"),
                    type:"DELETE",
                    // data:"_method=delete",
                    success:function (result){
                    }
                });
            }
        })

        // 批量删除
        // 全选/全不选
        $("#check_all").click(function (){
            /**
             * 注意点
             *  attr 获取checked是undefined
             *  dom原生的属性，attr可以获取自定义的值
             *  是否选中，可以用prop修改和读取原生属性的值
             */
            var checked = $(this).prop("checked"); // 变体行是否被选中
            $(".check_item").prop("checked",checked); // 所有checkbox跟随标题checkbox变化
        });
        // 给每个checkbox添加点击事件，有一个没选全选框取消
        // checked选择选择器，选中的个数
        $(document).on("click",".check_item",function (){
            // 当前选中的元素是否等于总人数
            var flag = $(".check_item:checked").length==$(".check_item").length;
            $("#check_all").prop("checked",flag);
        });
        // 给批量删除按钮添加点击事件
        $("#del_all_Emp_btn").click(function (){
            var names = "";
            // 选择所有被选中的复选框，进行遍历
            $.each($(".check_item:checked"),function (){
                var empName = $(this).parents("tr").find("td:eq(2)").text();// 获取选中的的复选框同行的员工姓名
                names += empName+",";
            })
            names = names.substring(0,names.length-1);
            if (confirm("是否确认删除【"+names+"】")){
                // 发送ajax请求
                $.ajax({
                    url:"/deleteEmp/"+names,
                    type:"delete",
                    success:function (){
                    }
                });
            }
        });





    </script>

</head>
<body>
<!-- 员工添加 Modal -->
<div class="modal fade" id="emp_add_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="add_emp_form" method="post">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="empName_add_input" name="empName" onblur="check_add_form()" placeholder="姓名">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">Age</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="age_add_input" name="age" placeholder="年龄">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">Sex</label>
                        <div class="col-sm-10">
                            <input type="radio" id="sexM" name="sex" value="男" checked="checked"> 男
                            <input type="radio" id="sexG" name="sex" value="女"> 女
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">DeptName</label>
                        <div class="col-sm-4">
<%--                            部门提交部门id--%>
                            <select class="form-control" name="did" id="dept_add_select">

                            </select>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_add_btn">Save</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工修改 Modal -->
<div class="modal fade" id="emp_edit_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="editModal">修改信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="edit_emp_form" method="post">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_edit_input"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">Age</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="age_edit_input" name="age" placeholder="年龄">
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">Sex</label>
                        <div class="col-sm-10">
                            <input type="radio" name="sex" value="男"> 男
                            <input type="radio" name="sex" value="女"> 女
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">DeptName</label>
                        <div class="col-sm-4">
                            <%--                            部门提交部门id--%>
                            <select class="form-control" name="did" id="dept_edit_sclect">

                            </select>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_edit_btn">Update</button>
            </div>
        </div>
    </div>
</div>

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
            <button class="btn btn-primary" id="emp_add_modal_btn">添加</button>
            <button class="btn btn-danger" id="del_all_Emp_btn">全部删除</button>
        </div>
    </div>
    <%--        表格数据--%>
    <div class="row">
        <table class="table table-hover" id="empsTable">
            <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all">
                    </th>
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

</body>
</html>
