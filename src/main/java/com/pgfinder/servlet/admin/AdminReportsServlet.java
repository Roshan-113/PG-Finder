package com.pgfinder.servlet.admin;

import com.pgfinder.config.DatabaseConfig;
import com.pgfinder.model.Report;
import com.pgfinder.service.AdminService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/admin/reports")
public class AdminReportsServlet extends HttpServlet {
    
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
            
            List<Report> reports = adminService.getAllReports(status, page, pageSize);
            
            request.setAttribute("reports", reports);
            request.setAttribute("currentPage", "reports"); // For sidebar navigation
            request.setAttribute("pageNumber", page); // For pagination
            request.setAttribute("selectedStatus", status);
            
            request.getRequestDispatcher("/WEB-INF/views/admin/reports.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading reports: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/reports.jsp").forward(request, response);
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
        int reportId = Integer.parseInt(request.getParameter("reportId"));
        String status = request.getParameter("status");
        String adminNotes = request.getParameter("adminNotes");
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            AdminService adminService = new AdminService(conn);
            
            boolean success = adminService.updateReportStatus(reportId, status, adminNotes, adminId);
            String message = success ? "Report updated successfully" : "Failed to update report";
            
            session.setAttribute(success ? "success" : "error", message);
            response.sendRedirect(request.getContextPath() + "/admin/reports");
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/reports");
        }
    }
}
