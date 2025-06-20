<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.example.mid_assignment.model.Complain" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admindashboard.css">
    <style>
        .status-form {
            display: inline-block;
            margin: 0;
        }

        .status-dropdown {
            border: 1px solid #dee2e6;
            padding: 0.25rem 0.5rem;
            border-radius: 0.375rem;
            font-size: 0.875rem;
            font-weight: 500;
            cursor: pointer;
            min-width: 120px;
        }

        .status-PENDING {
            background-color: #fff3cd;
            color: #664d03;
            border-color: #ffc107;
        }

        .status-IN_PROGRESS {
            background-color: #cff4fc;
            color: #055160;
            border-color: #0dcaf0;
        }

        .status-RESOLVED {
            background-color: #d1e7dd;
            color: #0f5132;
            border-color: #198754;
        }

        .status-REJECTED {
            background-color: #f8d7da;
            color: #721c24;
            border-color: #dc3545;
        }

        .update-btn {
            padding: 0.25rem 0.5rem;
            font-size: 0.75rem;
            margin-left: 0.25rem;
        }

        .summary-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: default;
        }

        .summary-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
        }

        .icon-circle {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            font-size: 2rem;
            transition: transform 0.3s ease;
        }

        .summary-card:hover .icon-circle {
            transform: scale(1.2);
        }

        /* Custom background colors if you want gradient instead of solid */
        .bg-primary {
            background: linear-gradient(135deg, #667eea, #764ba2) !important;
        }

        .bg-warning {
            background: linear-gradient(135deg, #f093fb, #f5576c) !important;
            color: #3a3a3a !important;
        }

        .bg-success {
            background: linear-gradient(135deg, #4facfe, #00f2fe) !important;
        }

        .bg-danger {
            background: linear-gradient(135deg, #fa709a, #fee140) !important;
        }

        .page-header {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgb(0 0 0 / 0.07);
            padding: 0.4rem 1rem;
            margin-bottom: 1rem;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .page-header i {
            transition: transform 0.3s ease;
        }

        .page-header:hover i {
            transform: scale(1.1);
        }

        .main-content {
            background-color: #f6f8fa;
            min-height: calc(100vh - 56px);
            padding-top: 1rem;
            padding-bottom: 1rem;
        }



    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg shadow-sm py-3 sticky-top" style="background: linear-gradient(to right, #2c3e50, #34495e);">
    <div class="container-fluid">
        <a class="navbar-brand text-white fw-bold d-flex align-items-center" href="#">
            <i class="bi bi-shield-check me-2 fs-4 text-info"></i>
            <span class="fs-5">Complaint Management System</span>
        </a>

        <button class="navbar-toggler text-white" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto ms-3">
                <li class="nav-item">
                    <a class="nav-link text-white fw-semibold" href="#">
                        <i class="bi bi-speedometer2 me-1"></i>Dashboard
                    </a>
                </li>
                <!-- Add more nav items if needed -->
            </ul>

            <div class="d-flex align-items-center">
                <form action="logout" method="post">
                    <button type="submit" class="btn btn-sm btn-outline-light d-flex align-items-center gap-1 px-3 py-1 rounded-pill shadow-sm">
                        <i class="bi bi-box-arrow-right fs-5"></i>
                        <span class="d-none d-md-inline">Logout</span>
                    </button>
                </form>
            </div>
        </div>
    </div>
</nav>


<%
    String adminName = (String) session.getAttribute("user_name");
%>

<div class="container-fluid main-content">
    <header class="page-header d-flex justify-content-between align-items-center flex-wrap p-2 mb-3 rounded shadow-sm bg-white">

        <!-- Date Display -->
        <div class="d-flex align-items-center text-muted fs-6">
            <i class="bi bi-calendar3 me-2 fs-5 text-info"></i>
            <span class="fw-semibold">
        <%= new java.text.SimpleDateFormat("MMMM dd, yyyy").format(new java.util.Date()) %>
      </span>
        </div>

        <!-- Admin Name -->
        <div class="d-flex align-items-center text-primary fw-semibold fs-6">
            <i class="bi bi-person-circle me-2 fs-4"></i>
            <span>Admin: <%= adminName != null ? adminName : "Admin" %></span>
        </div>

    </header>



    <!-- Success/Error Messages -->
    <%
        String successMessage = (String) request.getAttribute("successMessage");
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (successMessage != null) {
    %>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="bi bi-check-circle-fill me-2"></i><%= successMessage %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>
    <% if (errorMessage != null) { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="bi bi-exclamation-triangle-fill me-2"></i><%= errorMessage %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

<div class="row g-4 mb-5">
    <div class="col-lg-3 col-md-6">
        <div class="summary-card bg-primary d-flex align-items-center p-4 rounded-4 shadow-sm text-white">
            <div class="icon-circle bg-white bg-opacity-25 me-3 d-flex justify-content-center align-items-center">
                <i class="bi bi-clipboard-data fs-2"></i>
            </div>
            <div>
                <h6 class="text-uppercase fw-semibold mb-1">Total Complaints</h6>
                <h3 class="fw-bold mb-0">${totalComplaints != null ? totalComplaints : 0}</h3>
            </div>
        </div>
    </div>

    <div class="col-lg-3 col-md-6">
        <div class="summary-card bg-warning d-flex align-items-center p-4 rounded-4 shadow-sm text-dark">
            <div class="icon-circle bg-white bg-opacity-25 me-3 d-flex justify-content-center align-items-center">
                <i class="bi bi-hourglass-split fs-2"></i>
            </div>
            <div>
                <h6 class="text-uppercase fw-semibold mb-1">Pending</h6>
                <h3 class="fw-bold mb-0">${pendingComplaints != null ? pendingComplaints : 0}</h3>
            </div>
        </div>
    </div>

    <div class="col-lg-3 col-md-6">
        <div class="summary-card bg-success d-flex align-items-center p-4 rounded-4 shadow-sm text-white">
            <div class="icon-circle bg-white bg-opacity-25 me-3 d-flex justify-content-center align-items-center">
                <i class="bi bi-check-circle fs-2"></i>
            </div>
            <div>
                <h6 class="text-uppercase fw-semibold mb-1">Resolved</h6>
                <h3 class="fw-bold mb-0">${resolvedComplaints != null ? resolvedComplaints : 0}</h3>
            </div>
        </div>
    </div>

    <div class="col-lg-3 col-md-6">
        <div class="summary-card bg-danger d-flex align-items-center p-4 rounded-4 shadow-sm text-white">
            <div class="icon-circle bg-white bg-opacity-25 me-3 d-flex justify-content-center align-items-center">
                <i class="bi bi-x-circle fs-2"></i>
            </div>
            <div>
                <h6 class="text-uppercase fw-semibold mb-1">Rejected</h6>
                <h3 class="fw-bold mb-0">${rejectedComplaints != null ? rejectedComplaints : 0}</h3>
            </div>
        </div>
    </div>
</div>

<%--    <div class="card mb-4">--%>
<%--        <div class="card-header">--%>
<%--            <i class="bi bi-funnel me-2"></i>Filter Complaints--%>
<%--        </div>--%>
<%--        <div class="card-body">--%>
<%--            <form action="admin-dashboard" method="get" class="row g-3">--%>
<%--                <div class="col-md-3">--%>
<%--                    <label for="statusFilter" class="form-label">Filter by Status</label>--%>
<%--                    <select class="form-select" id="statusFilter" name="status">--%>
<%--                        <option value="">All Statuses</option>--%>
<%--                        <option value="PENDING">Pending</option>--%>
<%--                        <option value="IN_PROGRESS">In Progress</option>--%>
<%--                        <option value="RESOLVED">Resolved</option>--%>
<%--                        <option value="REJECTED">Rejected</option>--%>
<%--                    </select>--%>
<%--                </div>--%>
<%--                <div class="col-md-3">--%>
<%--                    <label for="dateFilter" class="form-label">Date Range</label>--%>
<%--                    <input type="date" class="form-control" id="dateFilter" name="date">--%>
<%--                </div>--%>
<%--                <div class="col-md-4">--%>
<%--                    <label for="searchFilter" class="form-label">Search</label>--%>
<%--                    <div class="input-group">--%>
<%--                        <span class="input-group-text"><i class="bi bi-search"></i></span>--%>
<%--                        <input type="text" class="form-control" id="searchFilter" name="search"--%>
<%--                               placeholder="Search by ID, title, or employee">--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="col-md-2 d-flex align-items-end">--%>
<%--                    <button type="submit" class="btn btn-primary w-100">--%>
<%--                        <i class="bi bi-filter"></i> Apply--%>
<%--                    </button>--%>
<%--                </div>--%>
<%--            </form>--%>
<%--        </div>--%>
<%--    </div>--%>

    <div class="card">
<%--        <div class="card-header d-flex justify-content-between align-items-center">--%>
<%--            <div>--%>
<%--                <i class="bi bi-table me-2"></i>All Complaints--%>
<%--            </div>--%>
<%--            <div>--%>
                <%
                    List<Complain> complaints = (List<Complain>) request.getAttribute("complaints");
                    int complaintCount = complaints != null ? complaints.size() : 0;
                %>
<%--                <span class="badge bg-secondary">Showing <%= complaintCount %> complaints</span>--%>
<%--            </div>--%>
<%--        </div>--%>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="table-light text-center align-middle">
                    <tr>
                        <th scope="col" class="py-3">ID</th>
                        <th scope="col" class="py-3 text-start">Title</th>
                        <th scope="col" class="py-3">Category</th>
                        <th scope="col" class="py-3">Employee</th>
                        <th scope="col" class="py-3">Priority</th>
                        <th scope="col" class="py-3">Date</th>
                        <th scope="col" class="py-3">Status</th>
                        <th scope="col" class="py-3">Actions</th>
                    </tr>
                    </thead>

                    <tbody>
                    <%
                        if (complaints != null && !complaints.isEmpty()) {
                            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                            for (Complain complaint : complaints) {
                                String priorityClass = "";
                                String priorityLabel = "";

                                switch (complaint.getPriority()) {
                                    case "HIGH":
                                        priorityClass = "badge bg-danger fw-bold";
                                        priorityLabel = "High Priority";
                                        break;
                                    case "MEDIUM":
                                        priorityClass = "badge bg-warning text-dark fw-semibold";
                                        priorityLabel = "Medium Priority";
                                        break;
                                    case "LOW":
                                        priorityClass = "badge bg-success fw-semibold";
                                        priorityLabel = "Low Priority";
                                        break;
                                }
                    %>
                    <tr>
                        <td><strong>CMP-<%= complaint.getId() %></strong></td>
                        <td>
                            <div class="complaint-title"
                                 title="<%= complaint.getDescription() != null ? complaint.getDescription() : complaint.getTitle() %>">
                                <%= complaint.getTitle() %>
                            </div>
                        </td>
                        <td><span class="badge bg-light text-dark"><%= complaint.getCategory() %></span></td>
                        <td><%= complaint.getSubmitterName() != null ? complaint.getSubmitterName() : "Unknown" %></td>
                        <td><span class="<%= priorityClass %>"><strong><%= complaint.getPriority() %></strong></span></td>
                        <td><%= complaint.getCreatedAt() != null ? dateFormat.format(complaint.getCreatedAt()) : "N/A" %></td>
                        <td>
                            <form action="update-status" method="post" class="status-form">
                                <input type="hidden" name="complaintId" value="<%= complaint.getId() %>">
                                <div class="d-flex align-items-center">
                                    <select name="status" class="status-dropdown status-<%= complaint.getStatus() %>">
                                        <option value="PENDING" <%= "PENDING".equals(complaint.getStatus()) ? "selected" : "" %>>
                                            Pending
                                        </option>
                                        <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(complaint.getStatus()) ? "selected" : "" %>>
                                            In Progress
                                        </option>
                                        <option value="RESOLVED" <%= "RESOLVED".equals(complaint.getStatus()) ? "selected" : "" %>>
                                            Resolved
                                        </option>
                                        <option value="REJECTED" <%= "REJECTED".equals(complaint.getStatus()) ? "selected" : "" %>>
                                            Rejected
                                        </option>
                                    </select>
                                    <button type="submit" class="btn btn-sm btn-primary update-btn"
                                            title="Update Status">
                                        <i class="bi bi-check"></i>
                                    </button>
                                </div>
                            </form>
                        </td>
                        <td>
                            <div class="btn-group">
                                <!-- View Button -->
                                <form action="view-complaint" method="get" style="display:inline;">
                                    <input type="hidden" name="id" value="<%= complaint.getId() %>">
                                    <button type="submit" class="btn btn-sm btn-info action-btn" title="View">
                                        <i class="bi bi-eye-fill"></i>
                                    </button>
                                </form>

                                <!-- Add Remarks Button -->
                                <button type="button"
                                        class="btn btn-sm btn-outline-warning d-flex align-items-center gap-1 px-2 py-1 rounded-2 shadow-sm"
                                        title="Add Remarks"
                                        data-bs-toggle="modal"
                                        data-bs-target="#remarksModal<%= complaint.getId() %>">
                                    <i class="bi bi-chat-left-text-fill fs-5"></i>
                                    <span class="d-none d-md-inline">Remarks</span>
                                </button>


                                <!-- Delete Button -->
                                <form action="admin-delete" method="post" style="display:inline;"
                                      onsubmit="return confirm('Are you sure you want to delete this complaint?');">
                                    <input type="hidden" name="id" value="<%= complaint.getId() %>">
                                    <button type="submit"
                                            class="btn btn-sm btn-outline-danger d-flex align-items-center gap-1 px-2 py-1 rounded-2 shadow-sm"
                                            title="Delete Complaint">
                                        <i class="bi bi-trash-fill fs-5"></i>
                                        <span class="d-none d-md-inline">Delete</span>
                                    </button>
                                </form>

                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="8" class="text-center py-5 bg-light rounded-3">
                            <div class="text-secondary">
                                <i class="bi bi-inbox display-3 mb-2"></i>
                                <p class="fs-5 fw-semibold m-0">No Complaints Found</p>
                                <small class="text-muted">You're all caught up for now!</small>
                            </div>
                        </td>
                    </tr>

                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="card-footer bg-transparent">
            <nav>
                <ul class="pagination justify-content-center mb-0">
                    <li class="page-item disabled">
                        <a class="page-link" href="#" tabindex="-1">
                            <i class="bi bi-chevron-left"></i>
                        </a>
                    </li>
                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item">
                        <a class="page-link" href="#">
                            <i class="bi bi-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>

<!-- Simple Add Remarks Modals -->
<%
    if (complaints != null && !complaints.isEmpty()) {
        for (Complain complaint : complaints) {
%>
<div class="modal fade" id="remarksModal<%= complaint.getId() %>" tabindex="-1"
     aria-labelledby="remarksModalLabel<%= complaint.getId() %>" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-warning text-dark">
                <h5 class="modal-title" id="remarksModalLabel<%= complaint.getId() %>">
                    <i class="bi bi-chat-left-text-fill me-2"></i>Add Remarks - CMP-<%= complaint.getId() %>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <p><strong>Complaint:</strong> <%= complaint.getTitle() %></p>
                    <p><strong>Employee:</strong> <%= complaint.getSubmitterName() != null ? complaint.getSubmitterName() : "Unknown" %></p>
                    <p><strong>Status:</strong>
                        <span class="badge status-<%= complaint.getStatus() %>">
                            <%= complaint.getStatus().replace("_", " ") %>
                        </span>
                    </p>
                </div>

                <form action="${pageContext.request.contextPath}/add-remarks" method="post"
                      id="remarksForm<%= complaint.getId() %>">
                    <input type="hidden" name="complaintId" value="<%= complaint.getId() %>">

                    <div class="mb-3">
                        <label for="remarks<%= complaint.getId() %>" class="form-label">Admin Remarks:</label>
                        <textarea class="form-control" id="remarks<%= complaint.getId() %>" name="remarks"
                                  rows="4" placeholder="Enter your remarks here..." required></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-x-circle"></i> Cancel
                </button>
                <button type="submit" form="remarksForm<%= complaint.getId() %>" class="btn btn-warning">
                    <i class="bi bi-check-circle"></i> Add Remarks
                </button>
            </div>
        </div>
    </div>
</div>
<%
        }
    }
%>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
