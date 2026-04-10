package com.pgfinder.dao;

import com.pgfinder.model.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminDAO {
    private Connection connection;
    
    public AdminDAO(Connection connection) {
        this.connection = connection;
    }
    
    // ==================== DASHBOARD ANALYTICS ====================
    
    public Map<String, Object> getDashboardStats() throws SQLException {
        Map<String, Object> stats = new HashMap<>();
        
        // Total users by type
        String userStatsQuery = "SELECT user_type, COUNT(*) as count FROM users WHERE is_active = 1 GROUP BY user_type";
        try (PreparedStatement stmt = connection.prepareStatement(userStatsQuery);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                stats.put(rs.getString("user_type") + "_count", rs.getInt("count"));
            }
        }
        
        // Total listings
        String listingQuery = "SELECT COUNT(*) as total, " +
                            "SUM(CASE WHEN is_verified = 1 THEN 1 ELSE 0 END) as verified, " +
                            "SUM(CASE WHEN is_active = 1 THEN 1 ELSE 0 END) as active " +
                            "FROM pg_listings";
        try (PreparedStatement stmt = connection.prepareStatement(listingQuery);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                stats.put("total_listings", rs.getInt("total"));
                stats.put("verified_listings", rs.getInt("verified"));
                stats.put("active_listings", rs.getInt("active"));
            }
        }
        
        // Bookings stats
        String bookingQuery = "SELECT COUNT(*) as total, " +
                            "SUM(CASE WHEN booking_status = 'pending' THEN 1 ELSE 0 END) as pending, " +
                            "SUM(CASE WHEN booking_status = 'confirmed' THEN 1 ELSE 0 END) as confirmed, " +
                            "SUM(rent_amount) as total_revenue " +
                            "FROM bookings";
        try (PreparedStatement stmt = connection.prepareStatement(bookingQuery);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                stats.put("total_bookings", rs.getInt("total"));
                stats.put("pending_bookings", rs.getInt("pending"));
                stats.put("confirmed_bookings", rs.getInt("confirmed"));
                stats.put("total_revenue", rs.getBigDecimal("total_revenue"));
            }
        }
        
        // Pending approvals
        String approvalQuery = "SELECT " +
                             "(SELECT COUNT(*) FROM owner_documents WHERE verification_status = 'pending') as pending_docs, " +
                             "(SELECT COUNT(*) FROM pg_listings WHERE is_verified = 0 AND is_active = 1) as pending_listings, " +
                             "(SELECT COUNT(*) FROM reports WHERE status = 'pending') as pending_reports";
        try (PreparedStatement stmt = connection.prepareStatement(approvalQuery);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                stats.put("pending_documents", rs.getInt("pending_docs"));
                stats.put("pending_listings", rs.getInt("pending_listings"));
                stats.put("pending_reports", rs.getInt("pending_reports"));
            }
        }
        
        // Recent activity count
        String activityQuery = "SELECT COUNT(*) as count FROM activity_logs WHERE created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)";
        try (PreparedStatement stmt = connection.prepareStatement(activityQuery);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                stats.put("recent_activities", rs.getInt("count"));
            }
        }
        
        return stats;
    }
    
    public List<Map<String, Object>> getRecentActivities(int limit) throws SQLException {
        List<Map<String, Object>> activities = new ArrayList<>();
        String query = "SELECT al.*, u.name as user_name, u.email as user_email " +
                      "FROM activity_logs al " +
                      "LEFT JOIN users u ON al.user_id = u.user_id " +
                      "ORDER BY al.created_at DESC LIMIT ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> activity = new HashMap<>();
                    activity.put("log_id", rs.getInt("log_id"));
                    activity.put("user_name", rs.getString("user_name"));
                    activity.put("action_type", rs.getString("action_type"));
                    activity.put("action_description", rs.getString("action_description"));
                    activity.put("created_at", rs.getTimestamp("created_at"));
                    activities.add(activity);
                }
            }
        }
        return activities;
    }
    
    // ==================== USER MANAGEMENT ====================
    
    public List<User> getAllUsers(String userType, String status, int page, int pageSize) throws SQLException {
        List<User> users = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM users WHERE 1=1");
        
        if (userType != null && !userType.isEmpty() && !userType.equals("all")) {
            query.append(" AND user_type = ?");
        }
        if (status != null && !status.isEmpty() && !status.equals("all")) {
            query.append(" AND is_active = ?");
        }
        
        query.append(" ORDER BY created_at DESC LIMIT ? OFFSET ?");
        
        try (PreparedStatement stmt = connection.prepareStatement(query.toString())) {
            int paramIndex = 1;
            if (userType != null && !userType.isEmpty() && !userType.equals("all")) {
                stmt.setString(paramIndex++, userType);
            }
            if (status != null && !status.isEmpty() && !status.equals("all")) {
                stmt.setBoolean(paramIndex++, status.equals("active"));
            }
            stmt.setInt(paramIndex++, pageSize);
            stmt.setInt(paramIndex, (page - 1) * pageSize);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    users.add(mapUser(rs));
                }
            }
        }
        return users;
    }
    
    public int getTotalUsersCount(String userType, String status) throws SQLException {
        StringBuilder query = new StringBuilder("SELECT COUNT(*) FROM users WHERE 1=1");
        
        if (userType != null && !userType.isEmpty() && !userType.equals("all")) {
            query.append(" AND user_type = ?");
        }
        if (status != null && !status.isEmpty() && !status.equals("all")) {
            query.append(" AND is_active = ?");
        }
        
        try (PreparedStatement stmt = connection.prepareStatement(query.toString())) {
            int paramIndex = 1;
            if (userType != null && !userType.isEmpty() && !userType.equals("all")) {
                stmt.setString(paramIndex++, userType);
            }
            if (status != null && !status.isEmpty() && !status.equals("all")) {
                stmt.setBoolean(paramIndex, status.equals("active"));
            }
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    public User getUserById(int userId) throws SQLException {
        String query = "SELECT * FROM users WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        }
        return null;
    }
    
    public boolean updateUserStatus(int userId, boolean isActive) throws SQLException {
        String query = "UPDATE users SET is_active = ? WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setBoolean(1, isActive);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean deactivateUserWithReason(int userId, String reason) throws SQLException {
        String query = "UPDATE users SET is_active = FALSE, deactivation_reason = ?, deactivated_at = CURRENT_TIMESTAMP WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, reason);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean activateUserClearReason(int userId) throws SQLException {
        String query = "UPDATE users SET is_active = TRUE, deactivation_reason = NULL, deactivated_at = NULL WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean verifyUser(int userId) throws SQLException {
        String query = "UPDATE users SET is_verified = 1 WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean deleteUser(int userId) throws SQLException {
        String query = "DELETE FROM users WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    // ==================== LISTING MANAGEMENT ====================
    
    public List<PGListing> getAllListings(String status, String city, int page, int pageSize) throws SQLException {
        List<PGListing> listings = new ArrayList<>();
        StringBuilder query = new StringBuilder(
            "SELECT l.*, u.name as owner_name, u.phone as owner_phone " +
            "FROM pg_listings l " +
            "JOIN users u ON l.owner_id = u.user_id " +
            "WHERE 1=1"
        );
        
        if (status != null && !status.isEmpty() && !status.equals("all")) {
            if (status.equals("verified")) {
                query.append(" AND l.is_verified = 1");
            } else if (status.equals("unverified")) {
                query.append(" AND l.is_verified = 0");
            } else if (status.equals("active")) {
                query.append(" AND l.is_active = 1");
            } else if (status.equals("inactive")) {
                query.append(" AND l.is_active = 0");
            }
        }
        
        if (city != null && !city.isEmpty() && !city.equals("all")) {
            query.append(" AND l.city = ?");
        }
        
        query.append(" ORDER BY l.created_at DESC LIMIT ? OFFSET ?");
        
        try (PreparedStatement stmt = connection.prepareStatement(query.toString())) {
            int paramIndex = 1;
            if (city != null && !city.isEmpty() && !city.equals("all")) {
                stmt.setString(paramIndex++, city);
            }
            stmt.setInt(paramIndex++, pageSize);
            stmt.setInt(paramIndex, (page - 1) * pageSize);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    listings.add(mapListing(rs));
                }
            }
        }
        return listings;
    }
    
    public int getTotalListingsCount(String status, String city) throws SQLException {
        StringBuilder query = new StringBuilder("SELECT COUNT(*) FROM pg_listings WHERE 1=1");
        
        if (status != null && !status.isEmpty() && !status.equals("all")) {
            if (status.equals("verified")) {
                query.append(" AND is_verified = 1");
            } else if (status.equals("unverified")) {
                query.append(" AND is_verified = 0");
            } else if (status.equals("active")) {
                query.append(" AND is_active = 1");
            } else if (status.equals("inactive")) {
                query.append(" AND is_active = 0");
            }
        }
        
        if (city != null && !city.isEmpty() && !city.equals("all")) {
            query.append(" AND city = ?");
        }
        
        try (PreparedStatement stmt = connection.prepareStatement(query.toString())) {
            if (city != null && !city.isEmpty() && !city.equals("all")) {
                stmt.setString(1, city);
            }
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    public boolean updateListingStatus(int listingId, boolean isActive) throws SQLException {
        String query = "UPDATE pg_listings SET is_active = ? WHERE listing_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setBoolean(1, isActive);
            stmt.setInt(2, listingId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean verifyListing(int listingId) throws SQLException {
        String query = "UPDATE pg_listings SET is_verified = 1 WHERE listing_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, listingId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean deleteListing(int listingId) throws SQLException {
        String query = "DELETE FROM pg_listings WHERE listing_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, listingId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    // ==================== APPROVALS ====================
    
    public List<Map<String, Object>> getPendingDocuments(int page, int pageSize) throws SQLException {
        List<Map<String, Object>> documents = new ArrayList<>();
        String query = "SELECT od.*, u.name as owner_name, u.email as owner_email, u.phone as owner_phone " +
                      "FROM owner_documents od " +
                      "JOIN users u ON od.owner_id = u.user_id " +
                      "WHERE od.verification_status = 'pending' " +
                      "ORDER BY od.uploaded_at DESC LIMIT ? OFFSET ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, pageSize);
            stmt.setInt(2, (page - 1) * pageSize);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> doc = new HashMap<>();
                    doc.put("document_id", rs.getInt("document_id"));
                    doc.put("owner_id", rs.getInt("owner_id"));
                    doc.put("owner_name", rs.getString("owner_name"));
                    doc.put("owner_email", rs.getString("owner_email"));
                    doc.put("owner_phone", rs.getString("owner_phone"));
                    doc.put("document_type", rs.getString("document_type"));
                    doc.put("document_url", rs.getString("document_url"));
                    doc.put("uploaded_at", rs.getTimestamp("uploaded_at"));
                    documents.add(doc);
                }
            }
        }
        return documents;
    }
    
    public boolean approveDocument(int documentId) throws SQLException {
        String query = "UPDATE owner_documents SET verification_status = 'approved', verified_at = NOW() WHERE document_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, documentId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean rejectDocument(int documentId) throws SQLException {
        String query = "UPDATE owner_documents SET verification_status = 'rejected', verified_at = NOW() WHERE document_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, documentId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    // ==================== REVIEWS MANAGEMENT ====================
    
    public List<Map<String, Object>> getAllReviews(String status, int page, int pageSize) throws SQLException {
        List<Map<String, Object>> reviews = new ArrayList<>();
        StringBuilder query = new StringBuilder(
            "SELECT r.*, u.name as tenant_name, l.title as listing_title " +
            "FROM reviews r " +
            "JOIN users u ON r.tenant_id = u.user_id " +
            "JOIN pg_listings l ON r.listing_id = l.listing_id " +
            "WHERE 1=1"
        );
        
        if (status != null && !status.isEmpty() && !status.equals("all")) {
            if (status.equals("active")) {
                query.append(" AND r.is_active = 1");
            } else if (status.equals("inactive")) {
                query.append(" AND r.is_active = 0");
            }
        }
        
        query.append(" ORDER BY r.created_at DESC LIMIT ? OFFSET ?");
        
        try (PreparedStatement stmt = connection.prepareStatement(query.toString())) {
            stmt.setInt(1, pageSize);
            stmt.setInt(2, (page - 1) * pageSize);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> review = new HashMap<>();
                    review.put("review_id", rs.getInt("review_id"));
                    review.put("listing_id", rs.getInt("listing_id"));
                    review.put("listing_title", rs.getString("listing_title"));
                    review.put("tenant_name", rs.getString("tenant_name"));
                    review.put("rating", rs.getInt("rating"));
                    review.put("review_text", rs.getString("review_text"));
                    review.put("is_active", rs.getBoolean("is_active"));
                    review.put("created_at", rs.getTimestamp("created_at"));
                    reviews.add(review);
                }
            }
        }
        return reviews;
    }
    
    public boolean updateReviewStatus(int reviewId, boolean isActive) throws SQLException {
        String query = "UPDATE reviews SET is_active = ? WHERE review_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setBoolean(1, isActive);
            stmt.setInt(2, reviewId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean deleteReview(int reviewId) throws SQLException {
        String query = "DELETE FROM reviews WHERE review_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, reviewId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    // ==================== REPORTS MANAGEMENT ====================
    
    public List<Report> getAllReports(String status, int page, int pageSize) throws SQLException {
        List<Report> reports = new ArrayList<>();
        StringBuilder query = new StringBuilder(
            "SELECT r.*, u.name as reporter_name, u.email as reporter_email " +
            "FROM reports r " +
            "JOIN users u ON r.reporter_id = u.user_id " +
            "WHERE 1=1"
        );
        
        if (status != null && !status.isEmpty() && !status.equals("all")) {
            query.append(" AND r.status = ?");
        }
        
        query.append(" ORDER BY r.created_at DESC LIMIT ? OFFSET ?");
        
        try (PreparedStatement stmt = connection.prepareStatement(query.toString())) {
            int paramIndex = 1;
            if (status != null && !status.isEmpty() && !status.equals("all")) {
                stmt.setString(paramIndex++, status);
            }
            stmt.setInt(paramIndex++, pageSize);
            stmt.setInt(paramIndex, (page - 1) * pageSize);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Report report = mapReport(rs);
                    report.setReporterName(rs.getString("reporter_name"));
                    report.setReporterEmail(rs.getString("reporter_email"));
                    reports.add(report);
                }
            }
        }
        return reports;
    }
    
    public Report getReportById(int reportId) throws SQLException {
        String query = "SELECT r.*, u.name as reporter_name, u.email as reporter_email " +
                      "FROM reports r " +
                      "JOIN users u ON r.reporter_id = u.user_id " +
                      "WHERE r.report_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, reportId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Report report = mapReport(rs);
                    report.setReporterName(rs.getString("reporter_name"));
                    report.setReporterEmail(rs.getString("reporter_email"));
                    return report;
                }
            }
        }
        return null;
    }
    
    public boolean updateReportStatus(int reportId, String status, String adminNotes, int adminId) throws SQLException {
        String query = "UPDATE reports SET status = ?, admin_notes = ?, resolved_by = ?, resolved_at = NOW() WHERE report_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, status);
            stmt.setString(2, adminNotes);
            stmt.setInt(3, adminId);
            stmt.setInt(4, reportId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    // ==================== SYSTEM SETTINGS ====================
    
    public List<SystemSettings> getAllSettings() throws SQLException {
        List<SystemSettings> settings = new ArrayList<>();
        String query = "SELECT * FROM system_settings ORDER BY setting_key";
        
        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                settings.add(mapSystemSettings(rs));
            }
        }
        return settings;
    }
    
    public SystemSettings getSettingByKey(String key) throws SQLException {
        String query = "SELECT * FROM system_settings WHERE setting_key = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, key);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapSystemSettings(rs);
                }
            }
        }
        return null;
    }
    
    public boolean updateSetting(String key, String value, int adminId) throws SQLException {
        String query = "UPDATE system_settings SET setting_value = ?, updated_by = ? WHERE setting_key = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, value);
            stmt.setInt(2, adminId);
            stmt.setString(3, key);
            return stmt.executeUpdate() > 0;
        }
    }
    
    // ==================== ACTIVITY LOGS ====================
    
    public void logActivity(Integer userId, String actionType, String actionDescription, 
                           String entityType, Integer entityId, String ipAddress, String userAgent) throws SQLException {
        String query = "INSERT INTO activity_logs (user_id, action_type, action_description, entity_type, entity_id, ip_address, user_agent) " +
                      "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setObject(1, userId);
            stmt.setString(2, actionType);
            stmt.setString(3, actionDescription);
            stmt.setString(4, entityType);
            stmt.setObject(5, entityId);
            stmt.setString(6, ipAddress);
            stmt.setString(7, userAgent);
            stmt.executeUpdate();
        }
    }
    
    public List<ActivityLog> getActivityLogs(int page, int pageSize) throws SQLException {
        List<ActivityLog> logs = new ArrayList<>();
        String query = "SELECT al.*, u.name as user_name, u.email as user_email " +
                      "FROM activity_logs al " +
                      "LEFT JOIN users u ON al.user_id = u.user_id " +
                      "ORDER BY al.created_at DESC LIMIT ? OFFSET ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, pageSize);
            stmt.setInt(2, (page - 1) * pageSize);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ActivityLog log = mapActivityLog(rs);
                    log.setUserName(rs.getString("user_name"));
                    log.setUserEmail(rs.getString("user_email"));
                    logs.add(log);
                }
            }
        }
        return logs;
    }
    
    // ==================== HELPER METHODS ====================
    
    private User mapUser(ResultSet rs) throws SQLException {
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
        user.setDeactivationReason(rs.getString("deactivation_reason"));
        user.setDeactivatedAt(rs.getTimestamp("deactivated_at"));
        return user;
    }
    
    private PGListing mapListing(ResultSet rs) throws SQLException {
        PGListing listing = new PGListing();
        listing.setListingId(rs.getInt("listing_id"));
        listing.setOwnerId(rs.getInt("owner_id"));
        listing.setTitle(rs.getString("title"));
        listing.setDescription(rs.getString("description"));
        listing.setAddress(rs.getString("address"));
        listing.setCity(rs.getString("city"));
        listing.setState(rs.getString("state"));
        listing.setPincode(rs.getString("pincode"));
        listing.setPgType(rs.getString("pg_type"));
        listing.setTotalRooms(rs.getInt("total_rooms"));
        listing.setAvailableRooms(rs.getInt("available_rooms"));
        listing.setRentPerMonth(rs.getBigDecimal("rent_per_month"));
        listing.setSecurityDeposit(rs.getBigDecimal("security_deposit"));
        listing.setVerified(rs.getBoolean("is_verified"));
        listing.setActive(rs.getBoolean("is_active"));
        listing.setCreatedAt(rs.getTimestamp("created_at"));
        listing.setOwnerName(rs.getString("owner_name"));
        listing.setOwnerPhone(rs.getString("owner_phone"));
        return listing;
    }
    
    private Report mapReport(ResultSet rs) throws SQLException {
        Report report = new Report();
        report.setReportId(rs.getInt("report_id"));
        report.setReporterId(rs.getInt("reporter_id"));
        report.setReportedType(rs.getString("reported_type"));
        report.setReportedId(rs.getInt("reported_id"));
        report.setReportReason(rs.getString("report_reason"));
        report.setReportDescription(rs.getString("report_description"));
        report.setStatus(rs.getString("status"));
        report.setAdminNotes(rs.getString("admin_notes"));
        report.setResolvedBy((Integer) rs.getObject("resolved_by"));
        report.setCreatedAt(rs.getTimestamp("created_at"));
        report.setResolvedAt(rs.getTimestamp("resolved_at"));
        return report;
    }
    
    private SystemSettings mapSystemSettings(ResultSet rs) throws SQLException {
        SystemSettings settings = new SystemSettings();
        settings.setSettingId(rs.getInt("setting_id"));
        settings.setSettingKey(rs.getString("setting_key"));
        settings.setSettingValue(rs.getString("setting_value"));
        settings.setSettingType(rs.getString("setting_type"));
        settings.setDescription(rs.getString("description"));
        settings.setUpdatedBy((Integer) rs.getObject("updated_by"));
        settings.setUpdatedAt(rs.getTimestamp("updated_at"));
        return settings;
    }
    
    private ActivityLog mapActivityLog(ResultSet rs) throws SQLException {
        ActivityLog log = new ActivityLog();
        log.setLogId(rs.getInt("log_id"));
        log.setUserId((Integer) rs.getObject("user_id"));
        log.setActionType(rs.getString("action_type"));
        log.setActionDescription(rs.getString("action_description"));
        log.setEntityType(rs.getString("entity_type"));
        log.setEntityId((Integer) rs.getObject("entity_id"));
        log.setIpAddress(rs.getString("ip_address"));
        log.setUserAgent(rs.getString("user_agent"));
        log.setCreatedAt(rs.getTimestamp("created_at"));
        return log;
    }
    
    // ==================== GRAPH DATA ====================
    
    public List<Map<String, Object>> getMonthlyRegistrationStats() throws SQLException {
        List<Map<String, Object>> stats = new ArrayList<>();
        String query = "SELECT " +
                      "DATE_FORMAT(created_at, '%Y-%m') as month, " +
                      "user_type, " +
                      "COUNT(*) as count " +
                      "FROM users " +
                      "WHERE created_at >= DATE_SUB(NOW(), INTERVAL 12 MONTH) " +
                      "GROUP BY DATE_FORMAT(created_at, '%Y-%m'), user_type " +
                      "ORDER BY month ASC";
        
        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> stat = new HashMap<>();
                stat.put("month", rs.getString("month"));
                stat.put("user_type", rs.getString("user_type"));
                stat.put("count", rs.getInt("count"));
                stats.add(stat);
            }
        }
        return stats;
    }
    
    public List<Map<String, Object>> getMonthlyRevenueStats() throws SQLException {
        List<Map<String, Object>> stats = new ArrayList<>();
        String query = "SELECT " +
                      "DATE_FORMAT(booking_date, '%Y-%m') as month, " +
                      "SUM(rent_amount) as revenue, " +
                      "COUNT(*) as booking_count " +
                      "FROM bookings " +
                      "WHERE booking_date >= DATE_SUB(NOW(), INTERVAL 12 MONTH) " +
                      "AND booking_status IN ('confirmed', 'completed') " +
                      "GROUP BY DATE_FORMAT(booking_date, '%Y-%m') " +
                      "ORDER BY month ASC";
        
        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> stat = new HashMap<>();
                stat.put("month", rs.getString("month"));
                stat.put("revenue", rs.getBigDecimal("revenue"));
                stat.put("booking_count", rs.getInt("booking_count"));
                stats.add(stat);
            }
        }
        return stats;
    }
}
