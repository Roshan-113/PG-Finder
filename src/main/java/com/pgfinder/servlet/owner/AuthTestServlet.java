package com.pgfinder.servlet.owner;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/owner/auth-test")
public class AuthTestServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession(false);
        
        out.println("<html><head><title>Owner Auth Test</title></head><body>");
        out.println("<h1>Owner Authentication Test</h1>");
        
        if (session == null) {
            out.println("<p style='color: red;'>ERROR: No session found!</p>");
            out.println("<p>This page should not be accessible without login.</p>");
        } else {
            Integer userId = (Integer) session.getAttribute("userId");
            String userRole = (String) session.getAttribute("userRole");
            String userName = (String) session.getAttribute("userName");
            
            out.println("<h2>Session Information:</h2>");
            out.println("<ul>");
            out.println("<li><strong>Session ID:</strong> " + session.getId() + "</li>");
            out.println("<li><strong>User ID:</strong> " + userId + "</li>");
            out.println("<li><strong>User Role:</strong> " + userRole + "</li>");
            out.println("<li><strong>User Name:</strong> " + userName + "</li>");
            out.println("<li><strong>Session Created:</strong> " + new java.util.Date(session.getCreationTime()) + "</li>");
            out.println("<li><strong>Last Accessed:</strong> " + new java.util.Date(session.getLastAccessedTime()) + "</li>");
            out.println("</ul>");
            
            if (!"owner".equals(userRole)) {
                out.println("<p style='color: red;'>WARNING: User role is not 'owner'!</p>");
            } else {
                out.println("<p style='color: green;'>✓ Authentication is working correctly!</p>");
            }
        }
        
        out.println("<p><a href='" + request.getContextPath() + "/owner/dashboard'>Back to Dashboard</a></p>");
        out.println("</body></html>");
    }
}
