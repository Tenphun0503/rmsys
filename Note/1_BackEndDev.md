# Development Record
## Introduction
This document outlines the development process and progress.
The purpose of this development is to serve as the server-side logic for the RMS.
The backend system is responsible for handling requests from the frontend, processing data, and communicating with the database.

## Project Setup
- Create a new SpringBoot project trough Spring Initializer
- Configured the [pom.xml](../pom.xml)
- Configured the [application.yml](../src/main/resources/application.yml)
- Load frontend static resources templates
- Configured the [WebMvcConfig.java](../src/main/java/com/tenphun/rmsys/config/WebMvcConfig.java) to map static resources

## DataBase Setup
- Created a MySQL database schema with necessary tables and columns
- Created domain models to map to the database tables

## Module Developing
### Login Module
#### Demand Analysis
- Function: Employee can log in with username and password
- Components: Username field, password field, login button
- Procedure: click button -> send request -> controller -> service -> mapper -> database
- Determine Request
  - Request URL: `http://localhost:8080/employee/login`
  - Request Method: POST
  - Request Payload: {username: "admin", password: "123456"}
- Determine Table
    - Related Table: employee
- Determine Response
  ```
  {
      let res = await loginApi(this.loginForm)
      if (String(res.code) === '1') {
          localStorage.setItem('userInfo',JSON.stringify(res.data))
          window.location.href= '/backend/index.html'
      } else {
          this.$message.error(res.msg)
          this.loading = false
      }
  }
  ```
  - We can see we need a res{code, data, msg}
#### Code Development
- Set up
  - Create entity class: [Employee.java](../src/main/java/com/tenphun/rmsys/entity/Employee.java)
  - Create mapper: [EmployeeMapper.java](../src/main/java/com/tenphun/rmsys/mapper/EmployeeMapper.java)
  - Create service interface: [EmployeeService.java](../src/main/java/com/tenphun/rmsys/service/EmployeeService.java)
  - Create service implementation: [EmployeeServiceImpl.java](../src/main/java/com/tenphun/rmsys/service/impl/EmployeeServiceImpl.java)
  - Create service controller: [EmployeeController.java](../src/main/java/com/tenphun/rmsys/controller/EmployeeController.java)
  - Create a common Result class: [R.java](../src/main/java/com/tenphun/rmsys/common/R.java)
- Business Logic
  - Search username in the database
    - if false: return `login failed` result
  - else: Encrypt the password with md5 and Compare password
    - if false, return `login failed` result
  - else: Check if employee is disabled
    - if true, return `employee disabled` result
  - else: Save employee id into session and Return `login successed` result
#### Function Test

## Security

## Testing

## Conclusion
- used lombok to print log in case of better maintenance
- Wrote detailed development documentation