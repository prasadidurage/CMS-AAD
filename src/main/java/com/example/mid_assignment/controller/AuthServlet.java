package com.example.mid_assignment.controller;


import com.example.mid_assignment.dao.UserDAO;
import com.example.mid_assignment.model.User;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.sql.DataSource;
import java.io.IOException;

@WebServlet("/authServlet")
public class AuthServlet extends HttpServlet {
    UserDAO userDAO ;

    public void init() throws ServletException {
        ServletContext context = getServletContext();
        DataSource ds = (DataSource) context.getAttribute("ds");
        userDAO = new UserDAO(ds);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("signup".equalsIgnoreCase(action)) {
            handleSignup(request, response);
        } else if ("login".equalsIgnoreCase(action)) {
            handleLogin(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }


    private void handleSignup(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullname = request.getParameter("full_name");
        String email = request.getParameter("email");
        String role = request.getParameter("role");

        User user = new User(username, password, fullname, email, role);

        boolean register = userDAO.register(user);
        if (register) {
            request.getSession().setAttribute("message", "Registration successful! Please login.");
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            request.getSession().setAttribute("error", "Registration failed.");
            response.sendRedirect(request.getContextPath() + "/Pages/Singup.jsp");
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println("username: " + username + " password: " + password);

        User user = userDAO.login(username, password);
        if (user != null) {
            String role = user.getRole();
            if ("ADMIN".equalsIgnoreCase(role)) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("role", user.getRole());
                response.sendRedirect(request.getContextPath() + "/Pages/admindashboard.jsp");
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("employeeId", user.getId());
                session.setAttribute("employeeName", user.getUsername());
                response.sendRedirect(request.getContextPath() + "/Pages/EmployeeDashBoard.jsp");
            }
        } else {
            request.getSession().setAttribute("error", "Invalid username or password");
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }

}
