package com.pgfinder.servlet.tenant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/tenant/settings")
public class TenantSettingsServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setAttribute("pageTitle", "Settings");
        request.setAttribute("currentPage", "settings");
        request.setAttribute("contentPage", "/WEB-INF/views/tenant/settings.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/tenant-layout.jsp").forward(request, response);
    }
}
