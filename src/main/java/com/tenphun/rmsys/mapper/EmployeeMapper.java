package com.tenphun.rmsys.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.tenphun.rmsys.entity.Employee;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EmployeeMapper extends BaseMapper<Employee> {
}