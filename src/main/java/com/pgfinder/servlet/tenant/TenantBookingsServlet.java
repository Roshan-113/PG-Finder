package com.pgfinder.servlet.tenant;

import com.pgfinder.dao.BookingDAO;
import com.pgfinder.model.Booking;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/tenant/bookings")
public class TenantBookingsServlet extends HttpServlet {
    private BookingDAO bookingDAO;
    
    @Override
    public void init() {
        bookingDAO = new BookingDAO();
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
        List<Booking> bookings = bookingDAO.getBookingsByTenant(userId);
        
        request.setAttribute("bookings", bookings);
        request.setAttribute("pageTitle", "My Bookings");
        request.setAttribute("currentPage", "bookings");
        request.setAttribute("contentPage", "/WEB-INF/views/tenant/bookings.jsp");
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
        String bookingIdStr = request.getParameter("bookingId");
        
        if ("cancel".equals(action) && bookingIdStr != null) {
            try {
                int bookingId = Integer.parseInt(bookingIdStr);
                boolean success = bookingDAO.cancelBooking(bookingId, userId);
                
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": " + success + "}");
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
