package com.pgfinder.util;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

import static org.junit.jupiter.api.Assertions.*;

@DisplayName("Validation Utils Tests")
class ValidationUtilsTest {
    
    @ParameterizedTest
    @ValueSource(strings = {
        "test@example.com",
        "user.name@domain.com",
        "user+tag@example.co.uk",
        "user_name@example.org"
    })
    @DisplayName("Should validate correct email formats")
    void testValidEmails(String email) {
        assertTrue(isValidEmail(email));
    }
    
    @ParameterizedTest
    @ValueSource(strings = {
        "invalid-email",
        "@example.com",
        "test@",
        "test@example",
        ""
    })
    @DisplayName("Should reject invalid email formats")
    void testInvalidEmails(String email) {
        assertFalse(isValidEmail(email));
    }
    
    @ParameterizedTest
    @ValueSource(strings = {
        "1234567890",
        "9876543210",
        "0123456789"
    })
    @DisplayName("Should validate correct phone formats")
    void testValidPhones(String phone) {
        assertTrue(isValidPhone(phone));
    }
    
    @ParameterizedTest
    @ValueSource(strings = {
        "123",
        "abcdefghij",
        "12345",
        "123-456-7890",
        "+911234567890",
        ""
    })
    @DisplayName("Should reject invalid phone formats")
    void testInvalidPhones(String phone) {
        assertFalse(isValidPhone(phone));
    }
    
    @Test
    @DisplayName("Should validate password length")
    void testPasswordLength() {
        assertTrue(isValidPassword("password123"));
        assertTrue(isValidPassword("123456"));
        assertFalse(isValidPassword("12345"));
        assertFalse(isValidPassword(""));
    }
    
    @Test
    @DisplayName("Should validate non-empty strings")
    void testNonEmptyString() {
        assertTrue(isNonEmpty("test"));
        assertTrue(isNonEmpty("  test  "));
        assertFalse(isNonEmpty(""));
        assertFalse(isNonEmpty("   "));
        assertFalse(isNonEmpty(null));
    }
    
    @Test
    @DisplayName("Should validate numeric strings")
    void testNumericString() {
        assertTrue(isNumeric("12345"));
        assertTrue(isNumeric("0"));
        assertFalse(isNumeric("12.34"));
        assertFalse(isNumeric("abc"));
        assertFalse(isNumeric(""));
    }
    
    @Test
    @DisplayName("Should validate pincode format")
    void testPincodeValidation() {
        assertTrue(isValidPincode("400001"));
        assertTrue(isValidPincode("110001"));
        assertFalse(isValidPincode("12345"));
        assertFalse(isValidPincode("abcdef"));
        assertFalse(isValidPincode(""));
    }
    
    // Helper validation methods
    private boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
        return email.matches(emailRegex);
    }
    
    private boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return false;
        }
        return phone.matches("^[0-9]{10}$");
    }
    
    private boolean isValidPassword(String password) {
        return password != null && password.length() >= 6;
    }
    
    private boolean isNonEmpty(String str) {
        return str != null && !str.trim().isEmpty();
    }
    
    private boolean isNumeric(String str) {
        if (str == null || str.isEmpty()) {
            return false;
        }
        return str.matches("^[0-9]+$");
    }
    
    private boolean isValidPincode(String pincode) {
        if (pincode == null || pincode.trim().isEmpty()) {
            return false;
        }
        return pincode.matches("^[0-9]{6}$");
    }
}
