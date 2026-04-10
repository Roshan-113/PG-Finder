package com.pgfinder.service;

import com.pgfinder.dao.AdminDAO;
import com.pgfinder.model.*;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class AdminService {
    private AdminDAO adminDAO;
    
    public AdminService(Connection connection) {
        this.adminDAO = new AdminDAO(connection);
    }
    
    // Dashboard
    public Map<String, Object> getDashboardStats() throws SQLException {
        return adminDAO.getDashboardStats();
    }
    
    public List<Map<String, Object>> getRecentActivities(int limit) throws SQLException {
        return adminDAO.getRecentActivities(limit);
    }
    
    // User Management
    public List<User> getAllUsers(String userType, String status, int page, int pageSize) throws SQLException {
        return adminDAO.getAllUsers(userType, status, page, pageSize);
    }
    
    public int getTotalUsersCount(String userType, String status) throws SQLException {
        return adminDAO.getTotalUsersCount(userType, status);
    }
    
    public User getUserById(int userId) throws SQLException {
        return adminDAO.getUserById(userId);
    }
    
    public boolean deactivateUser(int userId, int adminId, String reason) throws SQLException {
        boolean result = adminDAO.deactivateUserWithReason(userId, reason);
        if (result) {
            adminDAO.logActivity(adminId, "USER_DEACTIVATED", "Deactivated user ID: " + userId + " - Reason: " + reason, "user", userId, null, null);
        }
        return result;
    }
    
    public boolean activateUser(int userId, int adminId) throws SQLException {
        boolean result = adminDAO.activateUserClearReason(userId);
        if (result) {
            adminDAO.logActivity(adminId, "USER_ACTIVATED", "Activated user ID: " + userId, "user", userId, null, null);
        }
        return result;
    }
    
    public boolean verifyUser(int userId, int adminId) throws SQLException {
        boolean result = adminDAO.verifyUser(userId);
        if (result) {
            adminDAO.logActivity(adminId, "USER_VERIFIED", "Verified user ID: " + userId, "user", userId, null, null);
        }
        return result;
    }
    
    public boolean deleteUser(int userId, int adminId) throws SQLException {
        boolean result = adminDAO.deleteUser(userId);
        if (result) {
            adminDAO.logActivity(adminId, "USER_DELETED", "Deleted user ID: " + userId, "user", userId, null, null);
        }
        return result;
    }
    
    // Listing Management
    public List<PGListing> getAllListings(String status, String city, int page, int pageSize) throws SQLException {
        return adminDAO.getAllListings(status, city, page, pageSize);
    }
    
    public int getTotalListingsCount(String status, String city) throws SQLException {
        return adminDAO.getTotalListingsCount(status, city);
    }
    
    public boolean activateListing(int listingId, int adminId) throws SQLException {
        boolean result = adminDAO.updateListingStatus(listingId, true);
        if (result) {
            adminDAO.logActivity(adminId, "LISTING_ACTIVATED", "Activated listing ID: " + listingId, "listing", listingId, null, null);
        }
        return result;
    }
    
    public boolean deactivateListing(int listingId, int adminId) throws SQLException {
        boolean result = adminDAO.updateListingStatus(listingId, false);
        if (result) {
            adminDAO.logActivity(adminId, "LISTING_DEACTIVATED", "Deactivated listing ID: " + listingId, "listing", listingId, null, null);
        }
        return result;
    }
    
    public boolean verifyListing(int listingId, int adminId) throws SQLException {
        boolean result = adminDAO.verifyListing(listingId);
        if (result) {
            adminDAO.logActivity(adminId, "LISTING_VERIFIED", "Verified listing ID: " + listingId, "listing", listingId, null, null);
        }
        return result;
    }
    
    public boolean deleteListing(int listingId, int adminId) throws SQLException {
        boolean result = adminDAO.deleteListing(listingId);
        if (result) {
            adminDAO.logActivity(adminId, "LISTING_DELETED", "Deleted listing ID: " + listingId, "listing", listingId, null, null);
        }
        return result;
    }
    
    // Approvals
    public List<Map<String, Object>> getPendingDocuments(int page, int pageSize) throws SQLException {
        return adminDAO.getPendingDocuments(page, pageSize);
    }
    
    public boolean approveDocument(int documentId, int adminId) throws SQLException {
        boolean result = adminDAO.approveDocument(documentId);
        if (result) {
            adminDAO.logActivity(adminId, "DOCUMENT_APPROVED", "Approved document ID: " + documentId, "document", documentId, null, null);
        }
        return result;
    }
    
    public boolean rejectDocument(int documentId, int adminId) throws SQLException {
        boolean result = adminDAO.rejectDocument(documentId);
        if (result) {
            adminDAO.logActivity(adminId, "DOCUMENT_REJECTED", "Rejected document ID: " + documentId, "document", documentId, null, null);
        }
        return result;
    }
    
    // Reviews
    public List<Map<String, Object>> getAllReviews(String status, int page, int pageSize) throws SQLException {
        return adminDAO.getAllReviews(status, page, pageSize);
    }
    
    public boolean activateReview(int reviewId, int adminId) throws SQLException {
        boolean result = adminDAO.updateReviewStatus(reviewId, true);
        if (result) {
            adminDAO.logActivity(adminId, "REVIEW_ACTIVATED", "Activated review ID: " + reviewId, "review", reviewId, null, null);
        }
        return result;
    }
    
    public boolean deactivateReview(int reviewId, int adminId) throws SQLException {
        boolean result = adminDAO.updateReviewStatus(reviewId, false);
        if (result) {
            adminDAO.logActivity(adminId, "REVIEW_DEACTIVATED", "Deactivated review ID: " + reviewId, "review", reviewId, null, null);
        }
        return result;
    }
    
    public boolean deleteReview(int reviewId, int adminId) throws SQLException {
        boolean result = adminDAO.deleteReview(reviewId);
        if (result) {
            adminDAO.logActivity(adminId, "REVIEW_DELETED", "Deleted review ID: " + reviewId, "review", reviewId, null, null);
        }
        return result;
    }
    
    // Reports
    public List<Report> getAllReports(String status, int page, int pageSize) throws SQLException {
        return adminDAO.getAllReports(status, page, pageSize);
    }
    
    public Report getReportById(int reportId) throws SQLException {
        return adminDAO.getReportById(reportId);
    }
    
    public boolean updateReportStatus(int reportId, String status, String adminNotes, int adminId) throws SQLException {
        boolean result = adminDAO.updateReportStatus(reportId, status, adminNotes, adminId);
        if (result) {
            adminDAO.logActivity(adminId, "REPORT_UPDATED", "Updated report ID: " + reportId + " to status: " + status, "report", reportId, null, null);
        }
        return result;
    }
    
    // Settings
    public List<SystemSettings> getAllSettings() throws SQLException {
        return adminDAO.getAllSettings();
    }
    
    public SystemSettings getSettingByKey(String key) throws SQLException {
        return adminDAO.getSettingByKey(key);
    }
    
    public boolean updateSetting(String key, String value, int adminId) throws SQLException {
        boolean result = adminDAO.updateSetting(key, value, adminId);
        if (result) {
            adminDAO.logActivity(adminId, "SETTING_UPDATED", "Updated setting: " + key + " = " + value, "setting", null, null, null);
        }
        return result;
    }
    
    // Activity Logs
    public List<ActivityLog> getActivityLogs(int page, int pageSize) throws SQLException {
        return adminDAO.getActivityLogs(page, pageSize);
    }
    
    public void logActivity(Integer userId, String actionType, String actionDescription, 
                           String entityType, Integer entityId, String ipAddress, String userAgent) throws SQLException {
        adminDAO.logActivity(userId, actionType, actionDescription, entityType, entityId, ipAddress, userAgent);
    }
    
    // Graph Data
    public List<Map<String, Object>> getMonthlyRegistrationStats() throws SQLException {
        return adminDAO.getMonthlyRegistrationStats();
    }
    
    public List<Map<String, Object>> getMonthlyRevenueStats() throws SQLException {
        return adminDAO.getMonthlyRevenueStats();
    }
}
