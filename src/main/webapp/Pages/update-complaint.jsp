<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.example.mid_assignment.model.Complain" %>
<%
    Complain complaint = (Complain) request.getAttribute("complaint");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Complaint Update | Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #6a11cb, #2575fc);  !important;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #212529;
            padding: 2rem 1rem;
            min-height: 100vh;
        }
        .card {
            max-width: 900px;
            margin: 0 auto;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgb(0 0 0 / 0.1);
            background: white;
            padding: 1.8rem 2rem;
        }
        .section-title {
            font-weight: 700;
            font-size: 1.4rem;
            color: #0d6efd;
            border-bottom: 2px solid #0d6efd;
            padding-bottom: 6px;
            margin-bottom: 1.5rem;
        }
        .badge-category {
            background-color: #6c757d;
            font-weight: 500;
            font-size: 0.9rem;
            padding: 0.4em 0.7em;
            border-radius: 0.6rem;
            user-select: none;
        }
        .badge-priority-high {
            background-color: #dc3545;
            color: white;
        }
        .badge-priority-medium {
            background-color: #ffc107;
            color: #212529;
        }
        .badge-priority-low {
            background-color: #6c757d;
            color: white;
        }
        .badge-status-pending {
            background-color: #ffc107;
            color: #212529;
        }
        .badge-status-progress {
            background-color: #0dcaf0;
            color: #fff;
        }
        .badge-status-resolved {
            background-color: #198754;
            color: #fff;
        }
        .badge-status-rejected {
            background-color: #dc3545;
            color: #fff;
        }
        label {
            font-weight: 600;
        }
        textarea.form-control {
            resize: vertical;
        }
        .btn-primary {
            background: linear-gradient(45deg, #0d6efd, #6610f2);
            border: none;
            transition: background 0.3s ease;
        }
        .btn-primary:hover {
            background: linear-gradient(45deg, #6610f2, #0d6efd);
        }
        .btn-secondary {
            border-radius: 8px;
        }
        .previous-remarks {
            background-color: #e9f7ef;
            border-left: 5px solid #198754;
            padding: 1rem 1.25rem;
            margin-top: 1rem;
            border-radius: 6px;
            font-style: italic;
            color: #2f5d38;
        }
        @media (max-width: 575.98px) {
            .row-cols-md-2 > * {
                margin-bottom: 1rem;
            }
        }
    </style>
</head>
<body>
<div class="card shadow-sm">
    <h2 class="section-title mb-4"><i class="bi bi-pencil-square me-2"></i>Update Complaint Status</h2>

    <!-- Complaint Details -->
    <div class="mb-4">
        <div class="row row-cols-1 row-cols-md-2 g-3">
            <div>
                <strong>Complaint ID:</strong> CMP-<%= complaint.getId() %>
            </div>
            <div>
                <strong>Submitted By:</strong> <%= complaint.getSubmitterName() != null ? complaint.getSubmitterName() : "Unknown Employee" %>
            </div>
            <div>
                <strong>Title:</strong> <span class="fw-semibold"><%= complaint.getTitle() %></span>
            </div>
            <div>
                <strong>Category:</strong> <span class="badge badge-category"><%= complaint.getCategory() %></span>
            </div>
            <div>
                <strong>Priority:</strong>
                <% String priority = complaint.getPriority(); %>
                <span class="badge
                    <%= "HIGH".equals(priority) ? "badge-priority-high" : ("MEDIUM".equals(priority) ? "badge-priority-medium" : "badge-priority-low") %>">
                    <%= priority %>
                    </span>
            </div>
            <div>
                <strong>Status:</strong>
                <% String status = complaint.getStatus(); %>
                <span class="badge
                    <%= "PENDING".equals(status) ? "badge-status-pending" :
                       ("IN_PROGRESS".equals(status) ? "badge-status-progress" :
                       ("RESOLVED".equals(status) ? "badge-status-resolved" : "badge-status-rejected")) %>">
                    <%= status.replace("_", " ") %>
                    </span>
            </div>
            <div class="col-12">
                <strong>Description:</strong>
                <p class="mb-0"><%= complaint.getDescription() %></p>
            </div>
            <div>
                <strong>Submitted On:</strong> <%= dateFormat.format(complaint.getCreatedAt()) %>
            </div>
            <div>
                <strong>Last Updated:</strong> <%= dateFormat.format(complaint.getUpdatedAt()) %>
            </div>
        </div>
    </div>

    <!-- Update Form -->
    <form action="update-complaint" method="post" novalidate>
        <input type="hidden" name="id" value="<%= complaint.getId() %>" />

        <div class="mb-3">
            <label for="status" class="form-label"><i class="bi bi-flag me-1"></i>Update Status</label>
            <select class="form-select" id="status" name="status" required>
                <option value="PENDING" <%= "PENDING".equals(complaint.getStatus()) ? "selected" : "" %>>🕐 Pending</option>
                <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(complaint.getStatus()) ? "selected" : "" %>>🔄 In Progress</option>
                <option value="RESOLVED" <%= "RESOLVED".equals(complaint.getStatus()) ? "selected" : "" %>>✅ Resolved</option>
                <option value="REJECTED" <%= "REJECTED".equals(complaint.getStatus()) ? "selected" : "" %>>❌ Rejected</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="adminRemarks" class="form-label"><i class="bi bi-chat-left-text me-1"></i>Admin Remarks</label>
            <textarea id="adminRemarks" name="adminRemarks" class="form-control" rows="5" placeholder="Add your remarks..."><%= complaint.getAdminRemarks() != null ? complaint.getAdminRemarks() : "" %></textarea>
            <div class="form-text">
                Provide details about status update, actions taken, or resolution steps.
            </div>
        </div>

        <% if (complaint.getAdminRemarks() != null && !complaint.getAdminRemarks().trim().isEmpty()) { %>
        <div class="previous-remarks">
            <strong><i class="bi bi-clock-history me-1"></i>Previous Remarks:</strong><br/>
            <%= complaint.getAdminRemarks() %>
        </div>
        <% } %>

        <div class="d-flex gap-2 justify-content-end mt-4">
            <button type="submit" class="btn btn-primary">
                <i class="bi bi-check-circle me-1"></i>Update Complaint
            </button>
            <a href="view-complaint?id=<%= complaint.getId() %>" class="btn btn-outline-primary">
                <i class="bi bi-eye me-1"></i>View Details
            </a>
            <a href="admin-dashboard" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left me-1"></i>Back to Dashboard
            </a>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const statusSelect = document.getElementById('status');
    const remarksTextarea = document.getElementById('adminRemarks');

    statusSelect.addEventListener('change', () => {
        if (remarksTextarea.value.trim() === '') {
            switch(statusSelect.value) {
                case 'RESOLVED':
                    remarksTextarea.placeholder = 'Please describe how the complaint was resolved...';
                    break;
                case 'REJECTED':
                    remarksTextarea.placeholder = 'Please provide reason for rejection...';
                    break;
                case 'IN_PROGRESS':
                    remarksTextarea.placeholder = 'Please describe current progress and next steps...';
                    break;
                default:
                    remarksTextarea.placeholder = 'Add your remarks...';
            }
        }
    });

    document.querySelector('form').addEventListener('submit', e => {
        if ((statusSelect.value === 'RESOLVED' || statusSelect.value === 'REJECTED') &&
            remarksTextarea.value.trim() === '') {
            e.preventDefault();
            alert('Please add remarks when marking a complaint as ' + statusSelect.value.toLowerCase() + '.');
            remarksTextarea.focus();
            return false;
        }
        return confirm('Are you sure you want to update this complaint status to ' + statusSelect.value.replace('_', ' ') + '?');
    });
</script>
</body>
</html>
