package com.pgfinder.servlet.admin;

import com.pgfinder.dao.CityDAO;
import com.pgfinder.config.DatabaseConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.*;

@WebServlet("/admin/cities")
public class AdminCitiesServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null || 
            !"admin".equals(session.getAttribute("userType"))) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            CityDAO cityDAO = new CityDAO(conn);
            
            List<Map<String, Object>> cities = cityDAO.getAllCitiesWithCount();
            request.setAttribute("cities", cities);
            
            request.getRequestDispatcher("/WEB-INF/views/admin/cities.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Error loading cities: " + e.getMessage());
        }
    }
}
