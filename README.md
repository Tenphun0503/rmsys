# Restaurant Management System
A restaurant management system (RSM) based on SpringBoot + SSM.  
This project is a practice of learning SpringBoot, SSM
and perform of OOP, AOP, and MVC concept into real world problem.

---
## Table of Contents
- **[Restaurant Management System](#restaurant-management-system)**
    - **[Table of Contents](#table-of-contents)**
    - **[Technologies Used](#technologies-used)**
    - **[Getting Started](#getting-started)**
    - **[Test]()**
    - **[Contributing]()**
    - **[Contact]()**

---
## Technologies Used
- Programming language
  - Java
- Database Management System
  - MySQL
- Web Application Frameworks
  - SpringBoot
  - SpringMVC
  - Spring
- Persistence Framework
  - MyBaits-Plus
- Build Automation Tool
  - Maven
- Version Control Tool
  - Git&GitHub


---
## Getting Started
1. DataBase Building
2. FrontEnd Template
3. BackEnd Development
   - View all development records: [BackEndDev.md](Note/1_BackEndDev.md)
4. MobileEnd Development
   - View all development records: [MobileEndDev.md](Note/2_MobileEndDev.md)

---
## Project Deployment
1. [Linux](Note/3_Linux.md)

---
## Conclusion

## Conclusion
Perk
- used lombok to print log in case of better maintenance
- Wrote detailed development documentation
  Problem-Solution
- 19 length long data loss precision when it is sent to frontend
  - Use a self-defined **objectMapper** and put it into spring mvc message converters.
- Trying to use **metaObjectHandler** to autofill filed like createUser createTime, but it doesn't provide way to get current session
  - Use **ThreadLocal** to save current user of the session since each transaction(doFilter->update->updateFill) is happened in one thread
- packaged and deployed project on a linux(CentOS8) service

