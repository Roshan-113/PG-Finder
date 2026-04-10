package com.pgfinder.servlet.admin;

import com.pgfinder.config.DatabaseConfig;
import com.pgfinder.model.User;
import com.pgfinder.service.AdminService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUsersServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }
        
        String userType = request.getParameter("type");
        String status = request.getParameter("status");
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int pageSize = 20;
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            AdminService adminService = new AdminService(conn);
            
            List<User> users = adminService.getAllUsers(userType, status, page, pageSize);
            int totalUsers = adminService.getTotalUsersCount(userType, status);
            int totalPages = (int) Math.ceil((double) totalUsers / pageSize);
            
            request.setAttribute("users", users);
            request.setAttribute("currentPage", "users"); // For sidebar navigation
            request.setAttribute("pageNumber", page); // For pagination
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("selectedType", userType);
            request.setAttribute("selectedStatus", status);
            
            request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading users: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(request, response);
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
        int userId = Integer.parseInt(request.getParameter("userId"));
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            AdminService adminService = new AdminService(conn);
            boolean success = false;
            String message = "";
            
            switch (action) {
                case "activate":
                    success = adminService.activateUser(userId, adminId);
                    message = success ? "User activated successfully" : "Failed to activate user";
                    break;
                case "deactivate":
                    String reason = request.getParameter("reason");
                    if (reason == null || reason.trim().isEmpty()) {
                        session.setAttribute("error", "Deactivation reason is required");
                        response.sendRedirect(request.getContextPath() + "/admin/users");
                        return;
                    }
                    success = adminService.deactivateUser(userId, adminId, reason);
                    message = success ? "User deactivated successfully" : "Failed to deactivate user";
                    break;
                case "verify":
                    success = adminService.verifyUser(userId, adminId);
                    message = success ? "User verified successfully" : "Failed to verify user";
                    break;
                case "delete":
                    success = adminService.deleteUser(userId, adminId);
                    message = success ? "User deleted successfully" : "Failed to delete user";
                    break;
            }
            
            session.setAttribute(success ? "success" : "error", message);
            response.sendRedirect(request.getContextPath() + "/admin/users");
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
}
