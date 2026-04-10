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

@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet {
    private AuthService authService;
    
    @Override
    public void init() {
        authService = new AuthService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if already logged in as admin
        HttpSession session = request.getSession(false);
        if (session != null && "admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }
        
        request.getRequestDispatcher("/WEB-INF/views/auth/admin-login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Authenticate as admin
        AuthResult result = authService.login(email, password, "admin");
        
        if (result.isSuccess()) {
            User user = result.getUser();
            
            // Create session
            HttpSession session = request.getSession(true);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userRole", "admin");
            session.setAttribute("userProfileImage", user.getProfileImage());
            session.setMaxInactiveInterval(30 * 60); // 30 minutes
            
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            request.setAttribute("error", result.getMessage());
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/views/auth/admin-login.jsp").forward(request, response);
        }
    }
}
