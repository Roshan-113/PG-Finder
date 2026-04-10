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

@WebServlet("/owner/listings")
public class OwnerListingsServlet extends HttpServlet {
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
        request.setAttribute("pageTitle", "My Listings");
        request.setAttribute("currentPage", "listings");
        request.setAttribute("contentPage", "/WEB-INF/views/owner/listings.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/owner-layout.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        int ownerId = (int) session.getAttribute("userId");
        String action = request.getParameter("action");
        
        Map<String, Object> result = new HashMap<>();
        
        if ("delete".equals(action)) {
            String listingIdStr = request.getParameter("listingId");
            if (listingIdStr != null) {
                try {
                    int listingId = Integer.parseInt(listingIdStr);
                    
                    // Verify ownership before deleting
                    PGListing listing = pgListingDAO.getListingById(listingId);
                    if (listing != null && listing.getOwnerId() == ownerId) {
                        boolean success = pgListingDAO.deleteListing(listingId);
                        result.put("success", success);
                        result.put("message", success ? "Listing deleted successfully!" : "Failed to delete listing");
                    } else {
                        result.put("success", false);
                        result.put("message", "Unauthorized or listing not found");
                    }
                } catch (NumberFormatException e) {
                    result.put("success", false);
                    result.put("message", "Invalid listing ID");
                }
            } else {
                result.put("success", false);
                result.put("message", "Listing ID is required");
            }
        } else {
            result.put("success", false);
            result.put("message", "Invalid action");
        }
        
        response.setContentType("application/json");
        response.getWriter().write(gson.toJson(result));
    }
}
