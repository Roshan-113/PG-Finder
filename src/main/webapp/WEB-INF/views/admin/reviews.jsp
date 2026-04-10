<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reviews Moderation - PG Finder Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50">
    <div class="flex">
        <jsp:include page="../includes/sidebar-admin.jsp"><jsp:param name="currentPage" value="reviews" /></jsp:include>
        <main class="flex-1 min-h-screen" style="margin-left: 240px;">
            <jsp:include page="../includes/header-admin.jsp" />
            <div class="p-8">
                <h1 class="text-3xl font-bold text-gray-900 mb-2">Reviews Moderation</h1>
                <p class="text-gray-600 mb-8">Manage user reviews</p>
                <c:if test="${not empty sessionScope.success}">
                    <div class="bg-green-50 border border-green-200 text-green-800 px-4 py-3 rounded-lg mb-4">${sessionScope.success}</div>
                    <c:remove var="success" scope="session"/>
                </c:if>
                <div class="bg-white rounded-xl shadow-sm border border-gray-100">
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-gray-50 border-b border-gray-100">
                                <tr>
                                    <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Listing</th>
                                    <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Reviewer</th>
                                    <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Rating</th>
                                    <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Review</th>
                                    <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Status</th>
                                    <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${reviews}" var="review">
                                    <tr class="border-b border-gray-50 hover:bg-gray-50">
                                        <td class="py-3 px-4 text-sm text-gray-900">${review.listing_title}</td>
                                        <td class="py-3 px-4 text-sm text-gray-600">${review.tenant_name}</td>
                                        <td class="py-3 px-4 text-sm">
                                            <c:forEach begin="1" end="${review.rating}">
                                                <i class="fas fa-star text-yellow-500"></i>
                                            </c:forEach>
                                        </td>
                                        <td class="py-3 px-4 text-sm text-gray-600" style="max-width:300px">${review.review_text}</td>
                                        <td class="py-3 px-4 text-sm">
                                            <span class="px-2 py-1 rounded text-xs font-medium ${review.is_active ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}">${review.is_active ? 'Active' : 'Inactive'}</span>
                                        </td>
                                        <td class="py-3 px-4 text-sm">
                                            <div class="flex gap-2">
                                                <c:if test="${review.is_active}">
                                                    <form method="post" style="display:inline;">
                                                        <input type="hidden" name="action" value="deactivate">
                                                        <input type="hidden" name="reviewId" value="${review.review_id}">
                                                        <button type="submit" class="px-2 py-1 bg-yellow-100 text-yellow-700 rounded hover:bg-yellow-200">
                                                            <i class="fas fa-eye-slash"></i>
                                                        </button>
                                                    </form>
                                                </c:if>
                                                <c:if test="${!review.is_active}">
                                                    <form method="post" style="display:inline;">
                                                        <input type="hidden" name="action" value="activate">
                                                        <input type="hidden" name="reviewId" value="${review.review_id}">
                                                        <button type="submit" class="px-2 py-1 bg-green-100 text-green-700 rounded hover:bg-green-200">
                                                            <i class="fas fa-eye"></i>
                                                        </button>
                                                    </form>
                                                </c:if>
                                                <form method="post" style="display:inline;">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="reviewId" value="${review.review_id}">
                                                    <button type="submit" class="px-2 py-1 bg-red-100 text-red-700 rounded hover:bg-red-200" onclick="return confirm('Delete?')">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty reviews}">
                                    <tr><td colspan="6" class="py-12 text-center text-gray-500">No reviews found</td></tr>
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
