<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Admin Sidebar -->
<div class="sidebar">
    <div class="sidebar-header">
        <i class="fas fa-shield-alt"></i>
        <span>Admin Panel</span>
    </div>
    
    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item">
            <i class="fas fa-tachometer-alt"></i>
            <span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/users" class="nav-item">
            <i class="fas fa-users"></i>
            <span>Users</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/listings" class="nav-item">
            <i class="fas fa-building"></i>
            <span>PG Listings</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/cities" class="nav-item active">
            <i class="fas fa-city"></i>
            <span>Cities</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/approvals" class="nav-item">
            <i class="fas fa-check-circle"></i>
            <span>Approvals</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/reviews" class="nav-item">
            <i class="fas fa-star"></i>
            <span>Reviews</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/reports" class="nav-item">
            <i class="fas fa-flag"></i>
            <span>Reports</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/settings" class="nav-item">
            <i class="fas fa-cog"></i>
            <span>Settings</span>
        </a>
    </nav>
    
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="nav-item">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </div>
</div>
