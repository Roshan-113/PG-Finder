package com.pgfinder.dao;

import com.pgfinder.config.DatabaseConfig;
import com.pgfinder.model.PGListing;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PGListingDAO {
    
    // Get all active PG listings
    public List<PGListing> getAllListings() {
        List<PGListing> listings = new ArrayList<>();
        String sql = "SELECT l.*, u.name as owner_name, u.phone as owner_phone, " +
                    "COALESCE(AVG(r.rating), 0) as avg_rating, COUNT(r.review_id) as review_count " +
                    "FROM pg_listings l " +
                    "JOIN users u ON l.owner_id = u.user_id " +
                    "LEFT JOIN reviews r ON l.listing_id = r.listing_id " +
                    "WHERE l.is_active = TRUE " +
                    "GROUP BY l.listing_id " +
                    "ORDER BY l.created_at DESC";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                listings.add(extractListingFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listings;
    }
    
    // Search listings with filters
    public List<PGListing> searchListings(String city, String pgType, Double minRent, Double maxRent) {
        return searchListings(city, pgType, null, null, minRent, maxRent);
    }
    
    public List<PGListing> searchListings(String city, String pgType, String gender, String amenities, Double minRent, Double maxRent) {
        List<PGListing> listings = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT l.*, u.name as owner_name, u.phone as owner_phone, " +
            "COALESCE(AVG(r.rating), 0) as avg_rating, COUNT(r.review_id) as review_count " +
            "FROM pg_listings l " +
            "JOIN users u ON l.owner_id = u.user_id " +
            "LEFT JOIN reviews r ON l.listing_id = r.listing_id " +
            "WHERE l.is_active = TRUE "
        );
        
        List<Object> params = new ArrayList<>();
        
        System.out.println("=== Building Search Query ===");
        
        if (city != null && !city.isEmpty()) {
            sql.append("AND l.city LIKE ? ");
            params.add("%" + city + "%");
            System.out.println("Added city filter: " + city);
        }
        
        if (pgType != null && !pgType.isEmpty() && !pgType.equals("all")) {
            sql.append("AND l.pg_type = ? ");
            params.add(pgType);
            System.out.println("Added pgType filter: " + pgType);
        }
        
        // Note: gender filter maps to pg_type (boys/girls), not a separate column
        // The database doesn't have a gender_preference column
        
        if (amenities != null && !amenities.isEmpty()) {
            String[] amenityList = amenities.split(",");
            System.out.println("Processing amenities: " + amenities);
            for (String amenity : amenityList) {
                amenity = amenity.trim();
                switch (amenity.toLowerCase()) {
                    case "wifi":
                        sql.append("AND l.wifi_available = TRUE ");
                        System.out.println("Added WiFi filter");
                        break;
                    case "ac":
                        sql.append("AND l.ac_available = TRUE ");
                        System.out.println("Added AC filter");
                        break;
                    case "food":
                        sql.append("AND l.food_included = TRUE ");
                        System.out.println("Added Food filter");
                        break;
                    case "parking":
                        sql.append("AND l.parking_available = TRUE ");
                        System.out.println("Added Parking filter");
                        break;
                    case "laundry":
                        sql.append("AND l.laundry_available = TRUE ");
                        System.out.println("Added Laundry filter");
                        break;
                }
            }
        }
        
        if (minRent != null) {
            sql.append("AND l.rent_per_month >= ? ");
            params.add(minRent);
            System.out.println("Added minRent filter: " + minRent);
        }
        
        if (maxRent != null) {
            sql.append("AND l.rent_per_month <= ? ");
            params.add(maxRent);
            System.out.println("Added maxRent filter: " + maxRent);
        }
        
        sql.append("GROUP BY l.listing_id ORDER BY l.created_at DESC");
        
        System.out.println("Final SQL: " + sql.toString());
        System.out.println("Parameters: " + params);
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                listings.add(extractListingFromResultSet(rs));
            }
            
            System.out.println("Query returned " + listings.size() + " results");
        } catch (SQLException e) {
            System.err.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
        }
        return listings;
    }
    
    // Get listing by ID
    public PGListing getListingById(int listingId) {
        String sql = "SELECT l.*, u.name as owner_name, u.phone as owner_phone, " +
                    "COALESCE(AVG(r.rating), 0) as avg_rating, COUNT(r.review_id) as review_count " +
                    "FROM pg_listings l " +
                    "JOIN users u ON l.owner_id = u.user_id " +
                    "LEFT JOIN reviews r ON l.listing_id = r.listing_id " +
                    "WHERE l.listing_id = ? " +
                    "GROUP BY l.listing_id";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, listingId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractListingFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // Get photos for a listing
    public List<String> getListingPhotos(int listingId) {
        List<String> photos = new ArrayList<>();
        String sql = "SELECT photo_url FROM pg_photos WHERE listing_id = ? ORDER BY is_primary DESC, display_order ASC";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, listingId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                String photoUrl = rs.getString("photo_url");
                // Ensure photo URL is properly formatted
                if (photoUrl != null && !photoUrl.isEmpty()) {
                    photos.add(photoUrl);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        // Add default photo if no photos found
        if (photos.isEmpty()) {
            photos.add("https://images.unsplash.com/photo-1555854877-bab0e564b8d5?w=800");
        }
        
        return photos;
    }
    
    // Helper method to extract listing from ResultSet
    private PGListing extractListingFromResultSet(ResultSet rs) throws SQLException {
        PGListing listing = new PGListing();
        listing.setListingId(rs.getInt("listing_id"));
        listing.setOwnerId(rs.getInt("owner_id"));
        listing.setTitle(rs.getString("title"));
        listing.setDescription(rs.getString("description"));
        listing.setAddress(rs.getString("address"));
        listing.setCity(rs.getString("city"));
        listing.setState(rs.getString("state"));
        listing.setPincode(rs.getString("pincode"));
        listing.setPgType(rs.getString("pg_type"));
        // Map pg_type to genderPreference for JSP compatibility
        String pgType = rs.getString("pg_type");
        if (pgType != null) {
            switch (pgType.toLowerCase()) {
                case "boys":
                    listing.setGenderPreference("male");
                    break;
                case "girls":
                    listing.setGenderPreference("female");
                    break;
                default:
                    listing.setGenderPreference(pgType);
            }
        }
        listing.setTotalRooms(rs.getInt("total_rooms"));
        listing.setAvailableRooms(rs.getInt("available_rooms"));
        listing.setRentPerMonth(rs.getBigDecimal("rent_per_month"));
        listing.setSecurityDeposit(rs.getBigDecimal("security_deposit"));
        listing.setFoodIncluded(rs.getBoolean("food_included"));
        listing.setWifiAvailable(rs.getBoolean("wifi_available"));
        listing.setAcAvailable(rs.getBoolean("ac_available"));
        listing.setLaundryAvailable(rs.getBoolean("laundry_available"));
        listing.setParkingAvailable(rs.getBoolean("parking_available"));
        listing.setVerified(rs.getBoolean("is_verified"));
        listing.setActive(rs.getBoolean("is_active"));
        listing.setCreatedAt(rs.getTimestamp("created_at"));
        listing.setUpdatedAt(rs.getTimestamp("updated_at"));
        listing.setOwnerName(rs.getString("owner_name"));
        listing.setOwnerPhone(rs.getString("owner_phone"));
        listing.setAverageRating(rs.getDouble("avg_rating"));
        listing.setReviewCount(rs.getInt("review_count"));
        
        // Get photos
        listing.setPhotos(getListingPhotos(listing.getListingId()));
        
        return listing;
    }
    
    // Get listings by owner
    public List<PGListing> getListingsByOwner(int ownerId) {
        List<PGListing> listings = new ArrayList<>();
        String sql = "SELECT l.*, u.name as owner_name, u.phone as owner_phone, " +
                    "COALESCE(AVG(r.rating), 0) as avg_rating, COUNT(r.review_id) as review_count " +
                    "FROM pg_listings l " +
                    "JOIN users u ON l.owner_id = u.user_id " +
                    "LEFT JOIN reviews r ON l.listing_id = r.listing_id " +
                    "WHERE l.owner_id = ? " +
                    "GROUP BY l.listing_id " +
                    "ORDER BY l.created_at DESC";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, ownerId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                listings.add(extractListingFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listings;
    }
    
    // Update listing
    public boolean updateListing(PGListing listing) {
        String sql = "UPDATE pg_listings SET title = ?, description = ?, address = ?, city = ?, " +
                    "state = ?, pincode = ?, pg_type = ?, total_rooms = ?, available_rooms = ?, " +
                    "rent_per_month = ?, security_deposit = ?, food_included = ?, wifi_available = ?, " +
                    "ac_available = ?, laundry_available = ?, parking_available = ?, rules = ?, " +
                    "updated_at = CURRENT_TIMESTAMP WHERE listing_id = ? AND owner_id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, listing.getTitle());
            pstmt.setString(2, listing.getDescription());
            pstmt.setString(3, listing.getAddress());
            pstmt.setString(4, listing.getCity());
            pstmt.setString(5, listing.getState());
            pstmt.setString(6, listing.getPincode());
            pstmt.setString(7, listing.getPgType());
            pstmt.setInt(8, listing.getTotalRooms());
            pstmt.setInt(9, listing.getAvailableRooms());
            pstmt.setBigDecimal(10, listing.getRentPerMonth());
            pstmt.setBigDecimal(11, listing.getSecurityDeposit());
            pstmt.setBoolean(12, listing.isFoodIncluded());
            pstmt.setBoolean(13, listing.isWifiAvailable());
            pstmt.setBoolean(14, listing.isAcAvailable());
            pstmt.setBoolean(15, listing.isLaundryAvailable());
            pstmt.setBoolean(16, listing.isParkingAvailable());
            pstmt.setString(17, listing.getRules());
            pstmt.setInt(18, listing.getListingId());
            pstmt.setInt(19, listing.getOwnerId());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete listing
    public boolean deleteListing(int listingId) {
        String sql = "DELETE FROM pg_listings WHERE listing_id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, listingId);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Create new listing
    public boolean createListing(PGListing listing) {
        String sql = "INSERT INTO pg_listings (owner_id, title, description, address, city, state, pincode, " +
                    "pg_type, total_rooms, available_rooms, rent_per_month, security_deposit, " +
                    "food_included, wifi_available, ac_available, laundry_available, parking_available, " +
                    "is_active, is_verified) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            System.out.println("Creating listing for owner: " + listing.getOwnerId());
            
            pstmt.setInt(1, listing.getOwnerId());
            pstmt.setString(2, listing.getTitle());
            pstmt.setString(3, listing.getDescription());
            pstmt.setString(4, listing.getAddress());
            pstmt.setString(5, listing.getCity());
            pstmt.setString(6, listing.getState());
            pstmt.setString(7, listing.getPincode());
            pstmt.setString(8, listing.getPgType());
            pstmt.setInt(9, listing.getTotalRooms());
            pstmt.setInt(10, listing.getAvailableRooms());
            pstmt.setBigDecimal(11, listing.getRentPerMonth());
            pstmt.setBigDecimal(12, listing.getSecurityDeposit());
            pstmt.setBoolean(13, listing.isFoodIncluded());
            pstmt.setBoolean(14, listing.isWifiAvailable());
            pstmt.setBoolean(15, listing.isAcAvailable());
            pstmt.setBoolean(16, listing.isLaundryAvailable());
            pstmt.setBoolean(17, listing.isParkingAvailable());
            pstmt.setBoolean(18, listing.isActive());
            pstmt.setBoolean(19, listing.isVerified());
            
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("SQL Error creating listing: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Update available rooms
    public boolean updateAvailableRooms(int listingId, int availableRooms) {
        String sql = "UPDATE pg_listings SET available_rooms = ? WHERE listing_id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, availableRooms);
            pstmt.setInt(2, listingId);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
