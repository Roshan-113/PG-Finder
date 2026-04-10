package com.pgfinder.servlet.owner;

import com.pgfinder.config.DatabaseConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

@WebServlet("/test-db")
public class TestDatabaseServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html><body>");
        out.println("<h1>Database Connection Test</h1>");
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                out.println("<p style='color:green'>✓ Database connection successful!</p>");
                
                // Test pg_listings table
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as count FROM pg_listings");
                if (rs.next()) {
                    out.println("<p>Total PG Listings: " + rs.getInt("count") + "</p>");
                }
                
                // Test users table
                rs = stmt.executeQuery("SELECT COUNT(*) as count FROM users WHERE user_type='owner'");
                if (rs.next()) {
                    out.println("<p>Total Owners: " + rs.getInt("count") + "</p>");
                }
                
                // Test pg_photos table
                rs = stmt.executeQuery("SELECT COUNT(*) as count FROM pg_photos");
                if (rs.next()) {
                    out.println("<p>Total Photos: " + rs.getInt("count") + "</p>");
                }
                
            } else {
                out.println("<p style='color:red'>✗ Database connection failed!</p>");
            }
        } catch (Exception e) {
            out.println("<p style='color:red'>✗ Error: " + e.getMessage() + "</p>");
            e.printStackTrace(out);
        }
        
        out.println("</body></html>");
    }
}
