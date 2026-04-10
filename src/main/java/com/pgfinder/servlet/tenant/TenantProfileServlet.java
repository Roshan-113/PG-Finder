package com.pgfinder.servlet.tenant;

import com.pgfinder.dao.UserDAO;
import com.pgfinder.model.User;
import com.pgfinder.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/tenant/profile")
public class TenantProfileServlet extends HttpServlet {
    private UserDAO userDAO;
    
    @Override
    public void init() {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        request.setAttribute("pageTitle", "My Profile");
        request.setAttribute("contentPage", "/WEB-INF/views/tenant/profile.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/tenant-layout.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int userId = (int) session.getAttribute("userId");
        String action = request.getParameter("action");
        
        if ("updateProfile".equals(action)) {
            handleProfileUpdate(request, response, userId, session);
        } else if ("changePassword".equals(action)) {
            handlePasswordChange(request, response, userId);
        }
    }
    
    private void handleProfileUpdate(HttpServletRequest request, HttpServletResponse response, 
                                     int userId, HttpSession session) throws ServletException, IOException {
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        
        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Name is required");
            doGet(request, response);
            return;
        }
        
        User user = userDAO.getUserById(userId);
        if (user != null) {
            user.setName(name.trim());
            if (phone != null && !phone.trim().isEmpty()) {
                user.setPhone(phone.trim());
            }
            
            if (userDAO.updateUser(user)) {
                session.setAttribute("userName", user.getName());
                session.setAttribute("userPhone", user.getPhone());
                request.setAttribute("successMessage", "Profile updated successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile");
            }
        }
        
        doGet(request, response);
    }
    
    private void handlePasswordChange(HttpServletRequest request, HttpServletResponse response, 
                                      int userId) throws ServletException, IOException {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        if (currentPassword == null || newPassword == null || confirmPassword == null) {
            request.setAttribute("errorMessage", "All password fields are required");
            doGet(request, response);
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "New passwords do not match");
            doGet(request, response);
            return;
        }
        
        if (newPassword.length() < 6) {
            request.setAttribute("errorMessage", "Password must be at least 6 characters");
            doGet(request, response);
            return;
        }
        
        User user = userDAO.getUserById(userId);
        if (user != null) {
            if (!PasswordUtil.verifyPassword(currentPassword, user.getPassword())) {
                request.setAttribute("errorMessage", "Current password is incorrect");
                doGet(request, response);
                return;
            }
            
            String hashedPassword = PasswordUtil.hashPassword(newPassword);
            if (userDAO.updatePassword(userId, hashedPassword)) {
                request.setAttribute("successMessage", "Password changed successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to change password");
            }
        }
        
        doGet(request, response);
    }
}
