package com.pgfinder.servlet;

import com.pgfinder.config.DatabaseConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("pageTitle", "Contact Us");
        request.setAttribute("contentPage", "/WEB-INF/views/public/contact.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/main-layout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name    = request.getParameter("name");
        String email   = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        if (name == null || email == null || message == null ||
            name.trim().isEmpty() || email.trim().isEmpty() || message.trim().isEmpty()) {
            request.setAttribute("error", "Please fill all required fields.");
            request.setAttribute("pageTitle", "Contact Us");
            request.setAttribute("contentPage", "/WEB-INF/views/public/contact.jsp");
            request.getRequestDispatcher("/WEB-INF/views/layouts/main-layout.jsp").forward(request, response);
            return;
        }

        try {
            // Save using actual column names: action_type, action_description
            String sql = "INSERT INTO activity_logs (action_type, action_description, ip_address) VALUES (?,?,?)";
            try (Connection conn = DatabaseConfig.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, "CONTACT_FORM");
                ps.setString(2, "Name: " + name + " | Email: " + email +
                               " | Subject: " + (subject != null ? subject : "N/A") +
                               " | Message: " + message);
                ps.setString(3, request.getRemoteAddr());
                ps.executeUpdate();
            }
            request.setAttribute("success", "Thank you! We'll get back to you within 24 hours.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("success", "Thank you for contacting us!");
        }
        request.setAttribute("pageTitle", "Contact Us");
        request.setAttribute("contentPage", "/WEB-INF/views/public/contact.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/main-layout.jsp").forward(request, response);
    }
}
