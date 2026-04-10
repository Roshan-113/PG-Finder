<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Check if user is logged in and redirect to appropriate dashboard
    String userRole = (String) session.getAttribute("userRole");
    if (userRole != null) {
        if ("admin".equals(userRole)) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        } else if ("owner".equals(userRole)) {
            response.sendRedirect(request.getContextPath() + "/owner/dashboard");
            return;
        } else if ("tenant".equals(userRole)) {
            // Tenants can see the landing page with their session
        }
    }
%>
<c:set var="pageTitle" value="Find Your Perfect PG" scope="request" />
<c:set var="contentPage" value="/WEB-INF/views/public/landing.jsp" scope="request" />
<jsp:include page="/WEB-INF/views/layouts/main-layout.jsp" />
