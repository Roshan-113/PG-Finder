package com.pgfinder.servlet;

import com.pgfinder.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/verify-email")
public class VerifyEmailServlet extends HttpServlet {
    private AuthService authService;
    
    @Override
    public void init() {
        authService = new AuthService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String token = request.getParameter("token");
        
        if (token == null || token.trim().isEmpty()) {
            request.setAttribute("error", "Invalid verification link");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            return;
        }
        
        boolean verified = authService.verifyEmail(token);
        
        if (verified) {
            request.setAttribute("success", "Email verified successfully! You can now login.");
        } else {
            request.setAttribute("error", "Verification failed. Link may be expired or invalid.");
        }
        
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }
}
