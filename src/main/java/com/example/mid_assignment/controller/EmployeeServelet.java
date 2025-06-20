package com.example.mid_assignment.controller;

import com.example.mid_assignment.dao.ComplainDAO;
import com.example.mid_assignment.model.Complain;
import jakarta.annotation.Resource;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.sql.DataSource;
import javax.xml.stream.events.Comment;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet(urlPatterns = {"/submit-complaint", "/view-complaint", "/update-complaint", "/delete-complaint", "/my-complaints", "/employee-dashboard"})
public class EmployeeServelet extends HttpServlet {
    ComplainDAO complainDAO;
    private DataSource dataSource;

    @Override
    public void init() throws ServletException {
        ServletContext context = getServletContext();
        this.dataSource = (DataSource) context.getAttribute("ds");
        this.complainDAO = new ComplainDAO(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        complainDAO = new ComplainDAO();
//
//        HttpSession session = req.getSession();
//        if (session == null) {
//            resp.sendRedirect(req.getContextPath() + "/pages/login.jsp?msg=session_expired");
//            return;
//        }
//        Integer employeeId = (Integer) session.getAttribute("employeeId");
//        if (employeeId == null) {
//            resp.sendRedirect(req.getContextPath() + "/pages/login.jsp?msg=invalid_session");
//            return;
//        }
//
//        String servletPath = req.getServletPath();

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("employeeId") == null) {
            resp.sendRedirect(req.getContextPath() + "/pages/login.jsp?msg=session_expired");
            return;
        }

        String employeeId = (String) session.getAttribute("employeeId");
        String servletPath = req.getServletPath();

        switch (servletPath) {
            case "/employee-dashboard":
                handleDashboard(req, resp, complainDAO, employeeId, session);
                break;
            case "/my-complaints":
                handleMyComplaints(req, resp, complainDAO, employeeId);
                break;
            case "/view-complaint":
                handleViewComplaint(req, resp, complainDAO, employeeId);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/employee-dashboard");
        }
    }

    private void handleDashboard(HttpServletRequest req, HttpServletResponse resp, ComplainDAO complainDAO, String employeeId, HttpSession session) throws ServletException, IOException {
        try {
            //wrp
            List<Complain> complaints = complainDAO.getAllComplaintsById(employeeId);
            req.setAttribute("complaints", complaints);

            long totalComplaints = complaints.size();
            long pendingComplaints = complaints.stream().filter(c -> "PENDING".equals(c.getStatus())).count();
            long resolvedComplaints = complaints.stream().filter(c -> "RESOLVED".equals(c.getStatus())).count();
            long inProgressComplaints = complaints.stream().filter(c -> "IN_PROGRESS".equals(c.getStatus())).count();
            long rejectedComplaints = complaints.stream().filter(c -> "REJECTED".equals(c.getStatus())).count();

            req.setAttribute("totalComplaints", totalComplaints);
            req.setAttribute("pendingComplaints", pendingComplaints);
            req.setAttribute("resolvedComplaints", resolvedComplaints);
            req.setAttribute("inProgressComplaints", inProgressComplaints);
            req.setAttribute("rejectedComplaints", rejectedComplaints);

            String successMessage = (String) session.getAttribute("successMessage");
            String errorMessage = (String) session.getAttribute("errorMessage");

            if (successMessage != null) {
                req.setAttribute("successMessage", successMessage);
                session.removeAttribute("successMessage");
            }

            if (errorMessage != null) {
                req.setAttribute("errorMessage", errorMessage);
                session.removeAttribute("errorMessage");
            }

            req.getRequestDispatcher("/Pages/EmployeeDashBoard.jsp").forward(req, resp);

        } catch (Exception e) {
            throw new ServletException("Error loading dashboard data", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String servletPath = req.getServletPath();

        try {
            HttpSession session = req.getSession(false);
            System.out.println("jhhhhhhhh");
            if (session == null) {
                resp.sendRedirect(req.getContextPath() + "/pages/login.jsp?msg=session_expired");
                return;
            }

            String employeeId = (String) session.getAttribute("employeeId");
            String employeeName = (String) session.getAttribute("employeeName");
            System.out.println("kkkkkkkkkkk");

            if (employeeId == null || employeeName == null) {
                System.out.println("lllllllll");
                resp.sendRedirect(req.getContextPath() + "/pages/login.jsp?msg=invalid_session");
                return;
            }

            ComplainDAO complainDAO = new ComplainDAO(dataSource);

            switch (servletPath) {
                case "/submit-complaint":
                    saveComplaint(req, resp, complainDAO, employeeId, employeeName, session);
                    break;
                case "/delete-complaint":
                    deleteComplaint(req, resp, complainDAO, employeeId, session);
                    break;
                case "/update-complaint":
                    updateComplaint(req, resp, complainDAO, employeeId, session);
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/employee-dashboard");
            }
            System.out.println("iiiiiiii");

        } catch (Exception e) {
            System.err.println("Error in EmployeeServlet POST: " + e.getMessage());
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/employee-dashboard?msg=error");
        }
    }

    private void updateComplaint(HttpServletRequest req, HttpServletResponse resp, ComplainDAO complainDAO, String employeeId, HttpSession session) {
    }

    private void deleteComplaint(HttpServletRequest req, HttpServletResponse resp, ComplainDAO complainDAO, String employeeId, HttpSession session) {
    }

    private void saveComplaint(HttpServletRequest req, HttpServletResponse resp, ComplainDAO complainDAO, String employeeId, String employeeName, HttpSession session) throws IOException {
        try {
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            String category = req.getParameter("category");
            String priority = req.getParameter("priority");
            String status = "PENDING";

            Timestamp createdAt = new Timestamp(System.currentTimeMillis());

            Complain complain = new Complain();
            complain.setTitle(title);
            complain.setDescription(description);
            complain.setCategory(category);
            complain.setPriority(priority);
            complain.setStatus(status);
            complain.setCreatedAt(createdAt);
            complain.setSubmitterName(employeeName);
            complain.setSubmittedBy(String.valueOf(employeeId));

            boolean isSaved = complainDAO.saveComplaint(complain);

            if (isSaved) {
                session.setAttribute("successMessage", "Complaint submitted successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to submit complaint. Please try again.");
            }

        } catch (Exception e) {
            session.setAttribute("errorMessage", "Error submitting complaint: " + e.getMessage());
            System.err.println("Error submitting complaint: " + e.getMessage());
            e.printStackTrace();
        }

        resp.sendRedirect(req.getContextPath() + "/employee-dashboard");
    }

    private void handleMyComplaints(HttpServletRequest req, HttpServletResponse resp, ComplainDAO complainDAO, String employeeId) throws ServletException, IOException {
        try {
            List<Complain> complaints = complainDAO.getAllComplaintsById(employeeId);
            req.setAttribute("complaints", complaints);
            req.setAttribute("pageTitle", "My Complaints");
            req.getRequestDispatcher("/pages/my-complaints.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException("Error loading complaints", e);
        }
    }

    private void handleViewComplaint(HttpServletRequest req, HttpServletResponse resp, ComplainDAO complainDAO, String employeeId) throws ServletException, IOException {
        String complaintIdStr = req.getParameter("id");
        if (complaintIdStr != null) {
            try {
                int complaintId = Integer.parseInt(complaintIdStr);
                List<Complain> userComplaints = complainDAO.getAllComplaintsById(employeeId);
                Complain complaint = userComplaints.stream()
                        .filter(c -> c.getId() == complaintId)
                        .findFirst()
                        .orElse(null);

                if (complaint != null) {
                    req.setAttribute("complaint", complaint);
                    req.getRequestDispatcher("/pages/view-complaint.jsp").forward(req, resp);
                } else {
                    resp.sendRedirect(req.getContextPath() + "/employee-dashboard?msg=complaint_not_found");
                }
            } catch (NumberFormatException e) {
                resp.sendRedirect(req.getContextPath() + "/employee-dashboard?msg=invalid_id");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/employee-dashboard");
        }
    }

}

