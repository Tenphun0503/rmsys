package com.tenphun.rmsys.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.tenphun.rmsys.common.BusinessException;
import com.tenphun.rmsys.common.R;
import com.tenphun.rmsys.entity.Employee;
import com.tenphun.rmsys.service.EmployeeService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;


@Slf4j
@RestController
@RequestMapping("/employee")
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;


    /**
     * Employee login
     */
    @PostMapping("/login")
    public R<Employee> login(HttpServletRequest request, @RequestBody Employee employee){
        // 1. Compare username
        LambdaQueryWrapper<Employee> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Employee::getUsername, employee.getUsername());
        Employee emp = employeeService.getOne(queryWrapper);

        // 2. return false if no match
        if (null == emp) return R.error("Login Failed");

        // 3. Compare password
        // 3.1 encrypt password
        String password = employee.getPassword();
        password = DigestUtils.md5DigestAsHex(password.getBytes());
        // 3.2 return false if no match
        if(!emp.getPassword().equals(password)) return R.error("Login Failed");

        // 4. Compare status
        if(emp.getStatus()==0) return R.error("Account Disabled");

        // 5. Login
        // 5.1 Save to session
        request.getSession().setAttribute("employee", emp.getId());
        // 5.2 return success result
        return R.success(emp);
    }

    /**
     * Employee logout
     */
    @PostMapping("/logout")
    public R<String> logout(HttpServletRequest request){
        // Clean Session
        request.getSession().removeAttribute("employee");
        return R.success("Successfully log out");
    }


    /**
     * Employee Adding
     */
    @PostMapping
    public R<String> add(@RequestBody Employee employee){
        // 1. set other infos
        employee.setPassword(DigestUtils.md5DigestAsHex("123456".getBytes()));

        // 2. add to database
        try {employeeService.save(employee);}
        catch (Exception e){
            throw new BusinessException("Username Existed");
        }
        log.info("[INFO] Successfully add employee into database");
        return R.success("Successfully added");
    }

    /**
     * Show Employee By Page
     */
    @GetMapping("/page")
    public R<Page<Employee>> page(int page, int pageSize, String name){
        // Create Pagination Constructor
        Page<Employee> pageInfo = new Page<>(page,pageSize);

        // Create Condition Constructor
        LambdaQueryWrapper<Employee> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(StringUtils.isNotEmpty(name), Employee::getName, name);
        wrapper.orderByDesc(Employee::getUpdateTime);
        employeeService.page(pageInfo, wrapper);

        return R.success(pageInfo);
    }


    /**
     * Edit employee information
     */
    @PutMapping
    public R<String> update(@RequestBody Employee e){
        // update user
        employeeService.updateById(e);
        return R.success("Successfully Changed Status");
    }

    @GetMapping("/{id}")
    public R<Employee> getById(@PathVariable Long id){
        Employee emp = employeeService.getById(id);
        if(emp == null) {
            return R.error("User not existed");
        }
        return R.success(emp);
    }
}
