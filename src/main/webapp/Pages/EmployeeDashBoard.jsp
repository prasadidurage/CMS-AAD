<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.example.mid_assignment.model.Complain" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard - Complaint Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/employeedashboard.css">
</head>
<body>
<!-- Top Navigation -->
<nav class="navbar navbar-expand-lg top-navbar">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <i class="bi bi-shield-check me-2"></i>CMS Employee
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="#">
                        <i class="bi bi-speedometer2"></i>Dashboard
                    </a>
                </li>
            </ul>

            <div class="d-flex">
                <form action="logout" method="post">
                    <button type="submit" class="btn logout-btn">
                        <i class="bi bi-box-arrow-right"></i> Logout
                    </button>
                </form>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container-fluid main-content">
    <!-- Page Header -->
    <div class="page-header">
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center">
            <h1 class="h2"><i class="bi bi-grid-1x2 me-2"></i>Employee Dashboard</h1>
            <button type="button" class="btn new-complaint-btn" data-bs-toggle="modal"
                    data-bs-target="#newComplaintModal">
                <i class="bi bi-plus-circle me-2"></i>New Complaint
            </button>
        </div>
    </div>

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

    <!-- Summary Cards -->
    <div class="row mb-4">
        <div class="col-lg-4 col-md-6 mb-3">
            <div class="card text-white bg-primary-gradient">
                <div class="card-body summary-card">
                    <i class="bi bi-clipboard-data dashboard-icon"></i>
                    <h5 class="card-title">My Complaints</h5>
                    <h2 class="card-text">${totalComplaints != null ? totalComplaints : 0}</h2>
                </div>
            </div>
        </div>
        <div class="col-lg-4 col-md-6 mb-3">
            <div class="card text-white bg-warning-gradient">
                <div class="card-body summary-card">
                    <i class="bi bi-hourglass-split dashboard-icon"></i>
                    <h5 class="card-title">Pending</h5>
                    <h2 class="card-text">${pendingComplaints != null ? pendingComplaints : 0}</h2>
                </div>
            </div>
        </div>
        <div class="col-lg-4 col-md-6 mb-3">
            <div class="card text-white bg-success-gradient">
                <div class="card-body summary-card">
                    <i class="bi bi-check-circle dashboard-icon"></i>
                    <h5 class="card-title">Resolved</h5>
                    <h2 class="card-text">${resolvedComplaints != null ? resolvedComplaints : 0}</h2>
                </div>
            </div>
        </div>
    </div>

    <!-- My Complaints Table -->
    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center">
            <div>
                <i class="bi bi-list-ul me-2"></i>My Recent Complaints
            </div>
            <div>
                <%
                    List<Complain> complaints = (List<Complain>) request.getAttribute("complaints");
                    int complaintCount = complaints != null ? complaints.size() : 0;
                %>
                <span class="badge bg-secondary me-2">Showing <%= complaintCount %> complaints</span>
                <form action="my-complaints" method="get" style="display: inline;">
                    <button type="submit" class="btn btn-sm btn-outline-primary">
                        <i class="bi bi-eye"></i> View All
                    </button>
                </form>
            </div>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Category</th>
                        <th>Priority</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        if (complaints != null && !complaints.isEmpty()) {
                            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                            for (Complain complaint : complaints) {
                                String statusClass = "";
                                String statusIcon = "";
                                String priorityClass = "";

                                // Status styling
                                switch (complaint.getStatus()) {
                                    case "RESOLVED":
                                        statusClass = "bg-success";
                                        statusIcon = "bi-check-circle-fill";
                                        break;
                                    case "PENDING":
                                        statusClass = "bg-warning";
                                        statusIcon = "bi-hourglass";
                                        break;
                                    case "IN_PROGRESS":
                                        statusClass = "bg-info";
                                        statusIcon = "bi-arrow-repeat";
                                        break;
                                    case "REJECTED":
                                        statusClass = "bg-danger";
                                        statusIcon = "bi-x-circle-fill";
                                        break;
                                    default:
                                        statusClass = "bg-secondary";
                                        statusIcon = "bi-question-circle";
                                }

                                // Priority styling
                                switch (complaint.getPriority()) {
                                    case "HIGH":
                                        priorityClass = "text-danger";
                                        break;
                                    case "MEDIUM":
                                        priorityClass = "text-warning";
                                        break;
                                    case "LOW":
                                        priorityClass = "text-success";
                                        break;
                                }
                    %>
                    <tr>
                        <td><strong>CMP-<%= complaint.getId() %>
                        </strong></td>
                        <td>
                            <div class="complaint-title"
                                 title="<%= complaint.getDescription() != null ? complaint.getDescription() : complaint.getTitle() %>">
                                <%= complaint.getTitle() %>
                            </div>
                        </td>
                        <td>
                            <span class="badge bg-secondary"><%= complaint.getCategory() %></span>
                        </td>
                        <td>
                            <span class="<%= priorityClass %>"><strong><%= complaint.getPriority() %></strong></span>
                        </td>
                        <td><%= complaint.getCreatedAt() != null ? dateFormat.format(complaint.getCreatedAt()) : "N/A" %>
                        </td>
                        <td>
                            <span class="badge <%= statusClass %> status-badge">
                                <i class="bi <%= statusIcon %>"></i> <%= complaint.getStatus().replace("_", " ") %>
                            </span>
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

                                <!-- Update/Edit Button - Only for PENDING complaints -->
                                <% if ("PENDING".equals(complaint.getStatus())) { %>
                                <button type="button" class="btn btn-sm btn-primary action-btn"
                                        title="Update Complaint"
                                        data-bs-toggle="modal"
                                        data-bs-target="#updateComplaintModal<%= complaint.getId() %>">
                                    <i class="bi bi-pencil-square"></i>
                                </button>

                                <!-- Delete Button -->
                                <form action="${pageContext.request.contextPath}/delete-complaint" method="post"
                                      style="display:inline;"
                                      onsubmit="return confirm('Are you sure you want to delete complaint CMP-<%= complaint.getId() %>: <%= complaint.getTitle() %>?')">
                                    <input type="hidden" name="id" value="<%= complaint.getId() %>">
                                    <button type="submit" class="btn btn-sm btn-danger action-btn" title="Delete">
                                        <i class="bi bi-trash-fill"></i>
                                    </button>
                                </form>
                                <% } %>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="7" class="text-center py-4">
                            <div class="text-muted">
                                <i class="bi bi-inbox display-4"></i>
                                <p class="mt-2">No complaints found</p>
                                <p class="small">Click "New Complaint" to submit your first complaint</p>
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
    </div>
</div>

<!-- Update Complaint Modals - Reusing the same structure as New Complaint -->
<%
    if (complaints != null && !complaints.isEmpty()) {
        for (Complain complaint : complaints) {
            if ("PENDING".equals(complaint.getStatus())) {
%>
<div class="modal fade" id="updateComplaintModal<%= complaint.getId() %>" tabindex="-1"
     aria-labelledby="updateComplaintModalLabel<%= complaint.getId() %>" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="updateComplaintModalLabel<%= complaint.getId() %>">
                    <i class="bi bi-pencil-square me-2"></i>Update Complaint - CMP-<%= complaint.getId() %>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/update-complaint" method="post"
                      id="updateComplaintForm<%= complaint.getId() %>">
                    <input type="hidden" name="id" value="<%= complaint.getId() %>">

                    <div class="mb-3">
                        <label for="updateComplaintTitle<%= complaint.getId() %>" class="form-label">Complaint
                            Title</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-tag"></i></span>
                            <input type="text" class="form-control" id="updateComplaintTitle<%= complaint.getId() %>"
                                   name="title"
                                   value="<%= complaint.getTitle() %>" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="updateComplaintCategory<%= complaint.getId() %>"
                                   class="form-label">Category</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-folder"></i></span>
                                <select class="form-select" id="updateComplaintCategory<%= complaint.getId() %>"
                                        name="category" required>
                                    <option value="">Select Category</option>
                                    <option value="Hardware" <%= "Hardware".equals(complaint.getCategory()) ? "selected" : "" %>>
                                        Hardware Issue
                                    </option>
                                    <option value="Software" <%= "Software".equals(complaint.getCategory()) ? "selected" : "" %>>
                                        Software Issue
                                    </option>
                                    <option value="Network" <%= "Network".equals(complaint.getCategory()) ? "selected" : "" %>>
                                        Network Issue
                                    </option>
                                    <option value="Infrastructure" <%= "Infrastructure".equals(complaint.getCategory()) ? "selected" : "" %>>
                                        Infrastructure
                                    </option>
                                    <option value="Facility" <%= "Facility".equals(complaint.getCategory()) ? "selected" : "" %>>
                                        Facility Issue
                                    </option>
                                    <option value="Other" <%= "Other".equals(complaint.getCategory()) ? "selected" : "" %>>
                                        Other
                                    </option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="updateComplaintPriority<%= complaint.getId() %>"
                                   class="form-label">Priority</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-exclamation-triangle"></i></span>
                                <select class="form-select" id="updateComplaintPriority<%= complaint.getId() %>"
                                        name="priority" required>
                                    <option value="LOW" <%= "LOW".equals(complaint.getPriority()) ? "selected" : "" %>>
                                        Low
                                    </option>
                                    <option value="MEDIUM" <%= "MEDIUM".equals(complaint.getPriority()) ? "selected" : "" %>>
                                        Medium
                                    </option>
                                    <option value="HIGH" <%= "HIGH".equals(complaint.getPriority()) ? "selected" : "" %>>
                                        High
                                    </option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="updateComplaintDescription<%= complaint.getId() %>"
                               class="form-label">Description</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-chat-left-text"></i></span>
                            <textarea class="form-control" id="updateComplaintDescription<%= complaint.getId() %>"
                                      name="description" rows="4"
                                      required><%= complaint.getDescription() != null ? complaint.getDescription() : "" %></textarea>
                        </div>
                    </div>

                    <!-- Display current status (read-only) -->
                    <div class="mb-3">
                        <label class="form-label">Current Status</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-info-circle"></i></span>
                            <input type="text" class="form-control"
                                   value="<%= complaint.getStatus().replace("_", " ") %>" readonly>
                        </div>
                        <small class="text-muted">Status can only be changed by administrators</small>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-x-circle"></i> Cancel
                </button>
                <button type="submit" form="updateComplaintForm<%= complaint.getId() %>" class="btn btn-primary">
                    <i class="bi bi-check-circle"></i> Update Complaint
                </button>
            </div>
        </div>
    </div>
</div>
<%
            }
        }
    }
%>

<!-- New Complaint Modal -->
<div class="modal fade" id="newComplaintModal" tabindex="-1" aria-labelledby="newComplaintModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="newComplaintModalLabel">
                    <i class="bi bi-plus-circle me-2"></i>Submit New Complaint
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/submit-complaint" method="post" id="complaintForm">
                    <div class="mb-3">
                        <label for="complaintTitle" class="form-label">Complaint Title</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-tag"></i></span>
                            <input type="text" class="form-control" id="complaintTitle" name="title"
                                   placeholder="Brief title of your complaint" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="complaintCategory" class="form-label">Category</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-folder"></i></span>
                                <select class="form-select" id="complaintCategory" name="category" required>
                                    <option value="">Select Category</option>
                                    <option value="Hardware">Hardware Issue</option>
                                    <option value="Software">Software Issue</option>
                                    <option value="Network">Network Issue</option>
                                    <option value="Infrastructure">Infrastructure</option>
                                    <option value="Facility">Facility Issue</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="complaintPriority" class="form-label">Priority</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-exclamation-triangle"></i></span>
                                <select class="form-select" id="complaintPriority" name="priority" required>
                                    <option value="LOW">Low</option>
                                    <option value="MEDIUM" selected>Medium</option>
                                    <option value="HIGH">High</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="complaintDescription" class="form-label">Description</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-chat-left-text"></i></span>
                            <textarea class="form-control" id="complaintDescription" name="description" rows="4"
                                      placeholder="Please provide detailed information about your complaint"
                                      required></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-x-circle"></i> Cancel
                </button>
                <button type="submit" form="complaintForm" class="btn btn-primary">
                    <i class="bi bi-send"></i> Submit Complaint
                </button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
