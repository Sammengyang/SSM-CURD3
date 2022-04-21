package com.zmy.ssm.service.Impl;

import com.zmy.ssm.dao.EmployeeMapper;
import com.zmy.ssm.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author Sam  Email:superdouble@yeah.net
 * @Description
 * @create 2022-04-20 22:49
 */
@Service
public class EmpServiceImpl implements EmpService {

    @Autowired
    private EmployeeMapper employeeMapper;

    @Override
    public Integer getCount() {
        return employeeMapper.countByExample(null);
    }
}
