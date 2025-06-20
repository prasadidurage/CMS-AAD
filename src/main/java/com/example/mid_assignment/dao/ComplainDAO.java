package com.example.mid_assignment.dao;


import com.example.mid_assignment.model.Complain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ComplainDAO {
    private DataSource ds;

    public ComplainDAO(DataSource ds) {
        this.ds = ds;
    }

    public List<Complain> getAllComplaints() throws SQLException {
        List<Complain> complaints = new ArrayList<>();
        String sql = "SELECT * FROM complaint ORDER BY created_at DESC";
        String query = "select username from users where id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            System.out.println("Executing query: " + sql);

            while (rs.next()) {
                Complain complain = new Complain();
                complain.setId(rs.getInt("id"));
                complain.setTitle(rs.getString("title"));
                complain.setDescription(rs.getString("description"));
                complain.setCategory(rs.getString("category"));
                complain.setPriority(rs.getString("priority"));
                complain.setCreatedAt(rs.getTimestamp("created_at"));
                complain.setStatus(rs.getString("status"));
                complain.setAdminRemarks(rs.getString("admin_remarks")); // Add this line

                try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {
                    preparedStatement.setInt(1, rs.getInt("submitted_by"));
                    ResultSet rs2 = preparedStatement.executeQuery();
                    while (rs2.next()) {
                        complain.setSubmitterName(rs2.getString("username"));
                    }
                }
                complaints.add(complain);
            }
            System.out.println("Found " + complaints.size() + " complaints");
        } catch (SQLException e) {
            System.err.println("Database error: " + e.getMessage());
            throw e;
        }

        return complaints;
    }


    public boolean saveComplaint(Complain complain) {
        String sql = "INSERT INTO complaint (title, description, category, status, priority,submitted_by,assigned_to,admin_remarks) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            try (Connection conn = ds.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, complain.getTitle());
                stmt.setString(2, complain.getDescription());
                stmt.setString(3, complain.getCategory());
                stmt.setString(4, complain.getStatus().toUpperCase());
                stmt.setString(5, complain.getPriority());
                //string
                stmt.setString(6, complain.getSubmittedBy());
                stmt.setString(7, complain.getAssignedTo());
                stmt.setString(8, complain.getAdminRemarks());




                int rowsAffected = stmt.executeUpdate();
                return rowsAffected > 0;

            } catch (SQLException e) {
                System.err.println("Error saving complaint: " + e.getMessage());
                return false;
            }
        }

    public boolean complaintExists(int complaintId) {
        String sql = "SELECT COUNT(*) FROM complaint WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, complaintId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("Complaint exists check for ID " + complaintId + ": " + (count > 0));
                return count > 0;
            }
            return false;

        } catch (Exception e) {
            System.err.println("Error checking complaint existence: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteComplain(int complaintId) {
        String sql = "DELETE FROM complaints WHERE id = ?";
        try (Connection conn = ds.getConnection()) {
            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setInt(1, complaintId);
            return preparedStatement.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Error checking complaint existence: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public boolean updateComplaintStatus(int complaintId, String newStatus) throws SQLException {
        String sql = "UPDATE complaint SET status = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newStatus.toUpperCase());
            stmt.setInt(2, complaintId);

            int rowsAffected = stmt.executeUpdate();
            System.out.println("Updated complaint " + complaintId + " status to " + newStatus +
                    ". Rows affected: " + rowsAffected);

            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating complaint status: " + e.getMessage());
            throw e;
        }
    }

    public boolean updateAdminRemarks(int complaintId, String remarks) throws SQLException {
        String sql = "UPDATE complaint SET admin_remarks = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, remarks);
            stmt.setInt(2, complaintId);

            int rowsAffected = stmt.executeUpdate();
            System.out.println("Updated admin remarks for complaint " + complaintId +
                    ". Rows affected: " + rowsAffected);

            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating admin remarks: " + e.getMessage());
            throw e;
        }
    }

    public List<Complain> getAllComplaintsById(String employeeId) {
        List<Complain> complaints = new ArrayList<>();
        String sql = "SELECT * FROM complaint WHERE submitted_by = ? ORDER BY created_at DESC";
        String query = "SELECT username FROM users WHERE user_id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, employeeId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Complain c = new Complain();
                c.setId(rs.getInt("id"));
                c.setTitle(rs.getString("title"));
                c.setDescription(rs.getString("description"));
                c.setCategory(rs.getString("category"));
                c.setPriority(rs.getString("priority"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
                c.setStatus(rs.getString("status"));
                c.setAdminRemarks(rs.getString("admin_remarks")); // Add this line

                try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {
                    preparedStatement.setString(1, rs.getString("submitted_by"));                    ResultSet rs2 = preparedStatement.executeQuery();
                    while (rs2.next()) {
                        c.setSubmitterName(rs2.getString("username"));
                    }
                }
                complaints.add(c);
            }
        } catch (SQLException e) {
            System.err.println("Error loading complaints for employee ID " + employeeId + ": " + e.getMessage());
            e.printStackTrace();
        }
        return complaints;
    }

    public boolean updateComplaint(Complain complaint) throws SQLException {
        String sql = "UPDATE complaint SET title = ?, description = ?, category = ?, priority = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, complaint.getTitle());
            stmt.setString(2, complaint.getDescription());
            stmt.setString(3, complaint.getCategory());
            stmt.setString(4, complaint.getPriority());
            stmt.setInt(5, complaint.getId());

            int rowsAffected = stmt.executeUpdate();
            System.out.println("Updated complaint " + complaint.getId() +
                    ". Rows affected: " + rowsAffected);

            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating complaint: " + e.getMessage());
            throw e;
        }
    }



}

