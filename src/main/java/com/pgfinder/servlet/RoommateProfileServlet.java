package com.pgfinder.servlet;

import com.pgfinder.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/roommate-profile")
public class RoommateProfileServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

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
            // Reuse getRoommatesForFinder with no exclusion to find this specific user
            List<Map<String, Object>> all = userDAO.getRoommatesForFinder(-1, null);
            Map<String, Object> profile = null;
            for (Map<String, Object> r : all) {
                if (((Number) r.get("userId")).intValue() == roommateId) {
                    profile = r;
                    break;
                }
            }
            request.setAttribute("profile", profile);
        } catch (NumberFormatException e) {
            // ignore, profile stays null
        }

        request.setAttribute("pageTitle", "Roommate Profile");
        request.setAttribute("contentPage", "/WEB-INF/views/public/roommate-profile.jsp");
        request.getRequestDispatcher("/WEB-INF/views/layouts/main-layout.jsp").forward(request, response);
    }
}
