<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>City Management - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <style>
        .cities-table {
            width: 100%;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .cities-table table {
            width: 100%;
            border-collapse: collapse;
        }
        .cities-table th {
            background: #3498db;
            color: white;
            padding: 16px;
            text-align: left;
            font-weight: 600;
        }
        .cities-table td {
            padding: 16px;
            border-bottom: 1px solid #ecf0f1;
        }
        .cities-table tr:hover {
            background: #f8f9fa;
        }
        .badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }
        .badge-success {
            background: #d4edda;
            color: #155724;
        }
        .badge-warning {
            background: #fff3cd;
            color: #856404;
        }
        .badge-info {
            background: #d1ecf1;
            color: #0c5460;
        }
        .city-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .summary-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .summary-card h3 {
            font-size: 32px;
            color: #3498db;
            margin-bottom: 8px;
        }
        .summary-card p {
            color: #7f8c8d;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/admin/sidebar.jsp" />
    
    <div class="main-content">
        <div class="content-header">
            <h1>City Management</h1>
            <p>Overview of PG listings across different cities</p>
        </div>
        
        <div class="city-summary">
            <div class="summary-card">
                <h3>${cities.size()}</h3>
                <p>Total Cities</p>
            </div>
            <div class="summary-card">
                <h3>
                    <c:set var="totalPgs" value="0" />
                    <c:forEach var="city" items="${cities}">
                        <c:set var="totalPgs" value="${totalPgs + city.pgCount}" />
                    </c:forEach>
                    ${totalPgs}
                </h3>
                <p>Total PG Listings</p>
            </div>
            <div class="summary-card">
                <h3>
                    <c:set var="totalActive" value="0" />
                    <c:forEach var="city" items="${cities}">
                        <c:set var="totalActive" value="${totalActive + city.activeCount}" />
                    </c:forEach>
                    ${totalActive}
                </h3>
                <p>Active Listings</p>
            </div>
            <div class="summary-card">
                <h3>
                    <c:set var="totalVerified" value="0" />
                    <c:forEach var="city" items="${cities}">
                        <c:set var="totalVerified" value="${totalVerified + city.verifiedCount}" />
                    </c:forEach>
                    ${totalVerified}
                </h3>
                <p>Verified Listings</p>
            </div>
        </div>
        
        <div class="cities-table">
            <table>
                <thead>
                    <tr>
                        <th>City</th>
                        <th>State</th>
                        <th>Total PGs</th>
                        <th>Active</th>
                        <th>Verified</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="city" items="${cities}">
                        <tr>
                            <td><strong>${city.city}</strong></td>
                            <td>${city.state}</td>
                            <td>${city.pgCount}</td>
                            <td><span class="badge badge-success">${city.activeCount}</span></td>
                            <td><span class="badge badge-info">${city.verifiedCount}</span></td>
                            <td>
                                <c:choose>
                                    <c:when test="${city.activeCount > 0}">
                                        <span class="badge badge-success">Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-warning">Inactive</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/listings?city=${city.city}" 
                                   class="btn btn-sm btn-primary">View Listings</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <c:if test="${empty cities}">
            <div style="text-align: center; padding: 60px 20px; color: #95a5a6;">
                <p style="font-size: 18px;">No cities with PG listings yet.</p>
            </div>
        </c:if>
    </div>
</body>
</html>
