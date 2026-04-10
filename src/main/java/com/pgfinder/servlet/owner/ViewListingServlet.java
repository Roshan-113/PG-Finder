package com.pgfinder.servlet.owner;

import com.pgfinder.dao.PGListingDAO;
import com.pgfinder.model.PGListing;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/owner/view-listing")
public class ViewListingServlet extends HttpServlet {
    private PGListingDAO pgListingDAO;
    
    @Override
    public void init() {
        pgListingDAO = new PGListingDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String listingIdStr = request.getParameter("id");
        if (listingIdStr == null || listingIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/owner/listings");
            return;
        }
        
        try {
            int listingId = Integer.parseInt(listingIdStr);
            PGListing listing = pgListingDAO.getListingById(listingId);
            
            if (listing == null) {
                response.sendRedirect(request.getContextPath() + "/owner/listings");
                return;
            }
            
            // Ensure photos are loaded
            if (listing.getPhotos() == null || listing.getPhotos().isEmpty()) {
                listing.setPhotos(pgListingDAO.getListingPhotos(listingId));
            }
            
            request.setAttribute("listing", listing);
            request.setAttribute("pageTitle", listing.getTitle());
            request.setAttribute("currentPage", "listings");
            request.setAttribute("contentPage", "/WEB-INF/views/owner/view-listing.jsp");
            request.getRequestDispatcher("/WEB-INF/views/layouts/owner-layout.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/owner/listings");
        }
    }
}
