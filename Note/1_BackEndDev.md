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
### 1. Login / Logout Module
#### 1.1 Login Module
- **Demand Analysis**
  - Function: Employee can log in with username and password
  - Components: Username field, password field, login button
  - Procedure: click button -> send request -> controller -> service -> mapper -> database
  - Determine Table
    - Related Table: employee
  - Determine Request
    - Request URI: `/employee/login`
    - Request Method: POST
    - Request Payload: {username: "admin", password: "123456"}
  - Determine Response by analyzing frontend code
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
- **Code Development**
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
- **Function Optimization**
  - Problem: we can directly enter the url to bypass the login page
  - Intuition: we hope user can access system only when they log in. If invalid access detected, jump to login page.
  - Solution: use filter or interceptor
  - Business Logic:
    - Define a filter: [LoginCheckFilter](../src/main/java/com/tenphun/rmsys/filter/LoginCheckFilter.java)
    - Get Request URI and determine if it needs to be filtered
      - if not, let it go
    - else: Determine login status
      - if true, let it go
    - else: Return `no login` result based on `if (res.data.code === 0 && res.data.msg === 'NOTLOGIN')`

#### 1.2 Logout Module
- **Demand Analysis**
  - Function: Employee can click the logout button to log out
  - Determine Request:
    - Request URI: `/employee/logout`
    - Request Method: POST
  - Determine Response
    - Success: `res.code = 1`
- **Code Development**
  - Business Logic
    - Clean info in Session
    - return `logout successed` result

### 2. Employee Module
#### 2.1 Add new employee
- **Demand Analysis**
  - Function: We can add employee by add employee button
  - Components: 
    - Given: username, name, phoneNumber, sex, idNumber
    - Need to add: password, createUser, updateUser
  - Determine Table
    - table: employee
      - username: unique
  - Determine Request:
    - Request URI: `/employee`
    - Request Method: POST
  - Determine Response:
    - Success `res.code = 1`
    - Failed `res.code = 0, res.msg`
- **Code Development**
  - ExceptionHandler
    - [BusinessException](../src/main/java/com/tenphun/rmsys/common/BusinessException.java)
    - [GlobalExceptionHandler](../src/main/java/com/tenphun/rmsys/common/GlobalExceptionHandler.java)
  - Business Logic
    - set other infos
    - try adding to database
      - if failed: catch exception, return `failed` result
      - else: return `success` result
#### 2.2 Query employee information through pagination
- **Demand Analysis**
- **Code Development**
#### 2.3 Enable/Disable employee
- **Demand Analysis**
- **Code Development**
#### 2.4 Edit Employee information
- **Demand Analysis**
- **Code Development**


## Security

## Testing

## Conclusion
- used lombok to print log in case of better maintenance
- Wrote detailed development documentation