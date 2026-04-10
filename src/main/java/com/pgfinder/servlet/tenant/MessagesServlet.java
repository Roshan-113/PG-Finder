package com.pgfinder.servlet.tenant;

import com.pgfinder.dao.MessageDAO;
import com.pgfinder.model.Message;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@WebServlet("/tenant/messages")
public class MessagesServlet extends HttpServlet {
    private MessageDAO messageDAO;
    private Gson gson;
    
    @Override
    public void init() {
        messageDAO = new MessageDAO();
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
        
        int userId = (int) session.getAttribute("userId");
        String action = request.getParameter("action");
        
        if ("getConversations".equals(action)) {
            List<Map<String, Object>> conversations = messageDAO.getConversations(userId);
            response.setContentType("application/json");
            response.getWriter().write(gson.toJson(conversations));
            return;
        }
        
        if ("getMessages".equals(action)) {
            String otherUserIdStr = request.getParameter("otherUserId");
            if (otherUserIdStr != null) {
                int otherUserId = Integer.parseInt(otherUserIdStr);
                List<Message> messages = messageDAO.getMessagesBetweenUsers(userId, otherUserId);
                messageDAO.markAsRead(otherUserId, userId);
                response.setContentType("application/json");
                response.getWriter().write(gson.toJson(messages));
                return;
            }
        }
        
        // Check if opening conversation with specific user (from roommate finder or PG details)
        String roommateIdParam = request.getParameter("roommateId");
        String roommateNameParam = request.getParameter("roommateName");
        String ownerIdParam = request.getParameter("ownerId");
        String listingIdParam = request.getParameter("listingId");
        
        List<Map<String, Object>> conversations = messageDAO.getConversations(userId);
        request.setAttribute("conversations", conversations);
        request.setAttribute("pageTitle", "Messages");
        request.setAttribute("currentPage", "messages");
        
        // If opening specific conversation with roommate
        if (roommateIdParam != null && roommateNameParam != null) {
            request.setAttribute("openRoommateId", roommateIdParam);
            request.setAttribute("openRoommateName", roommateNameParam);
        }
        
        // If opening conversation with owner (from Contact Owner / Send Inquiry)
        if (ownerIdParam != null) {
            request.setAttribute("openRoommateId", ownerIdParam);
            request.setAttribute("openRoommateName", "PG Owner");
            if (listingIdParam != null) {
                request.setAttribute("openListingId", listingIdParam);
            }
        }
        
        request.setAttribute("contentPage", "/WEB-INF/views/tenant/messages.jsp");
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
        
        if ("sendMessage".equals(action)) {
            String receiverIdStr = request.getParameter("receiverId");
            String messageText = request.getParameter("messageText");
            String listingIdStr = request.getParameter("listingId");
            
            if (receiverIdStr != null && messageText != null && !messageText.trim().isEmpty()) {
                Message message = new Message();
                message.setSenderId(userId);
                message.setReceiverId(Integer.parseInt(receiverIdStr));
                message.setMessageText(messageText.trim());
                
                if (listingIdStr != null && !listingIdStr.isEmpty()) {
                    message.setListingId(Integer.parseInt(listingIdStr));
                }
                
                boolean success = messageDAO.sendMessage(message);
                
                Map<String, Object> result = new HashMap<>();
                result.put("success", success);
                if (success) {
                    result.put("message", message);
                }
                
                response.setContentType("application/json");
                response.getWriter().write(gson.toJson(result));
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        }
    }
}
