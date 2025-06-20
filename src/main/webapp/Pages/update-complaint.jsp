<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.example.mid_assignment.model.Complain" %>
<%
    Complain complaint = (Complain) request.getAttribute("complaint");
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy 'at' hh:mm a");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Complaint - CMS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --accent-color: #3498db;
            --success-color: #27ae60;
            --warning-color: #f39c12;
            --danger-color: #e74c3c;
            --info-color: #17a2b8;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .container {
            padding: 30px 15px;
        }

        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(44, 62, 80, 0.1);
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
        }

        .card-header {
            background: linear-gradient(135deg, var(--accent-color) 0%, #2980b9 100%);
            color: white;
            border-radius: 15px 15px 0 0 !important;
            padding: 20px 25px;
        }

        .form-control, .form-select {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 0.6rem 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.15);
        }

        .form-label {
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 8px;
        }

        .btn {
            border-radius: 8px;
            padding: 0.6rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--accent-color) 0%, #2980b9 100%);
            border: none;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #2980b9 0%, #21618c 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
            border: none;
        }

        .btn-secondary:hover {
            background: linear-gradient(135deg, #5a6268 0%, #495057 100%);
            transform: translateY(-2px);
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 500;
        }

        .info-section {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 25px;
        }

        .info-item {
            margin-bottom: 15px;
        }

        .info-item:last-child {
            margin-bottom: 0;
        }

        .info-label {
            font-size: 0.9rem;
            color: #6c757d;
            font-weight: 600;
            margin-bottom: 3px;
        }

        .info-value {
            font-size: 1rem;
            color: var(--primary-color);
            margin: 0;
        }

        .update-section {
            border-top: 2px solid #e9ecef;
            padding-top: 25px;
        }

        .section-title {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e9ecef;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card">
                <div class="card-header">
                    <h4 class="mb-0">
                        <i class="bi bi-pencil-square me-2"></i>Update Complaint Status
                    </h4>
                </div>
                <div class="card-body p-4">
                    <!-- Complaint Information Section -->
                    <div class="info-section">
                        <h5 class="section-title">
                            <i class="bi bi-info-circle me-2"></i>Complaint Information
                        </h5>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="info-item">
                                    <div class="info-label">Complaint ID</div>
                                    <p class="info-value fw-bold">CMP-<%= complaint.getId() %>
                                    </p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="info-item">
                                    <div class="info-label">Submitted By</div>
                                    <p class="info-value">
                                        <%= complaint.getSubmitterName() != null ? complaint.getSubmitterName() : "Unknown Employee" %>
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="info-item">
                            <div class="info-label">Title</div>
                            <p class="info-value fw-bold"><%= complaint.getTitle() %>
                            </p>
                        </div>

                        <div class="info-item">
                            <div class="info-label">Description</div>
                            <p class="info-value"><%= complaint.getDescription() %>
                            </p>
                        </div>

                        <div class="row">
                            <div class="col-md-4">
                                <div class="info-item">
                                    <div class="info-label">Category</div>
                                    <p class="info-value">
                                        <span class="badge bg-secondary"><%= complaint.getCategory() %></span>
                                    </p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="info-item">
                                    <div class="info-label">Priority</div>
                                    <p class="info-value">
                                            <span class="badge
                                                <% if("HIGH".equals(complaint.getPriority())) { %>bg-danger<% }
                                                   else if("MEDIUM".equals(complaint.getPriority())) { %>bg-warning text-dark<% }
                                                   else { %>bg-secondary<% } %>">
                                                <%= complaint.getPriority() %>
                                            </span>
                                    </p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="info-item">
                                    <div class="info-label">Current Status</div>
                                    <span class="badge status-badge
                                            <% if("PENDING".equals(complaint.getStatus())) { %>bg-warning text-dark<% }
                                               else if("IN_PROGRESS".equals(complaint.getStatus())) { %>bg-info text-white<% }
                                               else if("RESOLVED".equals(complaint.getStatus())) { %>bg-success text-white<% }
                                               else { %>bg-danger text-white<% } %>">
                                            <% if ("PENDING".equals(complaint.getStatus())) { %>
                                                <i class="bi bi-hourglass me-1"></i>
                                            <% } else if ("IN_PROGRESS".equals(complaint.getStatus())) { %>
                                                <i class="bi bi-arrow-repeat me-1"></i>
                                            <% } else if ("RESOLVED".equals(complaint.getStatus())) { %>
                                                <i class="bi bi-check-circle-fill me-1"></i>
                                            <% } else { %>
                                                <i class="bi bi-x-circle-fill me-1"></i>
                                            <% } %>
                                            <%= complaint.getStatus().replace("_", " ") %>
                                        </span>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="info-item">
                                    <div class="info-label">Submitted On</div>
                                    <p class="info-value">
                                        <i class="bi bi-calendar-plus me-1"></i>
                                        <%= dateFormat.format(complaint.getCreatedAt()) %>
                                    </p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="info-item">
                                    <div class="info-label">Last Updated</div>
                                    <p class="info-value">
                                        <i class="bi bi-calendar-check me-1"></i>
                                        <%= dateFormat.format(complaint.getUpdatedAt()) %>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Update Form Section -->
                    <div class="update-section">
                        <h5 class="section-title">
                            <i class="bi bi-gear me-2"></i>Update Status & Remarks
                        </h5>

                        <form action="update-complaint" method="post">
                            <input type="hidden" name="id" value="<%= complaint.getId() %>">

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="status" class="form-label">
                                        <i class="bi bi-flag me-1"></i>Update Status
                                    </label>
                                    <select class="form-select" id="status" name="status" required>
                                        <option value="PENDING" <%= "PENDING".equals(complaint.getStatus()) ? "selected" : "" %>>
                                            🕐 Pending
                                        </option>
                                        <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(complaint.getStatus()) ? "selected" : "" %>>
                                            🔄 In Progress
                                        </option>
                                        <option value="RESOLVED" <%= "RESOLVED".equals(complaint.getStatus()) ? "selected" : "" %>>
                                            ✅ Resolved
                                        </option>
                                        <option value="REJECTED" <%= "REJECTED".equals(complaint.getStatus()) ? "selected" : "" %>>
                                            ❌ Rejected
                                        </option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">
                                        <i class="bi bi-person me-1"></i>Admin
                                    </label>
                                    <input type="text" class="form-control" value="Current Admin" readonly>
                                    <small class="text-muted">You are updating this complaint</small>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="adminRemarks" class="form-label">
                                    <i class="bi bi-chat-left-text me-1"></i>Admin Remarks
                                </label>
                                <textarea class="form-control" id="adminRemarks" name="adminRemarks" rows="5"
                                          placeholder="Add your remarks, notes, or resolution details here..."><%= complaint.getAdminRemarks() != null ? complaint.getAdminRemarks() : "" %></textarea>
                                <small class="text-muted">
                                    Provide detailed information about the status update, actions taken, or resolution
                                    steps.
                                </small>
                            </div>

                            <!-- Current Remarks Display -->
                            <% if (complaint.getAdminRemarks() != null && !complaint.getAdminRemarks().trim().isEmpty()) { %>
                            <div class="mb-4">
                                <label class="form-label">
                                    <i class="bi bi-clock-history me-1"></i>Previous Remarks
                                </label>
                                <div class="alert alert-info">
                                    <strong>Previous Admin Notes:</strong><br>
                                    <%= complaint.getAdminRemarks() %>
                                </div>
                            </div>
                            <% } %>

                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-check-circle me-2"></i>Update Complaint
                                </button>
                                <a href="view-complaint?id=<%= complaint.getId() %>" class="btn btn-secondary">
                                    <i class="bi bi-eye me-2"></i>View Details
                                </a>
                                <a href="admin-dashboard" class="btn btn-secondary">
                                    <i class="bi bi-arrow-left me-2"></i>Back to Dashboard
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Status change confirmation
    document.getElementById('status').addEventListener('change', function () {
        const status = this.value;
        const remarksField = document.getElementById('adminRemarks');

        // Auto-suggest remarks based on status
        if (status === 'RESOLVED' && remarksField.value.trim() === '') {
            remarksField.placeholder = 'Please describe how the complaint was resolved...';
        } else if (status === 'REJECTED' && remarksField.value.trim() === '') {
            remarksField.placeholder = 'Please provide reason for rejection...';
        } else if (status === 'IN_PROGRESS' && remarksField.value.trim() === '') {
            remarksField.placeholder = 'Please describe current progress and next steps...';
        }
    });

    // Form submission confirmation
    document.querySelector('form').addEventListener('submit', function (e) {
        const status = document.getElementById('status').value;
        const remarks = document.getElementById('adminRemarks').value.trim();

        if ((status === 'RESOLVED' || status === 'REJECTED') && remarks === '') {
            e.preventDefault();
            alert('Please add remarks when marking a complaint as ' + status.toLowerCase() + '.');
            document.getElementById('adminRemarks').focus();
            return false;
        }

        return confirm('Are you sure you want to update this complaint status to ' + status.replace('_', ' ') + '?');
    });
</script>
</body>
</html>