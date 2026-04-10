package com.pgfinder.dao;

import com.pgfinder.config.DatabaseConfig;
import com.pgfinder.model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    
    // Register new user
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (name, email, phone, password_hash, user_type, email_verified, profile_image) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPhone() != null ? user.getPhone() : "");
            pstmt.setString(4, user.getPasswordHash());
            pstmt.setString(5, user.getUserType());
            pstmt.setBoolean(6, user.isEmailVerified());
            pstmt.setString(7, user.getProfileImage());
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        user.setUserId(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Find user by email
    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ? AND is_active = TRUE";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Find user by ID
    public User findById(int userId) {
        String sql = "SELECT * FROM users WHERE user_id = ? AND is_active = TRUE";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Check if email exists
    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Check if phone exists
    public boolean phoneExists(String phone) {
        String sql = "SELECT COUNT(*) FROM users WHERE phone = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, phone);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Update last login
    public boolean updateLastLogin(int userId) {
        String sql = "UPDATE users SET last_login = CURRENT_TIMESTAMP WHERE user_id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Update email verification status
    public boolean updateEmailVerification(int userId, boolean verified) {
        String sql = "UPDATE users SET email_verified = ? WHERE user_id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setBoolean(1, verified);
            pstmt.setInt(2, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Update password
    public boolean updatePassword(int userId, String newPasswordHash) {
        String sql = "UPDATE users SET password_hash = ? WHERE user_id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, newPasswordHash);
            pstmt.setInt(2, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Helper method to extract User from ResultSet
    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setName(rs.getString("name"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setUserType(rs.getString("user_type"));
        user.setProfileImage(rs.getString("profile_image"));
        user.setVerified(rs.getBoolean("is_verified"));
        user.setActive(rs.getBoolean("is_active"));
        user.setEmailVerified(rs.getBoolean("email_verified"));
        user.setPhoneVerified(rs.getBoolean("phone_verified"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        user.setUpdatedAt(rs.getTimestamp("updated_at"));
        user.setLastLogin(rs.getTimestamp("last_login"));
        return user;
    }
    
    // Get user by ID (alias for findById)
    public User getUserById(int userId) {
        return findById(userId);
    }
    
    // Get all tenants (for roommate finder) - optionally filtered by PG listing
    public List<java.util.Map<String, Object>> getRoommatesForFinder(int excludeUserId, Integer pgId) {
        List<java.util.Map<String, Object>> roommates = new ArrayList<>();
        
        String sql;
        if (pgId != null) {
            // Only tenants who have a confirmed/active booking in this specific PG
            sql = "SELECT u.user_id, u.name, u.profile_image, u.is_verified, " +
                  "l.title as pg_name, l.city, l.listing_id, b.booking_id " +
                  "FROM users u " +
                  "JOIN bookings b ON u.user_id = b.tenant_id " +
                  "JOIN pg_listings l ON b.listing_id = l.listing_id " +
                  "WHERE u.user_type = 'tenant' AND u.is_active = TRUE " +
                  "AND u.user_id != ? AND l.listing_id = ? " +
                  "AND b.booking_status IN ('confirmed','active','pending') " +
                  "GROUP BY u.user_id";
        } else {
            // All tenants who have any booking
            sql = "SELECT u.user_id, u.name, u.profile_image, u.is_verified, " +
                  "l.title as pg_name, l.city, l.listing_id, b.booking_id " +
                  "FROM users u " +
                  "JOIN bookings b ON u.user_id = b.tenant_id " +
                  "JOIN pg_listings l ON b.listing_id = l.listing_id " +
                  "WHERE u.user_type = 'tenant' AND u.is_active = TRUE " +
                  "AND u.user_id != ? " +
                  "AND b.booking_status IN ('confirmed','active','pending') " +
                  "GROUP BY u.user_id";
        }
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, excludeUserId);
            if (pgId != null) pstmt.setInt(2, pgId);
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                java.util.Map<String, Object> r = new java.util.HashMap<>();
                r.put("userId", rs.getInt("user_id"));
                r.put("name", rs.getString("name"));
                r.put("profileImage", rs.getString("profile_image"));
                r.put("verified", rs.getBoolean("is_verified"));
                r.put("pgName", rs.getString("pg_name"));
                r.put("city", rs.getString("city"));
                r.put("listingId", rs.getInt("listing_id"));
                roommates.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roommates;
    }
    
    // Update user profile
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET name = ?, phone = ? WHERE user_id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getPhone());
            pstmt.setInt(3, user.getUserId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
