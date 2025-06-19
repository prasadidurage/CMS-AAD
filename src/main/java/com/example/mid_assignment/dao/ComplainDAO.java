package com.example.mid_assignment.dao;


import com.example.mid_assignment.model.Complain;

import javax.sql.DataSource;
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
        String sql = "SELECT * FROM complaints ORDER BY created_at DESC";
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


}
