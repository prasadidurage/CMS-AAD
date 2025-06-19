<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%--%>
<%--    String role = (String) session.getAttribute("role");--%>
<%--    if (role == null || !role.equals("EMPLOYEE")) {--%>
<%--        response.sendRedirect("Emplo.jsp");--%>
<%--        return;--%>
<%--    }--%>
<%--%>--%>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Complaint</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4">Submit New Complaint</h2>
    <form action="submitComplaint" method="post">
        <div class="mb-3">
            <label class="form-label">Title</label>
            <input type="text" name="title" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control" rows="5" required></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">Category</label>
            <select name="category" class="form-select" required>
                <option value="">-- Select Category --</option>
                <option value="Infrastructure">Infrastructure</option>
                <option value="IT">IT</option>
                <option value="HR">HR</option>
                <option value="Other">Other</option>
            </select>
        </div>
        <input type="hidden" name="submittedBy" value="<%= session.getAttribute("userId") %>">
        <button type="submit" class="btn btn-success">Submit</button>
        <a href="employeeDashboard.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>
