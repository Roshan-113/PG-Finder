package com.pgfinder.servlet.owner;

import com.pgfinder.dao.OwnerDAO;
import com.pgfinder.model.Earning;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/owner/earnings")
public class EarningsServlet extends HttpServlet {
    private OwnerDAO ownerDAO;
    
    @Override
    public void init() {
        ownerDAO = new OwnerDAO();
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
        List<Earning> earnings = ownerDAO.getEarnings(ownerId);
        
        request.setAttribute("earnings", earnings);
        request.setAttribute("pageTitle", "Earnings");
        request.setAttribute("currentPage", "earnings");
        request.setAttribute("contentPage", "/WEB-INF/views/owner/earnings.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/owner-layout.jsp").forward(request, response);
    }
}
