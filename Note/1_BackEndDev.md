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
  - FrontEnd has an interceptor:
    - Determine Response: `res.data.code === 0 & res.data.msg === 'NOTLOGIN`
  - Business Logic:
    - Define a filter: [LoginCheckFilter](../src/main/java/com/tenphun/rmsys/filter/LoginCheckFilter.java)
    - Get Request URI and determine if it needs to be filtered
      - if not, let it go
    - else: Determine login status
      - if true, let it go
    - else: Return `no login` result stream

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
  - Determine Table
    - table: employee
      - username: unique
  - Determine Request:
    - Request URI: `/employee`
    - Request Method: POST
    - Request Payload: {username, name, phoneNumber, sex, idNumber}
    - Need to add: password
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
  - Function: We can see employee information with specific rows each page
  - Determine Request:
    - Request URI: `/employee/page?page&pageSize&name`
    - Request Method: GET
  - Determine Response:
    - Success: `res.code = 1 && res.data.records && res.data.total`
- **Code Development**
  - Set up MyBatis Plus Pagination Interceptor in [MyBatisPlusConfig.java](../src/main/java/com/tenphun/rmsys/config/MyBatisPlusConfig.java)
  - Create a Pagination Constructor
  - Create a Condition Constructor
  - Query user through pagination and condition
  - return Page object
  > Here we use highly encapsulated methods provided by myBatis Plus. Page object contains `records` and `total`
#### 2.3 Enable/Disable employee
- **Demand Analysis**
  - Function: Change employee status
  - Determine Request:
    - Request URI: `/employee`
    - Request Method: PUT
    - Request Payload: {id, status}
    - Need to update: updateTime updateUser
  - Determine Response:
    - Success: `res.code = 1`
- **Code Development**
  - Convert the id obtained from the frontend from long type to string type to prevent loss of precision
    - Create a [JacksonObjectMapper](../src/main/java/com/tenphun/rmsys/common/JacksonObjectMapper.java)
    - In [WebMvcConfig](../src/main/java/com/tenphun/rmsys/config/WebMvcConfig.java), extend our mapper into springMvc message converters
  - Update user info
  - return `update success` result
#### 2.4 Edit Employee information
- **Demand Analysis**
  - Function: First we have to show the current information of the employee, then we can edit the information.
  - Update is provided above, we have to implement getById method
  - Determine Request:
    - Request URI: `/employee/id`
    - Request Method: GET
  - Determine Response:
    - Success: return employee object
- **Code Development**
  - call service to get employee object by id
  - return employee object
#### 2.5 Module Optimization
- Problem: When we edit or insert a data, we have to manually set createTime, creatUser etc.
- Solution: Use automatic filling of common fields provided by myBaits-Plus
- Business Logic: 
  - Use `@TableField` annotation on attributes
  - Configure a [MetaObjectHandler](../src/main/java/com/tenphun/rmsys/common/MyMetaObjectHandler.java)
  - For time, we can directly set updateTime and createTime
  - For user, we have to use ThreadLocal to save the user from other place like filter
    - Set a tool class to get and save user: [BaseContext](../src/main/java/com/tenphun/rmsys/common/BaseContext.java)

### 3. Category Module
#### 3.1 Show Page
- **Demand Analysis**
  - Function: Present category through pagination
  - Request URI: `/category/page/page&pageSize`
  - Request Method: GET
  - Respond: {code, data{records,total}}
- **Code Development**
  - Create Pagination Constructor
  - Create Condition Constructor (sort by sort column)
  - return results
#### 3.2 Add Category
- **Demand Analysis**
  - Function: Add category 
  - Request URI: `/category`
  - Request Method: POST
  - Request Payload: {name, type, sort}
- **Code Development**
  - get object data
  - add into database
    - if success, return success
    - if exception occurs, return message
#### 3.3 Edit Category
- **Demand Analysis**
  - Function: Edit Category
  - Request URI: `/category`
  - Request Method: PUT
  - Request Payload: {id, name, sort}
- **Code Development**
  - call updateById
  - return success
#### 3.4 Delete Category
- **Demand Analysis**
  - Function: Delete Category, but will fail when the category related to a dish or set.
  - Request URI: `/category`
  - Request Method: DELETE
  - Request Payload: {id}
- **Code Development**
  - For checking Setmeal or Dish relevant relation, we have to first setup Setmeal and Dish module
  - write a self-defined remove method in [CategoryServiceImpl](../src/main/java/com/tenphun/rmsys/service/impl/CategoryServiceImpl.java)
    - check if category is associated with any of the Dish table
      - if there are, throw Exception
    - check if category is associated with any of the Setmeal table
      - if there are, throw Exception
    - call removeById
  - return success

### 4. Dish Module
#### 4.0 File Upload and Download
- **Demand Analysis**
  - Function: Allow user to upload and download files, such as image
  - Solution: We can use **MultipartFile** given by Spring-web
  - Request URI: `/common/upload` `/common/download`
  - Request Method: POST (File must use post)
- **Code Development**
  - in [CommonController](../src/main/java/com/tenphun/rmsys/controller/CommonController.java), set `MultipartFile` as para
  - in upload method, we can save file to specified path (we can configure direction in application.yml)
  - in download method, we have to write file content back to the frontend
#### 4.1 Add Dish
- **Demand Analysis**
  - Function: Add a new dish upon given data.
  - Related Table: dish_flavor
  - Show Category list
    - Request URI: `category/list?type`
    - Request Method: GET
    - Respond: List<Category>
  - Image upload and download
  - Save dish
    - Request URI: `/dish`
    - Request Method: POST
    - Request Payload: {categoryId, code, description, flavors, image, name, price, status}
- **Code Development**
  - Set up DishFlavor entity, mapper, service interface and implementation
  - Add a getByType method in CategoryController
  - Save dish into dish table, save flavors into dish_flavor table
    - Since frontend sent data different from our existed entity, so we have to create a new model [DishDto](../src/main/java/com/tenphun/rmsys/dto/DishDto.java)
      - Data Transfer Object (DTO) used for data transfer between presentation layer and business layer
    - Add self-defined service method in [DishServiceImpl](../src/main/java/com/tenphun/rmsys/service/impl/DishServiceImpl.java)
      - save dish into dish table
      - get dish id
      - set flavors dishId
      - save flavors into dish_flavor table
#### 4.2 Show Page
- **Demand Analysis**
  - Function: Show dishes through pagination
  - Request URI: `/dish/page`
  - Request Method: GET
  - Request Payload: {page, pageSize, [name]}
  - Response: {code, {records, total}}
  - Special Request:
    - Need to present image (use `/common/download`)
    - Need to present name of the category (use `DishDto`)
- **Code Development**
  - Business Logic:
    - Like before, get Page<Dish> object of dishes
    - Create a Page<DishDto> object
      - only difference between them should be `categoryName` in `records`
      - copy all other data from Page<Dish> object into Page<DishDto> object
      - use `categoryId` query name of the category and set into `categoryName`
      - return Page<DishDto> object
#### 4.3 Edit Dish
- **Demand Analysis**
  - Function: Present the existed information and allow modification
  - Present the information
    - Request URI: `/dish/{id}`
    - Request Method: GET
    - Response: DishDto
  - Update with given info
    - Request URI: `/dish`
    - Request Method: PUT
    - Request PayLoad: {DishDto}
- **Code Development**
  - getById method
    - Get dish by id from dish table
    - Get flavorList by dishId=id from dish_flavor table
    - create a DishDto object and set its attribute from dish and flavorList
    - return DishDto object
  - Update method
    - Update dish table
    - clean all current flavors
    - save new flavors
      - set dishId (new flavor records don't have that)
  - Return success
#### 4.4 Delete Dish
- **Demand Analysis**
  - Function: Delete Dish or Selected Dishes
  - Request URI: `/dish/{ids}`
  - Request Method: DELETE
- **Code Development**
  - iterate the ids
    - remove from dish table by id
    - remove from flavors table where dishId=id
    - TODO: remove image

### 5. Setmeal Module
#### 5.1 Show Page
- **Demand Analysis**
  - Function: Show set meals through pagination
  - Request URI: `/setmeal/page`
  - Request Method: GET
  - Request Payload: {page, pageSize, [name]}
  - Request Respond: {code, {records, total}}
- **Code Development**
#### 5.2 Add Category
- **Demand Analysis**
- **Code Development**
#### 5.3 Edit Category
- **Demand Analysis**
- **Code Development**
#### 5.4 Delete Category
- **Demand Analysis**
- **Code Development**

## Security

## Testing

## Conclusion
Perk
- used lombok to print log in case of better maintenance
- Wrote detailed development documentation
Problem-Solution
- 19 length long data loss precision when it is sent to frontend
  - Use a self-defined **objectMapper** and put it into spring mvc message converters.
- Trying to use **metaObjectHandler** to autofill filed like createUser createTime, but it doesn't provide way to get current session
  - Use **ThreadLocal** to save current user of the session since each transaction(doFilter->update->updateFill) is happened in one thread