package com.pgfinder.dao;

import java.sql.*;
import java.util.*;

public class CityDAO {
    private Connection connection;
    
    public CityDAO(Connection connection) {
        this.connection = connection;
    }
    
    // Get all cities with PG count
    public List<Map<String, Object>> getAllCitiesWithCount() throws SQLException {
        List<Map<String, Object>> cities = new ArrayList<>();
        String sql = "SELECT city, state, COUNT(*) as pg_count, " +
                    "SUM(CASE WHEN is_active = 1 THEN 1 ELSE 0 END) as active_count, " +
                    "SUM(CASE WHEN is_verified = 1 THEN 1 ELSE 0 END) as verified_count " +
                    "FROM pg_listings " +
                    "GROUP BY city, state " +
                    "ORDER BY pg_count DESC";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> city = new HashMap<>();
                city.put("city", rs.getString("city"));
                city.put("state", rs.getString("state"));
                city.put("pgCount", rs.getInt("pg_count"));
                city.put("activeCount", rs.getInt("active_count"));
                city.put("verifiedCount", rs.getInt("verified_count"));
                cities.add(city);
            }
        }
        return cities;
    }
    
    // Get distinct cities for dropdown
    public List<String> getDistinctCities() throws SQLException {
        List<String> cities = new ArrayList<>();
        String sql = "SELECT DISTINCT city FROM pg_listings ORDER BY city";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                cities.add(rs.getString("city"));
            }
        }
        return cities;
    }
    
    // Get city statistics
    public Map<String, Object> getCityStatistics(String city) throws SQLException {
        Map<String, Object> stats = new HashMap<>();
        String sql = "SELECT " +
                    "COUNT(*) as total_pgs, " +
                    "SUM(CASE WHEN is_active = 1 THEN 1 ELSE 0 END) as active_pgs, " +
                    "SUM(CASE WHEN is_verified = 1 THEN 1 ELSE 0 END) as verified_pgs, " +
                    "SUM(total_rooms) as total_rooms, " +
                    "SUM(available_rooms) as available_rooms, " +
                    "AVG(rent_per_month) as avg_rent, " +
                    "MIN(rent_per_month) as min_rent, " +
                    "MAX(rent_per_month) as max_rent " +
                    "FROM pg_listings WHERE city = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, city);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    stats.put("totalPgs", rs.getInt("total_pgs"));
                    stats.put("activePgs", rs.getInt("active_pgs"));
                    stats.put("verifiedPgs", rs.getInt("verified_pgs"));
                    stats.put("totalRooms", rs.getInt("total_rooms"));
                    stats.put("availableRooms", rs.getInt("available_rooms"));
                    stats.put("avgRent", rs.getBigDecimal("avg_rent"));
                    stats.put("minRent", rs.getBigDecimal("min_rent"));
                    stats.put("maxRent", rs.getBigDecimal("max_rent"));
                }
            }
        }
        return stats;
    }
}
