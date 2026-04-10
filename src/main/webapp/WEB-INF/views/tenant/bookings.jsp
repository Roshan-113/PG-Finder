<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="min-h-screen bg-gray-50 py-8">
    <div class="max-w-7xl mx-auto px-4">
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gray-900 mb-2">My Bookings</h1>
            <p class="text-gray-600">View and manage all your PG bookings</p>
        </div>

        <c:choose>
            <c:when test="${not empty bookings}">
                <div class="space-y-6">
                    <c:forEach var="booking" items="${bookings}">
                        <div class="bg-white rounded-lg border border-gray-200 shadow-sm overflow-hidden">
                            <div class="p-6">
                                <div class="flex justify-between items-start mb-4">
                                    <div>
                                        <div class="flex items-center gap-3 mb-2">
                                            <h3 class="text-xl font-bold text-gray-900">${booking.pgTitle}</h3>
                                            <c:choose>
                                                <c:when test="${booking.bookingStatus == 'confirmed'}">
                                                    <span class="px-3 py-1 bg-green-100 text-green-700 rounded-full text-sm font-semibold">Confirmed</span>
                                                </c:when>
                                                <c:when test="${booking.bookingStatus == 'pending'}">
                                                    <span class="px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-sm font-semibold">Pending</span>
                                                </c:when>
                                                <c:when test="${booking.bookingStatus == 'cancelled'}">
                                                    <span class="px-3 py-1 bg-red-100 text-red-700 rounded-full text-sm font-semibold">Cancelled</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-3 py-1 bg-gray-100 text-gray-700 rounded-full text-sm font-semibold">${booking.bookingStatus}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="flex items-center gap-2 text-gray-600 text-sm mb-1">
                                            <i class="fas fa-map-marker-alt"></i>
                                            <span>${booking.pgAddress}</span>
                                        </div>
                                        <div class="text-sm text-gray-500">
                                            Booking ID: #BK${booking.bookingId}
                                        </div>
                                    </div>
                                    <div class="text-right">
                                        <div class="text-2xl font-bold text-gray-900">₹<fmt:formatNumber value="${booking.rentAmount}" pattern="#,##0"/></div>
                                        <div class="text-sm text-gray-600">per month</div>
                                    </div>
                                </div>

                                <div class="grid grid-cols-4 gap-4 py-4 border-t border-b border-gray-200 mb-4">
                                    <div>
                                        <div class="text-sm text-gray-600 mb-1">Booking Date</div>
                                        <div class="font-semibold text-gray-900"><fmt:formatDate value="${booking.bookingDate}" pattern="dd MMM yyyy"/></div>
                                    </div>
                                    <div>
                                        <div class="text-sm text-gray-600 mb-1">Move-in Date</div>
                                        <div class="font-semibold text-gray-900"><fmt:formatDate value="${booking.moveInDate}" pattern="dd MMM yyyy"/></div>
                                    </div>
                                    <div>
                                        <div class="text-sm text-gray-600 mb-1">Security Deposit</div>
                                        <div class="font-semibold text-gray-900">₹<fmt:formatNumber value="${booking.securityDeposit}" pattern="#,##0"/></div>
                                    </div>
                                    <div>
                                        <div class="text-sm text-gray-600 mb-1">Payment Status</div>
                                        <c:choose>
                                            <c:when test="${booking.paymentStatus == 'paid'}">
                                                <div class="font-semibold text-green-600"><i class="fas fa-check-circle"></i> Paid</div>
                                            </c:when>
                                            <c:when test="${booking.paymentStatus == 'pending'}">
                                                <div class="font-semibold text-orange-600"><i class="fas fa-clock"></i> Pending</div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="font-semibold text-gray-600">${booking.paymentStatus}</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <c:if test="${not empty booking.specialRequests}">
                                    <div class="mb-4 p-3 bg-blue-50 rounded-lg">
                                        <div class="text-sm font-semibold text-blue-900 mb-1">Special Requests</div>
                                        <div class="text-sm text-gray-700">${booking.specialRequests}</div>
                                    </div>
                                </c:if>

                                <c:if test="${not empty booking.ownerName}">
                                    <div class="mb-4 p-3 bg-gray-50 rounded-lg">
                                        <div class="text-sm font-semibold text-gray-900 mb-2">Owner Details</div>
                                        <div class="flex items-center gap-4 text-sm text-gray-700">
                                            <div class="flex items-center gap-2">
                                                <i class="fas fa-user"></i>
                                                <span>${booking.ownerName}</span>
                                            </div>
                                            <c:if test="${not empty booking.ownerPhone}">
                                                <div class="flex items-center gap-2">
                                                    <i class="fas fa-phone"></i>
                                                    <span>${booking.ownerPhone}</span>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:if>

                                <div class="flex gap-3">
                                    <c:if test="${booking.bookingStatus == 'confirmed'}">
                                        <button onclick="window.location.href='${pageContext.request.contextPath}/tenant/booking-confirmation?bookingId=${booking.bookingId}'" class="px-4 py-2 text-white rounded-lg font-medium transition-colors" style="background-color: #2563eb;" onmouseover="this.style.backgroundColor='#1d4ed8'" onmouseout="this.style.backgroundColor='#2563eb'">
                                            <i class="fas fa-eye"></i> View Details
                                        </button>
                                        <button onclick="window.location.href='${pageContext.request.contextPath}/write-review?pgId=${booking.listingId}&bookingId=${booking.bookingId}'" class="px-4 py-2 text-white rounded-lg font-medium transition-colors" style="background-color: #10b981;" onmouseover="this.style.backgroundColor='#059669'" onmouseout="this.style.backgroundColor='#10b981'">
                                            <i class="fas fa-star"></i> Write Review
                                        </button>
                                    </c:if>
                                    <c:if test="${booking.bookingStatus == 'pending' && booking.paymentStatus == 'pending'}">
                                        <button onclick="window.location.href='${pageContext.request.contextPath}/tenant/payment?bookingId=${booking.bookingId}'" class="px-4 py-2 text-white rounded-lg font-medium transition-colors" style="background-color: #2563eb;" onmouseover="this.style.backgroundColor='#1d4ed8'" onmouseout="this.style.backgroundColor='#2563eb'">
                                            <i class="fas fa-credit-card"></i> Complete Payment
                                        </button>
                                    </c:if>
                                    <c:if test="${booking.bookingStatus != 'cancelled'}">
                                        <button onclick="cancelBooking(${booking.bookingId})" class="px-4 py-2 bg-white text-red-600 border border-red-600 rounded-lg font-medium hover:bg-red-50 transition-colors">
                                            <i class="fas fa-times-circle"></i> Cancel Booking
                                        </button>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="bg-white rounded-lg p-12 text-center border border-gray-200 shadow-sm">
                    <i class="fas fa-calendar-times text-gray-300 text-6xl mb-4"></i>
                    <h3 class="text-xl font-semibold text-gray-900 mb-2">No Bookings Yet</h3>
                    <p class="text-gray-600 mb-6">You haven't made any bookings yet. Start exploring PGs to find your perfect home!</p>
                    <button onclick="window.location.href='${pageContext.request.contextPath}/pg-listing'" class="px-6 py-3 text-white rounded-lg font-medium transition-colors" style="background-color: #2563eb;" onmouseover="this.style.backgroundColor='#1d4ed8'" onmouseout="this.style.backgroundColor='#2563eb'">
                        <i class="fas fa-search"></i> Browse PGs
                    </button>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
function cancelBooking(bookingId) {
    if (!confirm('Are you sure you want to cancel this booking?')) {
        return;
    }
    
    fetch('${pageContext.request.contextPath}/tenant/bookings', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'action=cancel&bookingId=' + bookingId
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Booking cancelled successfully');
            location.reload();
        } else {
            alert('Failed to cancel booking. Please try again.');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred. Please try again.');
    });
}
</script>

<style>
.space-y-6 > * + * {
    margin-top: 1.5rem;
}
.gap-6 {
    gap: 1.5rem;
}
.gap-4 {
    gap: 1rem;
}
.gap-3 {
    gap: 0.75rem;
}
.gap-2 {
    gap: 0.5rem;
}
</style>
