package com.aigao.manager.config;

import com.alibaba.druid.support.http.StatViewServlet;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;


/**
 * @author insomnia
 * @date 2021/3/13 下午8:44
 * @effect 设置 servlet 容器 ，相当于 web.xml
 */

public class WebInit implements WebApplicationInitializer {

   private static Logger logger = LogManager.getLogger(WebInit.class);

    /**
     * Configure the given {@link ServletContext} with any servlets, filters, listeners
     * context-params and attributes necessary for initializing this web application. See
     * examples {@linkplain WebApplicationInitializer above}.
     *
     * @param servletContext the {@code ServletContext} to initialize
     * @throws ServletException if any call against the given {@code ServletContext}
     *                          throws a {@code ServletException}
     */
    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {
        dispatcherServletRegister(servletContext);
        druidServletRegister(servletContext);

    }

    /**
     * SpringMVC 配置
     *
     * @param servletContext servletContext
     */

    private void dispatcherServletRegister(ServletContext servletContext) {
        AnnotationConfigWebApplicationContext context = new AnnotationConfigWebApplicationContext();
        context.register(MvcConfig.class);
        ServletRegistration.Dynamic dispatcherServlet = servletContext.addServlet("dispatcherServlet", new DispatcherServlet(context));
        dispatcherServlet.addMapping("/");
        dispatcherServlet.setLoadOnStartup(1);
        logger.info("Register Servlet ‘dispatcherServlet’...");
    }


    /**
     * 开启 druid 数据监控
     *
     * @param servletContext servletContext
     */

    private void druidServletRegister(ServletContext servletContext) {
        ServletRegistration.Dynamic druidStatView = servletContext.addServlet("DruidStatView", new StatViewServlet());
        druidStatView.setInitParameter("loginUsername", "admin");
        druidStatView.setInitParameter("loginPassword", "final");
        druidStatView.setInitParameter("allow", "127.0.0.1");
        druidStatView.addMapping("/druid/*");
        logger.info("Register Servlet ‘DruidStatView’...");
    }


}

