package com.pgfinder.servlet.tenant;

import com.pgfinder.dao.BookingDAO;
import com.pgfinder.dao.PGListingDAO;
import com.pgfinder.model.Booking;
import com.pgfinder.model.PGListing;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/tenant/book-pg")
public class BookingServlet extends HttpServlet {
    private BookingDAO bookingDAO;
    private PGListingDAO pgListingDAO;
    
    @Override
    public void init() {
        bookingDAO = new BookingDAO();
        pgListingDAO = new PGListingDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String listingIdStr = request.getParameter("listingId");
        if (listingIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/find-pg");
            return;
        }
        
        try {
            int listingId = Integer.parseInt(listingIdStr);
            PGListing listing = pgListingDAO.getListingById(listingId);
            
            if (listing == null) {
                response.sendRedirect(request.getContextPath() + "/find-pg");
                return;
            }
            
            request.setAttribute("listing", listing);
            request.setAttribute("pageTitle", "Book PG");
            request.setAttribute("contentPage", "/WEB-INF/views/tenant/booking.jsp");
            request.getRequestDispatcher("/WEB-INF/views/layouts/tenant-layout.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/find-pg");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int userId = (int) session.getAttribute("userId");
        
        try {
            int listingId = Integer.parseInt(request.getParameter("listingId"));
            String moveInDateStr = request.getParameter("moveInDate");
            String specialRequests = request.getParameter("specialRequests");
            String durationStr = request.getParameter("duration");
            int duration = 1;
            try {
                duration = Integer.parseInt(durationStr);
                if (duration < 1) duration = 1;
                if (duration > 12) duration = 12;
            } catch (NumberFormatException ignored) {}
            
            PGListing listing = pgListingDAO.getListingById(listingId);
            if (listing == null) {
                response.sendRedirect(request.getContextPath() + "/find-pg");
                return;
            }
            
            // Total rent = monthly rent × duration
            java.math.BigDecimal totalRent = listing.getRentPerMonth().multiply(java.math.BigDecimal.valueOf(duration));
            
            Booking booking = new Booking();
            booking.setTenantId(userId);
            booking.setListingId(listingId);
            booking.setOwnerId(listing.getOwnerId());
            booking.setBookingDate(new Date(System.currentTimeMillis()));
            booking.setMoveInDate(Date.valueOf(moveInDateStr));
            booking.setRentAmount(totalRent);
            booking.setSecurityDeposit(listing.getSecurityDeposit());
            booking.setSpecialRequests(specialRequests);
            
            System.out.println("Creating booking for tenant: " + userId + ", listing: " + listingId + ", owner: " + listing.getOwnerId());
            
            boolean created = bookingDAO.createBooking(booking);
            
            System.out.println("Booking created: " + created + ", Booking ID: " + booking.getBookingId());
            
            if (created && booking.getBookingId() > 0) {
                // Redirect to payment page with booking ID
                response.sendRedirect(request.getContextPath() + "/tenant/payment?bookingId=" + booking.getBookingId());
            } else {
                System.out.println("ERROR: Booking creation failed or booking ID is 0");
                request.setAttribute("error", "Failed to create booking. Please try again.");
                request.setAttribute("listing", listing);
                request.setAttribute("pageTitle", "Book PG");
                request.setAttribute("contentPage", "/WEB-INF/views/tenant/booking.jsp");
                request.getRequestDispatcher("/WEB-INF/views/layouts/tenant-layout.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/find-pg?error=booking_failed");
        }
    }
}
