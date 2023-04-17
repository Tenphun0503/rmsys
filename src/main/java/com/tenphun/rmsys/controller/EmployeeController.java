package com.tenphun.rmsys.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.tenphun.rmsys.common.R;
import com.tenphun.rmsys.entity.Employee;
import com.tenphun.rmsys.service.EmployeeService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/employee")
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;


    /**
     * Employee login
     * @param request
     * @param employee
     * @return
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
}
