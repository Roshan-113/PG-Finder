package com.pgfinder.model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Booking Model Tests")
class BookingTest {
    
    private Booking booking;
    
    @BeforeEach
    void setUp() {
        booking = new Booking();
    }
    
    @Test
    @DisplayName("Should create Booking with default constructor")
    void testDefaultConstructor() {
        assertNotNull(booking);
    }
    
    @Test
    @DisplayName("Should set and get booking ID")
    void testBookingIdGetterSetter() {
        booking.setBookingId(1);
        assertEquals(1, booking.getBookingId());
    }
    
    @Test
    @DisplayName("Should set and get listing ID")
    void testListingIdGetterSetter() {
        booking.setListingId(100);
        assertEquals(100, booking.getListingId());
    }
    
    @Test
    @DisplayName("Should set and get tenant ID")
    void testTenantIdGetterSetter() {
        booking.setTenantId(50);
        assertEquals(50, booking.getTenantId());
    }
    
    @Test
    @DisplayName("Should set and get owner ID")
    void testOwnerIdGetterSetter() {
        booking.setOwnerId(25);
        assertEquals(25, booking.getOwnerId());
    }
    
    @Test
    @DisplayName("Should set and get booking status")
    void testBookingStatusGetterSetter() {
        booking.setBookingStatus("confirmed");
        assertEquals("confirmed", booking.getBookingStatus());
    }
    
    @Test
    @DisplayName("Should set and get payment status")
    void testPaymentStatusGetterSetter() {
        booking.setPaymentStatus("paid");
        assertEquals("paid", booking.getPaymentStatus());
    }
    
    @Test
    @DisplayName("Should set and get rent amount")
    void testRentAmountGetterSetter() {
        BigDecimal amount = new BigDecimal("15000.00");
        booking.setRentAmount(amount);
        assertEquals(amount, booking.getRentAmount());
    }
    
    @Test
    @DisplayName("Should set and get security deposit")
    void testSecurityDepositGetterSetter() {
        BigDecimal deposit = new BigDecimal("30000.00");
        booking.setSecurityDeposit(deposit);
        assertEquals(deposit, booking.getSecurityDeposit());
    }
    
    @Test
    @DisplayName("Should set and get booking date")
    void testBookingDateGetterSetter() {
        Date date = new Date(System.currentTimeMillis());
        booking.setBookingDate(date);
        assertEquals(date, booking.getBookingDate());
    }
    
    @Test
    @DisplayName("Should set and get move in date")
    void testMoveInDateGetterSetter() {
        Date date = new Date(System.currentTimeMillis());
        booking.setMoveInDate(date);
        assertEquals(date, booking.getMoveInDate());
    }
    
    @Test
    @DisplayName("Should set and get special requests")
    void testSpecialRequestsGetterSetter() {
        booking.setSpecialRequests("Need parking space");
        assertEquals("Need parking space", booking.getSpecialRequests());
    }
    
    @Test
    @DisplayName("Should set and get timestamps")
    void testTimestampGetterSetters() {
        Timestamp now = new Timestamp(System.currentTimeMillis());
        
        booking.setCreatedAt(now);
        booking.setUpdatedAt(now);
        
        assertEquals(now, booking.getCreatedAt());
        assertEquals(now, booking.getUpdatedAt());
    }
    
    @Test
    @DisplayName("Should set and get Razorpay order ID")
    void testRazorpayOrderIdGetterSetter() {
        booking.setRazorpayOrderId("order_123456");
        assertEquals("order_123456", booking.getRazorpayOrderId());
    }
    
    @Test
    @DisplayName("Should set and get payment method")
    void testPaymentMethodGetterSetter() {
        booking.setPaymentMethod("UPI");
        assertEquals("UPI", booking.getPaymentMethod());
    }
}
