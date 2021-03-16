package com.aigao.manager.config;


import com.aigao.manager.util.MD5Utils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.sql.DataSource;
import java.sql.SQLException;

/**
 * @author insomnia
 * @date 2021/3/14 上午3:56
 * @effect
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {DruidConfig.class})
public class Main {

    Logger logger = LogManager.getLogger(Main.class);

    @Autowired
    DataSource dataSource;

    @Test
    public void testApp() throws SQLException {
       logger.info("Connection: "+dataSource.getConnection());
    }

    @Test
    public void testMD5Utils(){
        String password = "insomnia";
        logger.info(MD5Utils.saltValueMD5Upper(password));
        logger.info(MD5Utils.saltValueMD5Lower(password));
        logger.info(MD5Utils.valid(password,MD5Utils.MD5ToLower(password)));
    }
}
