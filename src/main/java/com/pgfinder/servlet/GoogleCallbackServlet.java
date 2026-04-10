package com.pgfinder.servlet;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.pgfinder.config.GoogleOAuthConfig;
import com.pgfinder.dao.UserDAO;
import com.pgfinder.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Collections;

@WebServlet("/auth/google/callback")
public class GoogleCallbackServlet extends HttpServlet {
    
    private UserDAO userDAO;
    
    @Override
    public void init() {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Verify state parameter
        String state = request.getParameter("state");
        String sessionState = (String) session.getAttribute("oauthState");
        
        if (state == null || !state.equals(sessionState)) {
            request.setAttribute("error", "Invalid OAuth state. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            return;
        }
        
        // Get authorization code
        String code = request.getParameter("code");
        if (code == null) {
            String error = request.getParameter("error");
            request.setAttribute("error", "Google authentication failed: " + (error != null ? error : "No code received"));
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            return;
        }
        
        try {
            // Exchange code for access token
            String accessToken = exchangeCodeForToken(code);
            
            // Get user info from Google
            JsonObject userInfo = getUserInfo(accessToken);
            
            // Extract user details
            String email = userInfo.get("email").getAsString();
            String name = userInfo.get("name").getAsString();
            String googleId = userInfo.get("id").getAsString();
            String picture = userInfo.has("picture") ? userInfo.get("picture").getAsString() : null;
            
            // Get user type from session
            String userType = (String) session.getAttribute("oauthUserType");
            if (userType == null) {
                userType = "tenant";
            }
            
            // Check if user exists
            User user = userDAO.findByEmail(email);
            
            if (user == null) {
                // Create new user
                user = new User();
                user.setName(name);
                user.setEmail(email);
                user.setUserType(userType);
                user.setProfileImage(picture);
                user.setEmailVerified(true); // Google emails are verified
                user.setPasswordHash("OAUTH_" + googleId); // Special marker for OAuth users
                user.setPhone(""); // No phone from Google
                
                boolean created = userDAO.registerUser(user);
                if (!created) {
                    request.setAttribute("error", "Failed to create user account. Please try again.");
                    request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                    return;
                }
                
                // Reload user to get ID
                user = userDAO.findByEmail(email);
            }
            
            // Update last login
            userDAO.updateLastLogin(user.getUserId());
            
            // Create session
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userRole", user.getUserType());
            session.setAttribute("userProfileImage", user.getProfileImage());
            session.setAttribute("emailVerified", user.isEmailVerified());
            session.setMaxInactiveInterval(30 * 60); // 30 minutes
            
            // Clean up OAuth session attributes
            session.removeAttribute("oauthState");
            session.removeAttribute("oauthUserType");
            
            // Redirect to dashboard
            redirectToDashboard(response, request.getContextPath(), user.getUserType());
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Authentication failed: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }
    
    private String exchangeCodeForToken(String code) throws IOException {
        URL url = new URL(GoogleOAuthConfig.TOKEN_URI);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        conn.setDoOutput(true);
        
        String params = "code=" + URLEncoder.encode(code, StandardCharsets.UTF_8) +
                "&client_id=" + URLEncoder.encode(GoogleOAuthConfig.CLIENT_ID, StandardCharsets.UTF_8) +
                "&client_secret=" + URLEncoder.encode(GoogleOAuthConfig.CLIENT_SECRET, StandardCharsets.UTF_8) +
                "&redirect_uri=" + URLEncoder.encode(GoogleOAuthConfig.REDIRECT_URI, StandardCharsets.UTF_8) +
                "&grant_type=authorization_code";
        
        try (OutputStream os = conn.getOutputStream()) {
            os.write(params.getBytes(StandardCharsets.UTF_8));
        }
        
        int responseCode = conn.getResponseCode();
        if (responseCode != 200) {
            throw new IOException("Failed to exchange code for token. Response code: " + responseCode);
        }
        
        try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
            
            JsonObject jsonResponse = JsonParser.parseString(response.toString()).getAsJsonObject();
            return jsonResponse.get("access_token").getAsString();
        }
    }
    
    private JsonObject getUserInfo(String accessToken) throws IOException {
        URL url = new URL(GoogleOAuthConfig.USER_INFO_URI);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + accessToken);
        
        int responseCode = conn.getResponseCode();
        if (responseCode != 200) {
            throw new IOException("Failed to get user info. Response code: " + responseCode);
        }
        
        try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
            
            return JsonParser.parseString(response.toString()).getAsJsonObject();
        }
    }
    
    private void redirectToDashboard(HttpServletResponse response, String contextPath, String userType) 
            throws IOException {
        String redirectUrl;
        switch (userType) {
            case "owner":
                redirectUrl = contextPath + "/owner/dashboard";
                break;
            case "admin":
                redirectUrl = contextPath + "/admin/dashboard";
                break;
            default:
                redirectUrl = contextPath + "/";
                break;
        }
        response.sendRedirect(redirectUrl);
    }
}
