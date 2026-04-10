package com.pgfinder.servlet.owner;

import com.pgfinder.dao.PGListingDAO;
import com.pgfinder.dao.CityDAO;
import com.pgfinder.model.PGListing;
import com.pgfinder.config.DatabaseConfig;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@WebServlet("/owner/add-pg")
@MultipartConfig(
    maxFileSize = 5242880,      // 5MB per file
    maxRequestSize = 26214400   // 25MB total
)
public class AddPGServlet extends HttpServlet {
    private PGListingDAO pgListingDAO;
    private Gson gson;
    private static final String UPLOAD_DIR = "uploads/pg-photos";
    
    @Override
    public void init() {
        pgListingDAO = new PGListingDAO();
        gson = new Gson();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Enhanced authentication check
        if (session == null || session.getAttribute("userId") == null || session.getAttribute("userRole") == null) {
            System.out.println("AddPGServlet: No session or userId, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Verify user role is owner
        String userRole = (String) session.getAttribute("userRole");
        if (!"owner".equals(userRole)) {
            System.out.println("AddPGServlet: User role is not owner: " + userRole);
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        System.out.println("AddPGServlet: Access granted for owner ID: " + session.getAttribute("userId"));
        
        // Load existing cities for dropdown
        try (Connection conn = DatabaseConfig.getConnection()) {
            CityDAO cityDAO = new CityDAO(conn);
            List<String> cities = cityDAO.getDistinctCities();
            request.setAttribute("existingCities", cities);
        } catch (Exception e) {
            System.err.println("Error loading cities: " + e.getMessage());
        }
        
        request.setAttribute("pageTitle", "Add New PG");
        request.setAttribute("currentPage", "add-pg");
        request.setAttribute("contentPage", "/WEB-INF/views/owner/add-pg.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/owner-layout.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        Map<String, Object> result = new HashMap<>();
        
        try {
            // Enhanced authentication check
            if (session == null || session.getAttribute("userId") == null || session.getAttribute("userRole") == null) {
                result.put("success", false);
                result.put("message", "Please login first");
                response.getWriter().write(gson.toJson(result));
                return;
            }
            
            // Verify user role is owner
            String userRole = (String) session.getAttribute("userRole");
            if (!"owner".equals(userRole)) {
                result.put("success", false);
                result.put("message", "Unauthorized access");
                response.getWriter().write(gson.toJson(result));
                return;
            }
            
            int ownerId = (int) session.getAttribute("userId");
            System.out.println("Adding PG for owner ID: " + ownerId);
            
            // Validate required fields
            String pgName = request.getParameter("pgName");
            String description = request.getParameter("description");
            String address = request.getParameter("address");
            String locality = request.getParameter("locality");
            String city = request.getParameter("city");
            String pincode = request.getParameter("pincode");
            String pgType = request.getParameter("pgType");
            String totalRoomsStr = request.getParameter("totalRooms");
            String startingPriceStr = request.getParameter("startingPrice");
            
            if (pgName == null || pgName.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "PG Name is required");
                response.getWriter().write(gson.toJson(result));
                return;
            }
            
            if (city == null || city.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "City is required");
                response.getWriter().write(gson.toJson(result));
                return;
            }
            
            if (totalRoomsStr == null || startingPriceStr == null) {
                result.put("success", false);
                result.put("message", "Total rooms and price are required");
                response.getWriter().write(gson.toJson(result));
                return;
            }
            
            // Create new listing object
            PGListing listing = new PGListing();
            listing.setOwnerId(ownerId);
            listing.setTitle(pgName.trim());
            listing.setDescription(description != null ? description.trim() : "");
            listing.setAddress((address != null ? address.trim() : "") + ", " + (locality != null ? locality.trim() : ""));
            listing.setCity(city.trim());
            listing.setState("Karnataka");
            listing.setPincode(pincode != null ? pincode.trim() : "");
            listing.setPgType(pgType != null ? pgType : "boys");
            
            int totalRooms = Integer.parseInt(totalRoomsStr);
            listing.setTotalRooms(totalRooms);
            listing.setAvailableRooms(totalRooms);
            listing.setRentPerMonth(new BigDecimal(startingPriceStr));
            
            String securityDeposit = request.getParameter("securityDeposit");
            if (securityDeposit != null && !securityDeposit.trim().isEmpty()) {
                listing.setSecurityDeposit(new BigDecimal(securityDeposit));
            } else {
                listing.setSecurityDeposit(BigDecimal.ZERO);
            }
            
            // Amenities - set all to false first
            listing.setWifiAvailable(false);
            listing.setAcAvailable(false);
            listing.setFoodIncluded(false);
            listing.setLaundryAvailable(false);
            listing.setParkingAvailable(false);
            
            String[] amenities = request.getParameterValues("amenities");
            if (amenities != null) {
                for (String amenity : amenities) {
                    switch (amenity) {
                        case "wifi": listing.setWifiAvailable(true); break;
                        case "ac": listing.setAcAvailable(true); break;
                        case "food": listing.setFoodIncluded(true); break;
                        case "laundry": listing.setLaundryAvailable(true); break;
                        case "parking": listing.setParkingAvailable(true); break;
                    }
                }
            }
            
            listing.setActive(true);
            listing.setVerified(false);
            
            System.out.println("Attempting to create listing: " + listing.getTitle());
            boolean success = pgListingDAO.createListing(listing);
            System.out.println("Create listing result: " + success);
            
            if (success) {
                // Get the newly created listing ID
                int newListingId = getLastInsertedListingId(ownerId);
                System.out.println("New listing ID: " + newListingId);
                
                // Handle photo uploads
                if (newListingId > 0) {
                    Collection<Part> parts = request.getParts();
                    int photoCount = 0;
                    
                    for (Part part : parts) {
                        if (!"photos".equals(part.getName())) continue;
                        if (part.getSize() == 0) continue;
                        
                        photoCount++;
                        if (photoCount > 5) break; // Max 5 photos
                        
                        String fileName = part.getSubmittedFileName();
                        String ext = fileName.substring(fileName.lastIndexOf("."));
                        String uniqueFileName = UUID.randomUUID() + ext;
                        
                        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) uploadDir.mkdirs();
                        
                        Path filePath = Paths.get(uploadPath, uniqueFileName);
                        
                        try (InputStream input = part.getInputStream()) {
                            Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
                        }
                        
                        String photoUrl = request.getContextPath() + "/" + UPLOAD_DIR + "/" + uniqueFileName;
                        boolean isPrimary = (photoCount == 1);
                        
                        savePhotoToDatabase(newListingId, photoUrl, isPrimary, photoCount);
                        System.out.println("Saved photo " + photoCount + ": " + photoUrl);
                    }
                    
                    if (photoCount > 0) {
                        System.out.println("Total photos uploaded: " + photoCount);
                    }
                }
            }
            
            result.put("success", success);
            
            if (success) {
                result.put("message", "PG added successfully! Waiting for admin approval.");
                result.put("redirect", request.getContextPath() + "/owner/listings");
            } else {
                result.put("message", "Failed to add PG to database. Please check server logs.");
            }
            
        } catch (NumberFormatException e) {
            System.err.println("Number format error: " + e.getMessage());
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "Invalid number format in form data");
        } catch (Exception e) {
            System.err.println("Error adding PG: " + e.getMessage());
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "Error: " + e.getMessage());
        }
        
        response.getWriter().write(gson.toJson(result));
    }
    
    private int getLastInsertedListingId(int ownerId) {
        String sql = "SELECT listing_id FROM pg_listings WHERE owner_id = ? ORDER BY created_at DESC LIMIT 1";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("listing_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    private boolean savePhotoToDatabase(int listingId, String url, boolean isPrimary, int order) {
        String sql = "INSERT INTO pg_photos (listing_id, photo_url, is_primary, display_order) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, listingId);
            ps.setString(2, url);
            ps.setBoolean(3, isPrimary);
            ps.setInt(4, order);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
