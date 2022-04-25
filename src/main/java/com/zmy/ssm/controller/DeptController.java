package com.zmy.ssm.controller;

import com.zmy.ssm.pojo.Dept;
import com.zmy.ssm.pojo.Message;
import com.zmy.ssm.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author Sam  Email:superdouble@yeah.net
 * @Description
 * @create 2022-04-21 16:17
 */
@Controller
public class DeptController {

    @Autowired
    private DeptService deptService;

    /**
     * 获取所有部门信息
     * @return
     */
    @GetMapping("/depts")
    @ResponseBody
    public Message getAllDept(){
        List<Dept> depts = deptService.getDepts();
        return Message.success().add("depts",depts);
    }


}
