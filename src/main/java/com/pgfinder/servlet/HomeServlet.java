package com.pgfinder.servlet;

import com.pgfinder.dao.CityDAO;
import com.pgfinder.config.DatabaseConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import java.util.Map;

@WebServlet("/")
public class HomeServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if user is logged in and redirect ONLY admin/owner to dashboard
        // Tenants stay on landing page
        String userRole = (String) request.getSession().getAttribute("userRole");
        if (userRole != null) {
            if ("admin".equals(userRole)) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                return;
            } else if ("owner".equals(userRole)) {
                response.sendRedirect(request.getContextPath() + "/owner/dashboard");
                return;
            }
            // Tenants can browse the landing page even when logged in
        }
        
        // Load popular cities for homepage
        try (Connection conn = DatabaseConfig.getConnection()) {
            CityDAO cityDAO = new CityDAO(conn);
            List<Map<String, Object>> popularCities = cityDAO.getAllCitiesWithCount();
            request.setAttribute("popularCities", popularCities);
        } catch (Exception e) {
            System.err.println("Error loading cities: " + e.getMessage());
        }
        
        request.setAttribute("pageTitle", "Find Your Perfect PG");
        request.setAttribute("contentPage", "/WEB-INF/views/public/landing.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/main-layout.jsp").forward(request, response);
    }
}

