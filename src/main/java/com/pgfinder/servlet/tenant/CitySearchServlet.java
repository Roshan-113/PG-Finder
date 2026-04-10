package com.pgfinder.servlet.tenant;

import com.pgfinder.dao.CityDAO;
import com.pgfinder.config.DatabaseConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.*;

@WebServlet("/tenant/cities")
public class CitySearchServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            CityDAO cityDAO = new CityDAO(conn);
            
            String action = request.getParameter("action");
            
            if ("stats".equals(action)) {
                String city = request.getParameter("city");
                Map<String, Object> stats = cityDAO.getCityStatistics(city);
                request.setAttribute("cityStats", stats);
                request.setAttribute("selectedCity", city);
            }
            
            List<Map<String, Object>> cities = cityDAO.getAllCitiesWithCount();
            request.setAttribute("cities", cities);
            
            request.getRequestDispatcher("/WEB-INF/views/tenant/cities.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Error loading cities: " + e.getMessage());
        }
    }
}
