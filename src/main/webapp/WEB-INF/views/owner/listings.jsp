<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% 
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<div class="mb-8">
    <h1 class="text-3xl font-bold text-gray-900">My Listings</h1>
    <p class="text-gray-600 mt-2">Manage all your PG properties</p>
</div>

<!-- Stats Cards -->
<c:set var="totalProperties" value="0" />
<c:set var="totalRooms" value="0" />
<c:set var="occupiedRooms" value="0" />
<c:set var="totalRating" value="0.0" />
<c:if test="${not empty listings}">
    <c:set var="totalProperties" value="${listings.size()}" />
    <c:forEach var="listing" items="${listings}">
        <c:set var="totalRooms" value="${totalRooms + listing.totalRooms}" />
        <c:set var="occupiedRooms" value="${occupiedRooms + (listing.totalRooms - listing.availableRooms)}" />
        <c:set var="totalRating" value="${totalRating + listing.averageRating}" />
    </c:forEach>
</c:if>
<c:set var="occupancyRate" value="${totalRooms > 0 ? (occupiedRooms * 100.0 / totalRooms) : 0}" />
<c:set var="avgRating" value="${totalProperties > 0 ? (totalRating / totalProperties) : 0}" />

<div class="grid grid-cols-4 gap-6 mb-8">
    <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
        <div class="text-sm text-gray-600 mb-2">Total Properties</div>
        <div class="text-3xl font-bold text-gray-900">${totalProperties}</div>
    </div>
    <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
        <div class="text-sm text-gray-600 mb-2">Total Rooms</div>
        <div class="text-3xl font-bold text-gray-900">${totalRooms}</div>
    </div>
    <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
        <div class="text-sm text-gray-600 mb-2">Occupancy Rate</div>
        <div class="text-3xl font-bold text-gray-900"><fmt:formatNumber value="${occupancyRate}" maxFractionDigits="0" />%</div>
    </div>
    <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
        <div class="text-sm text-gray-600 mb-2">Avg Rating</div>
        <div class="text-3xl font-bold text-gray-900 flex items-center gap-2"><fmt:formatNumber value="${avgRating}" maxFractionDigits="1" /> <i class="fas fa-star text-yellow-500" style="font-size: 24px;"></i></div>
    </div>
</div>

<!-- Listings -->
<c:choose>
    <c:when test="${not empty listings}">
        <div class="space-y-6">
        <c:forEach var="listing" items="${listings}">
            <div class="bg-white rounded-xl border border-gray-200 shadow-sm hover:shadow-md transition-shadow overflow-hidden">
                <div class="flex">
                    <!-- Large Image on Left -->
                    <div class="w-2/5">
                        <img src="${not empty listing.photos ? listing.photos[0] : 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=600&h=400&fit=crop'}" 
                             alt="${listing.title}" 
                             class="w-full h-full object-cover"
                             style="min-height: 280px; max-height: 280px;">
                    </div>
                    
                    <!-- Content on Right -->
                    <div class="flex-1 p-6 flex flex-col justify-between">
                        <div>
                            <div class="flex items-start justify-between mb-3">
                                <div>
                                    <h3 class="text-xl font-bold text-gray-900">${listing.title}</h3>
                                    <div class="flex items-center gap-2 text-gray-600 mt-1">
                                        <i class="fas fa-map-marker-alt" style="font-size: 14px;"></i>
                                        <span class="text-sm">${listing.city}, ${listing.state}</span>
                                    </div>
                                </div>
                                <c:choose>
                                    <c:when test="${listing.active}">
                                        <span class="px-3 py-1 rounded-full text-xs font-semibold" style="background-color: #dcfce7; color: #166534;">Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="px-3 py-1 rounded-full text-xs font-semibold" style="background-color: #fee2e2; color: #991b1b;">Inactive</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <div class="flex items-center gap-6 text-sm text-gray-600 mb-4">
                                <span>Total Rooms: <strong class="text-gray-900">${listing.totalRooms}</strong></span>
                                <span>Occupied: <strong class="text-gray-900">${listing.totalRooms - listing.availableRooms}</strong></span>
                                <span>Available: <strong class="text-green-600">${listing.availableRooms}</strong></span>
                                <span class="flex items-center gap-1">
                                    <i class="fas fa-star text-yellow-500"></i>
                                    <strong class="text-gray-900"><fmt:formatNumber value="${listing.averageRating}" maxFractionDigits="1" /></strong>
                                    <c:if test="${listing.reviewCount > 0}">(${listing.reviewCount} reviews)</c:if>
                                </span>
                            </div>
                        </div>
                        
                        <div class="flex items-center justify-between">
                            <div class="flex items-center gap-3">
                                <button onclick="viewListing(${listing.listingId})" class="px-4 py-2 rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors flex items-center gap-2">
                                    <i class="fas fa-eye"></i>
                                    View
                                </button>
                                <button onclick="editListing(${listing.listingId})" class="px-4 py-2 rounded-lg border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors flex items-center gap-2">
                                    <i class="fas fa-edit"></i>
                                    Edit
                                </button>
                                <button onclick="deleteListing(${listing.listingId})" class="px-4 py-2 rounded-lg border border-red-300 text-red-600 hover:bg-red-50 transition-colors flex items-center gap-2">
                                    <i class="fas fa-trash"></i>
                                    Delete
                                </button>
                            </div>
                            <div class="text-right">
                                <div class="text-2xl font-bold text-gray-900">₹<fmt:formatNumber value="${listing.rentPerMonth}" maxFractionDigits="0" /></div>
                                <div class="text-xs text-gray-500">per month</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        </div>
    </c:when>
    <c:otherwise>
        <!-- Empty State for New Owners -->
        <div class="bg-white rounded-xl p-16 text-center border border-gray-200 shadow-sm">
            <div style="width: 120px; height: 120px; margin: 0 auto 24px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                <i class="fas fa-home" style="font-size: 48px; color: white;"></i>
            </div>
            <h3 style="font-size: 24px; font-weight: 700; color: #111827; margin: 0 0 12px 0;">Welcome to PG Finder!</h3>
            <p style="font-size: 16px; color: #6b7280; margin: 0 0 8px 0; max-width: 500px; margin-left: auto; margin-right: auto;">You haven't added any PG listings yet. Start by adding your first property to reach thousands of potential tenants.</p>
            <p style="font-size: 14px; color: #9ca3af; margin: 0 0 32px 0;">It only takes a few minutes to create a listing!</p>
            <button onclick="window.location.href='${pageContext.request.contextPath}/owner/add-pg'" style="padding: 14px 32px; background: #2563eb; color: white; border: none; border-radius: 10px; font-size: 16px; font-weight: 600; cursor: pointer; display: inline-flex; align-items: center; gap: 10px; transition: background 0.3s;" onmouseover="this.style.background='#1d4ed8'" onmouseout="this.style.background='#2563eb'">
                <i class="fas fa-plus-circle"></i>
                Add Your First PG
            </button>
            <div style="margin-top: 32px; padding-top: 32px; border-top: 1px solid #e5e7eb;">
                <p style="font-size: 14px; color: #6b7280; margin: 0 0 16px 0; font-weight: 600;">Why list your PG with us?</p>
                <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 24px; max-width: 700px; margin: 0 auto;">
                    <div>
                        <i class="fas fa-users" style="font-size: 24px; color: #2563eb; margin-bottom: 8px;"></i>
                        <p style="font-size: 13px; color: #6b7280; margin: 0;">Reach thousands of verified tenants</p>
                    </div>
                    <div>
                        <i class="fas fa-shield-alt" style="font-size: 24px; color: #10b981; margin-bottom: 8px;"></i>
                        <p style="font-size: 13px; color: #6b7280; margin: 0;">Secure booking & payment system</p>
                    </div>
                    <div>
                        <i class="fas fa-chart-line" style="font-size: 24px; color: #f59e0b; margin-bottom: 8px;"></i>
                        <p style="font-size: 13px; color: #6b7280; margin: 0;">Track earnings & manage bookings</p>
                    </div>
                </div>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<script>
function viewListing(listingId) {
    window.location.href = '${pageContext.request.contextPath}/owner/view-listing?id=' + listingId;
}

function editListing(listingId) {
    window.location.href = '${pageContext.request.contextPath}/owner/edit-pg?id=' + listingId;
}

function deleteListing(listingId) {
    if (confirm('Are you sure you want to delete this listing? This action cannot be undone.')) {
        fetch('${pageContext.request.contextPath}/owner/listings', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'action=delete&listingId=' + listingId
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(data.message || 'Listing deleted successfully!');
                location.reload();
            } else {
                alert(data.message || 'Failed to delete listing');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('An error occurred');
        });
    }
}
</script>
