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

@WebServlet("/admin/approvals")
public class AdminApprovalsServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }
        
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int pageSize = 20;
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            AdminService adminService = new AdminService(conn);
            
            List<Map<String, Object>> pendingDocuments = adminService.getPendingDocuments(page, pageSize);
            
            request.setAttribute("documents", pendingDocuments);
            request.setAttribute("currentPage", "approvals"); // For sidebar navigation
            request.setAttribute("pageNumber", page); // For pagination
            
            request.getRequestDispatcher("/WEB-INF/views/admin/approvals.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading approvals: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/approvals.jsp").forward(request, response);
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
        int documentId = Integer.parseInt(request.getParameter("documentId"));
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            AdminService adminService = new AdminService(conn);
            boolean success = false;
            String message = "";
            
            if ("approve".equals(action)) {
                success = adminService.approveDocument(documentId, adminId);
                message = success ? "Document approved successfully" : "Failed to approve document";
            } else if ("reject".equals(action)) {
                success = adminService.rejectDocument(documentId, adminId);
                message = success ? "Document rejected successfully" : "Failed to reject document";
            }
            
            session.setAttribute(success ? "success" : "error", message);
            response.sendRedirect(request.getContextPath() + "/admin/approvals");
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/approvals");
        }
    }
}
