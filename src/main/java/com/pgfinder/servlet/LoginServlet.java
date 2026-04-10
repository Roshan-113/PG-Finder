package com.pgfinder.servlet;

import com.pgfinder.model.User;
import com.pgfinder.service.AuthService;
import com.pgfinder.service.AuthService.AuthResult;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private AuthService authService;
    
    @Override
    public void init() {
        authService = new AuthService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userId") != null) {
            String userRole = (String) session.getAttribute("userRole");
            redirectToDashboard(response, request.getContextPath(), userRole);
            return;
        }
        
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");
        
        // Default to tenant if not specified
        if (userType == null || userType.trim().isEmpty()) {
            userType = "tenant";
        }
        
        // Authenticate user
        AuthResult result = authService.login(email, password, userType);
        
        if (result.isSuccess()) {
            User user = result.getUser();
            
            // Create session
            HttpSession session = request.getSession(true);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userRole", user.getUserType());
            session.setAttribute("userProfileImage", user.getProfileImage());
            session.setAttribute("emailVerified", user.isEmailVerified());
            session.setMaxInactiveInterval(30 * 60); // 30 minutes
            
            // Check for redirect URL
            String redirectUrl = (String) session.getAttribute("redirectAfterLogin");
            if (redirectUrl != null) {
                session.removeAttribute("redirectAfterLogin");
                response.sendRedirect(redirectUrl);
            } else {
                redirectToDashboard(response, request.getContextPath(), user.getUserType());
            }
        } else {
            request.setAttribute("error", result.getMessage());
            request.setAttribute("email", email);
            request.setAttribute("userType", userType);
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
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
