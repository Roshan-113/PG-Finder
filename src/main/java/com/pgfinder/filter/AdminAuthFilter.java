package com.pgfinder.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/admin/*")
public class AdminAuthFilter implements Filter {
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String userRole = (session != null) ? (String) session.getAttribute("userRole") : null;
        
        if (userRole == null || !"admin".equals(userRole)) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/admin-login");
            return;
        }
        
        chain.doFilter(request, response);
    }
}
