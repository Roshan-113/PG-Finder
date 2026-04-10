package com.pgfinder.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/owner/*")
public class OwnerAuthFilter implements Filter {
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        // Log authentication attempt
        String requestURI = httpRequest.getRequestURI();
        System.out.println("OwnerAuthFilter: Checking access to " + requestURI);
        
        // Check if session exists
        if (session == null) {
            System.out.println("OwnerAuthFilter: No session found, redirecting to login");
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }
        
        // Check user role
        String userRole = (String) session.getAttribute("userRole");
        Integer userId = (Integer) session.getAttribute("userId");
        
        System.out.println("OwnerAuthFilter: Session found - UserID: " + userId + ", Role: " + userRole);
        
        if (userRole == null || !"owner".equals(userRole)) {
            System.out.println("OwnerAuthFilter: Invalid role or no role, redirecting to login");
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }
        
        System.out.println("OwnerAuthFilter: Access granted");
        chain.doFilter(request, response);
    }
}
