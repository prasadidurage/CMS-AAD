<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.example.mid_assignment.model.Complain" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <style>
        /* Modal background and content */
        #newComplaintModal .modal-content {
            background-color: #1e1e2f; /* Dark navy */
            color: #f0f0f5; /* Light text */
            border-radius: 10px;
            border: none;
        }

        /* Modal header */
        #newComplaintModal .modal-header {
            border-bottom: 2px solid #5c6bc0; /* Purple-blue accent */
        }
        #newComplaintModal .modal-title {
            color: #5c6bc0; /* Purple-blue */
        }
        #newComplaintModal .btn-close {
            filter: invert(1); /* Make close button white */
        }

        /* Form labels */
        #newComplaintModal label.form-label {
            color: #a8a8c0;
            font-weight: 600;
        }

        /* Input group text */
        #newComplaintModal .input-group-text {
            background-color: #3949ab; /* Indigo */
            color: #fff;
            border: none;
        }

        /* Form controls */
        #newComplaintModal .form-control,
        #newComplaintModal .form-select,
        #newComplaintModal textarea.form-control {
            background-color: #2a2a40; /* Slightly lighter dark */
            border: 1px solid #5c6bc0;
            color: #ddd;
        }
        #newComplaintModal .form-control::placeholder,
        #newComplaintModal textarea::placeholder {
            color: #8888aa;
        }
        #newComplaintModal .form-control:focus,
        #newComplaintModal .form-select:focus,
        #newComplaintModal textarea.form-control:focus {
            background-color: #2a2a40;
            border-color: #7986cb;
            color: #fff;
            box-shadow: 0 0 8px #7986cb;
        }

        /* Modal footer */
        #newComplaintModal .modal-footer {
            border-top: 2px solid #5c6bc0;
        }

        /* Buttons */
        #newComplaintModal .btn-secondary {
            background-color: #616161; /* Dark gray */
            border: none;
            color: #ddd;
        }
        #newComplaintModal .btn-secondary:hover {
            background-color: #757575;
            color: #fff;
        }
        #newComplaintModal .btn-primary {
            background-color: #5c6bc0; /* Purple-blue */
            border: none;
            color: #fff;
        }
        #newComplaintModal .btn-primary:hover {
            background-color: #7986cb;
        }

        /* Icons inside buttons */
        #newComplaintModal .btn i {
            margin-right: 5px;
        }
        .icon-wrapper {
            width: 50px;
            height: 50px;
            border-radius: 0.75rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .complaint-title {
            max-width: 250px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .btn-group .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }


    </style>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard - Complaint Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/employeedashboard.css">
</head>
<body>
<!-- Top Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm py-3">
    <div class="container">
        <!-- Logo / Brand -->
        <a class="navbar-brand d-flex align-items-center" href="#">
            <i class="bi bi-shield-check fs-4 me-2 text-primary"></i>
            <span class="fw-bold fs-5">Welcome Complaint Managemet System</span>
        </a>

        <!-- Toggler for mobile view -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar" aria-controls="mainNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar content -->
        <div class="collapse navbar-collapse" id="mainNavbar">
            <!-- Left nav items -->
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active d-flex align-items-center" href="#">
                        <i class="bi bi-speedometer2 me-1"></i> Dashboard
                    </a>
                </li>
                <!-- Add more links here -->
            </ul>

            <!-- Right-side logout -->
            <form action="logout" method="post" class="d-flex ms-lg-3">
                <button class="btn btn-outline-light d-flex align-items-center" type="submit">
                    <i class="bi bi-box-arrow-right me-1"></i> Logout
                </button>
            </form>
        </div>
    </div>
</nav>

<!-- Main Content -->

<%
    String employeeName = (String) session.getAttribute("employeeName");
%>

<div class="container-fluid main-content py-4">
    <!-- Page Header -->
    <div class="d-flex justify-content-between align-items-center flex-wrap mb-4">
        <div class="page-title d-flex flex-column">
<%--            <div class="d-flex align-items-center mb-1">--%>
<%--                <h2 class="h4 fw-semibold mb-0">Employee Dashboard</h2>--%>
<%--            </div>--%>
    <h2>
        <small class="text-muted ms-1">Welcome, <strong><%= employeeName %></strong></small>

    </h2>
        </div>
        <button type="button"
                class="btn btn-success btn-lg rounded-pill d-flex align-items-center shadow"
                data-bs-toggle="modal" data-bs-target="#newComplaintModal">
            <i class="bi bi-plus-circle me-2"></i> New Complaint
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
<div class="row g-4 mb-4">
    <!-- My Complaints -->
    <div class="col-lg-4 col-md-6">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-body d-flex align-items-center">
                <div class="icon-wrapper bg-primary text-white me-3">
                    <i class="bi bi-clipboard-data fs-4"></i>
                </div>
                <div>
                    <h6 class="mb-1 text-muted">My Complaints</h6>
                    <h3 class="mb-0 fw-bold text-dark">
                        ${totalComplaints != null ? totalComplaints : 0}
                    </h3>
                </div>
            </div>
        </div>
    </div>

    <!-- Pending Complaints -->
    <div class="col-lg-4 col-md-6">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-body d-flex align-items-center">
                <div class="icon-wrapper bg-warning text-white me-3">
                    <i class="bi bi-hourglass-split fs-4"></i>
                </div>
                <div>
                    <h6 class="mb-1 text-muted">Pending</h6>
                    <h3 class="mb-0 fw-bold text-dark">
                        ${pendingComplaints != null ? pendingComplaints : 0}
                    </h3>
                </div>
            </div>
        </div>
    </div>

    <!-- Resolved Complaints -->
    <div class="col-lg-4 col-md-6">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-body d-flex align-items-center">
                <div class="icon-wrapper bg-success text-white me-3">
                    <i class="bi bi-check-circle fs-4"></i>
                </div>
                <div>
                    <h6 class="mb-1 text-muted">Resolved</h6>
                    <h3 class="mb-0 fw-bold text-dark">
                        ${resolvedComplaints != null ? resolvedComplaints : 0}
                    </h3>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- My Complaints Table -->
<%--<div class="card shadow-sm border-0">--%>
<%--    <div class="card-header d-flex justify-content-between align-items-center bg-light">--%>
<%--        <h5 class="mb-0 d-flex align-items-center">--%>
<%--            <i class="bi bi-list-ul text-primary fs-5 me-2"></i> My Recent Complaints--%>
<%--        </h5>--%>
<%--        <div class="d-flex align-items-center gap-2">--%>
            <%
                List<Complain> complaints = (List<Complain>) request.getAttribute("complaints");
                int complaintCount = complaints != null ? complaints.size() : 0;
            %>
<%--            <span class="badge bg-secondary text-white px-3">Showing <%= complaintCount %> complaints</span>--%>
<%--            <form action="my-complaints" method="get">--%>
<%--                <button type="submit" class="btn btn-sm btn-outline-primary">--%>
<%--                    <i class="bi bi-eye me-1"></i> View All--%>
<%--                </button>--%>
<%--            </form>--%>
<%--        </div>--%>
<%--    </div>--%>

    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead class="table-light align-middle">
                <tr class="text-center text-uppercase text-muted small fw-semibold">
                    <th class="py-3">
                        <i class="bi bi-hash text-secondary me-1"></i> ID
                    </th>
                    <th class="py-3 text-start">
                        <i class="bi bi-card-text text-secondary me-1"></i> Title
                    </th>
                    <th class="py-3">
                        <i class="bi bi-tags text-secondary me-1"></i> Category
                    </th>
                    <th class="py-3">
                        <i class="bi bi-flag text-secondary me-1"></i> Priority
                    </th>
                    <th class="py-3">
                        <i class="bi bi-calendar-event text-secondary me-1"></i> Date
                    </th>
                    <th class="py-3">
                        <i class="bi bi-bar-chart-steps text-secondary me-1"></i> Status
                    </th>
                    <th class="py-3">
                        <i class="bi bi-gear text-secondary me-1"></i> Actions
                    </th>
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

                            switch (complaint.getStatus()) {
                                case "RESOLVED":
                                    statusClass = "badge bg-success d-inline-flex align-items-center gap-1";
                                    statusIcon = "bi bi-check-circle-fill";
                                    break;
                                case "PENDING":
                                    statusClass = "badge bg-warning text-dark d-inline-flex align-items-center gap-1";
                                    statusIcon = "bi bi-hourglass-split";
                                    break;
                                case "IN_PROGRESS":
                                    statusClass = "badge bg-info text-dark d-inline-flex align-items-center gap-1";
                                    statusIcon = "bi bi-arrow-repeat";
                                    break;
                                case "REJECTED":
                                    statusClass = "badge bg-danger d-inline-flex align-items-center gap-1";
                                    statusIcon = "bi bi-x-circle-fill";
                                    break;
                                default:
                                    statusClass = "badge bg-secondary d-inline-flex align-items-center gap-1";
                                    statusIcon = "bi bi-question-circle";
                            }


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
                <tr class="align-middle">
                    <td><strong>Complaint-<%= complaint.getId() %></strong></td>
                    <td class="text-start">
                        <div class="complaint-title text-truncate" title="<%= complaint.getDescription() != null ? complaint.getDescription() : complaint.getTitle() %>">
                            <%= complaint.getTitle() %>
                        </div>
                    </td>
                    <td class="text-center">
                        <span class="badge bg-secondary"><%= complaint.getCategory() %></span>
                    </td>
                    <td class="text-center">
                            <span class="<%= priorityClass %> fw-bold">
                                <i class="bi bi-flag-fill me-1"></i><%= complaint.getPriority() %>
                            </span>
                    </td>
                    <td class="text-center"><%= complaint.getCreatedAt() != null ? dateFormat.format(complaint.getCreatedAt()) : "N/A" %></td>
                    <td class="text-center">
                            <span class="badge <%= statusClass %> px-2 py-1">
                                <i class="bi <%= statusIcon %> me-1"></i> <%= complaint.getStatus().replace("_", " ") %>
                            </span>
                    </td>
                    <td class="text-center">
                        <div class="btn-group btn-group-sm gap-1">
                            <!-- View Button -->
<%--                            <form action="view-complaint" method="get">--%>
<%--                                <input type="hidden" name="id" value="<%= complaint.getId() %>">--%>
<%--                                <button type="submit" class="btn btn-info" title="View">--%>
<%--                                    <i class="bi bi-eye-fill"></i>--%>
<%--                                </button>--%>
<%--                            </form>--%>

                            <!-- Update and Delete Buttons (Only if PENDING) -->
                            <% if ("PENDING".equals(complaint.getStatus())) { %>
                            <button type="button" class="btn btn-sm btn-outline-primary rounded-circle me-2"
                                    title="Update"
                                    data-bs-toggle="modal"
                                    data-bs-target="#updateComplaintModal<%= complaint.getId() %>"
                                    aria-label="Update Complaint <%= complaint.getId() %>">
                                <i class="bi bi-pencil-square"></i>
                            </button>

                            <form action="${pageContext.request.contextPath}/delete-complaint" method="post"
                                  onsubmit="return confirm('Are you sure you want to delete CMP-<%= complaint.getId() %>: <%= complaint.getTitle() %>?')"
                                  style="display: inline;">
                                <input type="hidden" name="id" value="<%= complaint.getId() %>">
                                <button type="submit" class="btn btn-sm btn-outline-danger rounded-circle" title="Delete" aria-label="Delete Complaint <%= complaint.getId() %>">
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
                    <td colspan="7" class="text-center py-5">
                        <div class="text-muted">
                            <p>Empty Table</p>
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

            <!-- Modal Header -->
            <div class="modal-header">
                <h5 class="modal-title" id="updateComplaintModalLabel<%= complaint.getId() %>">
                    <i class="bi bi-pencil-square me-2"></i>Update Complaint - Complain-<%= complaint.getId() %>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/update-complaint" method="post"
                      id="updateComplaintForm<%= complaint.getId() %>">
                    <input type="hidden" name="id" value="<%= complaint.getId() %>">

                    <div class="mb-3">
                        <label for="updateComplaintTitle<%= complaint.getId() %>" class="form-label">Complaint Title</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-tag"></i></span>
                            <input type="text" class="form-control" id="updateComplaintTitle<%= complaint.getId() %>"
                                   name="title" value="<%= complaint.getTitle() %>" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="updateComplaintCategory<%= complaint.getId() %>" class="form-label">Category</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-folder"></i></span>
                                <select class="form-select" id="updateComplaintCategory<%= complaint.getId() %>"
                                        name="category" required>
                                    <option value="">Select Category</option>
                                    <option value="Hardware" <%= "Hardware".equals(complaint.getCategory()) ? "selected" : "" %>>Hardware Issue</option>
                                    <option value="Software" <%= "Software".equals(complaint.getCategory()) ? "selected" : "" %>>Software Issue</option>
                                    <option value="Network" <%= "Network".equals(complaint.getCategory()) ? "selected" : "" %>>Network Issue</option>
                                    <option value="Infrastructure" <%= "Infrastructure".equals(complaint.getCategory()) ? "selected" : "" %>>Infrastructure</option>
                                    <option value="Facility" <%= "Facility".equals(complaint.getCategory()) ? "selected" : "" %>>Facility Issue</option>
                                    <option value="Other" <%= "Other".equals(complaint.getCategory()) ? "selected" : "" %>>Other</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="updateComplaintPriority<%= complaint.getId() %>" class="form-label">Priority</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-exclamation-triangle"></i></span>
                                <select class="form-select" id="updateComplaintPriority<%= complaint.getId() %>"
                                        name="priority" required>
                                    <option value="LOW" <%= "LOW".equals(complaint.getPriority()) ? "selected" : "" %>>Low</option>
                                    <option value="MEDIUM" <%= "MEDIUM".equals(complaint.getPriority()) ? "selected" : "" %>>Medium</option>
                                    <option value="HIGH" <%= "HIGH".equals(complaint.getPriority()) ? "selected" : "" %>>High</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="updateComplaintDescription<%= complaint.getId() %>" class="form-label">Description</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-chat-left-text"></i></span>
                            <textarea class="form-control" id="updateComplaintDescription<%= complaint.getId() %>"
                                      name="description" rows="4" required><%= complaint.getDescription() != null ? complaint.getDescription() : "" %></textarea>
                        </div>
                    </div>

                    <!-- Current status read-only -->
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

            <!-- Modal Footer -->
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
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
