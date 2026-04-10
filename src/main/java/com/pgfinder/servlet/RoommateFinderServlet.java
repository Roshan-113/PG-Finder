package com.pgfinder.servlet;

import com.pgfinder.config.DatabaseConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/find-roommate")
public class RoommateFinderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        int currentUserId = -1;
        if (session != null && session.getAttribute("userId") != null) {
            currentUserId = (int) session.getAttribute("userId");
        }

        String city   = request.getParameter("city");
        String gender = request.getParameter("gender");

        List<Map<String, Object>> roommates = getRoommateProfiles(currentUserId, city, gender);

        request.setAttribute("roommates", roommates);
        request.setAttribute("filterCity", city);
        request.setAttribute("filterGender", gender);
        request.setAttribute("pageTitle", "Find Roommate");
        request.setAttribute("currentPage", "roommate");
        request.setAttribute("contentPage", "/WEB-INF/views/public/roommate-finder.jsp");

        // Check if logged-in user already has a profile
        if (currentUserId > 0) {
            Map<String, Object> myProfile = getMyProfile(currentUserId);
            request.setAttribute("myProfile", myProfile);
        }

        String layout = (currentUserId != -1)
                ? "/WEB-INF/views/layouts/tenant-layout.jsp"
                : "/WEB-INF/views/layouts/main-layout.jsp";

        request.getRequestDispatcher(layout).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String gender            = request.getParameter("gender");
        String occupation        = request.getParameter("occupation");
        String preferredLocation = request.getParameter("preferredLocation");
        String budgetMin         = request.getParameter("budgetMin");
        String budgetMax         = request.getParameter("budgetMax");
        String moveInDate        = request.getParameter("moveInDate");
        String bio               = request.getParameter("bio");
        String ageStr            = request.getParameter("age");

        try (Connection conn = DatabaseConfig.getConnection()) {
            // Check if profile exists
            boolean exists = false;
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT profile_id FROM roommate_profiles WHERE user_id = ?")) {
                ps.setInt(1, userId);
                exists = ps.executeQuery().next();
            }

            String sql = exists
                ? "UPDATE roommate_profiles SET gender=?, occupation=?, preferred_location=?, " +
                  "budget_min=?, budget_max=?, move_in_date=?, bio=?, age=?, is_active=1, " +
                  "updated_at=NOW() WHERE user_id=?"
                : "INSERT INTO roommate_profiles (gender, occupation, preferred_location, " +
                  "budget_min, budget_max, move_in_date, bio, age, user_id) VALUES (?,?,?,?,?,?,?,?,?)";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, gender);
                ps.setString(2, occupation != null ? occupation : "");
                ps.setString(3, preferredLocation != null ? preferredLocation : "");
                if (budgetMin != null && !budgetMin.isEmpty())
                    ps.setBigDecimal(4, new java.math.BigDecimal(budgetMin));
                else ps.setNull(4, Types.DECIMAL);
                if (budgetMax != null && !budgetMax.isEmpty())
                    ps.setBigDecimal(5, new java.math.BigDecimal(budgetMax));
                else ps.setNull(5, Types.DECIMAL);
                if (moveInDate != null && !moveInDate.isEmpty())
                    ps.setDate(6, java.sql.Date.valueOf(moveInDate));
                else ps.setNull(6, Types.DATE);
                ps.setString(7, bio != null ? bio : "");
                if (ageStr != null && !ageStr.isEmpty())
                    ps.setInt(8, Integer.parseInt(ageStr));
                else ps.setNull(8, Types.INTEGER);
                ps.setInt(9, userId);
                ps.executeUpdate();
            }
            request.setAttribute("profileSuccess", "Your roommate profile has been saved successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("profileError", "Failed to save profile. Please try again.");
        }

        doGet(request, response);
    }

    private List<Map<String, Object>> getRoommateProfiles(int excludeUserId, String city, String gender) {
        List<Map<String, Object>> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
            "SELECT rp.profile_id, rp.user_id, rp.age, rp.gender, rp.occupation, " +
            "rp.preferred_location, rp.budget_min, rp.budget_max, rp.move_in_date, " +
            "rp.bio, rp.created_at, u.name, u.profile_image, u.is_verified " +
            "FROM roommate_profiles rp " +
            "JOIN users u ON rp.user_id = u.user_id " +
            "WHERE rp.is_active = 1 AND u.is_active = 1 "
        );

        List<Object> params = new ArrayList<>();
        if (excludeUserId > 0) {
            sql.append("AND rp.user_id != ? ");
            params.add(excludeUserId);
        }
        if (city != null && !city.isEmpty()) {
            sql.append("AND rp.preferred_location LIKE ? ");
            params.add("%" + city + "%");
        }
        if (gender != null && !gender.isEmpty()) {
            sql.append("AND rp.gender = ? ");
            params.add(gender);
        }
        sql.append("ORDER BY rp.created_at DESC LIMIT 50");

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> m = new HashMap<>();
                m.put("profileId", rs.getInt("profile_id"));
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
                list.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private Map<String, Object> getMyProfile(int userId) {
        String sql = "SELECT * FROM roommate_profiles WHERE user_id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Map<String, Object> m = new HashMap<>();
                m.put("age", rs.getObject("age"));
                m.put("gender", rs.getString("gender"));
                m.put("occupation", rs.getString("occupation"));
                m.put("preferredLocation", rs.getString("preferred_location"));
                m.put("budgetMin", rs.getBigDecimal("budget_min"));
                m.put("budgetMax", rs.getBigDecimal("budget_max"));
                m.put("bio", rs.getString("bio"));
                m.put("moveInDate", rs.getDate("move_in_date"));
                m.put("isActive", rs.getBoolean("is_active"));
                return m;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
