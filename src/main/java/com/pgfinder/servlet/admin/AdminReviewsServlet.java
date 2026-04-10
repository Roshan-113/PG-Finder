package com.pgfinder.servlet.admin;

import com.pgfinder.config.DatabaseConfig;
import com.pgfinder.service.AdminService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/reviews")
public class AdminReviewsServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }
        
        String status = request.getParameter("status");
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int pageSize = 20;
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            AdminService adminService = new AdminService(conn);
            
            List<Map<String, Object>> reviews = adminService.getAllReviews(status, page, pageSize);
            
            request.setAttribute("reviews", reviews);
            request.setAttribute("currentPage", "reviews"); // For sidebar navigation
            request.setAttribute("pageNumber", page); // For pagination
            request.setAttribute("selectedStatus", status);
            
            request.getRequestDispatcher("/WEB-INF/views/admin/reviews.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading reviews: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/reviews.jsp").forward(request, response);
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
        int reviewId = Integer.parseInt(request.getParameter("reviewId"));
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            AdminService adminService = new AdminService(conn);
            boolean success = false;
            String message = "";
            
            switch (action) {
                case "activate":
                    success = adminService.activateReview(reviewId, adminId);
                    message = success ? "Review activated successfully" : "Failed to activate review";
                    break;
                case "deactivate":
                    success = adminService.deactivateReview(reviewId, adminId);
                    message = success ? "Review deactivated successfully" : "Failed to deactivate review";
                    break;
                case "delete":
                    success = adminService.deleteReview(reviewId, adminId);
                    message = success ? "Review deleted successfully" : "Failed to delete review";
                    break;
            }
            
            session.setAttribute(success ? "success" : "error", message);
            response.sendRedirect(request.getContextPath() + "/admin/reviews");
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/reviews");
        }
    }
}
