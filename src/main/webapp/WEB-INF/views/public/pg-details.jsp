<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div style="background-color: #ffffff; min-height: 100vh;">
    <!-- Back Button -->
    <div style="max-width: 1200px; margin: 0 auto; padding: 1.5rem 1.5rem 0 1.5rem;">
        <a href="${pageContext.request.contextPath}/pg-listing" style="display: inline-flex; align-items: center; gap: 0.5rem; color: #6b7280; text-decoration: none; font-size: 0.875rem;">
            <i class="fas fa-arrow-left"></i>
            <span>Back to Listings</span>
        </a>
    </div>

    <div style="max-width: 1200px; margin: 0 auto; padding: 1.5rem;">
        <div style="display: grid; grid-template-columns: 1fr 380px; gap: 2rem;">
            <!-- Left Side - Details -->
            <div>
                <!-- Hero Image / Photo Carousel -->
                <div style="position: relative; margin-bottom: 1.5rem;">
                    <c:choose>
                        <c:when test="${not empty listing.photos && listing.photos.size() > 0}">
                            <!-- Photo Carousel -->
                            <div id="photoCarousel" style="position: relative; width: 100%; height: 400px; border-radius: 1rem; overflow: hidden; background: #f3f4f6;">
                                <c:forEach var="photo" items="${listing.photos}" varStatus="status">
                                    <img src="${photo}" 
                                         alt="${listing.title}" 
                                         class="carousel-image ${status.index == 0 ? 'active' : ''}"
                                         style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; opacity: ${status.index == 0 ? '1' : '0'}; transition: opacity 0.5s ease-in-out;">
                                </c:forEach>
                                
                                <!-- Navigation Arrows - Show if photos exist -->
                                <c:if test="${not empty listing.photos && listing.photos.size() > 1}">
                                    <!-- Left Arrow -->
                                    <button type="button" onclick="changePhoto(-1)" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); width: 3rem; height: 3rem; border-radius: 50%; background: rgba(255,255,255,0.95); border: none; cursor: pointer; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 12px rgba(0,0,0,0.3); z-index: 100;">
                                        <i class="fas fa-chevron-left" style="color: #111827; font-size: 1.5rem;"></i>
                                    </button>
                                    
                                    <!-- Right Arrow -->
                                    <button type="button" onclick="changePhoto(1)" style="position: absolute; right: 1rem; top: 50%; transform: translateY(-50%); width: 3rem; height: 3rem; border-radius: 50%; background: rgba(255,255,255,0.95); border: none; cursor: pointer; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 12px rgba(0,0,0,0.3); z-index: 100;">
                                        <i class="fas fa-chevron-right" style="color: #111827; font-size: 1.5rem;"></i>
                                    </button>
                                    
                                    <!-- Photo Counter -->
                                    <div id="photoCounter" style="position: absolute; bottom: 1rem; left: 50%; transform: translateX(-50%); background: rgba(0,0,0,0.75); color: white; padding: 0.5rem 1rem; border-radius: 9999px; font-size: 0.875rem; font-weight: 600; z-index: 100;">
                                        1 / ${listing.photos.size()}
                                    </div>
                                </c:if>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Default Image -->
                            <img src="https://images.unsplash.com/photo-1555854877-bab0e564b8d5?w=800&h=400&fit=crop" 
                                 alt="${listing.title}" style="width: 100%; height: 400px; object-fit: cover; border-radius: 1rem;">
                        </c:otherwise>
                    </c:choose>
                    
                    <!-- Verified Badge -->
                    <div style="position: absolute; top: 1rem; left: 1rem; background: ${listing.verified ? '#2563eb' : '#6b7280'}; color: white; padding: 0.375rem 0.75rem; border-radius: 0.5rem; font-size: 0.75rem; font-weight: 600; z-index: 50;">
                        <i class="fas fa-check-circle" style="margin-right: 0.25rem;"></i>
                        ${listing.verified ? 'Verified' : 'Unverified'}
                    </div>
                    
                    <!-- Action Buttons -->
                    <div style="position: absolute; top: 1rem; right: 1rem; display: flex; gap: 0.5rem; z-index: 50;">
                        <button onclick="toggleSavePG(${listing.listingId})" id="saveBtn${listing.listingId}" style="width: 2.5rem; height: 2.5rem; border-radius: 50%; background: white; border: none; cursor: pointer; display: flex; align-items: center; justify-content: center; box-shadow: 0 2px 8px rgba(0,0,0,0.15);">
                            <i class="${listing.saved ? 'fas' : 'far'} fa-heart" style="color: ${listing.saved ? '#ef4444' : '#374151'}; font-size: 1.125rem;"></i>
                        </button>
                        <button onclick="sharePG()" style="width: 2.5rem; height: 2.5rem; border-radius: 50%; background: white; border: none; cursor: pointer; display: flex; align-items: center; justify-content: center; box-shadow: 0 2px 8px rgba(0,0,0,0.15);">
                            <i class="fas fa-share-alt" style="color: #374151; font-size: 1.125rem;"></i>
                        </button>
                    </div>
                </div>

                <!-- Title and Info -->
                <div style="margin-bottom: 1.5rem;">
                    <div style="display: flex; align-items: start; justify-content: space-between; margin-bottom: 1rem;">
                        <div>
                            <h1 style="margin: 0 0 0.5rem 0; font-size: 1.875rem; font-weight: bold; color: #111827;">${listing.title}</h1>
                            <div style="display: flex; align-items: center; gap: 0.375rem; color: #6b7280; font-size: 0.875rem; margin-bottom: 0.75rem;">
                                <i class="fas fa-map-marker-alt"></i>
                                <span>${listing.address}, ${listing.city}</span>
                            </div>
                            <div style="display: flex; align-items: center; gap: 1rem; flex-wrap: wrap;">
                                <div style="display: flex; align-items: center; gap: 0.375rem;">
                                    <i class="fas fa-star" style="color: #fbbf24; font-size: 1rem;"></i>
                                    <span style="font-weight: 600; color: #111827;">${listing.averageRating > 0 ? listing.averageRating : 'New'}</span>
                                    <c:if test="${listing.reviewCount > 0}">
                                        <span style="color: #6b7280; font-size: 0.875rem;">(${listing.reviewCount} reviews)</span>
                                    </c:if>
                                </div>
                                <span style="background: #dbeafe; color: #1e40af; padding: 0.25rem 0.75rem; border-radius: 9999px; font-size: 0.75rem; font-weight: 600;">${listing.pgType}</span>
                            </div>
                        </div>
                        <div style="text-align: right;">
                            <div style="font-size: 2rem; font-weight: bold; color: #111827;">₹<fmt:formatNumber value="${listing.rentPerMonth}" pattern="#,##0"/></div>
                            <div style="font-size: 0.875rem; color: #6b7280;">per month</div>
                        </div>
                    </div>
                    
                    <div style="display: flex; align-items: center; gap: 1.5rem; padding: 1rem; background: #f9fafb; border-radius: 0.5rem; font-size: 0.875rem;">
                        <div style="display: flex; align-items: center; gap: 0.5rem;">
                            <i class="fas fa-door-open" style="color: #2563eb;"></i>
                            <span style="color: #374151;"><strong>${listing.availableRooms} rooms</strong> available</span>
                        </div>
                        <div style="display: flex; align-items: center; gap: 0.5rem;">
                            <i class="fas fa-calendar-check" style="color: #2563eb;"></i>
                            <span style="color: #374151;"><strong>Immediate</strong> move-in</span>
                        </div>
                    </div>
                </div>

                <!-- About This Property -->
                <div style="margin-bottom: 1.5rem;">
                    <h2 style="margin: 0 0 1rem 0; font-size: 1.25rem; font-weight: 700; color: #111827;">About This Property</h2>
                    <p style="margin: 0; color: #4b5563; line-height: 1.75; font-size: 0.9375rem;">
                        ${listing.description != null ? listing.description : 'Spacious PG accommodation with all modern amenities. The property is well-maintained and located in a safe neighborhood.'}
                    </p>
                </div>

                <!-- Amenities -->
                <div style="margin-bottom: 1.5rem;">
                    <h2 style="margin: 0 0 1rem 0; font-size: 1.25rem; font-weight: 700; color: #111827;">Amenities</h2>
                    <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 1rem;">
                        <c:if test="${listing.wifiAvailable}">
                            <div style="display: flex; align-items: center; gap: 0.75rem; padding: 0.75rem; background: #f9fafb; border-radius: 0.5rem;">
                                <div style="width: 2.5rem; height: 2.5rem; border-radius: 0.5rem; background: #dbeafe; display: flex; align-items: center; justify-content: center;">
                                    <i class="fas fa-wifi" style="color: #2563eb; font-size: 1.125rem;"></i>
                                </div>
                                <span style="color: #374151; font-size: 0.9375rem;">WiFi</span>
                            </div>
                        </c:if>
                        <c:if test="${listing.acAvailable}">
                            <div style="display: flex; align-items: center; gap: 0.75rem; padding: 0.75rem; background: #f9fafb; border-radius: 0.5rem;">
                                <div style="width: 2.5rem; height: 2.5rem; border-radius: 0.5rem; background: #dbeafe; display: flex; align-items: center; justify-content: center;">
                                    <i class="fas fa-snowflake" style="color: #2563eb; font-size: 1.125rem;"></i>
                                </div>
                                <span style="color: #374151; font-size: 0.9375rem;">AC</span>
                            </div>
                        </c:if>
                        <c:if test="${listing.laundryAvailable}">
                            <div style="display: flex; align-items: center; gap: 0.75rem; padding: 0.75rem; background: #f9fafb; border-radius: 0.5rem;">
                                <div style="width: 2.5rem; height: 2.5rem; border-radius: 0.5rem; background: #dbeafe; display: flex; align-items: center; justify-content: center;">
                                    <i class="fas fa-tshirt" style="color: #2563eb; font-size: 1.125rem;"></i>
                                </div>
                                <span style="color: #374151; font-size: 0.9375rem;">Laundry</span>
                            </div>
                        </c:if>
                        <c:if test="${listing.foodIncluded}">
                            <div style="display: flex; align-items: center; gap: 0.75rem; padding: 0.75rem; background: #f9fafb; border-radius: 0.5rem;">
                                <div style="width: 2.5rem; height: 2.5rem; border-radius: 0.5rem; background: #dbeafe; display: flex; align-items: center; justify-content: center;">
                                    <i class="fas fa-utensils" style="color: #2563eb; font-size: 1.125rem;"></i>
                                </div>
                                <span style="color: #374151; font-size: 0.9375rem;">Food</span>
                            </div>
                        </c:if>
                        <c:if test="${listing.parkingAvailable}">
                            <div style="display: flex; align-items: center; gap: 0.75rem; padding: 0.75rem; background: #f9fafb; border-radius: 0.5rem;">
                                <div style="width: 2.5rem; height: 2.5rem; border-radius: 0.5rem; background: #dbeafe; display: flex; align-items: center; justify-content: center;">
                                    <i class="fas fa-car" style="color: #2563eb; font-size: 1.125rem;"></i>
                                </div>
                                <span style="color: #374151; font-size: 0.9375rem;">Parking</span>
                            </div>
                        </c:if>
                        <div style="display: flex; align-items: center; gap: 0.75rem; padding: 0.75rem; background: #f9fafb; border-radius: 0.5rem;">
                            <div style="width: 2.5rem; height: 2.5rem; border-radius: 0.5rem; background: #dbeafe; display: flex; align-items: center; justify-content: center;">
                                <i class="fas fa-shield-alt" style="color: #2563eb; font-size: 1.125rem;"></i>
                            </div>
                            <span style="color: #374151; font-size: 0.9375rem;">Security</span>
                        </div>
                    </div>
                </div>

                <!-- House Rules -->
                <div style="margin-bottom: 1.5rem;">
                    <h2 style="margin: 0 0 1rem 0; font-size: 1.25rem; font-weight: 700; color: #111827;">House Rules</h2>
                    <div style="display: flex; flex-direction: column; gap: 0.75rem;">
                        <div style="display: flex; align-items: center; gap: 0.75rem;">
                            <i class="fas fa-check-circle" style="color: #10b981; font-size: 1.125rem;"></i>
                            <span style="color: #4b5563; font-size: 0.9375rem;">No smoking</span>
                        </div>
                        <div style="display: flex; align-items: center; gap: 0.75rem;">
                            <i class="fas fa-check-circle" style="color: #10b981; font-size: 1.125rem;"></i>
                            <span style="color: #4b5563; font-size: 0.9375rem;">Curfew at 10 PM</span>
                        </div>
                        <div style="display: flex; align-items: center; gap: 0.75rem;">
                            <i class="fas fa-check-circle" style="color: #10b981; font-size: 1.125rem;"></i>
                            <span style="color: #4b5563; font-size: 0.9375rem;">ID proof required</span>
                        </div>
                    </div>
                </div>

                <!-- Reviews -->
                <div>
                    <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 1rem;">
                        <h2 style="margin: 0; font-size: 1.25rem; font-weight: 700; color: #111827;">Reviews</h2>
                        <a href="#" style="color: #2563eb; text-decoration: none; font-size: 0.875rem; font-weight: 500;">See All</a>
                    </div>

                    <!-- Review 1 -->
                    <div style="padding: 1rem 0; border-bottom: 1px solid #e5e7eb;">
                        <div style="display: flex; align-items: start; gap: 0.75rem;">
                            <div style="width: 2.5rem; height: 2.5rem; border-radius: 50%; background: #2563eb; color: white; display: flex; align-items: center; justify-content: center; font-weight: 600; flex-shrink: 0;">
                                P
                            </div>
                            <div style="flex: 1;">
                                <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 0.25rem;">
                                    <h4 style="margin: 0; font-weight: 600; color: #111827; font-size: 0.9375rem;">Priya Singh</h4>
                                    <div style="display: flex; align-items: center; gap: 0.25rem;">
                                        <i class="fas fa-star" style="color: #fbbf24; font-size: 0.875rem;"></i>
                                        <span style="font-weight: 600; color: #111827; font-size: 0.875rem;">5</span>
                                    </div>
                                </div>
                                <div style="color: #9ca3af; font-size: 0.75rem; margin-bottom: 0.5rem;">Jan 28, 2026</div>
                                <p style="margin: 0; color: #4b5563; font-size: 0.875rem; line-height: 1.5;">Very safe and clean environment. Perfect for working women. The security measures are excellent and the staff is very helpful. Highly recommended!</p>
                            </div>
                        </div>
                    </div>

                    <!-- Review 2 -->
                    <div style="padding: 1rem 0;">
                        <div style="display: flex; align-items: start; gap: 0.75rem;">
                            <div style="width: 2.5rem; height: 2.5rem; border-radius: 50%; background: #10b981; color: white; display: flex; align-items: center; justify-content: center; font-weight: 600; flex-shrink: 0;">
                                A
                            </div>
                            <div style="flex: 1;">
                                <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 0.25rem;">
                                    <h4 style="margin: 0; font-weight: 600; color: #111827; font-size: 0.9375rem;">Anjali Desai</h4>
                                    <div style="display: flex; align-items: center; gap: 0.25rem;">
                                        <i class="fas fa-star" style="color: #fbbf24; font-size: 0.875rem;"></i>
                                        <span style="font-weight: 600; color: #111827; font-size: 0.875rem;">4.8</span>
                                    </div>
                                </div>
                                <div style="color: #9ca3af; font-size: 0.75rem; margin-bottom: 0.5rem;">Dec 28, 2025</div>
                                <p style="margin: 0; color: #4b5563; font-size: 0.875rem; line-height: 1.5;">Amazing experience! The owner treats everyone like family. Clean rooms, good food, and great location. Would definitely recommend to my friends.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Side - Contact Owner Card -->
            <div>
                <div style="background: white; border: 1px solid #e5e7eb; border-radius: 1rem; padding: 1.5rem; position: sticky; top: 1.5rem;">
                    <h3 style="margin: 0 0 1rem 0; font-size: 1.125rem; font-weight: 700; color: #111827;">Contact Owner</h3>
                    
                    <!-- Owner Info -->
                    <div style="display: flex; align-items: center; gap: 0.75rem; padding: 1rem; background: #f9fafb; border-radius: 0.75rem; margin-bottom: 1rem;">
                        <div style="width: 3rem; height: 3rem; border-radius: 50%; background: #2563eb; color: white; display: flex; align-items: center; justify-content: center; font-weight: 600; font-size: 1.125rem; flex-shrink: 0;">
                            ${listing.ownerName != null ? listing.ownerName.substring(0, 1).toUpperCase() : 'O'}
                        </div>
                        <div>
                            <div style="font-weight: 600; color: #111827; font-size: 0.9375rem;">${listing.ownerName != null ? listing.ownerName : 'Property Owner'}</div>
                            <div style="color: #6b7280; font-size: 0.8125rem;">Property Owner</div>
                        </div>
                    </div>
                    
                    <!-- Action Buttons -->
                    <button onclick="bookNow()" style="width: 100%; padding: 0.875rem; background: #2563eb; color: white; font-weight: 600; border-radius: 0.5rem; border: none; cursor: pointer; font-size: 0.9375rem; margin-bottom: 0.75rem; display: flex; align-items: center; justify-content: center; gap: 0.5rem; transition: background 0.2s;"
                            onmouseover="this.style.background='#1d4ed8'" onmouseout="this.style.background='#2563eb'">
                        <i class="fas fa-calendar-check"></i>
                        Book Now
                    </button>
                    
                    <button onclick="sendInquiry()" style="width: 100%; padding: 0.875rem; background: #2563eb; color: white; font-weight: 600; border-radius: 0.5rem; border: none; cursor: pointer; font-size: 0.9375rem; margin-bottom: 0.75rem; display: flex; align-items: center; justify-content: center; gap: 0.5rem; transition: all 0.2s;"
                            onmouseover="this.style.background='#1d4ed8'" onmouseout="this.style.background='#2563eb'">
                        <i class="fas fa-paper-plane"></i>
                        Send Inquiry
                    </button>
                    
                    <button onclick="callOwner()" style="width: 100%; padding: 0.875rem; background: #2563eb; color: white; font-weight: 600; border-radius: 0.5rem; border: none; cursor: pointer; font-size: 0.9375rem; margin-bottom: 0.75rem; display: flex; align-items: center; justify-content: center; gap: 0.5rem; transition: all 0.2s;"
                            onmouseover="this.style.background='#1d4ed8'" onmouseout="this.style.background='#2563eb'">
                        <i class="fas fa-phone"></i>
                        +91 98765 43210
                    </button>
                    
                    <!-- Find Roommate Button -->
                    <button onclick="findRoommateForPG()" style="width: 100%; padding: 0.875rem; background: #10b981; color: white; font-weight: 600; border-radius: 0.5rem; border: none; cursor: pointer; font-size: 0.9375rem; display: flex; align-items: center; justify-content: center; gap: 0.5rem; transition: all 0.2s;"
                            onmouseover="this.style.background='#059669'" onmouseout="this.style.background='#10b981'">
                        <i class="fas fa-users"></i>
                        Find Roommate Here
                    </button>
                    
                    <!-- Quick Info -->
                    <div style="margin-top: 1.5rem; padding-top: 1.5rem; border-top: 1px solid #e5e7eb;">
                        <h4 style="margin: 0 0 1rem 0; font-size: 1rem; font-weight: 600; color: #111827;">Quick Info</h4>
                        <div style="display: flex; flex-direction: column; gap: 0.75rem;">
                            <div style="display: flex; align-items: center; justify-content: space-between;">
                                <span style="color: #6b7280; font-size: 0.875rem;">Response Rate</span>
                                <span style="font-weight: 600; color: #111827; font-size: 0.875rem;">95%</span>
                            </div>
                            <div style="display: flex; align-items: center; justify-content: space-between;">
                                <span style="color: #6b7280; font-size: 0.875rem;">Response Time</span>
                                <span style="font-weight: 600; color: #111827; font-size: 0.875rem;">Within 2 hours</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
let currentPhotoIndex = 0;
const totalPhotos = ${not empty listing.photos ? listing.photos.size() : 0};

function changePhoto(direction) {
    if (totalPhotos <= 1) return;
    
    const images = document.querySelectorAll('.carousel-image');
    images[currentPhotoIndex].style.opacity = '0';
    
    currentPhotoIndex += direction;
    if (currentPhotoIndex >= totalPhotos) currentPhotoIndex = 0;
    if (currentPhotoIndex < 0) currentPhotoIndex = totalPhotos - 1;
    
    images[currentPhotoIndex].style.opacity = '1';
    
    // Update counter
    const counter = document.getElementById('photoCounter');
    if (counter) {
        counter.textContent = (currentPhotoIndex + 1) + ' / ' + totalPhotos;
    }
}

// Auto-advance photos every 5 seconds
if (totalPhotos > 1) {
    setInterval(() => changePhoto(1), 5000);
}

// Keyboard navigation
document.addEventListener('keydown', (e) => {
    if (e.key === 'ArrowLeft') changePhoto(-1);
    if (e.key === 'ArrowRight') changePhoto(1);
});

function bookNow() {
    const isLoggedIn = ${sessionScope.userEmail != null};
    const listingId = ${listing.listingId};
    
    if (!isLoggedIn) {
        if (confirm('You need to login to book this PG. Would you like to login now?')) {
            window.location.href = '${pageContext.request.contextPath}/login?redirect=' + encodeURIComponent('/tenant/book-pg?listingId=' + listingId);
        }
    } else {
        window.location.href = '${pageContext.request.contextPath}/tenant/book-pg?listingId=' + listingId;
    }
}

function sendInquiry() {
    const isLoggedIn = ${sessionScope.userEmail != null};
    if (!isLoggedIn) {
        if (confirm('You need to login to send an inquiry. Would you like to login now?')) {
            window.location.href = '${pageContext.request.contextPath}/login';
        }
    } else {
        // Redirect to messages with owner ID and listing info
        window.location.href = '${pageContext.request.contextPath}/tenant/messages?ownerId=${listing.ownerId}&listingId=${listing.listingId}&listingTitle=${listing.title}';
    }
}

function callOwner() {
    const isLoggedIn = ${sessionScope.userEmail != null};
    if (!isLoggedIn) {
        if (confirm('You need to login to view contact details. Would you like to login now?')) {
            window.location.href = '${pageContext.request.contextPath}/login';
        }
    } else {
        alert('You can call the owner at ${listing.ownerPhone != null ? listing.ownerPhone : "+91 98765 43210"}');
    }
}

function findRoommateForPG() {
    // Redirect to roommate finder with PG information
    const pgName = '${listing.title}';
    const pgCity = '${listing.city}';
    const pgId = ${listing.listingId};
    
    window.location.href = '${pageContext.request.contextPath}/find-roommate?pgId=' + pgId + '&pgName=' + encodeURIComponent(pgName) + '&city=' + encodeURIComponent(pgCity);
}

function toggleSavePG(listingId) {
    const isLoggedIn = ${sessionScope.userEmail != null};
    if (!isLoggedIn) {
        if (confirm('You need to login to save PGs. Would you like to login now?')) {
            window.location.href = '${pageContext.request.contextPath}/login';
        }
        return;
    }
    
    const btn = document.getElementById('saveBtn' + listingId);
    const icon = btn.querySelector('i');
    const isSaved = icon.classList.contains('fas');
    
    const action = isSaved ? 'unsave' : 'save';
    
    fetch('${pageContext.request.contextPath}/tenant/saved-pgs?action=' + action + '&listingId=' + listingId, {
        method: 'POST'
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            if (isSaved) {
                icon.classList.remove('fas');
                icon.classList.add('far');
                icon.style.color = '#374151';
            } else {
                icon.classList.remove('far');
                icon.classList.add('fas');
                icon.style.color = '#ef4444';
            }
        } else {
            alert('Failed to update saved status');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred');
    });
}

function sharePG() {
    if (navigator.share) {
        navigator.share({
            title: '${listing.title}',
            url: window.location.href
        });
    } else {
        alert('Share link: ' + window.location.href);
    }
}
</script>

<style>
.carousel-arrow {
    position: absolute !important;
    top: 50% !important;
    transform: translateY(-50%) !important;
    width: 3rem !important;
    height: 3rem !important;
    border-radius: 50% !important;
    background: rgba(255, 255, 255, 0.95) !important;
    border: none !important;
    cursor: pointer !important;
    display: flex !important;
    align-items: center !important;
    justify-content: center !important;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3) !important;
    z-index: 100 !important;
    transition: all 0.2s !important;
}

.carousel-arrow:hover {
    background: rgba(255, 255, 255, 1) !important;
    transform: translateY(-50%) scale(1.1) !important;
}

.carousel-arrow-left {
    left: 1rem !important;
}

.carousel-arrow-right {
    right: 1rem !important;
}

.carousel-arrow i {
    color: #111827 !important;
    font-size: 1.5rem !important;
}
</style>
