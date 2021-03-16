package com.aigao.manager.config;

import com.alibaba.druid.pool.DruidDataSource;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContextInitializer;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import javax.sql.DataSource;

/**
 * @author insomnia
 * @date 2021/3/14 上午3:38
 * @effect Spring 配置
 */
@Configuration
@EnableWebMvc
@Import(DruidConfig.class)
@ComponentScan(value = {"com.aigao.manager"},
        excludeFilters = @ComponentScan.Filter (type = FilterType.ANNOTATION , value = {Controller.class}))
public class SpringConfig  {

    private static Logger logger = LogManager.getLogger(SpringConfig.class);

}
