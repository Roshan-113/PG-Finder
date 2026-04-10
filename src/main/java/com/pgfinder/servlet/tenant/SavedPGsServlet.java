package com.pgfinder.servlet.tenant;

import com.pgfinder.dao.PGListingDAO;
import com.pgfinder.dao.SavedPGDAO;
import com.pgfinder.model.PGListing;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/tenant/saved-pgs")
public class SavedPGsServlet extends HttpServlet {
    private PGListingDAO pgListingDAO;
    private SavedPGDAO savedPGDAO;
    
    @Override
    public void init() {
        pgListingDAO = new PGListingDAO();
        savedPGDAO = new SavedPGDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int userId = (int) session.getAttribute("userId");
        
        // Get saved PG IDs
        List<Integer> savedIds = getSavedPGIds(userId);
        
        // Get full listing details
        List<PGListing> savedListings = new ArrayList<>();
        for (int listingId : savedIds) {
            PGListing listing = pgListingDAO.getListingById(listingId);
            if (listing != null) {
                listing.setSaved(true);
                savedListings.add(listing);
            }
        }
        
        request.setAttribute("savedListings", savedListings);
        request.setAttribute("pageTitle", "Saved PGs");
        request.setAttribute("currentPage", "saved");
        request.setAttribute("contentPage", "/WEB-INF/views/tenant/saved-pgs.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/tenant-layout.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        int userId = (int) session.getAttribute("userId");
        String action = request.getParameter("action");
        String listingIdStr = request.getParameter("listingId");
        
        if (listingIdStr == null || action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        try {
            int listingId = Integer.parseInt(listingIdStr);
            
            if ("save".equals(action)) {
                savedPGDAO.savePG(userId, listingId);
            } else if ("unsave".equals(action)) {
                savedPGDAO.unsavePG(userId, listingId);
            }
            
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": true}");
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    
    private List<Integer> getSavedPGIds(int userId) {
        List<Integer> ids = new ArrayList<>();
        try (var conn = com.pgfinder.config.DatabaseConfig.getConnection();
             var pstmt = conn.prepareStatement("SELECT listing_id FROM saved_pgs WHERE tenant_id = ?")) {
            
            pstmt.setInt(1, userId);
            var rs = pstmt.executeQuery();
            
            while (rs.next()) {
                ids.add(rs.getInt("listing_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ids;
    }
}
