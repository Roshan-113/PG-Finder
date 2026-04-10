<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="page-container">
    <div class="page-header">
        <h1>Inquiries</h1>
        <p>Manage tenant inquiries and questions</p>
    </div>

    <c:choose>
        <c:when test="${not empty inquiries}">
            <div class="inquiries-grid">
                <c:forEach var="inquiry" items="${inquiries}">
                    <div class="inquiry-card ${inquiry.status}">
                        <div class="inquiry-header">
                            <div class="tenant-info">
                                <h3>${inquiry.tenantName}</h3>
                                <div class="contact-info">
                                    <span><i class="fas fa-envelope"></i> ${inquiry.tenantEmail}</span>
                                    <span><i class="fas fa-phone"></i> ${inquiry.tenantPhone}</span>
                                </div>
                            </div>
                            <c:choose>
                                <c:when test="${inquiry.status == 'pending'}">
                                    <span class="badge badge-warning">Pending</span>
                                </c:when>
                                <c:when test="${inquiry.status == 'responded'}">
                                    <span class="badge badge-success">Responded</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-secondary">Closed</span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="inquiry-property">
                            <i class="fas fa-home"></i>
                            <span>${inquiry.listingTitle}</span>
                        </div>

                        <div class="inquiry-content">
                            <div class="inquiry-question">
                                <strong>Question:</strong>
                                <p>${inquiry.inquiryText}</p>
                                <small><fmt:formatDate value="${inquiry.createdAt}" pattern="dd MMM yyyy, HH:mm"/></small>
                            </div>

                            <c:if test="${not empty inquiry.responseText}">
                                <div class="inquiry-response">
                                    <strong>Your Response:</strong>
                                    <p>${inquiry.responseText}</p>
                                    <small><fmt:formatDate value="${inquiry.respondedAt}" pattern="dd MMM yyyy, HH:mm"/></small>
                                </div>
                            </c:if>
                        </div>

                        <c:if test="${inquiry.status == 'pending'}">
                            <div class="inquiry-actions">
                                <textarea id="response-${inquiry.inquiryId}" placeholder="Type your response..." rows="3"></textarea>
                                <button onclick="respondToInquiry(${inquiry.inquiryId})" class="btn btn-primary">
                                    <i class="fas fa-paper-plane"></i> Send Response
                                </button>
                            </div>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="fas fa-question-circle"></i>
                <h3>No Inquiries Yet</h3>
                <p>When tenants have questions about your properties, their inquiries will appear here.</p>
                <p style="margin-top: 1rem; color: #6b7280; font-size: 0.875rem;">
                    Make sure your PG listings are active and have complete information to attract more inquiries!
                </p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
function respondToInquiry(inquiryId) {
    if (!validateInquiryResponse(inquiryId)) {
        return;
    }
    
    const textarea = document.getElementById('response-' + inquiryId);
    const responseText = textarea.value.trim();
    
    const formData = new FormData();
    formData.append('action', 'respond');
    formData.append('inquiryId', inquiryId);
    formData.append('responseText', responseText);
    
    fetch('${pageContext.request.contextPath}/owner/inquiries', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'action=respond&inquiryId=' + inquiryId + '&responseText=' + encodeURIComponent(responseText)
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Response sent successfully!');
            location.reload();
        } else {
            alert('Failed to send response');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred');
    });
}
</script>

<script src="${pageContext.request.contextPath}/js/owner-validation.js"></script>

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

.inquiries-grid {
    display: grid;
    gap: 1.5rem;
}

.inquiry-card {
    background: white;
    border-radius: 1rem;
    padding: 1.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    border-left: 4px solid #e5e7eb;
}

.inquiry-card.pending {
    border-left-color: #f59e0b;
}

.inquiry-card.responded {
    border-left-color: #10b981;
}

.inquiry-header {
    display: flex;
    justify-content: space-between;
    align-items: start;
    margin-bottom: 1rem;
}

.tenant-info h3 {
    margin: 0 0 0.5rem 0;
    font-size: 1.125rem;
    font-weight: 700;
    color: #111827;
}

.contact-info {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
    font-size: 0.875rem;
    color: #6b7280;
}

.contact-info i {
    width: 1rem;
}

.inquiry-property {
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

.inquiry-content {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.inquiry-question,
.inquiry-response {
    padding: 1rem;
    border-radius: 0.5rem;
}

.inquiry-question {
    background: #f9fafb;
}

.inquiry-response {
    background: #eff6ff;
}

.inquiry-question strong,
.inquiry-response strong {
    display: block;
    margin-bottom: 0.5rem;
    font-size: 0.875rem;
    color: #374151;
}

.inquiry-question p,
.inquiry-response p {
    margin: 0 0 0.5rem 0;
    color: #111827;
    font-size: 0.9375rem;
    line-height: 1.6;
}

.inquiry-question small,
.inquiry-response small {
    color: #6b7280;
    font-size: 0.75rem;
}

.inquiry-actions {
    margin-top: 1rem;
    padding-top: 1rem;
    border-top: 1px solid #f3f4f6;
}

.inquiry-actions textarea {
    width: 100%;
    padding: 0.75rem;
    border: 1px solid #d1d5db;
    border-radius: 0.5rem;
    font-size: 0.875rem;
    font-family: inherit;
    resize: vertical;
    margin-bottom: 0.75rem;
}

.inquiry-actions textarea:focus {
    outline: none;
    border-color: #2563eb;
}

.btn {
    padding: 0.75rem 1.5rem;
    border: none;
    border-radius: 0.5rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
}

.btn-primary {
    background: #2563eb;
    color: white;
}

.btn-primary:hover {
    background: #1d4ed8;
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
