package com.pgfinder.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/tenant/*")
public class TenantAuthFilter implements Filter {
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String userEmail = (session != null) ? (String) session.getAttribute("userEmail") : null;
        String userRole = (session != null) ? (String) session.getAttribute("userRole") : null;
        
        if (userEmail == null || !"tenant".equals(userRole)) {
            // Store the original URL to redirect back after login
            String requestedUrl = httpRequest.getRequestURI();
            if (httpRequest.getQueryString() != null) {
                requestedUrl += "?" + httpRequest.getQueryString();
            }
            session = httpRequest.getSession(true);
            session.setAttribute("redirectAfterLogin", requestedUrl);
            
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }
        
        chain.doFilter(request, response);
    }
}
