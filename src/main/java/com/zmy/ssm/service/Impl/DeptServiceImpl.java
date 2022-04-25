package com.zmy.ssm.service.Impl;

import com.zmy.ssm.mapper.DeptMapper;
import com.zmy.ssm.pojo.Dept;
import com.zmy.ssm.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Sam  Email:superdouble@yeah.net
 * @Description
 * @create 2022-04-21 16:17
 */
@Service
public class DeptServiceImpl implements DeptService {

    @Autowired
    private DeptMapper deptMapper;

    /**
     * 获取所有部门信息
     * @return
     */
    @Override
    public List<Dept> getDepts() {
        return deptMapper.selectAll();
    }


//
//
//    @Override
//    public int insertDept(Dept dept) {
//        return deptMapper.insertSelective(dept);
//    }
}
