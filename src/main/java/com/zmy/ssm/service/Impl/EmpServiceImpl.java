package com.zmy.ssm.service.Impl;

import com.zmy.ssm.mapper.EmpMapper;
import com.zmy.ssm.pojo.Emp;
import com.zmy.ssm.service.EmpService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


/**
 * @author Sam  Email:superdouble@yeah.net
 * @Description
 * @create 2022-04-20 22:49
 */
@Service
public class EmpServiceImpl implements EmpService {

    @Autowired
    private EmpMapper empMapper;


    /**
     * 登录
     *
     * @param eid
     * @param empName
     * @return
     */
    @Override
    public Emp Login(String eid, String empName) {
        Emp emp = new Emp();
        emp.setEmpName(empName);
        emp.setEid(Integer.valueOf(eid));
        return empMapper.selectOne(emp);
    }

    /**
     * 查询所有员工
     *
     * @return
     */
    @Override
    public List<Emp> getAllEmp() {
//        List<Emp> emps = empMapper.selectEmpWithDept();
        return empMapper.selectEmpWithDept();
    }

    /**
     * 添加员工
     *
     * @param emp
     * @return
     */
    @Override
    public void addEmp(Emp emp) {
        empMapper.insertSelective(emp);
    }

    /**
     * 校验用户名是否可用
     *
     * @param empName
     * @return true 可用 ，否则 不可用
     */
    @Override
    public boolean checkName(String empName) {
        Example example = new Example(Emp.class);
        example.createCriteria().andEqualTo("empName", empName);
        int count = empMapper.selectCountByExample(example);
        return count == 0;
    }

    /**
     * 根据id查询员工信息
     * @param eid
     * @return
     */
    @Override
    public Emp getEmpByid(Integer eid) {
        Example example = new Example(Emp.class);
        example.createCriteria().andEqualTo("eid",eid);
        return empMapper.selectOneByExample(example);
    }


    /**
     * 根据主键删除
     *
     * @param eid
     * @return
     */
    @Override
    public Integer delEmpByeid(Integer eid) {
        Example example = new Example(Emp.class);
        example.createCriteria().andEqualTo("eid",eid);
        return empMapper.deleteByExample(example);
    }

    /**
     * 批量删除
     *
     * @param list
     */
    @Override
    public void delEmpByExample(List<Integer> list) {
        Example example = new Example(Emp.class);
        example.createCriteria().andIn("eid", list);
        empMapper.deleteByExample(example);
    }

    @Override
    public void updateEmp(Integer eid,Emp emp) {
        Example example = new Example(Emp.class);
        example.createCriteria()
                .andEqualTo("eid", emp.getEid());
        empMapper.updateByExampleSelective(emp, example);
    }

    /**
     * 通过名字批量删除
     * @param names
     */
    @Override
    public void delAllEmpByName(String[] names) {
        List<String> nameList = Arrays.asList(names);
        Example example = new Example(Emp.class);
        example.createCriteria().andIn("empName",nameList);
        empMapper.deleteByExample(example);
    }

    // todo 未做，删除修改后当前页面刷新
}
