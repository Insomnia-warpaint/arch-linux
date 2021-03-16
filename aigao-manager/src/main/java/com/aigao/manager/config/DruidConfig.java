package com.aigao.manager.config;

import com.aigao.manager.util.MD5Utils;
import com.alibaba.druid.pool.DruidDataSource;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import javax.sql.DataSource;

/**
 * @author insomnia
 * @date 2021/3/15 下午6:19
 * @effect Druid 数据源配置
 */
@Configuration
@PropertySource("classpath:druid.properties")
public class DruidConfig {

    private static Logger logger = LogManager.getLogger(DruidConfig.class);

    @Value("${com.mysql.jdbc.userName}")
    private String userName;

    @Value("${com.mysql.jdbc.password}")
    private String password;

    @Value("${com.mysql.jdbc.url}")
    private String jdbcUrl;

    @Value("${com.mysql.jdbc.driverClass}")
    private String driverClass;

    //初始化大小
    @Value("${com.druid.initialSize}")
    private Integer initialSize;

    //最小连接数
    @Value("${com.druid.minIdle}")
    private Integer minIdle;

    //最大连接数
    @Value("${com.druid.maxActive}")
    private Integer maxActive;

    //配置获取连接等待超时的时间
    @Value("${com.druid.maxWait}")
    private Long maxWait;

    //配置多久检测需要关闭的空闲连接 单位是毫秒
    @Value("${com.druid.timeBetweenEvictionRunsMillis}")
    private Long timeBetweenEvictionRunsMillis;


    @Bean(name = "druidDataSource")
    public DataSource druidDataSource(){
        DruidDataSource dataSource = new DruidDataSource();
        dataSource.setUsername(userName);
        dataSource.setPassword(password);
        dataSource.setUrl(jdbcUrl);
        dataSource.setDriverClassName(driverClass);
        dataSource.setInitialSize(initialSize);
        dataSource.setMinIdle(minIdle);
        dataSource.setMaxActive(maxActive);
        dataSource.setMaxWait(maxWait);
        dataSource.setTimeBetweenEvictionRunsMillis(timeBetweenEvictionRunsMillis);
        return dataSource;
    }

}
