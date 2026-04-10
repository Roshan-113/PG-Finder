package com.pgfinder.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/cookie-policy")
public class CookiePolicyServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("pageTitle", "Cookie Policy");
        request.setAttribute("contentPage", "/WEB-INF/views/public/cookie-policy.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/main-layout.jsp").forward(request, response);
    }
}
