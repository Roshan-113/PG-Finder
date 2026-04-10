package com.pgfinder.servlet.owner;

import com.pgfinder.dao.OwnerDAO;
import com.pgfinder.model.Booking;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/owner/bookings")
public class OwnerBookingsServlet extends HttpServlet {
    private OwnerDAO ownerDAO;
    private Gson gson;
    
    @Override
    public void init() {
        ownerDAO = new OwnerDAO();
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
        
        int ownerId = (int) session.getAttribute("userId");
        List<Booking> bookings = ownerDAO.getAllBookings(ownerId);
        
        request.setAttribute("bookings", bookings);
        request.setAttribute("pageTitle", "Manage Bookings");
        request.setAttribute("currentPage", "bookings");
        request.setAttribute("contentPage", "/WEB-INF/views/owner/bookings.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/owner-layout.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        int ownerId = (int) session.getAttribute("userId");
        String action = request.getParameter("action");
        String bookingIdStr = request.getParameter("bookingId");
        
        if (bookingIdStr != null && action != null) {
            int bookingId = Integer.parseInt(bookingIdStr);
            boolean success = false;
            
            if ("accept".equals(action)) {
                success = ownerDAO.updateBookingStatus(bookingId, ownerId, "confirmed");
            } else if ("reject".equals(action)) {
                success = ownerDAO.updateBookingStatus(bookingId, ownerId, "rejected");
            }
            
            Map<String, Boolean> result = new HashMap<>();
            result.put("success", success);
            
            response.setContentType("application/json");
            response.getWriter().write(gson.toJson(result));
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
