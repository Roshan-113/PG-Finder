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

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            AdminService adminService = new AdminService(conn);
            
            // Get dashboard statistics
            Map<String, Object> stats = adminService.getDashboardStats();
            request.setAttribute("stats", stats);
            
            // Get recent activities
            List<Map<String, Object>> recentActivities = adminService.getRecentActivities(10);
            request.setAttribute("recentActivities", recentActivities);
            
            // Get graph data
            List<Map<String, Object>> registrationStats = adminService.getMonthlyRegistrationStats();
            request.setAttribute("registrationStats", registrationStats);
            
            List<Map<String, Object>> revenueStats = adminService.getMonthlyRevenueStats();
            request.setAttribute("revenueStats", revenueStats);
            
            request.setAttribute("currentPage", "dashboard"); // For sidebar navigation
            
            request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading dashboard: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
        }
    }
}
