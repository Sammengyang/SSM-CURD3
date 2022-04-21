package com.zmy.ssm.service;

import com.zmy.ssm.pojo.Emp;

import java.util.List;

/**
 * @author Sam  Email:superdouble@yeah.net
 * @Description
 * @create 2022-04-20 22:49
 */
public interface EmpService {

    /**
     * 获取所有员工
     * @return
     */
    List<Emp> getAllEmp();
}
