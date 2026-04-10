package com.pgfinder.servlet.admin;

import com.pgfinder.config.DatabaseConfig;
import com.pgfinder.model.ActivityLog;
import com.pgfinder.model.SystemSettings;
import com.pgfinder.service.AdminService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/admin/settings")
public class AdminSettingsServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }
        
        String tab = request.getParameter("tab");
        if (tab == null) tab = "general";
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            AdminService adminService = new AdminService(conn);
            
            if ("logs".equals(tab)) {
                int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                int pageSize = 50;
                List<ActivityLog> logs = adminService.getActivityLogs(page, pageSize);
                request.setAttribute("logs", logs);
                request.setAttribute("pageNumber", page); // For pagination
            } else {
                List<SystemSettings> settings = adminService.getAllSettings();
                request.setAttribute("settings", settings);
            }
            
            request.setAttribute("currentPage", "settings"); // For sidebar navigation
            request.setAttribute("activeTab", tab);
            request.getRequestDispatcher("/WEB-INF/views/admin/settings.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading settings: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/settings.jsp").forward(request, response);
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
        String settingKey = request.getParameter("settingKey");
        String settingValue = request.getParameter("settingValue");
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            AdminService adminService = new AdminService(conn);
            
            boolean success = adminService.updateSetting(settingKey, settingValue, adminId);
            String message = success ? "Setting updated successfully" : "Failed to update setting";
            
            session.setAttribute(success ? "success" : "error", message);
            response.sendRedirect(request.getContextPath() + "/admin/settings");
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/settings");
        }
    }
}
