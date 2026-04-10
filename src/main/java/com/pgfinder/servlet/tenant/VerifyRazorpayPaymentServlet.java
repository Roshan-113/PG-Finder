package com.pgfinder.servlet.tenant;

import com.google.gson.Gson;
import com.pgfinder.config.RazorpayConfig;
import com.pgfinder.dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.IOException;
import java.util.Map;

@WebServlet("/tenant/verify-razorpay-payment")
public class VerifyRazorpayPaymentServlet extends HttpServlet {
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
            response.getWriter().write(gson.toJson(Map.of("success", false, "error", "Unauthorized")));
            return;
        }
        
        String razorpayOrderId = request.getParameter("razorpay_order_id");
        String razorpayPaymentId = request.getParameter("razorpay_payment_id");
        String razorpaySignature = request.getParameter("razorpay_signature");
        String bookingIdStr = request.getParameter("booking_id");
        
        if (razorpayOrderId == null || razorpayPaymentId == null || 
            razorpaySignature == null || bookingIdStr == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(gson.toJson(Map.of("success", false, "error", "Missing parameters")));
            return;
        }
        
        try {
            // Verify signature
            String generatedSignature = generateSignature(razorpayOrderId, razorpayPaymentId);
            
            if (generatedSignature.equals(razorpaySignature)) {
                // Signature is valid, update booking
                int bookingId = Integer.parseInt(bookingIdStr);
                boolean updated = bookingDAO.updatePaymentDetails(
                    bookingId, 
                    razorpayOrderId, 
                    razorpayPaymentId, 
                    razorpaySignature,
                    "paid",
                    "confirmed"
                );
                
                if (updated) {
                    // Auto-populate roommate profile from confirmed booking
                    bookingDAO.upsertRoommateProfileFromBooking(bookingId);
                    response.getWriter().write(gson.toJson(Map.of(
                        "success", true,
                        "message", "Payment verified successfully",
                        "bookingId", bookingId
                    )));
                } else {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write(gson.toJson(Map.of(
                        "success", false,
                        "error", "Failed to update booking"
                    )));
                }
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write(gson.toJson(Map.of(
                    "success", false,
                    "error", "Invalid signature"
                )));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(gson.toJson(Map.of(
                "success", false,
                "error", "Payment verification failed: " + e.getMessage()
            )));
        }
    }
    
    private String generateSignature(String orderId, String paymentId) throws Exception {
        String payload = orderId + "|" + paymentId;
        String secret = RazorpayConfig.getKeySecret();
        
        Mac mac = Mac.getInstance("HmacSHA256");
        SecretKeySpec secretKeySpec = new SecretKeySpec(secret.getBytes(), "HmacSHA256");
        mac.init(secretKeySpec);
        
        byte[] hash = mac.doFinal(payload.getBytes());
        StringBuilder hexString = new StringBuilder();
        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) hexString.append('0');
            hexString.append(hex);
        }
        return hexString.toString();
    }
}
