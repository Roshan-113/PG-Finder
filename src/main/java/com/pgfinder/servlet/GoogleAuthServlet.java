package com.pgfinder.servlet;

import com.pgfinder.config.GoogleOAuthConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/auth/google")
public class GoogleAuthServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get user type from request
        String userType = request.getParameter("userType");
        if (userType == null || userType.trim().isEmpty()) {
            userType = "tenant";
        }
        
        // Store user type in session for callback
        HttpSession session = request.getSession();
        session.setAttribute("oauthUserType", userType);
        
        // Build Google OAuth URL
        String state = generateState();
        session.setAttribute("oauthState", state);
        
        String authUrl = GoogleOAuthConfig.AUTH_URI +
                "?client_id=" + URLEncoder.encode(GoogleOAuthConfig.CLIENT_ID, StandardCharsets.UTF_8) +
                "&redirect_uri=" + URLEncoder.encode(GoogleOAuthConfig.REDIRECT_URI, StandardCharsets.UTF_8) +
                "&response_type=code" +
                "&scope=" + URLEncoder.encode(GoogleOAuthConfig.SCOPE, StandardCharsets.UTF_8) +
                "&state=" + URLEncoder.encode(state, StandardCharsets.UTF_8) +
                "&access_type=offline" +
                "&prompt=select_account";
        
        response.sendRedirect(authUrl);
    }
    
    private String generateState() {
        return java.util.UUID.randomUUID().toString();
    }
}
