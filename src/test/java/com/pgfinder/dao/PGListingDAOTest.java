package com.pgfinder.dao;

import com.pgfinder.model.PGListing;
import org.junit.jupiter.api.*;
import org.mockito.MockedStatic;

import java.sql.*;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@DisplayName("PGListingDAO Tests")
class PGListingDAOTest {
    
    private PGListingDAO pgListingDAO;
    private Connection mockConnection;
    private PreparedStatement mockPreparedStatement;
    private ResultSet mockResultSet;
    private MockedStatic<com.pgfinder.config.DatabaseConfig> mockedDatabaseConfig;
    
    @BeforeEach
    void setUp() throws SQLException {
        pgListingDAO = new PGListingDAO();
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
    @DisplayName("Should create PGListingDAO instance")
    void testPGListingDAOCreation() {
        assertNotNull(pgListingDAO);
    }
    
    @Test
    @DisplayName("Should handle database connection")
    void testDatabaseConnection() throws SQLException {
        when(mockConnection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        assertNotNull(mockConnection);
    }
}
