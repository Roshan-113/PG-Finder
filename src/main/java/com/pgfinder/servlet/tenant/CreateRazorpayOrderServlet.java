package com.pgfinder.servlet.tenant;

import com.google.gson.Gson;
import com.pgfinder.config.RazorpayConfig;
import com.pgfinder.dao.BookingDAO;
import com.pgfinder.model.Booking;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/tenant/create-razorpay-order")
public class CreateRazorpayOrderServlet extends HttpServlet {
    private BookingDAO bookingDAO;
    private Gson gson;
    
    @Override
    public void init() {
        bookingDAO = new BookingDAO();
        gson = new Gson();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write(gson.toJson(Map.of("error", "Unauthorized")));
            return;
        }
        
        String bookingIdStr = request.getParameter("bookingId");
        if (bookingIdStr == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(Map.of("error", "Booking ID is required")));
            return;
        }
        
        try {
            int bookingId = Integer.parseInt(bookingIdStr);
            Booking booking = bookingDAO.getBookingById(bookingId);
            
            if (booking == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write(gson.toJson(Map.of("error", "Booking not found")));
                return;
            }
            
            // Calculate total amount (rent + security deposit)
            BigDecimal totalAmount = booking.getRentAmount().add(booking.getSecurityDeposit());
            int amountInPaise = totalAmount.multiply(new BigDecimal(100)).intValue();
            
            // Create Razorpay order
            RazorpayClient razorpayClient = RazorpayConfig.getClient();
            JSONObject orderRequest = new JSONObject();
            orderRequest.put("amount", amountInPaise);
            orderRequest.put("currency", "INR");
            orderRequest.put("receipt", "booking_" + bookingId);
            
            JSONObject notes = new JSONObject();
            notes.put("booking_id", bookingId);
            notes.put("tenant_id", booking.getTenantId());
            notes.put("listing_id", booking.getListingId());
            orderRequest.put("notes", notes);
            
            Order order = razorpayClient.orders.create(orderRequest);
            
            // Update booking with Razorpay order ID
            bookingDAO.updateRazorpayOrderId(bookingId, order.get("id"));
            
            // Prepare response
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("orderId", order.get("id"));
            responseData.put("amount", amountInPaise);
            responseData.put("currency", "INR");
            responseData.put("keyId", RazorpayConfig.getKeyId());
            responseData.put("bookingId", bookingId);
            responseData.put("tenantName", booking.getTenantName());
            responseData.put("tenantEmail", booking.getTenantEmail());
            responseData.put("tenantPhone", booking.getTenantPhone());
            
            response.getWriter().write(gson.toJson(responseData));
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(gson.toJson(Map.of("error", "Failed to create order: " + e.getMessage())));
        }
    }
}
