package com.zmy.ssm.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zmy.ssm.mapper.EmpMapper;
import com.zmy.ssm.pojo.Emp;
import com.zmy.ssm.pojo.Message;
import com.zmy.ssm.service.EmpService;
import com.zmy.ssm.service.Impl.EmpServiceImpl;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import sun.security.util.Password;

import java.util.ArrayList;
import java.util.Arrays;
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
    @Autowired
    private EmpMapper empMapper;

    // 插入
    @PostMapping("/pemp")
    @ResponseBody
    public Message insertEmp(Emp emp){
        int insert = empMapper.insert(emp);
        System.out.println("emp ============ " + insert);
        return Message.success().add("emp",emp);
    }
    // 删除
    @DeleteMapping("/pemp/{eid}")
    @ResponseBody
    public Message pdelEmp(@PathVariable("eid")Integer eid){
        int delete = empMapper.deleteById(eid);

        return Message.success().add("影响行数",delete);
    }

    /**
     * 条件构造器  UpdateWrapper
     *
     *
     * @param eid
     * @return
     */
    @DeleteMapping("/pemps/{eid}")
    @ResponseBody
    public Message pdelEmpByname(@PathVariable("eid")Integer eid){

        UpdateWrapper<Emp> wrapper = new UpdateWrapper<>();
        wrapper.eq("eid",eid);
        int delete = empMapper.deleteById(wrapper);

        return Message.success().add("影响行数",delete);
    }



    // 修改
    @PutMapping("/pemp")
    @ResponseBody
    public Message Update(Emp emp){

        empMapper.updateById(emp);

        return Message.success().add("emp",emp);
    }
    /**
     * 查询
     */
    // 查询总记录数
    @GetMapping("/pemp/count")
    @ResponseBody
    public Message GetCount(){
        long count = empService.count();
        return Message.success().add("count",count);
    }
    // 分页查询
    @GetMapping("/empPage")
    @ResponseBody
    public Message getAllEmpByPage(){

        Page<Emp> page = new Page<>(1,3);

        Page<Emp> page1 = empMapper.selectPage(page, null);

        return Message.success().add("page",page1);
    }


    // 根据id查询
    @GetMapping("/pemp/{eid}")
    @ResponseBody
    public Message getEmp1(@PathVariable("eid")Integer eid){
        System.out.println("eid = " + eid);
        Emp emp = empMapper.selectById(eid);
        return Message.success().add("emp",emp);
    }
    // 根据多个id查询
    @GetMapping("/pemp")
    @ResponseBody
    public Message getEmpByids(Integer eid1,Integer eid2,Integer eid3){
        List<Integer> eid = new ArrayList<>();
        eid.add(eid1);
        eid.add(eid2);
        eid.add(eid3);
        List<Emp> emps = empMapper.selectBatchIds(eid);
        return Message.success().add("emps",emps);
    }
    // 查询所有
    @GetMapping("/pemp/list")
    @ResponseBody
    public Message getAll(){
        List<Emp> emps = empMapper.selectList(null);
        return Message.success().add("emps",emps);
    }



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
    @RequestMapping("/emp/{eid}")
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
