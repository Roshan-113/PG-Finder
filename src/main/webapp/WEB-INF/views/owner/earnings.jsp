<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="page-container">
    <div class="page-header">
        <h1>Earnings & Transactions</h1>
        <p>Track your income and transaction history</p>
    </div>

    <c:choose>
        <c:when test="${not empty earnings}">
            <!-- Summary Cards -->
            <div class="summary-grid">
                <div class="summary-card">
                    <div class="summary-icon" style="background: #d1fae5;">
                        <i class="fas fa-check-circle" style="color: #10b981;"></i>
                    </div>
                    <div>
                        <c:set var="completedTotal" value="0"/>
                        <c:forEach var="earning" items="${earnings}">
                            <c:if test="${earning.status == 'completed'}">
                                <c:set var="completedTotal" value="${completedTotal + earning.amount}"/>
                            </c:if>
                        </c:forEach>
                        <h3>₹<fmt:formatNumber value="${completedTotal}" pattern="#,##0"/></h3>
                        <p>Total Completed</p>
                    </div>
                </div>
                <div class="summary-card">
                    <div class="summary-icon" style="background: #fef3c7;">
                        <i class="fas fa-clock" style="color: #f59e0b;"></i>
                    </div>
                    <div>
                        <c:set var="pendingTotal" value="0"/>
                        <c:forEach var="earning" items="${earnings}">
                            <c:if test="${earning.status == 'pending'}">
                                <c:set var="pendingTotal" value="${pendingTotal + earning.amount}"/>
                            </c:if>
                        </c:forEach>
                        <h3>₹<fmt:formatNumber value="${pendingTotal}" pattern="#,##0"/></h3>
                        <p>Pending Amount</p>
                    </div>
                </div>
                <div class="summary-card">
                    <div class="summary-icon" style="background: #dbeafe;">
                        <i class="fas fa-list" style="color: #2563eb;"></i>
                    </div>
                    <div>
                        <h3>${earnings.size()}</h3>
                        <p>Total Transactions</p>
                    </div>
                </div>
            </div>

            <!-- Transactions Table -->
            <div class="section-card">
                <h2>Transaction History</h2>
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Booking ID</th>
                                <th>Tenant</th>
                                <th>Property</th>
                                <th>Type</th>
                                <th>Amount</th>
                                <th>Method</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="earning" items="${earnings}">
                                <tr>
                                    <td><fmt:formatDate value="${earning.transactionDate}" pattern="dd MMM yyyy"/></td>
                                    <td>#BK${earning.bookingId}</td>
                                    <td>${earning.tenantName}</td>
                                    <td>${earning.listingTitle}</td>
                                    <td>
                                        <span class="type-badge type-${earning.transactionType}">
                                            ${earning.transactionType}
                                        </span>
                                    </td>
                                    <td class="amount">₹<fmt:formatNumber value="${earning.amount}" pattern="#,##0"/></td>
                                    <td>${earning.paymentMethod}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${earning.status == 'completed'}">
                                                <span class="badge badge-success">Completed</span>
                                            </c:when>
                                            <c:when test="${earning.status == 'pending'}">
                                                <span class="badge badge-warning">Pending</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-danger">Failed</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <div style="width: 100px; height: 100px; margin: 0 auto 1.5rem; background: linear-gradient(135deg, #10b981 0%, #059669 100%); border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                    <i class="fas fa-wallet" style="font-size: 3rem; color: white;"></i>
                </div>
                <h3>No Earnings Yet</h3>
                <p>Your transaction history and earnings will appear here once tenants book your properties.</p>
                <div style="margin-top: 2rem; padding: 1.5rem; background: #f0fdf4; border-radius: 0.75rem; max-width: 500px; margin-left: auto; margin-right: auto;">
                    <p style="color: #065f46; font-weight: 600; margin: 0 0 0.5rem 0;">
                        <i class="fas fa-lightbulb"></i> How to start earning:
                    </p>
                    <ol style="text-align: left; color: #374151; font-size: 0.875rem; margin: 0; padding-left: 1.5rem;">
                        <li>Add your PG listings with complete details</li>
                        <li>Upload quality photos of your property</li>
                        <li>Set competitive pricing</li>
                        <li>Respond quickly to tenant inquiries</li>
                    </ol>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

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

.summary-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 1.5rem;
    margin-bottom: 2rem;
}

.summary-card {
    background: white;
    border-radius: 1rem;
    padding: 1.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    display: flex;
    align-items: center;
    gap: 1rem;
}

.summary-icon {
    width: 3.5rem;
    height: 3.5rem;
    border-radius: 0.75rem;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
}

.summary-card h3 {
    margin: 0 0 0.25rem 0;
    font-size: 1.75rem;
    font-weight: 700;
    color: #111827;
}

.summary-card p {
    margin: 0;
    font-size: 0.875rem;
    color: #6b7280;
}

.section-card {
    background: white;
    border-radius: 1rem;
    padding: 1.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.section-card h2 {
    margin: 0 0 1.5rem 0;
    font-size: 1.25rem;
    font-weight: 700;
    color: #111827;
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

.amount {
    font-weight: 700;
    color: #10b981;
}

.type-badge {
    display: inline-block;
    padding: 0.25rem 0.75rem;
    border-radius: 0.375rem;
    font-size: 0.75rem;
    font-weight: 600;
    text-transform: capitalize;
}

.type-booking {
    background: #dbeafe;
    color: #1e40af;
}

.type-refund {
    background: #fee2e2;
    color: #991b1b;
}

.type-commission {
    background: #fef3c7;
    color: #92400e;
}

.badge {
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
