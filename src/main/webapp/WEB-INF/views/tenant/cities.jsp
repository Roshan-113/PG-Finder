<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Browse by City - PG Finder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css">
    <style>
        .cities-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
        }
        .cities-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        .city-card {
            background: white;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform 0.2s, box-shadow 0.2s;
            cursor: pointer;
        }
        .city-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 4px 16px rgba(0,0,0,0.15);
        }
        .city-name {
            font-size: 24px;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
        }
        .city-state {
            color: #7f8c8d;
            font-size: 14px;
            margin-bottom: 16px;
        }
        .city-stats {
            display: flex;
            justify-content: space-between;
            margin-top: 16px;
            padding-top: 16px;
            border-top: 1px solid #ecf0f1;
        }
        .stat {
            text-align: center;
        }
        .stat-value {
            font-size: 20px;
            font-weight: 600;
            color: #3498db;
        }
        .stat-label {
            font-size: 12px;
            color: #95a5a6;
            margin-top: 4px;
        }
        .page-header {
            text-align: center;
            margin-bottom: 40px;
        }
        .page-header h1 {
            font-size: 36px;
            color: #2c3e50;
            margin-bottom: 12px;
        }
        .page-header p {
            color: #7f8c8d;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />
    
    <div class="cities-container">
        <div class="page-header">
            <h1>Browse PGs by City</h1>
            <p>Find your perfect PG in cities across India</p>
        </div>
        
        <div class="cities-grid">
            <c:forEach var="city" items="${cities}">
                <div class="city-card" onclick="location.href='${pageContext.request.contextPath}/pg-listings?city=${city.city}'">
                    <div class="city-name">${city.city}</div>
                    <div class="city-state">${city.state}</div>
                    
                    <div class="city-stats">
                        <div class="stat">
                            <div class="stat-value">${city.pgCount}</div>
                            <div class="stat-label">Total PGs</div>
                        </div>
                        <div class="stat">
                            <div class="stat-value">${city.activeCount}</div>
                            <div class="stat-label">Active</div>
                        </div>
                        <div class="stat">
                            <div class="stat-value">${city.verifiedCount}</div>
                            <div class="stat-label">Verified</div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <c:if test="${empty cities}">
            <div style="text-align: center; padding: 60px 20px; color: #95a5a6;">
                <p style="font-size: 18px;">No cities available yet. Check back soon!</p>
            </div>
        </c:if>
    </div>
    
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
