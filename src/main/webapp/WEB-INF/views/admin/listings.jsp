<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PG Listings - PG Finder Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50">
    <div class="flex">
        <jsp:include page="../includes/sidebar-admin.jsp"><jsp:param name="currentPage" value="listings" /></jsp:include>
        <main class="flex-1 min-h-screen" style="margin-left: 240px;">
            <jsp:include page="../includes/header-admin.jsp" />
            <div class="p-8">
                <h1 class="text-3xl font-bold text-gray-900 mb-2">PG Listings</h1>
                <p class="text-gray-600 mb-8">Manage all PG listings</p>
                <c:if test="${not empty sessionScope.success}">
                    <div class="bg-green-50 border border-green-200 text-green-800 px-4 py-3 rounded-lg mb-4">${sessionScope.success}</div>
                    <c:remove var="success" scope="session"/>
                </c:if>
                <div class="bg-white rounded-xl shadow-sm border border-gray-100">
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-gray-50 border-b border-gray-100">
                                <tr>
                                    <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">ID</th>
                                    <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Title</th>
                                    <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Owner</th>
                                    <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">City</th>
                                    <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Rent</th>
                                    <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Status</th>
                                    <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${listings}" var="listing">
                                    <tr class="border-b border-gray-50 hover:bg-gray-50">
                                        <td class="py-3 px-4 text-sm text-gray-900">${listing.listingId}</td>
                                        <td class="py-3 px-4 text-sm text-gray-900">${listing.title}</td>
                                        <td class="py-3 px-4 text-sm text-gray-600">${listing.ownerName}</td>
                                        <td class="py-3 px-4 text-sm text-gray-600">${listing.city}</td>
                                        <td class="py-3 px-4 text-sm text-gray-900">₹<fmt:formatNumber value="${listing.rentPerMonth}" pattern="#,##0"/></td>
                                        <td class="py-3 px-4 text-sm">
                                            <span class="px-2 py-1 rounded text-xs font-medium ${listing.verified ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700'}">${listing.verified ? 'Verified' : 'Unverified'}</span>
                                        </td>
                                        <td class="py-3 px-4 text-sm">
                                            <div class="flex gap-2">
                                                <a href="${pageContext.request.contextPath}/pg-details?id=${listing.listingId}" target="_blank" class="px-2 py-1 bg-blue-100 text-blue-700 rounded hover:bg-blue-200">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <c:if test="${!listing.verified}">
                                                    <form method="post" style="display:inline;">
                                                        <input type="hidden" name="action" value="verify">
                                                        <input type="hidden" name="listingId" value="${listing.listingId}">
                                                        <button type="submit" class="px-2 py-1 bg-green-100 text-green-700 rounded hover:bg-green-200">
                                                            <i class="fas fa-check"></i>
                                                        </button>
                                                    </form>
                                                </c:if>
                                                <form method="post" style="display:inline;">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="listingId" value="${listing.listingId}">
                                                    <button type="submit" class="px-2 py-1 bg-red-100 text-red-700 rounded hover:bg-red-200" onclick="return confirm('Delete?')">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty listings}">
                                    <tr><td colspan="7" class="py-12 text-center text-gray-500">No listings found</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
