package com.pgfinder.service;

import com.pgfinder.dao.UserDAO;
import com.pgfinder.model.User;
import com.pgfinder.util.PasswordUtil;
import com.pgfinder.util.TokenGenerator;
import com.pgfinder.util.ValidationUtil;
import com.pgfinder.config.DatabaseConfig;
import java.sql.*;
import java.time.LocalDateTime;

public class AuthService {
    private UserDAO userDAO;
    private EmailService emailService;
    
    public AuthService() {
        this.userDAO = new UserDAO();
        this.emailService = new EmailService();
    }
    
    // Register new user
    public AuthResult register(String name, String email, String phone, String password, String userType) {
        // Validate inputs
        if (!ValidationUtil.isNotEmpty(name)) {
            return new AuthResult(false, "Name is required");
        }
        if (!ValidationUtil.isValidEmail(email)) {
            return new AuthResult(false, "Invalid email format");
        }
        if (!ValidationUtil.isValidPhone(phone)) {
            return new AuthResult(false, "Invalid phone number. Must be 10 digits starting with 6-9");
        }
        if (!ValidationUtil.isValidPassword(password)) {
            return new AuthResult(false, "Password must be at least 8 characters with uppercase, lowercase, number and special character");
        }
        
        // Check if email already exists
        if (userDAO.emailExists(email)) {
            return new AuthResult(false, "Email already registered");
        }
        
        // Check if phone already exists
        if (userDAO.phoneExists(phone)) {
            return new AuthResult(false, "Phone number already registered");
        }
        
        // Hash password
        String passwordHash = PasswordUtil.hashPassword(password);
        
        // Create user
        User user = new User(name, email, phone, passwordHash, userType);
        
        if (userDAO.registerUser(user)) {
            // Generate verification token
            String token = TokenGenerator.generateToken();
            saveEmailVerificationToken(user.getUserId(), token);
            
            // Send verification email
            String verificationLink = "http://localhost:8082/pg-finder/verify-email?token=" + token;
            emailService.sendVerificationEmail(email, name, verificationLink);
            
            return new AuthResult(true, "Registration successful. Please check your email to verify your account.", user);
        }
        
        return new AuthResult(false, "Registration failed. Please try again.");
    }
    
    // Login user
    public AuthResult login(String email, String password, String userType) {
        // Validate inputs
        if (!ValidationUtil.isValidEmail(email)) {
            return new AuthResult(false, "Invalid email format");
        }
        if (!ValidationUtil.isNotEmpty(password)) {
            return new AuthResult(false, "Password is required");
        }
        
        // Find user
        User user = userDAO.findByEmail(email);
        
        if (user == null) {
            return new AuthResult(false, "Invalid email or password");
        }
        
        // Verify password
        if (!PasswordUtil.verifyPassword(password, user.getPasswordHash())) {
            return new AuthResult(false, "Invalid email or password");
        }
        
        // Check user type
        if (!user.getUserType().equals(userType)) {
            return new AuthResult(false, "Invalid user type. Please use the correct login page.");
        }
        
        // Check if account is active
        if (!user.isActive()) {
            return new AuthResult(false, "Your account has been deactivated. Please contact support.");
        }
        
        // Update last login
        userDAO.updateLastLogin(user.getUserId());
        
        return new AuthResult(true, "Login successful", user);
    }
    
    // Verify email
    public boolean verifyEmail(String token) {
        try (Connection conn = DatabaseConfig.getConnection()) {
            String sql = "SELECT user_id, expires_at FROM email_verification_tokens WHERE token = ? AND is_used = FALSE";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, token);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                int userId = rs.getInt("user_id");
                Timestamp expiresAt = rs.getTimestamp("expires_at");
                
                // Check if token expired
                if (expiresAt.before(new Timestamp(System.currentTimeMillis()))) {
                    return false;
                }
                
                // Mark token as used
                String updateTokenSql = "UPDATE email_verification_tokens SET is_used = TRUE WHERE token = ?";
                PreparedStatement updatePstmt = conn.prepareStatement(updateTokenSql);
                updatePstmt.setString(1, token);
                updatePstmt.executeUpdate();
                
                // Update user email verification status
                userDAO.updateEmailVerification(userId, true);
                
                // Get user and send welcome email
                User user = userDAO.findById(userId);
                if (user != null) {
                    emailService.sendWelcomeEmail(user.getEmail(), user.getName(), user.getUserType());
                }
                
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Request password reset
    public boolean requestPasswordReset(String email) {
        System.out.println("Password reset requested for email: " + email);
        
        User user = userDAO.findByEmail(email);
        if (user == null) {
            System.out.println("User not found for email: " + email);
            // Return true anyway for security (don't reveal if email exists)
            return true;
        }
        
        System.out.println("User found: " + user.getName() + " (ID: " + user.getUserId() + ")");
        
        // Generate reset token
        String token = TokenGenerator.generateToken();
        System.out.println("Generated token: " + token);
        
        savePasswordResetToken(user.getUserId(), token);
        System.out.println("Token saved to database");
        
        // Send reset email
        String resetLink = "http://localhost:8082/pg-finder/reset-password?token=" + token;
        System.out.println("Attempting to send email to: " + email);
        
        boolean emailSent = emailService.sendPasswordResetEmail(email, user.getName(), resetLink);
        System.out.println("Email sent status: " + emailSent);
        
        return emailSent;
    }
    
    // Reset password
    public boolean resetPassword(String token, String newPassword) {
        if (!ValidationUtil.isValidPassword(newPassword)) {
            return false;
        }
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            String sql = "SELECT user_id, expires_at FROM password_reset_tokens WHERE token = ? AND is_used = FALSE";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, token);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                int userId = rs.getInt("user_id");
                Timestamp expiresAt = rs.getTimestamp("expires_at");
                
                // Check if token expired
                if (expiresAt.before(new Timestamp(System.currentTimeMillis()))) {
                    return false;
                }
                
                // Mark token as used
                String updateTokenSql = "UPDATE password_reset_tokens SET is_used = TRUE WHERE token = ?";
                PreparedStatement updatePstmt = conn.prepareStatement(updateTokenSql);
                updatePstmt.setString(1, token);
                updatePstmt.executeUpdate();
                
                // Update password
                String passwordHash = PasswordUtil.hashPassword(newPassword);
                return userDAO.updatePassword(userId, passwordHash);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Save email verification token
    private void saveEmailVerificationToken(int userId, String token) {
        try (Connection conn = DatabaseConfig.getConnection()) {
            String sql = "INSERT INTO email_verification_tokens (user_id, token, expires_at) VALUES (?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setString(2, token);
            pstmt.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now().plusHours(24)));
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Save password reset token
    private void savePasswordResetToken(int userId, String token) {
        try (Connection conn = DatabaseConfig.getConnection()) {
            String sql = "INSERT INTO password_reset_tokens (user_id, token, expires_at) VALUES (?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setString(2, token);
            pstmt.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now().plusHours(1)));
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Inner class for authentication result
    public static class AuthResult {
        private boolean success;
        private String message;
        private User user;
        
        public AuthResult(boolean success, String message) {
            this.success = success;
            this.message = message;
        }
        
        public AuthResult(boolean success, String message, User user) {
            this.success = success;
            this.message = message;
            this.user = user;
        }
        
        public boolean isSuccess() { return success; }
        public String getMessage() { return message; }
        public User getUser() { return user; }
    }
}
