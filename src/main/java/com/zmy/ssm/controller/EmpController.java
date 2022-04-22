package com.zmy.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zmy.ssm.pojo.Emp;
import com.zmy.ssm.pojo.Message;
import com.zmy.ssm.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author Sam  Email:superdouble@yeah.net
 * @Description    处理员工的CURD
 * @create 2022-04-20 22:50
 */
@Controller
public class EmpController {

    @Autowired
    private EmpService empService;

//    // 引入分页插件
//    @RequestMapping("/emps")
//    public String getEmps(@RequestParam(value = "page",defaultValue = "1")Integer page, Model model){
//
//        // 车讯之前调用，传入页码，以及每页展示数量
//        PageHelper.startPage(page,3);
//        // 后面的查询就是分页查询
//        List<Emp> emps = empService.getAllEmp();
//        // 使用pageInfo包装  查询的数据，和导航页码数量
//        PageInfo pageInfo = new PageInfo(emps,5);
//        model.addAttribute("pageInfo",pageInfo);
//        return "emplist";
//    }

    // 引入分页插件
    @RequestMapping("/emps")
    @ResponseBody
    public Message getEmplist(@RequestParam(value = "page",defaultValue = "1")Integer page, Model model){
        // 查询之前调用，传入页码，以及每页展示数量
        PageHelper.startPage(page,3);
        // 后面的查询就是分页查询
        List<Emp> emps = empService.getAllEmp();
        // 使用pageInfo包装  查询的数据，和导航页码数量
        PageInfo pageInfo = new PageInfo(emps,5);
        List list = pageInfo.getList();
        list.forEach(emp -> System.out.println("emp = " + emp));
        return Message.success().add("pageInfo",pageInfo);
    }




}
