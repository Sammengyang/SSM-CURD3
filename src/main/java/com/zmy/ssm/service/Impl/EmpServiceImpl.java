package com.zmy.ssm.service.Impl;

import com.zmy.ssm.mapper.EmpMapper;
import com.zmy.ssm.pojo.Emp;
import com.zmy.ssm.pojo.EmpExample;
import com.zmy.ssm.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
     * 查询所有员工
     * @return
     */
    @Override
    public List<Emp> getAllEmp() {
        return empMapper.selectByExampleWithDept(null);
    }
}
