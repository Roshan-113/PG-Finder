package com.pgfinder.servlet;

import com.pgfinder.config.DatabaseConfig;
import com.pgfinder.dao.PGListingDAO;
import com.pgfinder.model.PGListing;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet("/write-review")
public class WriteReviewServlet extends HttpServlet {

    private PGListingDAO pgListingDAO;

    @Override
    public void init() { pgListingDAO = new PGListingDAO(); }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String pgIdStr = request.getParameter("pgId");
        String bookingIdStr = request.getParameter("bookingId");
        if (pgIdStr != null) {
            try {
                PGListing listing = pgListingDAO.getListingById(Integer.parseInt(pgIdStr));
                request.setAttribute("listing", listing);
            } catch (NumberFormatException ignored) {}
        }
        request.setAttribute("pgId", pgIdStr);
        request.setAttribute("bookingId", bookingIdStr);
        request.setAttribute("pageTitle", "Write Review");
        request.setAttribute("contentPage", "/WEB-INF/views/tenant/write-review.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/tenant-layout.jsp").forward(request, response);
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
        String pgIdStr      = request.getParameter("pgId");
        String bookingIdStr = request.getParameter("bookingId");
        String ratingStr    = request.getParameter("rating");
        String reviewText   = request.getParameter("reviewText");
        String cleanStr     = request.getParameter("cleanlinessRating");
        String foodStr      = request.getParameter("foodRating");
        String safetyStr    = request.getParameter("safetyRating");

        if (pgIdStr == null || ratingStr == null || reviewText == null || reviewText.trim().isEmpty()) {
            request.setAttribute("error", "Please fill all required fields.");
            doGet(request, response);
            return;
        }
        try {
            int listingId = Integer.parseInt(pgIdStr);
            int rating    = Integer.parseInt(ratingStr);
            Integer bookingId = (bookingIdStr != null && !bookingIdStr.isEmpty())
                    ? Integer.parseInt(bookingIdStr) : null;

            // Check if already reviewed
            String checkSql = "SELECT review_id FROM reviews WHERE listing_id=? AND tenant_id=?";
            try (Connection conn = DatabaseConfig.getConnection();
                 PreparedStatement check = conn.prepareStatement(checkSql)) {
                check.setInt(1, listingId);
                check.setInt(2, userId);
                if (check.executeQuery().next()) {
                    request.setAttribute("error", "You have already reviewed this PG.");
                    doGet(request, response);
                    return;
                }
            }

            String sql = "INSERT INTO reviews (listing_id, tenant_id, booking_id, rating, review_text, " +
                         "cleanliness_rating, food_rating, safety_rating) VALUES (?,?,?,?,?,?,?,?)";
            try (Connection conn = DatabaseConfig.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, listingId);
                ps.setInt(2, userId);
                if (bookingId != null) ps.setInt(3, bookingId); else ps.setNull(3, Types.INTEGER);
                ps.setInt(4, rating);
                ps.setString(5, reviewText.trim());
                ps.setObject(6, cleanStr != null && !cleanStr.isEmpty() ? Integer.parseInt(cleanStr) : null);
                ps.setObject(7, foodStr  != null && !foodStr.isEmpty()  ? Integer.parseInt(foodStr)  : null);
                ps.setObject(8, safetyStr != null && !safetyStr.isEmpty() ? Integer.parseInt(safetyStr) : null);
                ps.executeUpdate();
            }
            response.sendRedirect(request.getContextPath() + "/tenant/bookings?reviewSuccess=true");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to submit review. Please try again.");
            doGet(request, response);
        }
    }
}
