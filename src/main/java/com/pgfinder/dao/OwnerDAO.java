package com.pgfinder.dao;

import com.pgfinder.config.DatabaseConfig;
import com.pgfinder.model.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

public class OwnerDAO {
    
    // Get owner dashboard statistics
    public Map<String, Object> getDashboardStats(int ownerId) {
        Map<String, Object> stats = new HashMap<>();
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            // Total listings
            String sql1 = "SELECT COUNT(*) FROM pg_listings WHERE owner_id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql1)) {
                pstmt.setInt(1, ownerId);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) stats.put("totalListings", rs.getInt(1));
            }
            
            // Active bookings (only count bookings within 1 month from move-in date)
            String sql2 = "SELECT COUNT(*) FROM bookings WHERE owner_id = ? AND booking_status = 'confirmed' " +
                         "AND DATE_ADD(move_in_date, INTERVAL 1 MONTH) > NOW()";
            try (PreparedStatement pstmt = conn.prepareStatement(sql2)) {
                pstmt.setInt(1, ownerId);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) stats.put("activeBookings", rs.getInt(1));
            }
            
            // Total earnings
            String sql3 = "SELECT COALESCE(SUM(amount), 0) FROM earnings WHERE owner_id = ? AND status = 'completed'";
            try (PreparedStatement pstmt = conn.prepareStatement(sql3)) {
                pstmt.setInt(1, ownerId);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) stats.put("totalEarnings", rs.getBigDecimal(1));
            }
            
            // Pending inquiries
            String sql4 = "SELECT COUNT(*) FROM inquiries WHERE owner_id = ? AND status = 'pending'";
            try (PreparedStatement pstmt = conn.prepareStatement(sql4)) {
                pstmt.setInt(1, ownerId);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) stats.put("pendingInquiries", rs.getInt(1));
            }
            
            // Available rooms
            String sql5 = "SELECT COALESCE(SUM(available_rooms), 0) FROM pg_listings WHERE owner_id = ? AND is_active = TRUE";
            try (PreparedStatement pstmt = conn.prepareStatement(sql5)) {
                pstmt.setInt(1, ownerId);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) stats.put("availableRooms", rs.getInt(1));
            }
            
            // Average rating
            String sql6 = "SELECT COALESCE(AVG(r.rating), 0) FROM reviews r " +
                         "JOIN pg_listings l ON r.listing_id = l.listing_id " +
                         "WHERE l.owner_id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql6)) {
                pstmt.setInt(1, ownerId);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) stats.put("averageRating", rs.getDouble(1));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return stats;
    }
    
    // Get recent bookings (exclude bookings where 1 month has passed since move-in date)
    public List<Booking> getRecentBookings(int ownerId, int limit) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, l.title as pg_title, u.name as tenant_name, u.phone as tenant_phone " +
                    "FROM bookings b " +
                    "JOIN pg_listings l ON b.listing_id = l.listing_id " +
                    "JOIN users u ON b.tenant_id = u.user_id " +
                    "WHERE b.owner_id = ? " +
                    "AND DATE_ADD(b.move_in_date, INTERVAL 1 MONTH) > NOW() " +
                    "ORDER BY b.created_at DESC LIMIT ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, ownerId);
            pstmt.setInt(2, limit);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setTenantId(rs.getInt("tenant_id"));
                booking.setListingId(rs.getInt("listing_id"));
                booking.setBookingDate(rs.getDate("booking_date"));
                booking.setMoveInDate(rs.getDate("move_in_date"));
                booking.setRentAmount(rs.getBigDecimal("rent_amount"));
                booking.setBookingStatus(rs.getString("booking_status"));
                booking.setPaymentStatus(rs.getString("payment_status"));
                booking.setPgTitle(rs.getString("pg_title"));
                booking.setTenantName(rs.getString("tenant_name"));
                booking.setTenantPhone(rs.getString("tenant_phone"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }
    
    // Get all bookings for owner (exclude bookings where 1 month has passed since move-in date)
    public List<Booking> getAllBookings(int ownerId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, l.title as pg_title, l.address as pg_address, " +
                    "u.name as tenant_name, u.email as tenant_email, u.phone as tenant_phone " +
                    "FROM bookings b " +
                    "JOIN pg_listings l ON b.listing_id = l.listing_id " +
                    "JOIN users u ON b.tenant_id = u.user_id " +
                    "WHERE b.owner_id = ? " +
                    "AND DATE_ADD(b.move_in_date, INTERVAL 1 MONTH) > NOW() " +
                    "ORDER BY b.created_at DESC";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, ownerId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setTenantId(rs.getInt("tenant_id"));
                booking.setListingId(rs.getInt("listing_id"));
                booking.setBookingDate(rs.getDate("booking_date"));
                booking.setMoveInDate(rs.getDate("move_in_date"));
                booking.setRentAmount(rs.getBigDecimal("rent_amount"));
                booking.setSecurityDeposit(rs.getBigDecimal("security_deposit"));
                booking.setBookingStatus(rs.getString("booking_status"));
                booking.setPaymentStatus(rs.getString("payment_status"));
                booking.setSpecialRequests(rs.getString("special_requests"));
                booking.setCreatedAt(rs.getTimestamp("created_at"));
                booking.setPgTitle(rs.getString("pg_title"));
                booking.setPgAddress(rs.getString("pg_address"));
                booking.setTenantName(rs.getString("tenant_name"));
                booking.setTenantEmail(rs.getString("tenant_email"));
                booking.setTenantPhone(rs.getString("tenant_phone"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }
    
    // Update booking status
    public boolean updateBookingStatus(int bookingId, int ownerId, String status) {
        String sql = "UPDATE bookings SET booking_status = ? WHERE booking_id = ? AND owner_id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            pstmt.setInt(2, bookingId);
            pstmt.setInt(3, ownerId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Get earnings
    public List<Earning> getEarnings(int ownerId) {
        List<Earning> earnings = new ArrayList<>();
        String sql = "SELECT e.*, u.name as tenant_name, l.title as listing_title " +
                    "FROM earnings e " +
                    "JOIN bookings b ON e.booking_id = b.booking_id " +
                    "JOIN users u ON b.tenant_id = u.user_id " +
                    "JOIN pg_listings l ON b.listing_id = l.listing_id " +
                    "WHERE e.owner_id = ? " +
                    "ORDER BY e.transaction_date DESC";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, ownerId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Earning earning = new Earning();
                earning.setEarningId(rs.getInt("earning_id"));
                earning.setBookingId(rs.getInt("booking_id"));
                earning.setAmount(rs.getBigDecimal("amount"));
                earning.setTransactionType(rs.getString("transaction_type"));
                earning.setTransactionDate(rs.getDate("transaction_date"));
                earning.setPaymentMethod(rs.getString("payment_method"));
                earning.setStatus(rs.getString("status"));
                earning.setTenantName(rs.getString("tenant_name"));
                earning.setListingTitle(rs.getString("listing_title"));
                earnings.add(earning);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return earnings;
    }
    
    // Get inquiries
    public List<Inquiry> getInquiries(int ownerId) {
        List<Inquiry> inquiries = new ArrayList<>();
        String sql = "SELECT i.*, u.name as tenant_name, u.email as tenant_email, u.phone as tenant_phone, " +
                    "l.title as listing_title " +
                    "FROM inquiries i " +
                    "JOIN users u ON i.tenant_id = u.user_id " +
                    "JOIN pg_listings l ON i.listing_id = l.listing_id " +
                    "WHERE i.owner_id = ? " +
                    "ORDER BY i.created_at DESC";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, ownerId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Inquiry inquiry = new Inquiry();
                inquiry.setInquiryId(rs.getInt("inquiry_id"));
                inquiry.setListingId(rs.getInt("listing_id"));
                inquiry.setTenantId(rs.getInt("tenant_id"));
                inquiry.setInquiryText(rs.getString("inquiry_text"));
                inquiry.setResponseText(rs.getString("response_text"));
                inquiry.setStatus(rs.getString("status"));
                inquiry.setCreatedAt(rs.getTimestamp("created_at"));
                inquiry.setRespondedAt(rs.getTimestamp("responded_at"));
                inquiry.setTenantName(rs.getString("tenant_name"));
                inquiry.setTenantEmail(rs.getString("tenant_email"));
                inquiry.setTenantPhone(rs.getString("tenant_phone"));
                inquiry.setListingTitle(rs.getString("listing_title"));
                inquiries.add(inquiry);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return inquiries;
    }
    
    // Respond to inquiry
    public boolean respondToInquiry(int inquiryId, int ownerId, String responseText) {
        String sql = "UPDATE inquiries SET response_text = ?, status = 'responded', responded_at = NOW() " +
                    "WHERE inquiry_id = ? AND owner_id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            System.out.println("Responding to inquiry " + inquiryId + " for owner " + ownerId);
            
            pstmt.setString(1, responseText);
            pstmt.setInt(2, inquiryId);
            pstmt.setInt(3, ownerId);
            
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("SQL Error responding to inquiry: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    // Get reviews for owner's listings
    public List<Map<String, Object>> getOwnerReviews(int ownerId) {
        List<Map<String, Object>> reviews = new ArrayList<>();
        String sql = "SELECT r.*, u.name as tenant_name, l.title as listing_title " +
                    "FROM reviews r " +
                    "JOIN users u ON r.tenant_id = u.user_id " +
                    "JOIN pg_listings l ON r.listing_id = l.listing_id " +
                    "WHERE l.owner_id = ? AND r.is_active = TRUE " +
                    "ORDER BY r.created_at DESC";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, ownerId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> review = new HashMap<>();
                review.put("reviewId", rs.getInt("review_id"));
                review.put("listingId", rs.getInt("listing_id"));
                review.put("rating", rs.getInt("rating"));
                review.put("reviewText", rs.getString("review_text"));
                review.put("tenantName", rs.getString("tenant_name"));
                review.put("listingTitle", rs.getString("listing_title"));
                review.put("createdAt", rs.getTimestamp("created_at"));
                reviews.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }
}
