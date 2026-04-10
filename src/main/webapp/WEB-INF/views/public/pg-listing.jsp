<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
* { box-sizing: border-box; }
.page-container {max-width: 1400px;margin: 0 auto;padding: 32px 24px;}
.page-header {margin-bottom: 32px;}
.page-title {font-size: 28px;font-weight: 700;color: #1f2937;margin: 0 0 8px 0;}
.page-subtitle {font-size: 16px;color: #6b7280;}
.header-actions {display: flex;gap: 12px;margin-top: 16px;}
.btn-filter, .btn-map {padding: 10px 20px;background: white;border: 1px solid #d1d5db;border-radius: 8px;font-weight: 500;cursor: pointer;display: flex;align-items: center;gap: 8px;transition: all 0.3s;}
.btn-filter:hover, .btn-map:hover {background: #f9fafb;border-color: #2563eb;}
.content-wrapper {display: flex;gap: 32px;}
.sidebar {width: 280px;flex-shrink: 0;}
.filter-card {background: white;border-radius: 12px;padding: 24px;box-shadow: 0 1px 3px rgba(0,0,0,0.1);position: sticky;top: 24px;}
.filter-title {font-size: 18px;font-weight: 700;color: #1f2937;margin: 0 0 20px 0;}
.filter-section {margin-bottom: 24px;}
.filter-label {font-weight: 600;font-size: 14px;color: #374151;margin-bottom: 12px;display: block;}
.range-slider {width: 100%;margin: 16px 0;}
.range-values {display: flex;justify-content: space-between;font-size: 14px;color: #6b7280;margin-top: 8px;}
.filter-select {width: 100%;padding: 10px 12px;border: 1px solid #d1d5db;border-radius: 8px;font-size: 14px;background: white;}
.checkbox-group {display: flex;flex-direction: column;gap: 10px;}
.checkbox-item {display: flex;align-items: center;gap: 8px;}
.checkbox-item input {width: 18px;height: 18px;cursor: pointer;}
.checkbox-item label {font-size: 14px;color: #374151;cursor: pointer;}
.btn-clear {width: 100%;padding: 10px;background: white;border: 1px solid #d1d5db;border-radius: 8px;font-weight: 500;cursor: pointer;transition: all 0.3s;}
.btn-clear:hover {background: #f9fafb;}
.listings-container {flex: 1;}
.listing-card {background: white;border-radius: 12px;overflow: hidden;box-shadow: 0 1px 3px rgba(0,0,0,0.1);transition: box-shadow 0.3s;display: flex;margin-bottom: 24px;}
.listing-card:hover {box-shadow: 0 4px 12px rgba(0,0,0,0.15);}
.listing-image-wrapper {width: 280px;height: 200px;position: relative;flex-shrink: 0;}
.listing-image {width: 100%;height: 100%;object-fit: cover;}
.verified-badge {position: absolute;top: 12px;left: 12px;background: #2563eb;color: white;padding: 4px 12px;border-radius: 6px;font-size: 12px;font-weight: 600;}
.listing-content {flex: 1;padding: 20px 24px;display: flex;flex-direction: column;}
.listing-header {display: flex;justify-content: space-between;align-items: start;margin-bottom: 8px;}
.listing-title {font-size: 20px;font-weight: 700;color: #1f2937;margin: 0;}
.listing-price-wrapper {text-align: right;}
.listing-price {font-size: 24px;font-weight: 700;color: #1f2937;}
.price-label {font-size: 12px;color: #6b7280;font-weight: 400;}
.listing-location {color: #6b7280;font-size: 14px;margin-bottom: 12px;display: flex;align-items: center;gap: 4px;}
.listing-meta {display: flex;align-items: center;gap: 12px;margin-bottom: 12px;flex-wrap: wrap;}
.rating {display: flex;align-items: center;gap: 4px;font-size: 14px;font-weight: 600;color: #1f2937;}
.rating i {color: #fbbf24;}
.review-count {color: #6b7280;font-weight: 400;}
.badge {padding: 4px 10px;border-radius: 6px;font-size: 12px;font-weight: 500;}
.badge-blue { background: #dbeafe; color: #1e40af; }
.badge-green { background: #d1fae5; color: #065f46; }
.badge-pink { background: #fce7f3; color: #9f1239; }
.badge-purple { background: #e9d5ff; color: #6b21a8; }
.amenities-list {display: flex;gap: 16px;margin-bottom: 16px;flex-wrap: wrap;color: #6b7280;font-size: 14px;}
.amenity-item {display: flex;align-items: center;gap: 6px;}
.action-buttons {display: flex;gap: 12px;margin-top: auto;}
.btn-primary {flex: 1;padding: 12px 24px;background: #2563eb;color: white;border: none;border-radius: 8px;font-weight: 600;cursor: pointer;transition: background 0.3s;display: flex;align-items: center;justify-content: center;gap: 8px;}
.btn-primary:hover {background: #1d4ed8;}
.btn-secondary {flex: 1;padding: 12px 24px;background: white;color: #2563eb;border: 2px solid #2563eb;border-radius: 8px;font-weight: 600;cursor: pointer;transition: all 0.3s;}
.btn-secondary:hover {background: #eff6ff;}
.no-results {background: white;border-radius: 12px;padding: 60px 24px;text-align: center;box-shadow: 0 1px 3px rgba(0,0,0,0.1);}
.no-results i {font-size: 64px;color: #d1d5db;margin-bottom: 16px;}
.no-results h3 {font-size: 20px;font-weight: 600;color: #1f2937;margin: 0 0 8px 0;}
.no-results p {color: #6b7280;margin: 0 0 24px 0;}
</style>

<div class="page-container">
    <!-- Page Header -->
    <div class="page-header">
        <h1 class="page-title">Available PG Accommodations</h1>
        <p class="page-subtitle">
            <c:choose>
                <c:when test="${not empty listings}">
                    ${listings.size()} properties found
                    <c:if test="${not empty searchCity}"> in ${searchCity}</c:if>
                </c:when>
                <c:otherwise>
                    No properties found
                    <c:if test="${not empty searchCity}"> in ${searchCity}</c:if>
                </c:otherwise>
            </c:choose>
        </p>
        <div class="header-actions">
            <button class="btn-filter" onclick="toggleFilters()">
                <i class="fas fa-sliders-h"></i>
                <span id="filterToggleText">Hide Filters</span>
            </button>
            <button class="btn-map" onclick="showMapView()">
                <i class="fas fa-map"></i>
                <span>Map View</span>
            </button>
        </div>
    </div>

    <div class="content-wrapper">
        <!-- Sidebar Filters -->
        <aside class="sidebar" id="filterSidebar">
            <div class="filter-card">
                <h3 class="filter-title">Filters</h3>
                
                <!-- Rent Range -->
                <div class="filter-section">
                    <label class="filter-label">Rent Range</label>
                    <input type="range" class="range-slider" min="0" max="50000" value="50000" step="1000" id="rentRange">
                    <div class="range-values">
                        <span>₹5000</span>
                        <span id="maxRentValue">₹50000</span>
                    </div>
                </div>
                
                <!-- Gender Preference -->
                <div class="filter-section">
                    <label class="filter-label">Gender Preference</label>
                    <select class="filter-select" id="genderFilter">
                        <option value="">All</option>
                        <option value="boys">Male</option>
                        <option value="girls">Female</option>
                    </select>
                </div>
                
                <!-- Sharing Type -->
                <div class="filter-section">
                    <label class="filter-label">Sharing Type</label>
                    <select class="filter-select" id="sharingFilter">
                        <option value="">All Types</option>
                        <option value="Single Room">Single Room</option>
                        <option value="Double Sharing">Double Sharing</option>
                        <option value="Triple Sharing">Triple Sharing</option>
                    </select>
                </div>
                
                <!-- Amenities -->
                <div class="filter-section">
                    <label class="filter-label">Amenities</label>
                    <div class="checkbox-group">
                        <div class="checkbox-item">
                            <input type="checkbox" id="wifi" value="wifi">
                            <label for="wifi">WiFi</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="ac" value="ac">
                            <label for="ac">AC</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="food" value="food">
                            <label for="food">Food</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="parking" value="parking">
                            <label for="parking">Parking</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="laundry" value="laundry">
                            <label for="laundry">Laundry</label>
                        </div>
                    </div>
                </div>
                
                <button class="btn-clear" onclick="clearFilters()">Clear All Filters</button>
            </div>
        </aside>

        <!-- Listings -->
        <main class="listings-container">
            <c:choose>
                <c:when test="${not empty listings}">
                    <c:forEach var="listing" items="${listings}">
                        <div class="listing-card">
                            <!-- Image -->
                            <div class="listing-image-wrapper">
                                <c:choose>
                                    <c:when test="${not empty listing.photos && listing.photos.size() > 0}">
                                        <img src="${listing.photos[0]}" alt="${listing.title}" class="listing-image">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://images.unsplash.com/photo-1555854877-bab0e564b8d5?w=400&h=300&fit=crop" alt="${listing.title}" class="listing-image">
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${listing.verified}">
                                    <div class="verified-badge">Verified</div>
                                </c:if>
                            </div>
                            
                            <!-- Content -->
                            <div class="listing-content">
                                <div class="listing-header">
                                    <h3 class="listing-title">${listing.title}</h3>
                                    <div class="listing-price-wrapper">
                                        <div class="listing-price">₹${listing.rentPerMonth}</div>
                                        <div class="price-label">per month</div>
                                    </div>
                                </div>
                                
                                <div class="listing-location">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>${listing.city}, ${listing.state}</span>
                                </div>
                                
                                <div class="listing-meta">
                                    <div class="rating">
                                        <i class="fas fa-star"></i>
                                        <span>${listing.averageRating > 0 ? listing.averageRating : 'New'}</span>
                                        <c:if test="${listing.reviewCount > 0}">
                                            <span class="review-count">(${listing.reviewCount} reviews)</span>
                                        </c:if>
                                    </div>
                                    <span class="badge badge-blue">${listing.pgType == 'boys' ? 'Male' : 'Female'}</span>
                                    <c:if test="${listing.availableRooms > 0}">
                                        <span class="badge badge-green">${listing.availableRooms} rooms available</span>
                                    </c:if>
                                </div>
                                
                                <div class="amenities-list">
                                    <c:if test="${listing.wifiAvailable}">
                                        <div class="amenity-item">
                                            <i class="fas fa-wifi"></i>
                                            <span>WiFi</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${listing.acAvailable}">
                                        <div class="amenity-item">
                                            <i class="fas fa-snowflake"></i>
                                            <span>AC</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${listing.foodIncluded}">
                                        <div class="amenity-item">
                                            <i class="fas fa-utensils"></i>
                                            <span>Food</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${listing.parkingAvailable}">
                                        <div class="amenity-item">
                                            <i class="fas fa-car"></i>
                                            <span>Parking</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${listing.laundryAvailable}">
                                        <div class="amenity-item">
                                            <i class="fas fa-tshirt"></i>
                                            <span>Laundry</span>
                                        </div>
                                    </c:if>
                                </div>
                                
                                <div class="action-buttons">
                                    <button class="btn-primary" onclick="viewDetails(${listing.listingId})">
                                        <i class="fas fa-eye"></i>
                                        View Details
                                    </button>
                                    <button class="btn-secondary" onclick="contactOwner(${listing.listingId}, ${listing.ownerId})">Contact Owner</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-results">
                        <i class="fas fa-search"></i>
                        <h3>No PG Found</h3>
                        <p>Try adjusting your search filters or browse all listings</p>
                        <button class="btn-primary" onclick="clearFilters()">Clear Filters</button>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
</div>

<script>
// Range slider
const rentRange = document.getElementById('rentRange');
const maxRentValue = document.getElementById('maxRentValue');

if (rentRange) {
    rentRange.addEventListener('input', function() {
        maxRentValue.textContent = '₹' + parseInt(this.value).toLocaleString('en-IN');
        applyFilters();
    });
}

// Add event listeners for filters
document.getElementById('genderFilter').addEventListener('change', applyFilters);
document.getElementById('sharingFilter').addEventListener('change', applyFilters);
document.querySelectorAll('.checkbox-item input').forEach(checkbox => {
    checkbox.addEventListener('change', applyFilters);
});

// Apply filters function
function applyFilters() {
    const maxRent = parseInt(rentRange.value);
    const gender = document.getElementById('genderFilter').value;
    const sharing = document.getElementById('sharingFilter').value;
    
    // Get selected amenities
    const amenities = [];
    document.querySelectorAll('.checkbox-item input:checked').forEach(cb => {
        amenities.push(cb.value);
    });
    
    // Get all listing cards
    const listings = document.querySelectorAll('.listing-card');
    let visibleCount = 0;
    
    listings.forEach(listing => {
        let show = true;
        
        // Get listing data
        const listingRent = parseInt(listing.querySelector('.listing-price').textContent.replace('₹', '').replace(',', ''));
        const listingGender = listing.querySelector('.badge-blue') ? listing.querySelector('.badge-blue').textContent.toLowerCase() : '';
        
        // Filter by rent
        if (listingRent > maxRent) {
            show = false;
        }
        
        // Filter by gender
        if (gender && !listingGender.includes(gender === 'boys' ? 'male' : 'female')) {
            show = false;
        }
        
        // Filter by amenities
        if (amenities.length > 0) {
            const listingAmenities = listing.querySelectorAll('.amenity-item span');
            const listingAmenitiesText = Array.from(listingAmenities).map(a => a.textContent.toLowerCase());
            
            const hasAllAmenities = amenities.every(amenity => {
                return listingAmenitiesText.some(la => la.includes(amenity));
            });
            
            if (!hasAllAmenities) {
                show = false;
            }
        }
        
        // Show/hide listing
        listing.style.display = show ? 'flex' : 'none';
        if (show) visibleCount++;
    });
    
    // Update count
    const subtitle = document.querySelector('.page-subtitle');
    if (subtitle) {
        const cityText = subtitle.textContent.includes(' in ') ? subtitle.textContent.split(' in ')[1] : '';
        subtitle.textContent = visibleCount + ' properties found' + (cityText ? ' in ' + cityText : '');
    }
    
    // Show/hide no results
    const noResults = document.querySelector('.no-results');
    if (noResults) {
        noResults.style.display = visibleCount === 0 ? 'block' : 'none';
    }
}

// Toggle filters
function toggleFilters() {
    const sidebar = document.getElementById('filterSidebar');
    const toggleText = document.getElementById('filterToggleText');
    
    if (sidebar.style.display === 'none') {
        sidebar.style.display = 'block';
        toggleText.textContent = 'Hide Filters';
    } else {
        sidebar.style.display = 'none';
        toggleText.textContent = 'Show Filters';
    }
}

// View details
function viewDetails(id) {
    window.location.href = '${pageContext.request.contextPath}/pg-details?id=' + id;
}

// Contact owner - redirect to messages chat
function contactOwner(listingId, ownerId) {
    const isLoggedIn = ${sessionScope.userEmail != null};
    if (!isLoggedIn) {
        if (confirm('You need to login to contact the owner. Would you like to login now?')) {
            window.location.href = '${pageContext.request.contextPath}/login';
        }
    } else {
        window.location.href = '${pageContext.request.contextPath}/tenant/messages?ownerId=' + ownerId + '&listingId=' + listingId;
    }
}

// Clear filters
function clearFilters() {
    // Reset all filters
    document.getElementById('rentRange').value = 50000;
    document.getElementById('maxRentValue').textContent = '₹50000';
    document.getElementById('genderFilter').value = '';
    document.getElementById('sharingFilter').value = '';
    document.querySelectorAll('.checkbox-item input').forEach(cb => cb.checked = false);
    
    // Show all listings
    document.querySelectorAll('.listing-card').forEach(listing => {
        listing.style.display = 'flex';
    });
    
    // Update count
    const listings = document.querySelectorAll('.listing-card');
    const subtitle = document.querySelector('.page-subtitle');
    if (subtitle) {
        const cityText = subtitle.textContent.includes(' in ') ? subtitle.textContent.split(' in ')[1] : '';
        subtitle.textContent = listings.length + ' properties found' + (cityText ? ' in ' + cityText : '');
    }
}

// Show map view
function showMapView() {
    alert('Map view feature coming soon!');
}
</script>
