package com.example.mid_assignment.dao;

import com.example.mid_assignment.model.User;

import javax.sql.DataSource;
import java.sql.*;
import java.util.UUID;

public class UserDAO {
    private final DataSource dataSource;

    public UserDAO(DataSource dataSource) {

        this.dataSource = dataSource;
    }

    // User registration
//    public boolean register(User user) {
//        String sql = "INSERT INTO users (user_id,username, password, full_name, email, role) VALUES (?,?, ?, ?, ?, ?)";
//
//        try (Connection conn = dataSource.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql)) {
//
//            stmt.setString(1, UUID.randomUUID().toString());
//            stmt.setString(1, user.getUsername());
//            stmt.setString(2, user.getPassword()); // Note: Hash this in real apps!
//            stmt.setString(3, user.getFullname());
//            stmt.setString(4, user.getEmail());
//            stmt.setString(5, user.getRole());
//
//            return stmt.executeUpdate() > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }
//    }

    public boolean register(User user) {
        String sql = "INSERT INTO users (user_id, username, password, full_name, email, role) VALUES (?, ?, ?, ?, ?, ?)";


        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String uuid = UUID.randomUUID().toString().replaceAll("-", "");
            String id4Digits = uuid.substring(0, 4);  // Example: "a3f9"
            stmt.setString(1, id4Digits);
            stmt.setString(2, user.getUsername());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getFullname());
            stmt.setString(5, user.getEmail());
            stmt.setString(6, user.getRole());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // User login
    public User login(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password); // Again, use hash + salt in production

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getString("user_id"),
                            rs.getString("username"),
                            rs.getString("password"),
                            rs.getString("full_name"),
                            rs.getString("email"),
                            rs.getString("role")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
