package com.pgfinder.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/safety-tips")
public class SafetyTipsServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("pageTitle", "Safety Tips");
        request.setAttribute("contentPage", "/WEB-INF/views/public/safety-tips.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/main-layout.jsp").forward(request, response);
    }
}
