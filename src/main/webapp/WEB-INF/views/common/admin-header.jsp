<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="dashboard-header">
    <div class="dashboard-header-content">
        <!-- Search Bar -->
        <div class="dashboard-search">
            <i class="fas fa-search dashboard-search-icon"></i>
            <input type="text" placeholder="Search..." id="adminSearchInput" />
        </div>

        <!-- Right Side - Notifications & Profile -->
        <div class="dashboard-header-actions">
            <!-- Notifications -->
            <button class="dashboard-notification-btn" onclick="window.location.href='${pageContext.request.contextPath}/admin/notifications'">
                <i class="fas fa-bell" style="font-size: 20px; color: var(--color-gray-600);"></i>
                <span class="notification-badge"></span>
            </button>

            <!-- Profile -->
            <div class="dashboard-profile">
                <div class="dashboard-profile-avatar">
                    ${sessionScope.userName != null ? sessionScope.userName.substring(0,1).toUpperCase() : 'A'}
                </div>
                <div class="dashboard-profile-info">
                    <div class="dashboard-profile-name">${sessionScope.userName != null ? sessionScope.userName : 'Admin User'}</div>
                    <div class="dashboard-profile-email">admin@pgfinder.com</div>
                </div>
            </div>
        </div>
    </div>
</header>
