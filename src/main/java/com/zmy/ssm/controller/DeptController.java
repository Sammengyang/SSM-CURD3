package com.zmy.ssm.controller;

import com.zmy.ssm.pojo.Dept;
import com.zmy.ssm.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author Sam  Email:superdouble@yeah.net
 * @Description
 * @create 2022-04-21 16:17
 */
@Controller
public class DeptController {

    @Autowired
    private DeptService deptService;

    @RequestMapping("/insertDept")
    @ResponseBody
    public int insertDept(){
        return deptService.insertDept(new Dept(null, "开发部门"));
    }
}
