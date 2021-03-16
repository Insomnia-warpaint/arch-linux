# 艾高科技管理系统
### 1.框架
- 视图层 
  - spring-mvc
  - jquery
    
- 持久化层
    - mybatis
    
- 日志
  - log4j2
    
- 模板引擎
  - thymeleaf
    
- 权限
    - spring-security
    - JWT
    
- 数据库
    - mysql:8.0
  
```groovy
 // 日志
    implementation group: 'org.apache.logging.log4j', name: 'log4j-core', version: '2.14.0'

    // 安全
    implementation group: 'com.auth0', name: 'java-jwt', version: '3.14.0'
    implementation group: 'org.springframework.security', name: 'spring-security-core', version: '5.2.1.RELEASE'

    //视图
    implementation group: 'org.thymeleaf', name: 'thymeleaf-spring5', version: '3.0.12.RELEASE'
    implementation group: 'org.springframework', name: 'spring-webmvc', version: '5.2.13.RELEASE'

    //数据库
    implementation group: 'com.alibaba', name: 'druid', version: '1.2.4'
    implementation group: 'org.mybatis', name: 'mybatis-spring', version: '2.0.6'
    implementation group:  'mysql', name: 'mysql-connector-java', version: '8.0.22'
```
    