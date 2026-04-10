package com.pgfinder.servlet.admin;

import com.pgfinder.config.DatabaseConfig;
import com.pgfinder.model.PGListing;
import com.pgfinder.model.User;
import com.pgfinder.service.AdminService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/admin/listings")
public class AdminListingsServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }
        
        String status = request.getParameter("status");
        String city = request.getParameter("city");
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int pageSize = 20;
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            AdminService adminService = new AdminService(conn);
            
            List<PGListing> listings = adminService.getAllListings(status, city, page, pageSize);
            int totalListings = adminService.getTotalListingsCount(status, city);
            int totalPages = (int) Math.ceil((double) totalListings / pageSize);
            
            request.setAttribute("listings", listings);
            request.setAttribute("currentPage", "listings"); // For sidebar navigation
            request.setAttribute("pageNumber", page); // For pagination
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalListings", totalListings);
            request.setAttribute("selectedStatus", status);
            request.setAttribute("selectedCity", city);
            
            request.getRequestDispatcher("/WEB-INF/views/admin/listings.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading listings: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/listings.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }
        
        Integer adminId = (Integer) session.getAttribute("userId");
        String action = request.getParameter("action");
        int listingId = Integer.parseInt(request.getParameter("listingId"));
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            AdminService adminService = new AdminService(conn);
            boolean success = false;
            String message = "";
            
            switch (action) {
                case "activate":
                    success = adminService.activateListing(listingId, adminId);
                    message = success ? "Listing activated successfully" : "Failed to activate listing";
                    break;
                case "deactivate":
                    success = adminService.deactivateListing(listingId, adminId);
                    message = success ? "Listing deactivated successfully" : "Failed to deactivate listing";
                    break;
                case "verify":
                    success = adminService.verifyListing(listingId, adminId);
                    message = success ? "Listing verified successfully" : "Failed to verify listing";
                    break;
                case "delete":
                    success = adminService.deleteListing(listingId, adminId);
                    message = success ? "Listing deleted successfully" : "Failed to delete listing";
                    break;
            }
            
            session.setAttribute(success ? "success" : "error", message);
            response.sendRedirect(request.getContextPath() + "/admin/listings");
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/listings");
        }
    }
}
