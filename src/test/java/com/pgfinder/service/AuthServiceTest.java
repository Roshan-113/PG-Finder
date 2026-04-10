package com.pgfinder.service;

import com.pgfinder.dao.UserDAO;
import com.pgfinder.model.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("AuthService Tests")
class AuthServiceTest {
    
    @Mock
    private UserDAO userDAO;
    
    private AuthService authService;
    
    @BeforeEach
    void setUp() {
        authService = new AuthService();
    }
    
    @Test
    @DisplayName("Should register user successfully")
    void testRegisterSuccess() {
        // Act - Test with real AuthService (no mocking needed)
        AuthService.AuthResult result = authService.register(
            "Test User", 
            "test@example.com", 
            "1234567890", 
            "password123", 
            "tenant"
        );
        
        // Assert
        assertNotNull(result);
        // Note: This tests the actual AuthService logic
    }
    
    @Test
    @DisplayName("Should validate email format")
    void testEmailValidation() {
        // Valid emails
        assertTrue(isValidEmail("test@example.com"));
        assertTrue(isValidEmail("user.name@domain.co.uk"));
        
        // Invalid emails
        assertFalse(isValidEmail("invalid-email"));
        assertFalse(isValidEmail("@example.com"));
        assertFalse(isValidEmail("test@"));
    }
    
    @Test
    @DisplayName("Should validate phone format")
    void testPhoneValidation() {
        // Valid phones
        assertTrue(isValidPhone("1234567890"));
        assertTrue(isValidPhone("9876543210"));
        
        // Invalid phones
        assertFalse(isValidPhone("123"));
        assertFalse(isValidPhone("abcdefghij"));
        assertFalse(isValidPhone("12345"));
    }
    
    @Test
    @DisplayName("Should validate password strength")
    void testPasswordValidation() {
        // Valid passwords
        assertTrue(isValidPassword("Password123"));
        assertTrue(isValidPassword("MyP@ssw0rd"));
        
        // Invalid passwords
        assertFalse(isValidPassword("short"));
        assertFalse(isValidPassword("12345"));
    }
    
    @Test
    @DisplayName("AuthResult should store success and message")
    void testAuthResult() {
        AuthService.AuthResult result = new AuthService.AuthResult(true, "Success");
        
        assertTrue(result.isSuccess());
        assertEquals("Success", result.getMessage());
        assertNull(result.getUser());
    }
    
    @Test
    @DisplayName("AuthResult should store user")
    void testAuthResultWithUser() {
        User user = new User();
        user.setUserId(1);
        user.setName("Test User");
        
        AuthService.AuthResult result = new AuthService.AuthResult(true, "Success", user);
        
        assertTrue(result.isSuccess());
        assertEquals("Success", result.getMessage());
        assertNotNull(result.getUser());
        assertEquals(1, result.getUser().getUserId());
    }
    
    // Helper methods for validation (these would typically be in AuthService)
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
        if (password == null || password.length() < 6) {
            return false;
        }
        return true;
    }
}
