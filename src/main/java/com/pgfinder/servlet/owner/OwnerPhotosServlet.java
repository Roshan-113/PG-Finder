package com.pgfinder.servlet.owner;

import com.pgfinder.dao.PGListingDAO;
import com.pgfinder.model.PGListing;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.nio.file.*;
import java.sql.*;
import java.util.*;

import com.pgfinder.config.DatabaseConfig;

@WebServlet("/owner/photos")
@MultipartConfig(
    maxFileSize = 20971520,     // 20MB per file
    maxRequestSize = 104857600  // 100MB total
)
public class OwnerPhotosServlet extends HttpServlet {

    private PGListingDAO pgListingDAO;
    private Gson gson;
    private static final String UPLOAD_DIR = "uploads/pg-photos";

    @Override
    public void init() {
        pgListingDAO = new PGListingDAO();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int ownerId = (int) session.getAttribute("userId");
        List<PGListing> listings = pgListingDAO.getListingsByOwner(ownerId);

        request.setAttribute("listings", listings);
        request.setAttribute("contentPage", "/WEB-INF/views/owner/photos.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/owner-layout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> result = new HashMap<>();

        try {

            String action = request.getParameter("action");

            if ("upload".equals(action)) {

                int listingId = Integer.parseInt(request.getParameter("listingId"));

                Collection<Part> parts = request.getParts();
                int fileCount = 0;

                for (Part part : parts) {

                    if (!"photos".equals(part.getName())) continue;
                    if (part.getSize() == 0) continue;

                    fileCount++;

                    if (fileCount > 5) {
                        result.put("success", false);
                        result.put("message", "Max 5 photos allowed");
                        response.getWriter().write(gson.toJson(result));
                        return;
                    }

                    if (part.getSize() > 20971520) {
                        result.put("success", false);
                        result.put("message", "File must be < 20MB");
                        response.getWriter().write(gson.toJson(result));
                        return;
                    }

                    String fileName = part.getSubmittedFileName();
                    String ext = fileName.substring(fileName.lastIndexOf("."));
                    String uniqueFileName = UUID.randomUUID() + ext;

                    String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdirs();

                    Path filePath = Paths.get(uploadPath, uniqueFileName);

                    try (InputStream input = part.getInputStream()) {
                        Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
                    }

                    String photoUrl = request.getContextPath() + "/" + UPLOAD_DIR + "/" + uniqueFileName;

                    int displayOrder = getPhotoCount(listingId) + 1;
                    boolean isPrimary = (displayOrder == 1);

                    savePhotoToDatabase(listingId, photoUrl, isPrimary, displayOrder);
                }

                if (fileCount == 0) {
                    result.put("success", false);
                    result.put("message", "Select at least 1 photo");
                    response.getWriter().write(gson.toJson(result));
                    return;
                }

                result.put("success", true);
                result.put("message", "Photos uploaded successfully");
            }

        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "Error: " + e.getMessage());
        }

        response.getWriter().write(gson.toJson(result));
    }

    private int getPhotoCount(int listingId) {
        String sql = "SELECT COUNT(*) FROM pg_photos WHERE listing_id=?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, listingId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    private boolean savePhotoToDatabase(int listingId, String url, boolean isPrimary, int order) {
        String sql = "INSERT INTO pg_photos (listing_id, photo_url, is_primary, display_order) VALUES (?, ?, ?, ?)";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, listingId);
            ps.setString(2, url);
            ps.setBoolean(3, isPrimary);
            ps.setInt(4, order);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}