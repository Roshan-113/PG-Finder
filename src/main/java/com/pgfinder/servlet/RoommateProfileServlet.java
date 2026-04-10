package com.pgfinder.servlet;

import com.pgfinder.config.DatabaseConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/roommate-profile")
public class RoommateProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String roommateIdStr = request.getParameter("id");
        if (roommateIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/find-roommate");
            return;
        }

        try {
            int roommateId = Integer.parseInt(roommateIdStr);
            Map<String, Object> profile = getProfileByUserId(roommateId);
            request.setAttribute("profile", profile);
        } catch (NumberFormatException e) {
            // ignore, profile stays null
        }

        request.setAttribute("pageTitle", "Roommate Profile");
        request.setAttribute("contentPage", "/WEB-INF/views/public/roommate-profile.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/main-layout.jsp").forward(request, response);
    }

    private Map<String, Object> getProfileByUserId(int userId) {
        String sql = "SELECT rp.profile_id, rp.user_id, rp.age, rp.gender, rp.occupation, " +
                     "rp.preferred_location, rp.budget_min, rp.budget_max, rp.move_in_date, " +
                     "rp.bio, rp.room_number, u.name, u.profile_image, u.is_verified, " +
                     "COALESCE(l.title, '') as pg_name, COALESCE(l.city, rp.preferred_location, '') as city " +
                     "FROM roommate_profiles rp " +
                     "JOIN users u ON rp.user_id = u.user_id " +
                     "LEFT JOIN pg_listings l ON rp.pg_listing_id = l.listing_id " +
                     "WHERE rp.user_id = ? AND rp.is_active = 1";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Map<String, Object> m = new HashMap<>();
                m.put("userId", rs.getInt("user_id"));
                m.put("name", rs.getString("name"));
                m.put("profileImage", rs.getString("profile_image"));
                m.put("verified", rs.getBoolean("is_verified"));
                m.put("gender", rs.getString("gender"));
                m.put("age", rs.getObject("age"));
                m.put("occupation", rs.getString("occupation"));
                m.put("preferredLocation", rs.getString("preferred_location"));
                m.put("budgetMin", rs.getBigDecimal("budget_min"));
                m.put("budgetMax", rs.getBigDecimal("budget_max"));
                m.put("bio", rs.getString("bio"));
                m.put("moveInDate", rs.getDate("move_in_date"));
                m.put("pgName", rs.getString("pg_name"));
                m.put("city", rs.getString("city"));
                m.put("roomNumber", rs.getString("room_number"));
                return m;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
