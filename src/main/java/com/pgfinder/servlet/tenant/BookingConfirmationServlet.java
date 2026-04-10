package com.pgfinder.servlet.tenant;

import com.pgfinder.dao.BookingDAO;
import com.pgfinder.dao.UserDAO;
import com.pgfinder.model.Booking;
import com.pgfinder.model.User;
import com.pgfinder.service.EmailService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;

@WebServlet("/tenant/booking-confirmation")
public class BookingConfirmationServlet extends HttpServlet {
    private BookingDAO bookingDAO;
    private UserDAO userDAO;
    private EmailService emailService;
    
    @Override
    public void init() {
        bookingDAO = new BookingDAO();
        userDAO = new UserDAO();
        emailService = new EmailService();
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
            int userId = (int) session.getAttribute("userId");
            
            Booking booking = bookingDAO.getBookingById(bookingId);
            
            if (booking == null) {
                response.sendRedirect(request.getContextPath() + "/tenant/bookings");
                return;
            }
            
            // Send booking confirmation email
            try {
                User tenant = userDAO.getUserById(userId);
                if (tenant != null && tenant.getEmail() != null) {
                    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy");
                    String moveInDate = dateFormat.format(booking.getMoveInDate());
                    
                    // Extract city from address if available
                    String address = booking.getPgAddress() != null ? booking.getPgAddress() : "";
                    String city = "";
                    if (address.contains(",")) {
                        String[] parts = address.split(",");
                        city = parts.length > 1 ? parts[parts.length - 1].trim() : "";
                    }
                    
                    emailService.sendBookingConfirmationEmail(
                        tenant.getEmail(),
                        tenant.getName(),
                        booking.getPgTitle() != null ? booking.getPgTitle() : "PG Accommodation",
                        address,
                        city,
                        moveInDate,
                        String.valueOf(booking.getRentAmount()),
                        String.valueOf(booking.getSecurityDeposit()),
                        String.valueOf(booking.getBookingId()),
                        booking.getOwnerName() != null ? booking.getOwnerName() : "Owner",
                        booking.getOwnerPhone() != null ? booking.getOwnerPhone() : "N/A",
                        booking.getRoomNumber() != null ? booking.getRoomNumber() : "TBA"
                    );
                    System.out.println("Booking confirmation email sent to: " + tenant.getEmail());
                }
            } catch (Exception e) {
                System.err.println("Failed to send booking confirmation email: " + e.getMessage());
                e.printStackTrace();
            }
            
            request.setAttribute("booking", booking);
            request.setAttribute("pageTitle", "Booking Confirmed");
            request.setAttribute("currentPage", "booking-confirmation");
            request.setAttribute("contentPage", "/WEB-INF/views/tenant/booking-confirmation.jsp");
            request.getRequestDispatcher("/WEB-INF/views/layouts/tenant-layout.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/tenant/bookings");
        }
    }
}
