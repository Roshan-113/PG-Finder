package com.pgfinder.servlet.owner;

import com.pgfinder.dao.OwnerDAO;
import com.pgfinder.model.Inquiry;
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

@WebServlet("/owner/inquiries")
public class OwnerInquiriesServlet extends HttpServlet {
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
        
        // Enhanced authentication check
        if (session == null || session.getAttribute("userId") == null || session.getAttribute("userRole") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Verify user role is owner
        String userRole = (String) session.getAttribute("userRole");
        if (!"owner".equals(userRole)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int ownerId = (int) session.getAttribute("userId");
        List<Inquiry> inquiries = ownerDAO.getInquiries(ownerId);
        
        request.setAttribute("inquiries", inquiries);
        request.setAttribute("pageTitle", "Inquiries");
        request.setAttribute("currentPage", "inquiries");
        request.setAttribute("contentPage", "/WEB-INF/views/owner/inquiries.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/owner-layout.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        Map<String, Object> result = new HashMap<>();
        
        try {
            // Enhanced authentication check
            if (session == null || session.getAttribute("userId") == null || session.getAttribute("userRole") == null) {
                result.put("success", false);
                result.put("message", "Please login first");
                response.getWriter().write(gson.toJson(result));
                return;
            }
            
            // Verify user role is owner
            String userRole = (String) session.getAttribute("userRole");
            if (!"owner".equals(userRole)) {
                result.put("success", false);
                result.put("message", "Unauthorized access");
                response.getWriter().write(gson.toJson(result));
                return;
            }
            
            int ownerId = (int) session.getAttribute("userId");
            String action = request.getParameter("action");
            
            System.out.println("Inquiries - Action: " + action + ", Owner: " + ownerId);
            
            if ("respond".equals(action)) {
                String inquiryIdStr = request.getParameter("inquiryId");
                String responseText = request.getParameter("responseText");
                
                System.out.println("Responding to inquiry: " + inquiryIdStr);
                
                if (inquiryIdStr == null || inquiryIdStr.trim().isEmpty()) {
                    result.put("success", false);
                    result.put("message", "Inquiry ID is required");
                } else if (responseText == null || responseText.trim().isEmpty()) {
                    result.put("success", false);
                    result.put("message", "Response text is required");
                } else {
                    int inquiryId = Integer.parseInt(inquiryIdStr);
                    boolean success = ownerDAO.respondToInquiry(inquiryId, ownerId, responseText.trim());
                    
                    result.put("success", success);
                    result.put("message", success ? "Response sent successfully!" : "Failed to send response");
                    System.out.println("Response result: " + success);
                }
            } else {
                result.put("success", false);
                result.put("message", "Invalid action: " + action);
            }
        } catch (NumberFormatException e) {
            System.err.println("Number format error: " + e.getMessage());
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "Invalid inquiry ID");
        } catch (Exception e) {
            System.err.println("Error in inquiries: " + e.getMessage());
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "Error: " + e.getMessage());
        }
        
        response.getWriter().write(gson.toJson(result));
    }
}
