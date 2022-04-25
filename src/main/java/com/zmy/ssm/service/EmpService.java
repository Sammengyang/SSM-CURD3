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
     *
     * @param eid
     * @param empName
     * @return
     */
    Emp Login(String eid,String empName);
    /**
     * 获取所有员工
     * @return
     */
    List<Emp> getAllEmp();

    /**
     *  添加员工
     * @param emp
     * @return
     */
    void addEmp(Emp emp);

    /**
     *  校验用户名是否可用
     * @param empName
     * @return
     */
    boolean checkName(String empName);

    /**
     * 根据id查询员工信息
     * @param eid
     * @return
     */
    Emp getEmpByid(Integer eid);

    /**
     * 根据主键删除
     * @param eid
     * @return
     */
    Integer delEmpByeid(Integer eid);

    /**
     * 批量删除
     * @param list
     */
    void delEmpByExample(List<Integer> list);

    /**
     *  更新
     * @param emp
     */
    void updateEmp(Integer eid,Emp emp);

    /**
     * 通过名字批量删除
     * @param names
     */
    void delAllEmpByName(String[] names);
}
