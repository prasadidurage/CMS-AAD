package com.example.mid_assignment.util;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.SQLException;

@WebListener
public class DataSource implements ServletContextListener {

    public void contextInitialized(ServletContextEvent sce) {
        BasicDataSource ds = new BasicDataSource();
        ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
        ds.setUrl("jdbc:mysql://localhost:3306/CMS");
        ds.setUsername("root");
        ds.setPassword("1234");
        ds.setInitialSize(5);
        ds.setMaxIdle(5);

        ServletContext context = sce.getServletContext();
        context.setAttribute("ds", ds);
    }

    public void contextDestroyed(ServletContextEvent sce) {

        try {
            ServletContext context = sce.getServletContext();
            BasicDataSource ds = (BasicDataSource) context.getAttribute("ds");
            ds.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
