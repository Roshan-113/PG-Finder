package com.pgfinder.model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;

import java.math.BigDecimal;
import java.sql.Timestamp;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("PGListing Model Tests")
class PGListingTest {
    
    private PGListing pgListing;
    
    @BeforeEach
    void setUp() {
        pgListing = new PGListing();
    }
    
    @Test
    @DisplayName("Should create PGListing with default constructor")
    void testDefaultConstructor() {
        assertNotNull(pgListing);
    }
    
    @Test
    @DisplayName("Should set and get listing ID")
    void testListingIdGetterSetter() {
        pgListing.setListingId(1);
        assertEquals(1, pgListing.getListingId());
    }
    
    @Test
    @DisplayName("Should set and get owner ID")
    void testOwnerIdGetterSetter() {
        pgListing.setOwnerId(100);
        assertEquals(100, pgListing.getOwnerId());
    }
    
    @Test
    @DisplayName("Should set and get title")
    void testTitleGetterSetter() {
        pgListing.setTitle("Comfortable PG near Metro");
        assertEquals("Comfortable PG near Metro", pgListing.getTitle());
    }
    
    @Test
    @DisplayName("Should set and get description")
    void testDescriptionGetterSetter() {
        String description = "Spacious rooms with all amenities";
        pgListing.setDescription(description);
        assertEquals(description, pgListing.getDescription());
    }
    
    @Test
    @DisplayName("Should set and get address")
    void testAddressGetterSetter() {
        pgListing.setAddress("123 Main Street");
        assertEquals("123 Main Street", pgListing.getAddress());
    }
    
    @Test
    @DisplayName("Should set and get city")
    void testCityGetterSetter() {
        pgListing.setCity("Mumbai");
        assertEquals("Mumbai", pgListing.getCity());
    }
    
    @Test
    @DisplayName("Should set and get state")
    void testStateGetterSetter() {
        pgListing.setState("Maharashtra");
        assertEquals("Maharashtra", pgListing.getState());
    }
    
    @Test
    @DisplayName("Should set and get pincode")
    void testPincodeGetterSetter() {
        pgListing.setPincode("400001");
        assertEquals("400001", pgListing.getPincode());
    }
    
    @Test
    @DisplayName("Should set and get rent per month")
    void testRentPerMonthGetterSetter() {
        BigDecimal rent = new BigDecimal("8000.00");
        pgListing.setRentPerMonth(rent);
        assertEquals(rent, pgListing.getRentPerMonth());
    }
    
    @Test
    @DisplayName("Should set and get security deposit")
    void testSecurityDepositGetterSetter() {
        BigDecimal deposit = new BigDecimal("16000.00");
        pgListing.setSecurityDeposit(deposit);
        assertEquals(deposit, pgListing.getSecurityDeposit());
    }
    
    @Test
    @DisplayName("Should set and get PG type")
    void testPgTypeGetterSetter() {
        pgListing.setPgType("Boys");
        assertEquals("Boys", pgListing.getPgType());
    }
    
    @Test
    @DisplayName("Should set and get total rooms")
    void testTotalRoomsGetterSetter() {
        pgListing.setTotalRooms(10);
        assertEquals(10, pgListing.getTotalRooms());
    }
    
    @Test
    @DisplayName("Should set and get available rooms")
    void testAvailableRoomsGetterSetter() {
        pgListing.setAvailableRooms(5);
        assertEquals(5, pgListing.getAvailableRooms());
    }
    
    @Test
    @DisplayName("Should set and get food included")
    void testFoodIncludedGetterSetter() {
        pgListing.setFoodIncluded(true);
        assertTrue(pgListing.isFoodIncluded());
    }
    
    @Test
    @DisplayName("Should set and get WiFi available")
    void testWifiAvailableGetterSetter() {
        pgListing.setWifiAvailable(true);
        assertTrue(pgListing.isWifiAvailable());
    }
    
    @Test
    @DisplayName("Should set and get AC available")
    void testAcAvailableGetterSetter() {
        pgListing.setAcAvailable(false);
        assertFalse(pgListing.isAcAvailable());
    }
    
    @Test
    @DisplayName("Should set and get parking available")
    void testParkingAvailableGetterSetter() {
        pgListing.setParkingAvailable(true);
        assertTrue(pgListing.isParkingAvailable());
    }
    
    @Test
    @DisplayName("Should set and get laundry available")
    void testLaundryAvailableGetterSetter() {
        pgListing.setLaundryAvailable(true);
        assertTrue(pgListing.isLaundryAvailable());
    }
    
    @Test
    @DisplayName("Should set and get verified status")
    void testVerifiedGetterSetter() {
        pgListing.setVerified(true);
        assertTrue(pgListing.isVerified());
    }
    
    @Test
    @DisplayName("Should set and get active status")
    void testActiveGetterSetter() {
        pgListing.setActive(true);
        assertTrue(pgListing.isActive());
    }
    
    @Test
    @DisplayName("Should set and get timestamps")
    void testTimestampGetterSetters() {
        Timestamp now = new Timestamp(System.currentTimeMillis());
        
        pgListing.setCreatedAt(now);
        pgListing.setUpdatedAt(now);
        
        assertEquals(now, pgListing.getCreatedAt());
        assertEquals(now, pgListing.getUpdatedAt());
    }
    
    @Test
    @DisplayName("Should set and get amenities")
    void testAmenitiesGetterSetter() {
        pgListing.setAmenities("WiFi, AC, Laundry");
        assertEquals("WiFi, AC, Laundry", pgListing.getAmenities());
    }
    
    @Test
    @DisplayName("Should set and get rules")
    void testRulesGetterSetter() {
        pgListing.setRules("No smoking, No pets");
        assertEquals("No smoking, No pets", pgListing.getRules());
    }
}
