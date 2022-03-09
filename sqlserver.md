# SQLServer 命令行笔记
- 连接SQLServer
```bash
sqlcmd -S localhost -U SA -P '<YouPassword>'
```

- 创建数据库
```sql
CREATE DATABASE TestDB
GO
```

- 查询所有的数据库名称
```sql
SELECT NAME FROM Sys.Databases
GO
```

- 切换数据库
```sql
USE TestDB
GO
```

- 查询当前数据库的表名称
```sql
SELECT NAME FROM SysObjects WHERE XTYPE = 'U'
GO
```

- SQLServer 数据类型
	1. int  
	2. tinyint
	3. varchar
- 创建表

