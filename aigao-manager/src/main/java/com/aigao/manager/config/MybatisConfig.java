package com.aigao.manager.config;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

import javax.sql.DataSource;

/**
 * @author insomnia
 * @date 2021/3/16 下午1:34
 * @effect MybatisSpring 配置
 */
@Configuration
public class MybatisConfig {
    private static Logger logger = LogManager.getLogger(MybatisConfig.class);


    @Autowired
    DataSource dataSource;

    @Bean
    public SqlSessionFactory sqlSessionFactoryBean() throws Exception {
        SqlSessionFactoryBean sessionFactoryBean = new SqlSessionFactoryBean();
        sessionFactoryBean.setDataSource(dataSource);
        sessionFactoryBean.setMapperLocations(new ClassPathResource("/mybatis/**/*.xml"));
        sessionFactoryBean.setConfigLocation(new ClassPathResource("/mybatis/mybatis.cfg.xml"));
        return sessionFactoryBean.getObject();
    }

}
