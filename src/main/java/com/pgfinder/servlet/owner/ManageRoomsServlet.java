package com.pgfinder.servlet.owner;

import com.pgfinder.dao.PGListingDAO;
import com.pgfinder.model.PGListing;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/owner/manage-rooms")
public class ManageRoomsServlet extends HttpServlet {
    private PGListingDAO pgListingDAO;
    private Gson gson;
    
    @Override
    public void init() {
        pgListingDAO = new PGListingDAO();
        gson = new Gson();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int ownerId = (int) session.getAttribute("userId");
        List<PGListing> listings = pgListingDAO.getListingsByOwner(ownerId);
        
        request.setAttribute("listings", listings);
        request.setAttribute("pageTitle", "Manage Rooms");
        request.setAttribute("currentPage", "manage-rooms");
        request.setAttribute("contentPage", "/WEB-INF/views/owner/manage-rooms.jsp");
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
            if (session == null || session.getAttribute("userId") == null) {
                result.put("success", false);
                result.put("message", "Please login first");
                response.getWriter().write(gson.toJson(result));
                return;
            }
            
            int ownerId = (int) session.getAttribute("userId");
            String action = request.getParameter("action");
            
            System.out.println("=== ManageRooms POST Debug ===");
            System.out.println("Owner ID: " + ownerId);
            System.out.println("Action parameter: " + action);
            System.out.println("Content-Type: " + request.getContentType());
            System.out.println("All parameters:");
            request.getParameterMap().forEach((key, value) -> {
                System.out.println("  " + key + " = " + String.join(",", value));
            });
            System.out.println("=== End Debug ===");
            
            if (action == null || action.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "No action specified");
                response.getWriter().write(gson.toJson(result));
                return;
            }
            
            if ("updateAvailability".equals(action)) {
                String listingIdStr = request.getParameter("listingId");
                String availableRoomsStr = request.getParameter("availableRooms");
                
                System.out.println("Updating listing: " + listingIdStr + ", rooms: " + availableRoomsStr);
                
                if (listingIdStr == null || availableRoomsStr == null) {
                    result.put("success", false);
                    result.put("message", "Missing parameters");
                    response.getWriter().write(gson.toJson(result));
                    return;
                }
                
                int listingId = Integer.parseInt(listingIdStr);
                int availableRooms = Integer.parseInt(availableRoomsStr);
                
                // Verify ownership
                PGListing listing = pgListingDAO.getListingById(listingId);
                if (listing == null) {
                    result.put("success", false);
                    result.put("message", "Listing not found");
                } else if (listing.getOwnerId() != ownerId) {
                    result.put("success", false);
                    result.put("message", "Unauthorized - not your listing");
                } else {
                    boolean success = pgListingDAO.updateAvailableRooms(listingId, availableRooms);
                    result.put("success", success);
                    result.put("message", success ? "Availability updated successfully!" : "Failed to update availability");
                    System.out.println("Update result: " + success);
                }
            } else {
                result.put("success", false);
                result.put("message", "Invalid action: " + action);
            }
        } catch (NumberFormatException e) {
            System.err.println("Number format error: " + e.getMessage());
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "Invalid number format");
        } catch (Exception e) {
            System.err.println("Error in manage rooms: " + e.getMessage());
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "Error: " + e.getMessage());
        }
        
        response.getWriter().write(gson.toJson(result));
    }
}
