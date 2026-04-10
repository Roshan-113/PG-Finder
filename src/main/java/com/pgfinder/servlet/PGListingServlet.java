package com.pgfinder.servlet;

import com.pgfinder.dao.PGListingDAO;
import com.pgfinder.model.PGListing;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet({"/find-pg", "/pg-listing", "/search-pg"})
public class PGListingServlet extends HttpServlet {
    private PGListingDAO pgListingDAO;
    
    @Override
    public void init() {
        pgListingDAO = new PGListingDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get search parameters
        String city = request.getParameter("city");
        String pgType = request.getParameter("pgType");
        String gender = request.getParameter("gender");
        String amenities = request.getParameter("amenities");
        String minRentStr = request.getParameter("minRent");
        String maxRentStr = request.getParameter("maxRent");
        
        // Debug logging
        System.out.println("=== PG Listing Filter Parameters ===");
        System.out.println("City: " + city);
        System.out.println("PG Type: " + pgType);
        System.out.println("Gender: " + gender);
        System.out.println("Amenities: " + amenities);
        System.out.println("Min Rent: " + minRentStr);
        System.out.println("Max Rent: " + maxRentStr);
        
        Double minRent = null;
        Double maxRent = null;
        
        try {
            if (minRentStr != null && !minRentStr.isEmpty()) {
                minRent = Double.parseDouble(minRentStr);
            }
            if (maxRentStr != null && !maxRentStr.isEmpty()) {
                maxRent = Double.parseDouble(maxRentStr);
            }
        } catch (NumberFormatException e) {
            System.err.println("Error parsing rent values: " + e.getMessage());
        }
        
        // Get listings with all filters
        List<PGListing> listings;
        if (city != null || pgType != null || gender != null || amenities != null || minRent != null || maxRent != null) {
            System.out.println("Applying filters...");
            listings = pgListingDAO.searchListings(city, pgType, gender, amenities, minRent, maxRent);
            System.out.println("Found " + listings.size() + " listings");
        } else {
            System.out.println("No filters applied, getting all listings");
            listings = pgListingDAO.getAllListings();
            System.out.println("Found " + listings.size() + " listings");
        }
        
        request.setAttribute("listings", listings);
        request.setAttribute("searchCity", city);
        request.setAttribute("searchPgType", pgType);
        request.setAttribute("searchGender", gender);
        request.setAttribute("searchAmenities", amenities);
        request.setAttribute("searchMinRent", minRentStr);
        request.setAttribute("searchMaxRent", maxRentStr);
        request.setAttribute("pageTitle", "Find PG");
        request.setAttribute("currentPage", "find-pg");
        request.setAttribute("contentPage", "/WEB-INF/views/public/pg-listing.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/main-layout.jsp").forward(request, response);
    }
}
