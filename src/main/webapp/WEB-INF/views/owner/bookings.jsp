<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="page-container">
    <div class="page-header">
        <h1>Manage Bookings</h1>
        <p>View and manage all your property bookings</p>
    </div>

    <c:choose>
        <c:when test="${not empty bookings}">
            <div class="bookings-grid">
                <c:forEach var="booking" items="${bookings}">
                    <div class="booking-card">
                        <div class="booking-header">
                            <div>
                                <h3>${booking.pgTitle}</h3>
                                <p class="booking-id">#BK${booking.bookingId}</p>
                            </div>
                            <c:choose>
                                <c:when test="${booking.bookingStatus == 'confirmed'}">
                                    <span class="badge badge-success">Confirmed</span>
                                </c:when>
                                <c:when test="${booking.bookingStatus == 'pending'}">
                                    <span class="badge badge-warning">Pending</span>
                                </c:when>
                                <c:when test="${booking.bookingStatus == 'rejected'}">
                                    <span class="badge badge-danger">Rejected</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-secondary">${booking.bookingStatus}</span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="booking-details">
                            <div class="detail-row">
                                <i class="fas fa-user"></i>
                                <div>
                                    <strong>${booking.tenantName}</strong>
                                    <small>${booking.tenantPhone}</small>
                                </div>
                            </div>
                            <div class="detail-row">
                                <i class="fas fa-envelope"></i>
                                <span>${booking.tenantEmail}</span>
                            </div>
                            <div class="detail-row">
                                <i class="fas fa-calendar"></i>
                                <span>Move-in: <fmt:formatDate value="${booking.moveInDate}" pattern="dd MMM yyyy"/></span>
                            </div>
                            <div class="detail-row">
                                <i class="fas fa-rupee-sign"></i>
                                <span>Rent: ₹<fmt:formatNumber value="${booking.rentAmount}" pattern="#,##0"/>/month</span>
                            </div>
                            <div class="detail-row">
                                <i class="fas fa-shield-alt"></i>
                                <span>Deposit: ₹<fmt:formatNumber value="${booking.securityDeposit}" pattern="#,##0"/></span>
                            </div>
                            <div class="detail-row">
                                <i class="fas fa-credit-card"></i>
                                <span>Payment: 
                                    <c:choose>
                                        <c:when test="${booking.paymentStatus == 'paid'}">
                                            <strong style="color: #10b981;">Paid</strong>
                                        </c:when>
                                        <c:otherwise>
                                            <strong style="color: #f59e0b;">Pending</strong>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </div>

                        <c:if test="${not empty booking.specialRequests}">
                            <div class="special-requests">
                                <strong>Special Requests:</strong>
                                <p>${booking.specialRequests}</p>
                            </div>
                        </c:if>

                        <c:if test="${booking.bookingStatus == 'pending'}">
                            <div class="booking-actions">
                                <button onclick="updateBooking(${booking.bookingId}, 'accept')" class="btn btn-success">
                                    <i class="fas fa-check"></i> Accept
                                </button>
                                <button onclick="updateBooking(${booking.bookingId}, 'reject')" class="btn btn-danger">
                                    <i class="fas fa-times"></i> Reject
                                </button>
                            </div>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="fas fa-calendar-times"></i>
                <h3>No Bookings Yet</h3>
                <p>Once tenants book your PG properties, they'll appear here.</p>
                <c:if test="${empty listings || listings.size() == 0}">
                    <p style="margin-top: 1rem; color: #2563eb; font-weight: 600;">
                        <i class="fas fa-info-circle"></i> Start by adding your first PG listing to receive bookings!
                    </p>
                    <button onclick="window.location.href='${pageContext.request.contextPath}/owner/add-pg'" style="margin-top: 1.5rem; padding: 0.75rem 1.5rem; background: #2563eb; color: white; border: none; border-radius: 0.5rem; font-weight: 600; cursor: pointer; transition: background 0.3s;" onmouseover="this.style.background='#1d4ed8'" onmouseout="this.style.background='#2563eb'">
                        <i class="fas fa-plus-circle"></i> Add Your First PG
                    </button>
                </c:if>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
function updateBooking(bookingId, action) {
    const confirmMsg = action === 'accept' ? 'Accept this booking?' : 'Reject this booking?';
    if (!confirm(confirmMsg)) return;
    
    const formData = new FormData();
    formData.append('action', action);
    formData.append('bookingId', bookingId);
    
    fetch('${pageContext.request.contextPath}/owner/bookings', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Booking ' + (action === 'accept' ? 'accepted' : 'rejected') + ' successfully!');
            location.reload();
        } else {
            alert('Failed to update booking');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred');
    });
}
</script>

<style>
.page-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 1.5rem;
}

.page-header {
    margin-bottom: 2rem;
}

.page-header h1 {
    margin: 0 0 0.5rem 0;
    font-size: 2rem;
    font-weight: 700;
    color: #111827;
}

.page-header p {
    margin: 0;
    color: #6b7280;
}

.bookings-grid {
    display: grid;
    gap: 1.5rem;
}

.booking-card {
    background: white;
    border-radius: 1rem;
    padding: 1.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.booking-header {
    display: flex;
    justify-content: space-between;
    align-items: start;
    margin-bottom: 1.5rem;
    padding-bottom: 1rem;
    border-bottom: 1px solid #f3f4f6;
}

.booking-header h3 {
    margin: 0 0 0.25rem 0;
    font-size: 1.25rem;
    font-weight: 700;
    color: #111827;
}

.booking-id {
    margin: 0;
    font-size: 0.875rem;
    color: #6b7280;
}

.booking-details {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1rem;
    margin-bottom: 1rem;
}

.detail-row {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    font-size: 0.875rem;
}

.detail-row i {
    color: #2563eb;
    width: 1.25rem;
}

.detail-row div {
    display: flex;
    flex-direction: column;
}

.detail-row strong {
    color: #111827;
}

.detail-row small {
    color: #6b7280;
    font-size: 0.75rem;
}

.special-requests {
    background: #f0f9ff;
    border-radius: 0.5rem;
    padding: 1rem;
    margin-bottom: 1rem;
}

.special-requests strong {
    color: #1e40af;
    font-size: 0.875rem;
}

.special-requests p {
    margin: 0.5rem 0 0 0;
    color: #374151;
    font-size: 0.875rem;
}

.booking-actions {
    display: flex;
    gap: 1rem;
    padding-top: 1rem;
    border-top: 1px solid #f3f4f6;
}

.btn {
    flex: 1;
    padding: 0.75rem 1.5rem;
    border: none;
    border-radius: 0.5rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
}

.btn-success {
    background: #10b981;
    color: white;
}

.btn-success:hover {
    background: #059669;
}

.btn-danger {
    background: #ef4444;
    color: white;
}

.btn-danger:hover {
    background: #dc2626;
}

.badge {
    padding: 0.375rem 0.75rem;
    border-radius: 9999px;
    font-size: 0.75rem;
    font-weight: 600;
}

.badge-success {
    background: #d1fae5;
    color: #065f46;
}

.badge-warning {
    background: #fef3c7;
    color: #92400e;
}

.badge-danger {
    background: #fee2e2;
    color: #991b1b;
}

.badge-secondary {
    background: #f3f4f6;
    color: #374151;
}

.empty-state {
    background: white;
    border-radius: 1rem;
    padding: 4rem 2rem;
    text-align: center;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.empty-state i {
    font-size: 4rem;
    color: #d1d5db;
    margin-bottom: 1rem;
}

.empty-state h3 {
    margin: 0 0 0.5rem 0;
    font-size: 1.5rem;
    color: #374151;
}

.empty-state p {
    margin: 0;
    color: #6b7280;
}
</style>
