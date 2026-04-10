<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="currentPage" value="saved" scope="request" />

<div class="max-w-7xl mx-auto px-6 py-8">
    <!-- Header -->
    <div class="flex items-center justify-between mb-8">
        <div>
            <h1 class="text-3xl font-bold text-gray-900">Saved PGs</h1>
            <p class="text-gray-600 mt-2">
                <c:choose>
                    <c:when test="${empty savedListings}">You have no saved PGs</c:when>
                    <c:otherwise>You have ${savedListings.size()} saved PG<c:if test="${savedListings.size() > 1}">s</c:if></c:otherwise>
                </c:choose>
            </p>
        </div>
        <button onclick="window.location.href='${pageContext.request.contextPath}/find-pg'" class="px-4 py-2 text-sm font-medium text-white rounded-lg transition-colors" style="background-color: #2563eb;" onmouseover="this.style.backgroundColor='#1d4ed8'" onmouseout="this.style.backgroundColor='#2563eb'">
            <i class="fas fa-search mr-2"></i>Browse More PGs
        </button>
    </div>

    <!-- Saved PGs Grid -->
    <c:choose>
        <c:when test="${empty savedListings}">
            <div class="bg-white rounded-xl p-12 text-center border border-gray-200">
                <i class="fas fa-heart text-gray-300 text-6xl mb-4"></i>
                <h3 class="text-xl font-semibold text-gray-900 mb-2">No Saved PGs</h3>
                <p class="text-gray-600 mb-6">Start saving your favorite PGs to view them here!</p>
                <button onclick="window.location.href='${pageContext.request.contextPath}/find-pg'" class="px-6 py-3 text-white rounded-lg font-medium transition-colors" style="background-color: #2563eb;" onmouseover="this.style.backgroundColor='#1d4ed8'" onmouseout="this.style.backgroundColor='#2563eb'">
                    <i class="fas fa-search mr-2"></i>Browse PGs
                </button>
            </div>
        </c:when>
        <c:otherwise>
            <div class="grid grid-cols-3 gap-6">
                <c:forEach var="listing" items="${savedListings}">
                    <div class="bg-white rounded-xl overflow-hidden border border-gray-200 shadow-sm hover:shadow-md transition-shadow">
                        <div class="relative">
                            <c:choose>
                                <c:when test="${not empty listing.photos && listing.photos.size() > 0}">
                                    <img src="${listing.photos[0]}" alt="${listing.title}" class="w-full h-48 object-cover">
                                </c:when>
                                <c:otherwise>
                                    <img src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400&h=250&fit=crop" alt="${listing.title}" class="w-full h-48 object-cover">
                                </c:otherwise>
                            </c:choose>
                            <button onclick="removeSaved(${listing.listingId})" class="absolute top-3 right-3 w-10 h-10 rounded-full bg-white flex items-center justify-center shadow-md hover:bg-gray-50">
                                <i class="fas fa-heart text-red-500"></i>
                            </button>
                            <c:if test="${listing.verified}">
                                <div class="absolute top-3 left-3 px-2 py-1 rounded text-xs font-semibold bg-blue-600 text-white">
                                    <i class="fas fa-check-circle"></i> Verified
                                </div>
                            </c:if>
                        </div>
                        <div class="p-4">
                            <h3 class="font-bold text-lg text-gray-900 mb-1">${listing.title}</h3>
                            <div class="flex items-center gap-1 text-sm text-gray-600 mb-2">
                                <i class="fas fa-map-marker-alt" style="font-size: 12px;"></i>
                                ${listing.city}
                            </div>
                            <div class="flex items-center gap-2 mb-3">
                                <div class="flex items-center gap-1">
                                    <i class="fas fa-star text-yellow-500" style="font-size: 14px;"></i>
                                    <span class="font-semibold text-gray-900"><fmt:formatNumber value="${listing.averageRating}" pattern="0.0"/></span>
                                    <span class="text-sm text-gray-500">(${listing.reviewCount})</span>
                                </div>
                            </div>
                            <div class="flex items-center gap-2 mb-3 text-xs">
                                <c:if test="${listing.wifiAvailable}">
                                    <span class="px-2 py-1 rounded bg-blue-50 text-blue-700">WiFi</span>
                                </c:if>
                                <c:if test="${listing.acAvailable}">
                                    <span class="px-2 py-1 rounded bg-blue-50 text-blue-700">AC</span>
                                </c:if>
                                <c:if test="${listing.foodIncluded}">
                                    <span class="px-2 py-1 rounded bg-blue-50 text-blue-700">Food</span>
                                </c:if>
                            </div>
                            <div class="flex items-center justify-between">
                                <div>
                                    <div class="text-2xl font-bold text-gray-900">₹<fmt:formatNumber value="${listing.rentPerMonth}" pattern="#,##0"/></div>
                                    <div class="text-xs text-gray-500">/month</div>
                                </div>
                                <div class="flex gap-2">
                                    <button onclick="window.location.href='${pageContext.request.contextPath}/pg-details?id=${listing.listingId}'" class="p-2 rounded-lg transition-colors" style="background-color: #2563eb; color: white;" onmouseover="this.style.backgroundColor='#1d4ed8'" onmouseout="this.style.backgroundColor='#2563eb'" title="View Details">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button onclick="removeSaved(${listing.listingId})" class="p-2 rounded-lg transition-colors" style="background-color: #ef4444; color: white;" onmouseover="this.style.backgroundColor='#dc2626'" onmouseout="this.style.backgroundColor='#ef4444'" title="Remove">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
function removeSaved(listingId) {
    if (confirm('Remove this PG from your saved list?')) {
        fetch('${pageContext.request.contextPath}/tenant/saved-pgs?action=unsave&listingId=' + listingId, {
            method: 'POST'
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('PG removed from saved list');
                location.reload();
            } else {
                alert('Failed to remove PG');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('An error occurred');
        });
    }
}
</script>
