package com.pgfinder.servlet.tenant;

import com.pgfinder.config.RazorpayConfig;
import com.pgfinder.dao.BookingDAO;
import com.pgfinder.model.Booking;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/tenant/payment")
public class PaymentServlet extends HttpServlet {
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
        
        String bookingIdStr = request.getParameter("bookingId");
        if (bookingIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/tenant/bookings");
            return;
        }
        
        try {
            int bookingId = Integer.parseInt(bookingIdStr);
            Booking booking = bookingDAO.getBookingById(bookingId);
            
            if (booking == null) {
                response.sendRedirect(request.getContextPath() + "/tenant/bookings");
                return;
            }
            
            // Calculate total amount
            BigDecimal totalAmount = booking.getRentAmount().add(booking.getSecurityDeposit());
            
            request.setAttribute("booking", booking);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("razorpayKeyId", RazorpayConfig.getKeyId());
            request.setAttribute("pageTitle", "Payment");
            request.setAttribute("currentPage", "payment");
            request.setAttribute("contentPage", "/WEB-INF/views/tenant/payment.jsp");
            request.getRequestDispatcher("/WEB-INF/views/layouts/tenant-layout.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/tenant/bookings");
        }
    }
}
