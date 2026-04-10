package com.pgfinder.dao;

import com.pgfinder.config.DatabaseConfig;
import com.pgfinder.model.Booking;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    
    // Create new booking
    public boolean createBooking(Booking booking) {
        String sql = "INSERT INTO bookings (tenant_id, listing_id, owner_id, booking_date, move_in_date, " +
                    "rent_amount, security_deposit, special_requests) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setInt(1, booking.getTenantId());
            pstmt.setInt(2, booking.getListingId());
            pstmt.setInt(3, booking.getOwnerId());
            pstmt.setDate(4, booking.getBookingDate());
            pstmt.setDate(5, booking.getMoveInDate());
            pstmt.setBigDecimal(6, booking.getRentAmount());
            pstmt.setBigDecimal(7, booking.getSecurityDeposit());
            pstmt.setString(8, booking.getSpecialRequests());
            
            int affected = pstmt.executeUpdate();
            if (affected > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    booking.setBookingId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Get bookings by tenant
    public List<Booking> getBookingsByTenant(int tenantId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, l.title as pg_title, l.address as pg_address, " +
                    "u.name as owner_name, u.phone as owner_phone " +
                    "FROM bookings b " +
                    "JOIN pg_listings l ON b.listing_id = l.listing_id " +
                    "JOIN users u ON b.owner_id = u.user_id " +
                    "WHERE b.tenant_id = ? " +
                    "ORDER BY b.created_at DESC";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, tenantId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                bookings.add(extractBookingFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }
    
    // Get booking by ID
    public Booking getBookingById(int bookingId) {
        String sql = "SELECT b.*, l.title as pg_title, l.address as pg_address, " +
                    "u.name as owner_name, u.phone as owner_phone, " +
                    "t.name as tenant_name, t.email as tenant_email, t.phone as tenant_phone " +
                    "FROM bookings b " +
                    "JOIN pg_listings l ON b.listing_id = l.listing_id " +
                    "JOIN users u ON b.owner_id = u.user_id " +
                    "JOIN users t ON b.tenant_id = t.user_id " +
                    "WHERE b.booking_id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookingId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Booking booking = extractBookingFromResultSet(rs);
                booking.setTenantName(rs.getString("tenant_name"));
                booking.setTenantEmail(rs.getString("tenant_email"));
                booking.setTenantPhone(rs.getString("tenant_phone"));
                return booking;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Cancel booking
    public boolean cancelBooking(int bookingId, int tenantId) {
        // First check if booking exists and belongs to tenant
        String checkSql = "SELECT booking_status FROM bookings WHERE booking_id = ? AND tenant_id = ?";
        String updateSql = "UPDATE bookings SET booking_status = 'cancelled' WHERE booking_id = ? AND tenant_id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            // Check booking status
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, bookingId);
                checkStmt.setInt(2, tenantId);
                ResultSet rs = checkStmt.executeQuery();
                
                if (!rs.next()) {
                    System.out.println("Booking not found or doesn't belong to tenant");
                    return false;
                }
                
                String currentStatus = rs.getString("booking_status");
                System.out.println("Current booking status: " + currentStatus);
                
                // Don't allow cancellation of already cancelled or completed bookings
                if ("cancelled".equals(currentStatus) || "completed".equals(currentStatus)) {
                    System.out.println("Cannot cancel booking with status: " + currentStatus);
                    return false;
                }
            }
            
            // Update booking status
            try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                updateStmt.setInt(1, bookingId);
                updateStmt.setInt(2, tenantId);
                int affected = updateStmt.executeUpdate();
                System.out.println("Rows affected: " + affected);
                return affected > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Update payment status
    public boolean updatePaymentStatus(int bookingId, String paymentStatus, String bookingStatus) {
        String sql = "UPDATE bookings SET payment_status = ?, booking_status = ? WHERE booking_id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, paymentStatus);
            pstmt.setString(2, bookingStatus);
            pstmt.setInt(3, bookingId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Update Razorpay order ID
    public boolean updateRazorpayOrderId(int bookingId, String razorpayOrderId) {
        String sql = "UPDATE bookings SET razorpay_order_id = ? WHERE booking_id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, razorpayOrderId);
            pstmt.setInt(2, bookingId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Update payment details after successful payment
    public boolean updatePaymentDetails(int bookingId, String razorpayOrderId, 
                                       String razorpayPaymentId, String razorpaySignature,
                                       String paymentStatus, String bookingStatus) {
        String sql = "UPDATE bookings SET razorpay_order_id = ?, razorpay_payment_id = ?, " +
                    "razorpay_signature = ?, payment_status = ?, booking_status = ? WHERE booking_id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, razorpayOrderId);
            pstmt.setString(2, razorpayPaymentId);
            pstmt.setString(3, razorpaySignature);
            pstmt.setString(4, paymentStatus);
            pstmt.setString(5, bookingStatus);
            pstmt.setInt(6, bookingId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private Booking extractBookingFromResultSet(ResultSet rs) throws SQLException {
        Booking booking = new Booking();
        booking.setBookingId(rs.getInt("booking_id"));
        booking.setTenantId(rs.getInt("tenant_id"));
        booking.setListingId(rs.getInt("listing_id"));
        booking.setOwnerId(rs.getInt("owner_id"));
        booking.setBookingDate(rs.getDate("booking_date"));
        booking.setMoveInDate(rs.getDate("move_in_date"));
        booking.setRentAmount(rs.getBigDecimal("rent_amount"));
        booking.setSecurityDeposit(rs.getBigDecimal("security_deposit"));
        booking.setBookingStatus(rs.getString("booking_status"));
        booking.setPaymentStatus(rs.getString("payment_status"));
        booking.setSpecialRequests(rs.getString("special_requests"));
        booking.setCreatedAt(rs.getTimestamp("created_at"));
        booking.setUpdatedAt(rs.getTimestamp("updated_at"));
        booking.setPgTitle(rs.getString("pg_title"));
        booking.setPgAddress(rs.getString("pg_address"));
        booking.setOwnerName(rs.getString("owner_name"));
        booking.setOwnerPhone(rs.getString("owner_phone"));
        
        // Set room number if exists
        try {
            booking.setRoomNumber(rs.getString("room_number"));
        } catch (SQLException e) {
            // Column might not exist in older schema
        }
        
        // Set Razorpay fields if they exist
        try {
            booking.setRazorpayOrderId(rs.getString("razorpay_order_id"));
            booking.setRazorpayPaymentId(rs.getString("razorpay_payment_id"));
            booking.setRazorpaySignature(rs.getString("razorpay_signature"));
        } catch (SQLException e) {
            // Columns might not exist in older schema
        }
        
        return booking;
    }
}
