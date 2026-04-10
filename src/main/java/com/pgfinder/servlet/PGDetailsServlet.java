package com.pgfinder.servlet;

import com.pgfinder.dao.PGListingDAO;
import com.pgfinder.dao.SavedPGDAO;
import com.pgfinder.model.PGListing;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/pg-details")
public class PGDetailsServlet extends HttpServlet {
    private PGListingDAO pgListingDAO;
    private SavedPGDAO savedPGDAO;
    
    @Override
    public void init() {
        pgListingDAO = new PGListingDAO();
        savedPGDAO = new SavedPGDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String listingIdStr = request.getParameter("id");
        if (listingIdStr == null || listingIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/pg-listing");
            return;
        }
        
        try {
            int listingId = Integer.parseInt(listingIdStr);
            PGListing listing = pgListingDAO.getListingById(listingId);
            
            if (listing == null) {
                response.sendRedirect(request.getContextPath() + "/pg-listing");
                return;
            }
            
            // Ensure photos are loaded
            if (listing.getPhotos() == null || listing.getPhotos().isEmpty()) {
                listing.setPhotos(pgListingDAO.getListingPhotos(listingId));
            }
            
            // Check if saved by current user
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("userId") != null) {
                int userId = (int) session.getAttribute("userId");
                listing.setSaved(savedPGDAO.isSaved(userId, listingId));
            }
            
            request.setAttribute("listing", listing);
            request.setAttribute("pageTitle", listing.getTitle());
            request.setAttribute("contentPage", "/WEB-INF/views/public/pg-details.jsp");
            request.getRequestDispatcher("/WEB-INF/views/layouts/main-layout.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/pg-listing");
        }
    }
}
