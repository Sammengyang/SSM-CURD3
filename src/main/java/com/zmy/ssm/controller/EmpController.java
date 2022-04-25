package com.zmy.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zmy.ssm.pojo.Emp;
import com.zmy.ssm.pojo.Message;
import com.zmy.ssm.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import sun.security.util.Password;

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

    /**
     * 登录
     * @param eid
     * @param empName
     * @return
     */
    @RequestMapping("/login")
    public String login(String eid, String empName){
        Emp login = empService.Login(eid, empName);
        if (login!=null){
            return "/list";
        }else {
            return "/login";
        }
    }



    // 引入分页插件
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

    /**
     * 分页查询所有员工
     * @param page
     * @return
     */
    // 引入分页插件
    @GetMapping("/emps")
    @ResponseBody
    public Message getEmplist(@RequestParam(value = "page",defaultValue = "1")Integer page){
        // 查询前传入页码，以及每页展示的条数
        PageHelper.startPage(page,3);
        // 后面查询就是分页
        List<Emp> allEmp = empService.getAllEmp();
        // 使用pageInfo封装
        PageInfo pageInfo = new PageInfo(allEmp,5);

        return Message.success().add("pageInfo",pageInfo);
    }

    /**
     * 添加员工
     * @param emp
     * @return
     */
    @PostMapping("/emp")
    @ResponseBody
    public Message addEmp(Emp emp){
        System.out.println("emp = " + emp);
        empService.addEmp(emp);
        return Message.success();
    }

    /**
     * 校验用户名是否可用
     * @param empName
     * @return
     */
    @PostMapping("/checkName")
    @ResponseBody
    public Message checkName(String empName){
        // 先判断用名是否合法
        String regx = "^[a-zA-Z0-9\u2E80-\u9FFF]{3,16}$";
        System.out.println(empName.matches(regx)+"+++++++++++++++++++++++");
        if (!empName.matches(regx)) {
            return Message.fail().add("check_msg","用户名可以是3-16位英文、数字、中文组合");
        }
        // 合法再判断用户名是否可用
        boolean isExit = empService.checkName(empName);
        if (isExit){
            return Message.success();
        }else {
            return Message.fail().add("check_msg","用户名不可用");
        }
    }

    /**
     * 根据id查询员工信息
     * @param eid
     * @return
     */
    @GetMapping("/emp/{eid}")
    @ResponseBody
    public Message getEmpByid(@PathVariable("eid")Integer eid){
        Emp emp = empService.getEmpByid(eid);
        return Message.success().add("emp",emp);
    }

    /**
     * 更新员工信息
     * @param emp
     * @return
     */
    @PutMapping("/emp/{eid}")
    @ResponseBody
    public Message updateEmp(@PathVariable("eid")Integer eid, Emp emp){
        System.out.println("eid = " + eid);
        System.out.println("emp = " + emp);
        empService.updateEmp(eid,emp);
        return Message.success();
    }

    /**
     * 删除员工 单个删除
     * @param eid
     * @return
     */
    @DeleteMapping("/emp/{eid}")
    @ResponseBody
    public Message delEmp(@PathVariable("eid")Integer eid){
        empService.delEmpByeid(eid);
        return Message.success();
    }

    @DeleteMapping("/deleteEmp/{names}")
    @ResponseBody
    public Message delAllEmp(@PathVariable("names") String empNames){
        System.out.println("empNames = " + empNames);
        String[] names = empNames.split(",");
        empService.delAllEmpByName(names);
        return Message.success();
    }






}
