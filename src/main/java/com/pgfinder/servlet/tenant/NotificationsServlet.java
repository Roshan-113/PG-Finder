package com.pgfinder.servlet.tenant;

import com.pgfinder.config.DatabaseConfig;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/tenant/notifications")
public class NotificationsServlet extends HttpServlet {
    private Gson gson;
    
    @Override
    public void init() {
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
        
        int userId = (int) session.getAttribute("userId");
        List<Map<String, Object>> notifications = getNotifications(userId);
        
        request.setAttribute("notifications", notifications);
        request.setAttribute("pageTitle", "Notifications");
        request.setAttribute("currentPage", "notifications");
        request.setAttribute("contentPage", "/WEB-INF/views/tenant/notifications.jsp");
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
        
        if ("markAsRead".equals(action)) {
            String notificationIdStr = request.getParameter("notificationId");
            if (notificationIdStr != null) {
                int notificationId = Integer.parseInt(notificationIdStr);
                boolean success = markAsRead(notificationId, userId);
                
                Map<String, Object> result = new HashMap<>();
                result.put("success", success);
                
                response.setContentType("application/json");
                response.getWriter().write(gson.toJson(result));
            }
        }
    }
    
    private List<Map<String, Object>> getNotifications(int userId) {
        List<Map<String, Object>> notifications = new ArrayList<>();
        String sql = "SELECT * FROM notifications WHERE user_id = ? ORDER BY created_at DESC LIMIT 20";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> notification = new HashMap<>();
                notification.put("notificationId", rs.getInt("notification_id"));
                notification.put("type", rs.getString("notification_type"));
                notification.put("title", rs.getString("title"));
                notification.put("message", rs.getString("message"));
                notification.put("isRead", rs.getBoolean("is_read"));
                notification.put("createdAt", rs.getTimestamp("created_at"));
                notifications.add(notification);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notifications;
    }

    private boolean markAsRead(int notificationId, int userId) {
        String sql = "UPDATE notifications SET is_read = TRUE WHERE notification_id = ? AND user_id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, notificationId);
            pstmt.setInt(2, userId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
