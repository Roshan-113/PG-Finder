package com.pgfinder.servlet.tenant;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.pgfinder.config.RazorpayConfig;
import com.pgfinder.dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.Map;

/**
 * Webhook endpoint for Razorpay payment notifications
 * This provides an additional layer of payment verification
 * Configure this URL in Razorpay Dashboard: Settings → Webhooks
 */
@WebServlet("/webhooks/razorpay")
public class RazorpayWebhookServlet extends HttpServlet {
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
        
        try {
            // Read webhook payload
            StringBuilder payload = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                payload.append(line);
            }
            
            String webhookBody = payload.toString();
            String webhookSignature = request.getHeader("X-Razorpay-Signature");
            
            // Verify webhook signature
            if (!verifyWebhookSignature(webhookBody, webhookSignature)) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write(gson.toJson(Map.of("error", "Invalid signature")));
                return;
            }
            
            // Parse webhook data
            JsonObject webhookData = gson.fromJson(webhookBody, JsonObject.class);
            String event = webhookData.get("event").getAsString();
            
            // Handle different webhook events
            switch (event) {
                case "payment.authorized":
                    handlePaymentAuthorized(webhookData);
                    break;
                case "payment.captured":
                    handlePaymentCaptured(webhookData);
                    break;
                case "payment.failed":
                    handlePaymentFailed(webhookData);
                    break;
                default:
                    System.out.println("Unhandled webhook event: " + event);
            }
            
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write(gson.toJson(Map.of("status", "success")));
            
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(gson.toJson(Map.of("error", e.getMessage())));
        }
    }
    
    private boolean verifyWebhookSignature(String payload, String signature) {
        try {
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
            
            return hexString.toString().equals(signature);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private void handlePaymentAuthorized(JsonObject webhookData) {
        System.out.println("Payment authorized: " + webhookData);
        // Payment is authorized but not yet captured
        // You can capture it manually or let it auto-capture
    }
    
    private void handlePaymentCaptured(JsonObject webhookData) {
        try {
            JsonObject payload = webhookData.getAsJsonObject("payload");
            JsonObject payment = payload.getAsJsonObject("payment").getAsJsonObject("entity");
            
            String paymentId = payment.get("id").getAsString();
            String orderId = payment.get("order_id").getAsString();
            
            // Extract booking ID from order notes
            JsonObject notes = payment.getAsJsonObject("notes");
            if (notes != null && notes.has("booking_id")) {
                int bookingId = notes.get("booking_id").getAsInt();
                
                // Update booking status
                bookingDAO.updatePaymentStatus(bookingId, "paid", "confirmed");
                System.out.println("Payment captured for booking: " + bookingId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private void handlePaymentFailed(JsonObject webhookData) {
        try {
            JsonObject payload = webhookData.getAsJsonObject("payload");
            JsonObject payment = payload.getAsJsonObject("payment").getAsJsonObject("entity");
            
            String orderId = payment.get("order_id").getAsString();
            System.out.println("Payment failed for order: " + orderId);
            
            // You can update booking status to 'payment_failed' if needed
            // Or send notification to user
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
