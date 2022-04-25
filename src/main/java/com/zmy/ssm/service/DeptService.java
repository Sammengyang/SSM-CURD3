package com.zmy.ssm.service;

import com.zmy.ssm.pojo.Dept;

import java.util.List;

/**
 * @author Sam  Email:superdouble@yeah.net
 * @Description
 * @create 2022-04-21 16:17
 */
public interface DeptService {
    /**
     * 获取所有部门
     * @return
     */
    List<Dept> getDepts();
    /**
     * 插入部门
     */
//    int insertDept(Dept dept);
}
