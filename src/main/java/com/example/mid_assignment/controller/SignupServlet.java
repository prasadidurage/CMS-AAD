package com.example.mid_assignment.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Map;
import java.util.UUID;

import static java.lang.System.out;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        ObjectMapper mapper = new ObjectMapper();
//        Map<String, String> user = mapper.readValue(req.getReader(), Map.class);


        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String fullName = req.getParameter("full_name");
        String email = req.getParameter("email");
        String role = req.getParameter("role");


        ServletContext sc = getServletContext();
        BasicDataSource ds = (BasicDataSource) sc.getAttribute("ds");

        String sql = "INSERT INTO users (user_id, username, password, full_name, email, role, created_at) " +
                "VALUES (?, ?, ?, ?, ?, ?,NOW())";

        try {
            Connection connection = ds.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, UUID.randomUUID().toString());
            ps.setString(2, username);
            ps.setString(3, password);
            ps.setString(4, fullName);
            ps.setString(5, email);
            ps.setString(6, role);

            int execute = ps.executeUpdate();
            resp.setContentType("application/json");

            if (execute > 0) {
                req.setAttribute("message", "User created successfully!");
            } else {
                req.setAttribute("error", "Failed to create user.");
            }

        } catch (SQLException e) {
            req.setAttribute("error", "Username already exists or server error.");
        }

        req.getRequestDispatcher("/Pages/Singup.jsp").forward(req, resp);
    }


    }

