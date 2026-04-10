<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<aside class="dashboard-sidebar">
    <!-- Logo -->
    <div class="sidebar-logo">
        <div class="flex items-center gap-3 text-white">
            <div class="sidebar-logo-icon">
                <span>🏠</span>
            </div>
            <div>
                <div class="font-bold text-xl">PG Finder</div>
                <div class="text-xs opacity-80">Admin Panel</div>
            </div>
        </div>
    </div>

    <!-- Navigation - Scrollable -->
    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/admin/dashboard" 
           class="sidebar-nav-item ${currentPage == 'dashboard' ? 'active' : ''}">
            <i class="fas fa-home"></i>
            <span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/listings" 
           class="sidebar-nav-item ${currentPage == 'listings' ? 'active' : ''}">
            <i class="fas fa-building"></i>
            <span>PG Listings</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/users" 
           class="sidebar-nav-item ${currentPage == 'users' ? 'active' : ''}">
            <i class="fas fa-users"></i>
            <span>User Management</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/approvals" 
           class="sidebar-nav-item ${currentPage == 'approvals' ? 'active' : ''}">
            <i class="fas fa-shield-alt"></i>
            <span>Owner Verification</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/reviews" 
           class="sidebar-nav-item ${currentPage == 'reviews' ? 'active' : ''}">
            <i class="fas fa-star"></i>
            <span>Reviews Moderation</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/reports" 
           class="sidebar-nav-item ${currentPage == 'reports' ? 'active' : ''}">
            <i class="fas fa-flag"></i>
            <span>Reports & Flags</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/settings" 
           class="sidebar-nav-item ${currentPage == 'settings' ? 'active' : ''}">
            <i class="fas fa-cog"></i>
            <span>System Settings</span>
        </a>
    </nav>

    <!-- Logout Button at Bottom -->
    <div class="sidebar-footer">
        <button onclick="window.location.href='${pageContext.request.contextPath}/logout'" class="sidebar-logout-btn">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </button>
    </div>
</aside>
