package com.pgfinder.model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;

import java.sql.Timestamp;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

@DisplayName("User Model Tests")
class UserTest {
    
    private User user;
    
    @BeforeEach
    void setUp() {
        user = new User();
    }
    
    @Test
    @DisplayName("Should create user with default constructor")
    void testDefaultConstructor() {
        assertNotNull(user);
        assertEquals(0, user.getUserId());
    }
    
    @Test
    @DisplayName("Should create user with parameterized constructor")
    void testParameterizedConstructor() {
        User newUser = new User("John Doe", "john@example.com", "1234567890", "hashedPassword", "tenant");
        
        assertThat(newUser.getName()).isEqualTo("John Doe");
        assertThat(newUser.getEmail()).isEqualTo("john@example.com");
        assertThat(newUser.getPhone()).isEqualTo("1234567890");
        assertThat(newUser.getPasswordHash()).isEqualTo("hashedPassword");
        assertThat(newUser.getUserType()).isEqualTo("tenant");
    }
    
    @Test
    @DisplayName("Should set and get user ID")
    void testUserIdGetterSetter() {
        user.setUserId(123);
        assertEquals(123, user.getUserId());
    }
    
    @Test
    @DisplayName("Should set and get name")
    void testNameGetterSetter() {
        user.setName("Jane Smith");
        assertEquals("Jane Smith", user.getName());
    }
    
    @Test
    @DisplayName("Should set and get email")
    void testEmailGetterSetter() {
        user.setEmail("jane@example.com");
        assertEquals("jane@example.com", user.getEmail());
    }
    
    @Test
    @DisplayName("Should set and get phone")
    void testPhoneGetterSetter() {
        user.setPhone("9876543210");
        assertEquals("9876543210", user.getPhone());
    }
    
    @Test
    @DisplayName("Should set and get password hash")
    void testPasswordHashGetterSetter() {
        user.setPasswordHash("$2a$10$hashedPassword");
        assertEquals("$2a$10$hashedPassword", user.getPasswordHash());
    }
    
    @Test
    @DisplayName("Should set and get user type")
    void testUserTypeGetterSetter() {
        user.setUserType("owner");
        assertEquals("owner", user.getUserType());
    }
    
    @Test
    @DisplayName("Should set and get profile image")
    void testProfileImageGetterSetter() {
        user.setProfileImage("profile.jpg");
        assertEquals("profile.jpg", user.getProfileImage());
    }
    
    @Test
    @DisplayName("Should set and get verified status")
    void testVerifiedGetterSetter() {
        user.setVerified(true);
        assertTrue(user.isVerified());
    }
    
    @Test
    @DisplayName("Should set and get active status")
    void testActiveGetterSetter() {
        user.setActive(true);
        assertTrue(user.isActive());
    }
    
    @Test
    @DisplayName("Should set and get email verified status")
    void testEmailVerifiedGetterSetter() {
        user.setEmailVerified(true);
        assertTrue(user.isEmailVerified());
    }
    
    @Test
    @DisplayName("Should set and get phone verified status")
    void testPhoneVerifiedGetterSetter() {
        user.setPhoneVerified(true);
        assertTrue(user.isPhoneVerified());
    }
    
    @Test
    @DisplayName("Should set and get timestamps")
    void testTimestampGetterSetters() {
        Timestamp now = new Timestamp(System.currentTimeMillis());
        
        user.setCreatedAt(now);
        user.setUpdatedAt(now);
        user.setLastLogin(now);
        
        assertEquals(now, user.getCreatedAt());
        assertEquals(now, user.getUpdatedAt());
        assertEquals(now, user.getLastLogin());
    }
    
    @Test
    @DisplayName("Should use password alias methods")
    void testPasswordAliasMethods() {
        user.setPassword("hashedPassword");
        assertEquals("hashedPassword", user.getPassword());
        assertEquals("hashedPassword", user.getPasswordHash());
    }
}
