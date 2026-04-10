<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="page-container">
    <div class="page-header">
        <h1>Reviews & Ratings</h1>
        <p>See what tenants are saying about your properties</p>
    </div>

    <c:choose>
        <c:when test="${not empty reviews}">
            <div class="reviews-grid">
                <c:forEach var="review" items="${reviews}">
                    <div class="review-card">
                        <div class="review-header">
                            <div class="reviewer-info">
                                <div class="reviewer-avatar">
                                    ${review.tenantName.substring(0,1).toUpperCase()}
                                </div>
                                <div>
                                    <h3>${review.tenantName}</h3>
                                    <p class="review-date"><fmt:formatDate value="${review.createdAt}" pattern="dd MMM yyyy"/></p>
                                </div>
                            </div>
                            <div class="rating-display">
                                <c:forEach begin="1" end="5" var="i">
                                    <i class="fas fa-star ${i <= review.rating ? 'filled' : ''}"></i>
                                </c:forEach>
                                <span class="rating-number">${review.rating}/5</span>
                            </div>
                        </div>

                        <div class="review-property">
                            <i class="fas fa-home"></i>
                            <span>${review.listingTitle}</span>
                        </div>

                        <div class="review-content">
                            <p>${review.reviewText}</p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="fas fa-star"></i>
                <h3>No Reviews Yet</h3>
                <p>Reviews from tenants will appear here</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<style>
.page-container {
    max-width: 1200px;
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

.reviews-grid {
    display: grid;
    gap: 1.5rem;
}

.review-card {
    background: white;
    border-radius: 1rem;
    padding: 1.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.review-header {
    display: flex;
    justify-content: space-between;
    align-items: start;
    margin-bottom: 1rem;
}

.reviewer-info {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.reviewer-avatar {
    width: 3rem;
    height: 3rem;
    border-radius: 50%;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.25rem;
    font-weight: 700;
}

.reviewer-info h3 {
    margin: 0 0 0.25rem 0;
    font-size: 1.125rem;
    font-weight: 700;
    color: #111827;
}

.review-date {
    margin: 0;
    font-size: 0.875rem;
    color: #6b7280;
}

.rating-display {
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.rating-display i {
    color: #d1d5db;
    font-size: 1.125rem;
}

.rating-display i.filled {
    color: #eab308;
}

.rating-number {
    font-weight: 700;
    color: #111827;
    font-size: 1.125rem;
}

.review-property {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.75rem;
    background: #f0f9ff;
    border-radius: 0.5rem;
    margin-bottom: 1rem;
    font-size: 0.875rem;
    color: #1e40af;
    font-weight: 600;
}

.review-content p {
    margin: 0;
    color: #374151;
    font-size: 0.9375rem;
    line-height: 1.6;
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
