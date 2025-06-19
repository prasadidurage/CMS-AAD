<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%--<%@ page import="dto.Complaint" %>--%>
<%--<%--%>
<%--    List<Complaint> complaintList = (List<Complaint>) request.getAttribute("complaints");--%>
<%--    String role = (String) session.getAttribute("role");--%>
<%--%>--%>
<!DOCTYPE html>
<html>
<head>
    <title>Complaint List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
<%--    <h2 class="mb-4"><%= role.equals("A") ? "All Complaints" : "My Complaints" %></h2>--%>

    <table class="table table-bordered table-hover">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Category</th>
            <th>Status</th>
            <th>Priority</th>
            <th>Created At</th>
<%--            <% if ("A".equals(role)) { %>--%>
            <th>Submitted By</th>
            <th>Assigned To</th>
            <th>Remarks</th>
            <th>Actions</th>
<%--            <% } else { %>--%>
<%--            <th>Actions</th>--%>
<%--            <% } %>--%>
        </tr>
        </thead>
        <tbody>
<%--        <%--%>
<%--            if (complaintList != null && !complaintList.isEmpty()) {--%>
<%--                for (Complaint c : complaintList) {--%>
<%--        %>--%>
<%--        <tr>--%>
<%--            <td><%= c.getId() %></td>--%>
<%--            <td><%= c.getTitle() %></td>--%>
<%--            <td><%= c.getCategory() %></td>--%>
<%--            <td><%= c.getStatus() %></td>--%>
<%--            <td><%= c.getPriority() %></td>--%>
<%--            <td><%= c.getCreatedAt() %></td>--%>
<%--            <% if ("A".equals(role)) { %>--%>
<%--            <td><%= c.getSubmitterName() %></td>--%>
<%--            <td><%= c.getAssigneeName() != null ? c.getAssigneeName() : "Unassigned" %></td>--%>
<%--            <td><%= c.getAdminRemarks() != null ? c.getAdminRemarks() : "-" %></td>--%>
<%--            <td>--%>
<%--                <a href="editComplaint?id=<%= c.getId() %>" class="btn btn-sm btn-warning">Edit</a>--%>
<%--                <a href="deleteComplaint?id=<%= c.getId() %>" class="btn btn-sm btn-danger"--%>
<%--                   onclick="return confirm('Are you sure?');">Delete</a>--%>
<%--            </td>--%>
<%--           // <% } else { %>--%>
<%--            <td>--%>
<%--                <% if (!"RESOLVED".equalsIgnoreCase(c.getStatus())) { %>--%>
<%--                <a href="editComplaint?id=<%= c.getId() %>" class="btn btn-sm btn-warning">Edit</a>--%>
<%--                <a href="deleteComplaint?id=<%= c.getId() %>" class="btn btn-sm btn-danger"--%>
<%--                   onclick="return confirm('Are you sure?');">Delete</a>--%>
<%--                <% } else { %>--%>
<%--                <span class="text-muted">Locked</span>--%>
<%--                <% } %>--%>
<%--            </td>--%>
<%--            <% } %>--%>
<%--        </tr>--%>
<%--        <%--%>
<%--            }--%>
<%--        } else {--%>
<%--        %>--%>
<%--        <tr><td colspan="10" class="text-center">No complaints found.</td></tr>--%>
<%--        <%--%>
<%--            }--%>
<%--        %>--%>
        </tbody>
    </table>

<%--    <a href="<%= role.equals("A") ? "adminDashboard.jsp" : "employeeDashboard.jsp" %>" class="btn btn-secondary">Back</a>--%>
</div>
</body>
</html>
