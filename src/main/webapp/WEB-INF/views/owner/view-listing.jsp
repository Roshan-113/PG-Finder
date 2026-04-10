<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="page-container">
    <div class="page-header">
        <a href="${pageContext.request.contextPath}/owner/listings" style="display: inline-flex; align-items: center; gap: 0.5rem; color: #6b7280; text-decoration: none; font-size: 0.875rem; margin-bottom: 1rem;">
            <i class="fas fa-arrow-left"></i>
            <span>Back to Listings</span>
        </a>
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <h1>${listing.title}</h1>
            <div style="display: flex; gap: 0.75rem;">
                <button onclick="window.location.href='${pageContext.request.contextPath}/owner/edit-pg?id=${listing.listingId}'" class="btn btn-primary">
                    <i class="fas fa-edit"></i> Edit Listing
                </button>
                <button onclick="window.location.href='${pageContext.request.contextPath}/owner/photos?listingId=${listing.listingId}'" class="btn btn-secondary">
                    <i class="fas fa-images"></i> Manage Photos
                </button>
            </div>
        </div>
    </div>

    <!-- Photos -->
    <c:if test="${not empty listing.photos}">
        <div class="photos-grid" style="margin-bottom: 2rem;">
            <c:forEach var="photo" items="${listing.photos}" varStatus="status">
                <c:if test="${status.index < 4}">
                    <c:choose>
                        <c:when test="${photo.startsWith('http')}">
                            <img src="${photo}" alt="${listing.title}" style="width: 100%; height: 200px; object-fit: cover; border-radius: 0.75rem;">
                        </c:when>
                        <c:when test="${photo.startsWith('/pg-finder') || photo.startsWith(pageContext.request.contextPath)}">
                            <img src="${photo}" alt="${listing.title}" style="width: 100%; height: 200px; object-fit: cover; border-radius: 0.75rem;">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/${photo}" alt="${listing.title}" style="width: 100%; height: 200px; object-fit: cover; border-radius: 0.75rem;">
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </c:forEach>
        </div>
    </c:if>

    <!-- Details Grid -->
    <div class="details-grid">
        <div class="detail-card">
            <h3>Basic Information</h3>
            <div class="detail-row">
                <span class="label">Address:</span>
                <span class="value">${listing.address}, ${listing.city}, ${listing.state} - ${listing.pincode}</span>
            </div>
            <div class="detail-row">
                <span class="label">PG Type:</span>
                <span class="value">${listing.pgType}</span>
            </div>
            <div class="detail-row">
                <span class="label">Total Rooms:</span>
                <span class="value">${listing.totalRooms}</span>
            </div>
            <div class="detail-row">
                <span class="label">Available Rooms:</span>
                <span class="value">${listing.availableRooms}</span>
            </div>
        </div>

        <div class="detail-card">
            <h3>Pricing</h3>
            <div class="detail-row">
                <span class="label">Rent per Month:</span>
                <span class="value">₹<fmt:formatNumber value="${listing.rentPerMonth}" pattern="#,##0"/></span>
            </div>
            <div class="detail-row">
                <span class="label">Security Deposit:</span>
                <span class="value">₹<fmt:formatNumber value="${listing.securityDeposit}" pattern="#,##0"/></span>
            </div>
        </div>

        <div class="detail-card">
            <h3>Amenities</h3>
            <div class="amenities-list">
                <c:if test="${listing.wifiAvailable}">
                    <span class="amenity"><i class="fas fa-wifi"></i> WiFi</span>
                </c:if>
                <c:if test="${listing.acAvailable}">
                    <span class="amenity"><i class="fas fa-snowflake"></i> AC</span>
                </c:if>
                <c:if test="${listing.laundryAvailable}">
                    <span class="amenity"><i class="fas fa-tshirt"></i> Laundry</span>
                </c:if>
                <c:if test="${listing.foodIncluded}">
                    <span class="amenity"><i class="fas fa-utensils"></i> Food</span>
                </c:if>
                <c:if test="${listing.parkingAvailable}">
                    <span class="amenity"><i class="fas fa-car"></i> Parking</span>
                </c:if>
            </div>
        </div>

        <div class="detail-card">
            <h3>Status</h3>
            <div class="detail-row">
                <span class="label">Verified:</span>
                <span class="value">${listing.verified ? 'Yes' : 'No'}</span>
            </div>
            <div class="detail-row">
                <span class="label">Active:</span>
                <span class="value">${listing.active ? 'Yes' : 'No'}</span>
            </div>
            <div class="detail-row">
                <span class="label">Average Rating:</span>
                <span class="value">${listing.averageRating > 0 ? listing.averageRating : 'No ratings yet'}</span>
            </div>
            <div class="detail-row">
                <span class="label">Total Reviews:</span>
                <span class="value">${listing.reviewCount}</span>
            </div>
        </div>
    </div>

    <c:if test="${not empty listing.description}">
        <div class="detail-card" style="margin-top: 1.5rem;">
            <h3>Description</h3>
            <p style="color: #4b5563; line-height: 1.6;">${listing.description}</p>
        </div>
    </c:if>
</div>

<style>
.page-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 1.5rem;
}

.page-header h1 {
    margin: 0;
    font-size: 2rem;
    font-weight: 700;
    color: #111827;
}

.photos-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 1rem;
}

.details-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 1.5rem;
}

.detail-card {
    background: white;
    border-radius: 1rem;
    padding: 1.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.detail-card h3 {
    margin: 0 0 1rem 0;
    font-size: 1.125rem;
    font-weight: 700;
    color: #111827;
}

.detail-row {
    display: flex;
    justify-content: space-between;
    padding: 0.75rem 0;
    border-bottom: 1px solid #f3f4f6;
}

.detail-row:last-child {
    border-bottom: none;
}

.label {
    color: #6b7280;
    font-size: 0.875rem;
}

.value {
    color: #111827;
    font-weight: 600;
    font-size: 0.875rem;
}

.amenities-list {
    display: flex;
    flex-wrap: wrap;
    gap: 0.75rem;
}

.amenity {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.5rem 1rem;
    background: #f0f9ff;
    color: #1e40af;
    border-radius: 0.5rem;
    font-size: 0.875rem;
    font-weight: 500;
}

.btn {
    padding: 0.75rem 1.5rem;
    border-radius: 0.5rem;
    font-weight: 600;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    border: none;
    transition: all 0.2s;
}

.btn-primary {
    background: #2563eb;
    color: white;
}

.btn-primary:hover {
    background: #1d4ed8;
}

.btn-secondary {
    background: white;
    color: #374151;
    border: 1px solid #d1d5db;
}

.btn-secondary:hover {
    background: #f9fafb;
}
</style>
