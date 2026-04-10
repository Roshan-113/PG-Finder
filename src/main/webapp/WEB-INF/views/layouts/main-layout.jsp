<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Find Your Perfect PG'} - PG Finder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="min-h-screen flex flex-col">
        <!-- Navigation - Conditional based on login status -->
        <c:choose>
            <c:when test="${not empty sessionScope.userEmail && sessionScope.userRole == 'tenant'}">
                <%@ include file="../includes/navigation-authenticated.jsp" %>
            </c:when>
            <c:otherwise>
                <%@ include file="../includes/navigation.jsp" %>
            </c:otherwise>
        </c:choose>
        
        <!-- Main Content -->
        <main class="flex-1">
            <jsp:include page="${contentPage}" />
        </main>
        
        <!-- Footer -->
        <%@ include file="../includes/footer.jsp" %>
    </div>
    
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
