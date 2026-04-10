<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="dashboard-container">
    <div class="dashboard-header">
        <h1>Owner Dashboard</h1>
        <p>Welcome back! Here's your business overview</p>
    </div>

    <!-- Statistics Cards -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon" style="background: #eff6ff;">
                <i class="fas fa-home" style="color: #2563eb;"></i>
            </div>
            <div class="stat-content">
                <h3>${stats.totalListings != null ? stats.totalListings : 0}</h3>
                <p>Total Listings</p>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon" style="background: #f0fdf4;">
                <i class="fas fa-calendar-check" style="color: #10b981;"></i>
            </div>
            <div class="stat-content">
                <h3>${stats.activeBookings != null ? stats.activeBookings : 0}</h3>
                <p>Active Bookings</p>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon" style="background: #fef3c7;">
                <i class="fas fa-rupee-sign" style="color: #f59e0b;"></i>
            </div>
            <div class="stat-content">
                <h3>₹<fmt:formatNumber value="${stats.totalEarnings != null ? stats.totalEarnings : 0}" pattern="#,##0"/></h3>
                <p>Total Earnings</p>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon" style="background: #fce7f3;">
                <i class="fas fa-question-circle" style="color: #ec4899;"></i>
            </div>
            <div class="stat-content">
                <h3>${stats.pendingInquiries != null ? stats.pendingInquiries : 0}</h3>
                <p>Pending Inquiries</p>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon" style="background: #ede9fe;">
                <i class="fas fa-door-open" style="color: #8b5cf6;"></i>
            </div>
            <div class="stat-content">
                <h3>${stats.availableRooms != null ? stats.availableRooms : 0}</h3>
                <p>Available Rooms</p>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon" style="background: #fef9c3;">
                <i class="fas fa-star" style="color: #eab308;"></i>
            </div>
            <div class="stat-content">
                <h3><fmt:formatNumber value="${stats.averageRating != null ? stats.averageRating : 0}" pattern="#.#"/></h3>
                <p>Average Rating</p>
            </div>
        </div>
    </div>

    <!-- Recent Bookings -->
    <div class="section-card">
        <div class="section-header">
            <h2>Recent Bookings</h2>
            <a href="${pageContext.request.contextPath}/owner/bookings" class="btn-link">View All</a>
        </div>

        <c:choose>
            <c:when test="${not empty recentBookings}">
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Booking ID</th>
                                <th>Tenant</th>
                                <th>PG</th>
                                <th>Move-in Date</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Payment</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="booking" items="${recentBookings}">
                                <tr>
                                    <td>#BK${booking.bookingId}</td>
                                    <td>
                                        <div class="tenant-info">
                                            <strong>${booking.tenantName}</strong>
                                            <small>${booking.tenantPhone}</small>
                                        </div>
                                    </td>
                                    <td>${booking.pgTitle}</td>
                                    <td><fmt:formatDate value="${booking.moveInDate}" pattern="dd MMM yyyy"/></td>
                                    <td>₹<fmt:formatNumber value="${booking.rentAmount}" pattern="#,##0"/></td>
                                    <td>
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
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${booking.paymentStatus == 'paid'}">
                                                <span class="badge badge-success"><i class="fas fa-check-circle"></i> Paid</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-warning"><i class="fas fa-clock"></i> Pending</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-calendar-times"></i>
                    <p>No recent bookings</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- New Owner Welcome Message -->
    <c:if test="${stats.totalListings == 0 || stats.totalListings == null}">
        <div class="section-card" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; text-align: center; padding: 3rem;">
            <i class="fas fa-rocket" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.9;"></i>
            <h2 style="color: white; font-size: 1.75rem; margin-bottom: 1rem;">Ready to Get Started?</h2>
            <p style="font-size: 1.125rem; margin-bottom: 2rem; opacity: 0.95;">Add your first PG listing and start receiving bookings from verified tenants!</p>
            <a href="${pageContext.request.contextPath}/owner/add-pg" style="display: inline-block; padding: 1rem 2rem; background: white; color: #667eea; border-radius: 0.75rem; font-weight: 700; text-decoration: none; transition: transform 0.2s;" onmouseover="this.style.transform='scale(1.05)'" onmouseout="this.style.transform='scale(1)'">
                <i class="fas fa-plus-circle"></i> Add Your First PG
            </a>
        </div>
    </c:if>

    <!-- Quick Actions -->
    <div class="quick-actions">
        <h2>Quick Actions</h2>
        <div class="actions-grid">
            <a href="${pageContext.request.contextPath}/owner/add-pg" class="action-card">
                <i class="fas fa-plus-circle"></i>
                <span>Add New PG</span>
            </a>
            <a href="${pageContext.request.contextPath}/owner/listings" class="action-card">
                <i class="fas fa-list"></i>
                <span>Manage Listings</span>
            </a>
            <a href="${pageContext.request.contextPath}/owner/bookings" class="action-card">
                <i class="fas fa-calendar-check"></i>
                <span>View Bookings</span>
            </a>
            <a href="${pageContext.request.contextPath}/owner/inquiries" class="action-card">
                <i class="fas fa-envelope"></i>
                <span>Check Inquiries</span>
            </a>
        </div>
    </div>
</div>

<style>
.dashboard-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 1.5rem;
}

.dashboard-header {
    margin-bottom: 2rem;
}

.dashboard-header h1 {
    margin: 0 0 0.5rem 0;
    font-size: 2rem;
    font-weight: 700;
    color: #111827;
}

.dashboard-header p {
    margin: 0;
    color: #6b7280;
}

.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1.5rem;
    margin-bottom: 2rem;
}

.stat-card {
    background: white;
    border-radius: 1rem;
    padding: 1.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    display: flex;
    align-items: center;
    gap: 1rem;
}

.stat-icon {
    width: 3.5rem;
    height: 3.5rem;
    border-radius: 0.75rem;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
}

.stat-content h3 {
    margin: 0 0 0.25rem 0;
    font-size: 1.75rem;
    font-weight: 700;
    color: #111827;
}

.stat-content p {
    margin: 0;
    font-size: 0.875rem;
    color: #6b7280;
}

.section-card {
    background: white;
    border-radius: 1rem;
    padding: 1.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    margin-bottom: 2rem;
}

.section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
}

.section-header h2 {
    margin: 0;
    font-size: 1.25rem;
    font-weight: 700;
    color: #111827;
}

.btn-link {
    color: #2563eb;
    text-decoration: none;
    font-weight: 600;
    font-size: 0.875rem;
}

.btn-link:hover {
    text-decoration: underline;
}

.table-responsive {
    overflow-x: auto;
}

.data-table {
    width: 100%;
    border-collapse: collapse;
}

.data-table thead {
    background: #f9fafb;
}

.data-table th {
    padding: 0.75rem 1rem;
    text-align: left;
    font-size: 0.875rem;
    font-weight: 600;
    color: #6b7280;
    border-bottom: 1px solid #e5e7eb;
}

.data-table td {
    padding: 1rem;
    border-bottom: 1px solid #f3f4f6;
    font-size: 0.875rem;
    color: #111827;
}

.tenant-info {
    display: flex;
    flex-direction: column;
}

.tenant-info strong {
    color: #111827;
}

.tenant-info small {
    color: #6b7280;
    font-size: 0.75rem;
}

.badge {
    display: inline-block;
    padding: 0.25rem 0.75rem;
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
    text-align: center;
    padding: 3rem 1rem;
    color: #9ca3af;
}

.empty-state i {
    font-size: 3rem;
    margin-bottom: 1rem;
}

.empty-state p {
    margin: 0;
    font-size: 1rem;
}

.quick-actions h2 {
    margin: 0 0 1.5rem 0;
    font-size: 1.25rem;
    font-weight: 700;
    color: #111827;
}

.actions-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1rem;
}

.action-card {
    background: white;
    border-radius: 0.75rem;
    padding: 1.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.75rem;
    text-decoration: none;
    color: #111827;
    transition: all 0.2s;
}

.action-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    background: #2563eb;
    color: white;
}

.action-card i {
    font-size: 2rem;
}

.action-card span {
    font-weight: 600;
    font-size: 0.875rem;
}
</style>
