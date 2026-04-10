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
import java.util.Map;

@WebServlet("/owner/edit-pg")
public class EditPGServlet extends HttpServlet {
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
        
        String listingIdStr = request.getParameter("id");
        if (listingIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/owner/listings");
            return;
        }
        
        try {
            int listingId = Integer.parseInt(listingIdStr);
            int ownerId = (int) session.getAttribute("userId");
            
            PGListing listing = pgListingDAO.getListingById(listingId);
            
            // Verify ownership
            if (listing == null || listing.getOwnerId() != ownerId) {
                response.sendRedirect(request.getContextPath() + "/owner/listings");
                return;
            }
            
            request.setAttribute("listing", listing);
            request.setAttribute("pageTitle", "Edit PG");
            request.setAttribute("currentPage", "listings");
            request.setAttribute("contentPage", "/WEB-INF/views/owner/edit-pg.jsp");
            request.getRequestDispatcher("/WEB-INF/views/layouts/owner-layout.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/owner/listings");
        }
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
        
        try {
            // Debug: Log all parameters
            System.out.println("=== Edit PG Request Parameters ===");
            System.out.println("Request Method: " + request.getMethod());
            System.out.println("Content Type: " + request.getContentType());
            request.getParameterMap().forEach((key, values) -> {
                System.out.println(key + ": " + String.join(", ", values));
            });
            
            String listingIdStr = request.getParameter("listingId");
            System.out.println("Listing ID from request: " + listingIdStr);
            
            if (listingIdStr == null || listingIdStr.trim().isEmpty()) {
                System.err.println("ERROR: Listing ID is missing or empty");
                System.err.println("All parameters: " + request.getParameterMap().keySet());
                Map<String, Object> result = new HashMap<>();
                result.put("success", false);
                result.put("error", "Listing ID is required");
                response.setContentType("application/json");
                response.getWriter().write(gson.toJson(result));
                return;
            }
            
            int listingId = Integer.parseInt(listingIdStr);
            
            // Verify ownership
            PGListing existingListing = pgListingDAO.getListingById(listingId);
            if (existingListing == null || existingListing.getOwnerId() != ownerId) {
                Map<String, Object> result = new HashMap<>();
                result.put("success", false);
                result.put("error", "Unauthorized");
                response.setContentType("application/json");
                response.getWriter().write(gson.toJson(result));
                return;
            }
            
            // Create updated listing object
            PGListing listing = new PGListing();
            listing.setListingId(listingId);
            listing.setOwnerId(ownerId);
            listing.setTitle(request.getParameter("title"));
            listing.setDescription(request.getParameter("description"));
            listing.setAddress(request.getParameter("address"));
            listing.setCity(request.getParameter("city"));
            listing.setState(request.getParameter("state"));
            listing.setPincode(request.getParameter("pincode"));
            listing.setPgType(request.getParameter("pgType"));
            listing.setTotalRooms(Integer.parseInt(request.getParameter("totalRooms")));
            listing.setAvailableRooms(Integer.parseInt(request.getParameter("availableRooms")));
            listing.setRentPerMonth(new java.math.BigDecimal(request.getParameter("rentPerMonth")));
            
            // Handle security deposit (might be null or empty)
            String securityDepositStr = request.getParameter("securityDeposit");
            if (securityDepositStr != null && !securityDepositStr.trim().isEmpty()) {
                listing.setSecurityDeposit(new java.math.BigDecimal(securityDepositStr));
            } else {
                listing.setSecurityDeposit(java.math.BigDecimal.ZERO);
            }
            
            // Amenities
            listing.setFoodIncluded("on".equals(request.getParameter("foodIncluded")));
            listing.setWifiAvailable("on".equals(request.getParameter("wifiAvailable")));
            listing.setAcAvailable("on".equals(request.getParameter("acAvailable")));
            listing.setLaundryAvailable("on".equals(request.getParameter("laundryAvailable")));
            listing.setParkingAvailable("on".equals(request.getParameter("parkingAvailable")));
            
            // Handle rules (might be null)
            String rules = request.getParameter("rules");
            listing.setRules(rules != null ? rules : "");
            
            boolean success = pgListingDAO.updateListing(listing);
            
            Map<String, Object> result = new HashMap<>();
            result.put("success", success);
            
            response.setContentType("application/json");
            response.getWriter().write(gson.toJson(result));
            
        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("error", e.getMessage());
            
            response.setContentType("application/json");
            response.getWriter().write(gson.toJson(result));
        }
    }
}
