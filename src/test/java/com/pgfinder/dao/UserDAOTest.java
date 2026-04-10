package com.pgfinder.dao;

import com.pgfinder.model.User;
import org.junit.jupiter.api.*;
import org.mockito.MockedStatic;

import java.sql.*;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@DisplayName("UserDAO Tests")
class UserDAOTest {
    
    private UserDAO userDAO;
    private Connection mockConnection;
    private PreparedStatement mockPreparedStatement;
    private ResultSet mockResultSet;
    private MockedStatic<com.pgfinder.config.DatabaseConfig> mockedDatabaseConfig;
    
    @BeforeEach
    void setUp() throws SQLException {
        userDAO = new UserDAO();
        mockConnection = mock(Connection.class);
        mockPreparedStatement = mock(PreparedStatement.class);
        mockResultSet = mock(ResultSet.class);
        
        mockedDatabaseConfig = mockStatic(com.pgfinder.config.DatabaseConfig.class);
        mockedDatabaseConfig.when(com.pgfinder.config.DatabaseConfig::getConnection)
                .thenReturn(mockConnection);
    }
    
    @AfterEach
    void tearDown() {
        if (mockedDatabaseConfig != null) {
            mockedDatabaseConfig.close();
        }
    }
    
    @Test
    @DisplayName("Should register user successfully")
    void testRegisterUserSuccess() throws SQLException {
        // Arrange
        User user = new User("Test User", "test@example.com", "1234567890", "hashedPassword", "tenant");
        user.setEmailVerified(false);
        user.setProfileImage(null);
        
        when(mockConnection.prepareStatement(anyString(), eq(Statement.RETURN_GENERATED_KEYS)))
                .thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeUpdate()).thenReturn(1);
        when(mockPreparedStatement.getGeneratedKeys()).thenReturn(mockResultSet);
        when(mockResultSet.next()).thenReturn(true);
        when(mockResultSet.getInt(1)).thenReturn(1);
        
        // Act
        boolean result = userDAO.registerUser(user);
        
        // Assert
        assertTrue(result);
        assertEquals(1, user.getUserId());
        verify(mockPreparedStatement).setString(1, "Test User");
        verify(mockPreparedStatement).setString(2, "test@example.com");
        verify(mockPreparedStatement).setString(3, "1234567890");
        verify(mockPreparedStatement).setString(4, "hashedPassword");
        verify(mockPreparedStatement).setString(5, "tenant");
    }
    
    @Test
    @DisplayName("Should return false when registration fails")
    void testRegisterUserFailure() throws SQLException {
        // Arrange
        User user = new User("Test User", "test@example.com", "1234567890", "hashedPassword", "tenant");
        
        when(mockConnection.prepareStatement(anyString(), eq(Statement.RETURN_GENERATED_KEYS)))
                .thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeUpdate()).thenReturn(0);
        
        // Act
        boolean result = userDAO.registerUser(user);
        
        // Assert
        assertFalse(result);
    }
    
    @Test
    @DisplayName("Should find user by email")
    void testFindByEmailSuccess() throws SQLException {
        // Arrange
        when(mockConnection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeQuery()).thenReturn(mockResultSet);
        when(mockResultSet.next()).thenReturn(true);
        
        setupMockResultSet();
        
        // Act
        User user = userDAO.findByEmail("test@example.com");
        
        // Assert
        assertNotNull(user);
        assertEquals(1, user.getUserId());
        assertEquals("Test User", user.getName());
        assertEquals("test@example.com", user.getEmail());
        verify(mockPreparedStatement).setString(1, "test@example.com");
    }
    
    @Test
    @DisplayName("Should return null when user not found by email")
    void testFindByEmailNotFound() throws SQLException {
        // Arrange
        when(mockConnection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeQuery()).thenReturn(mockResultSet);
        when(mockResultSet.next()).thenReturn(false);
        
        // Act
        User user = userDAO.findByEmail("notfound@example.com");
        
        // Assert
        assertNull(user);
    }
    
    @Test
    @DisplayName("Should find user by ID")
    void testFindByIdSuccess() throws SQLException {
        // Arrange
        when(mockConnection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeQuery()).thenReturn(mockResultSet);
        when(mockResultSet.next()).thenReturn(true);
        
        setupMockResultSet();
        
        // Act
        User user = userDAO.findById(1);
        
        // Assert
        assertNotNull(user);
        assertEquals(1, user.getUserId());
        verify(mockPreparedStatement).setInt(1, 1);
    }
    
    @Test
    @DisplayName("Should check if email exists")
    void testEmailExists() throws SQLException {
        // Arrange
        when(mockConnection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeQuery()).thenReturn(mockResultSet);
        when(mockResultSet.next()).thenReturn(true);
        when(mockResultSet.getInt(1)).thenReturn(1);
        
        // Act
        boolean exists = userDAO.emailExists("test@example.com");
        
        // Assert
        assertTrue(exists);
    }
    
    @Test
    @DisplayName("Should check if phone exists")
    void testPhoneExists() throws SQLException {
        // Arrange
        when(mockConnection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeQuery()).thenReturn(mockResultSet);
        when(mockResultSet.next()).thenReturn(true);
        when(mockResultSet.getInt(1)).thenReturn(1);
        
        // Act
        boolean exists = userDAO.phoneExists("1234567890");
        
        // Assert
        assertTrue(exists);
    }
    
    @Test
    @DisplayName("Should update last login")
    void testUpdateLastLogin() throws SQLException {
        // Arrange
        when(mockConnection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeUpdate()).thenReturn(1);
        
        // Act
        boolean result = userDAO.updateLastLogin(1);
        
        // Assert
        assertTrue(result);
        verify(mockPreparedStatement).setInt(1, 1);
    }
    
    @Test
    @DisplayName("Should update email verification")
    void testUpdateEmailVerification() throws SQLException {
        // Arrange
        when(mockConnection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeUpdate()).thenReturn(1);
        
        // Act
        boolean result = userDAO.updateEmailVerification(1, true);
        
        // Assert
        assertTrue(result);
        verify(mockPreparedStatement).setBoolean(1, true);
        verify(mockPreparedStatement).setInt(2, 1);
    }
    
    @Test
    @DisplayName("Should update password")
    void testUpdatePassword() throws SQLException {
        // Arrange
        when(mockConnection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeUpdate()).thenReturn(1);
        
        // Act
        boolean result = userDAO.updatePassword(1, "newHashedPassword");
        
        // Assert
        assertTrue(result);
        verify(mockPreparedStatement).setString(1, "newHashedPassword");
        verify(mockPreparedStatement).setInt(2, 1);
    }
    
    @Test
    @DisplayName("Should update user profile")
    void testUpdateUser() throws SQLException {
        // Arrange
        User user = new User();
        user.setUserId(1);
        user.setName("Updated Name");
        user.setPhone("9876543210");
        
        when(mockConnection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeUpdate()).thenReturn(1);
        
        // Act
        boolean result = userDAO.updateUser(user);
        
        // Assert
        assertTrue(result);
        verify(mockPreparedStatement).setString(1, "Updated Name");
        verify(mockPreparedStatement).setString(2, "9876543210");
        verify(mockPreparedStatement).setInt(3, 1);
    }
    
    private void setupMockResultSet() throws SQLException {
        when(mockResultSet.getInt("user_id")).thenReturn(1);
        when(mockResultSet.getString("name")).thenReturn("Test User");
        when(mockResultSet.getString("email")).thenReturn("test@example.com");
        when(mockResultSet.getString("phone")).thenReturn("1234567890");
        when(mockResultSet.getString("password_hash")).thenReturn("hashedPassword");
        when(mockResultSet.getString("user_type")).thenReturn("tenant");
        when(mockResultSet.getString("profile_image")).thenReturn(null);
        when(mockResultSet.getBoolean("is_verified")).thenReturn(false);
        when(mockResultSet.getBoolean("is_active")).thenReturn(true);
        when(mockResultSet.getBoolean("email_verified")).thenReturn(false);
        when(mockResultSet.getBoolean("phone_verified")).thenReturn(false);
        when(mockResultSet.getTimestamp("created_at")).thenReturn(new Timestamp(System.currentTimeMillis()));
        when(mockResultSet.getTimestamp("updated_at")).thenReturn(new Timestamp(System.currentTimeMillis()));
        when(mockResultSet.getTimestamp("last_login")).thenReturn(null);
    }
}
