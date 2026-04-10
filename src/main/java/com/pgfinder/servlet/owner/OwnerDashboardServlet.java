package com.pgfinder.servlet.owner;

import com.pgfinder.dao.OwnerDAO;
import com.pgfinder.model.Booking;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/owner/dashboard")
public class OwnerDashboardServlet extends HttpServlet {
    private OwnerDAO ownerDAO;
    
    @Override
    public void init() {
        ownerDAO = new OwnerDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int ownerId = (int) session.getAttribute("userId");
        
        Map<String, Object> stats = ownerDAO.getDashboardStats(ownerId);
        request.setAttribute("stats", stats);
        
        List<Booking> recentBookings = ownerDAO.getRecentBookings(ownerId, 5);
        request.setAttribute("recentBookings", recentBookings);
        
        request.setAttribute("pageTitle", "Owner Dashboard");
        request.setAttribute("currentPage", "dashboard");
        request.setAttribute("contentPage", "/WEB-INF/views/owner/dashboard.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/owner-layout.jsp").forward(request, response);
    }
}
