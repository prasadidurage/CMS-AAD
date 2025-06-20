<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>User Signup</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Google Fonts for a modern look -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@600&display=swap" rel="stylesheet" />
    <style>
        /* Body with full-screen background and overlay */
        body {
            background: linear-gradient(135deg, rgba(29, 202, 156, 0.16), #4d5949);  !important;
            height: 100vh;
            margin: 0;
            font-family: 'Montserrat', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        /* Container with animated entrance */
        .signup-container {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 3rem 2rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            max-width: 450px;
            width: 100%;
            animation: slideIn 1s ease-out;
        }

        /* Animation for entrance */
        @keyframes slideIn {
            from { transform: translateY(-30px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        /* Heading styles */
        h2 {
            text-align: center;
            margin-bottom: 1.75rem;
            font-weight: 700;
            color: #0d6efd;
            letter-spacing: 1px;
            text-shadow: 1px 1px 4px rgba(0,0,0,0.2);
        }

        /* Labels styling */
        .form-label {
            font-weight: 600;
            color: #333;
        }

        /* Input focus style */
        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 8px rgba(13, 110, 253, 0.3);
        }

        /* Button styles with hover animation */
        .btn-primary {
            background-color: #0d6efd;
            border: none;
            transition: transform 0.2s, background-color 0.3s;
        }

        .btn-primary:hover {
            background-color: #0b5ed7;
            transform: translateY(-2px);
        }

        /* Feedback messages */
        .message-success {
            color: #198754;
            font-weight: 600;
            text-align: center;
            margin-top: 1rem;
        }

        .message-error {
            color: #dc3545;
            font-weight: 600;
            text-align: center;
            margin-top: 1rem;
        }

        /* Responsive adjustments */
        @media (max-width: 500px) {
            .signup-container {
                padding: 2rem 1.5rem;
            }
        }
    </style>
</head>
<body>

<div class="signup-container shadow-lg">
    <h2>Create Your Account</h2>
    <form action="${pageContext.request.contextPath}/authServlet" method="post" novalidate>
        <input type="hidden" name="action" value="signup" />
        <input type="hidden" name="role" value="EMPLOYEE" />

        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" id="username" name="username" class="form-control" placeholder="Enter username" required />
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="Create password" required />
        </div>

        <div class="mb-3">
            <label for="full_name" class="form-label">Full Name</label>
            <input type="text" id="full_name" name="full_name" class="form-control" placeholder="Your full name" required />
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" id="email" name="email" class="form-control" placeholder="you@example.com" required />
        </div>

        <div class="mb-4">
            <label for="roleSelect" class="form-label">Role</label>
            <select id="roleSelect" name="role" class="form-select" required>
                <option value="EMPLOYEE" selected>Employee</option>
                <option value="ADMIN" selected>Admin</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary w-100 py-2 fs-5">Register Now</button>
    </form>

    <!-- Feedback messages -->
    <% if (request.getAttribute("message") != null) { %>
    <p class="message-success"><%= request.getAttribute("message") %></p>
    <% } %>
    <% if (request.getAttribute("error") != null) { %>
    <p class="message-error"><%= request.getAttribute("error") %></p>
    <% } %>
</div>

<!-- Bootstrap JS Bundle for interactivity -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>