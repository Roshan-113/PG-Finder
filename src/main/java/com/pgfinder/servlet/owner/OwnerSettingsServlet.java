package com.pgfinder.servlet.owner;

import com.pgfinder.dao.UserDAO;
import com.pgfinder.util.PasswordUtil;
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

@WebServlet("/owner/settings")
public class OwnerSettingsServlet extends HttpServlet {
    private UserDAO userDAO;
    private Gson gson;
    
    @Override
    public void init() {
        userDAO = new UserDAO();
        gson = new Gson();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setAttribute("pageTitle", "Settings");
        request.setAttribute("currentPage", "settings");
        request.setAttribute("contentPage", "/WEB-INF/views/owner/settings.jsp");
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
            
            int userId = (int) session.getAttribute("userId");
            String action = request.getParameter("action");
            
            System.out.println("Settings - Action: " + action + ", User: " + userId);
            
            if ("changePassword".equals(action)) {
                String currentPassword = request.getParameter("currentPassword");
                String newPassword = request.getParameter("newPassword");
                String confirmPassword = request.getParameter("confirmPassword");
                
                if (currentPassword == null || currentPassword.trim().isEmpty()) {
                    result.put("success", false);
                    result.put("message", "Current password is required");
                } else if (newPassword == null || newPassword.trim().isEmpty()) {
                    result.put("success", false);
                    result.put("message", "New password is required");
                } else if (!newPassword.equals(confirmPassword)) {
                    result.put("success", false);
                    result.put("message", "New passwords do not match");
                } else {
                    // Verify current password
                    var user = userDAO.findById(userId);
                    if (user == null) {
                        result.put("success", false);
                        result.put("message", "User not found");
                    } else if (!PasswordUtil.verifyPassword(currentPassword, user.getPasswordHash())) {
                        result.put("success", false);
                        result.put("message", "Current password is incorrect");
                    } else {
                        String newHash = PasswordUtil.hashPassword(newPassword);
                        boolean success = userDAO.updatePassword(userId, newHash);
                        result.put("success", success);
                        result.put("message", success ? "Password changed successfully!" : "Failed to change password");
                        System.out.println("Password change result: " + success);
                    }
                }
            } else {
                result.put("success", true);
                result.put("message", "Settings updated successfully");
            }
        } catch (Exception e) {
            System.err.println("Error in settings: " + e.getMessage());
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "Error: " + e.getMessage());
        }
        
        response.getWriter().write(gson.toJson(result));
    }
}
