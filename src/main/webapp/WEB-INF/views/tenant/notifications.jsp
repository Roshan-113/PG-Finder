<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="currentPage" value="notifications" scope="request" />

<div class="max-w-4xl mx-auto px-6 py-8">
    <!-- Header -->
    <div class="mb-8">
        <div class="flex items-center gap-3 mb-2">
            <div class="w-12 h-12 rounded-xl flex items-center justify-center" style="background-color: #2563eb;">
                <i class="fas fa-bell text-white" style="font-size: 24px;"></i>
            </div>
            <div>
                <h1 class="text-3xl font-bold text-gray-900">Notifications</h1>
                <c:set var="unreadCount" value="0"/>
                <c:forEach var="notif" items="${notifications}">
                    <c:if test="${!notif.isRead}">
                        <c:set var="unreadCount" value="${unreadCount + 1}"/>
                    </c:if>
                </c:forEach>
                <p class="text-gray-600">${unreadCount} unread notification${unreadCount != 1 ? 's' : ''}</p>
            </div>
        </div>
    </div>
    
    <!-- Notifications List -->
    <c:choose>
        <c:when test="${not empty notifications}">
            <div class="space-y-3">
                <c:forEach var="notif" items="${notifications}">
                    <div class="${notif.isRead ? 'bg-white border-gray-200' : 'bg-blue-50 border-blue-200'} rounded-xl shadow-sm border p-5">
                        <div class="flex items-start gap-4">
                            <div class="w-12 h-12 rounded-full flex items-center justify-center flex-shrink-0" 
                                 style="background-color: ${notif.isRead ? '#f3f4f6' : '#dbeafe'};">
                                <c:choose>
                                    <c:when test="${notif.type == 'message'}">
                                        <i class="fas fa-comment" style="color: #2563eb; font-size: 20px;"></i>
                                    </c:when>
                                    <c:when test="${notif.type == 'booking'}">
                                        <i class="fas fa-check-circle" style="color: #16a34a; font-size: 20px;"></i>
                                    </c:when>
                                    <c:when test="${notif.type == 'review'}">
                                        <i class="fas fa-star" style="color: #f59e0b; font-size: 20px;"></i>
                                    </c:when>
                                    <c:when test="${notif.type == 'price'}">
                                        <i class="fas fa-heart" style="color: #6366f1; font-size: 20px;"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-bell" style="color: #2563eb; font-size: 20px;"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <div class="flex-1">
                                <div class="flex items-start justify-between mb-2">
                                    <h3 class="font-semibold text-gray-900">${notif.title}</h3>
                                    <c:if test="${!notif.isRead}">
                                        <span class="px-2 py-1 text-white text-xs rounded-full font-medium" style="background-color: #2563eb;">New</span>
                                    </c:if>
                                </div>
                                <p class="text-gray-700 mb-2">${notif.message}</p>
                                <div class="flex items-center justify-between">
                                    <span class="text-sm text-gray-500">
                                        <fmt:formatDate value="${notif.createdAt}" pattern="dd MMM yyyy, HH:mm"/>
                                    </span>
                                    <c:if test="${!notif.isRead}">
                                        <button onclick="markAsRead(${notif.notificationId})" class="flex items-center gap-1 text-sm font-medium" style="color: #2563eb;">
                                            <i class="fas fa-check-circle" style="font-size: 16px;"></i>
                                            Mark as read
                                        </button>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="bg-white rounded-xl p-12 text-center border border-gray-200">
                <i class="fas fa-bell-slash text-gray-300 text-6xl mb-4"></i>
                <h3 class="text-xl font-semibold text-gray-900 mb-2">No Notifications</h3>
                <p class="text-gray-600">You're all caught up! Check back later for updates.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
function markAsRead(notificationId) {
    const formData = new FormData();
    formData.append('action', 'markAsRead');
    formData.append('notificationId', notificationId);
    
    fetch('${pageContext.request.contextPath}/tenant/notifications', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            location.reload();
        } else {
            alert('Failed to mark as read');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred');
    });
}
</script>

<style>
.space-y-3 > * + * {
    margin-top: 0.75rem;
}
</style>
