package com.pgfinder.dao;

import com.pgfinder.config.DatabaseConfig;
import java.sql.*;

public class SavedPGDAO {
    
    // Save a PG
    public boolean savePG(int tenantId, int listingId) {
        String sql = "INSERT INTO saved_pgs (tenant_id, listing_id) VALUES (?, ?)";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, tenantId);
            pstmt.setInt(2, listingId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Unsave a PG
    public boolean unsavePG(int tenantId, int listingId) {
        String sql = "DELETE FROM saved_pgs WHERE tenant_id = ? AND listing_id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, tenantId);
            pstmt.setInt(2, listingId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Check if PG is saved
    public boolean isSaved(int tenantId, int listingId) {
        String sql = "SELECT COUNT(*) FROM saved_pgs WHERE tenant_id = ? AND listing_id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, tenantId);
            pstmt.setInt(2, listingId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
