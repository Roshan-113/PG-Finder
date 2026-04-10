<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav style="background: white; border-bottom: 1px solid #e5e7eb; position: sticky; top: 0; z-index: 50;">
    <div style="max-width: 1400px; margin: 0 auto; padding: 0 1.5rem;">
        <div style="display: flex; align-items: center; justify-content: space-between; height: 4rem;">
            <!-- Logo -->
            <a href="${pageContext.request.contextPath}/" style="display: flex; align-items: center; gap: 0.5rem; text-decoration: none;">
                <img src="${pageContext.request.contextPath}/uploads/logo.png" alt="PG Finder" style="height:40px;width:40px;object-fit:contain;flex-shrink:0;border-radius:8px;">
                <div>
                    <div style="font-size: 1.125rem; font-weight: bold; color: #111827; line-height: 1.2;">PG Finder</div>
                    <div style="font-size: 0.75rem; color: #6b7280; line-height: 1.2;">Smart PG Discovery</div>
                </div>
            </a>

            <!-- Navigation Links -->
            <div style="display: flex; align-items: center; gap: 1.5rem;">
                <a href="${pageContext.request.contextPath}/" style="display: flex; align-items: center; gap: 0.5rem; color: #374151; text-decoration: none; font-size: 0.9375rem; transition: color 0.2s;" onmouseover="this.style.color='#2563eb'" onmouseout="this.style.color='#374151'">
                    <i class="fas fa-home"></i>
                    <span>Home</span>
                </a>
                <a href="${pageContext.request.contextPath}/find-pg" style="display: flex; align-items: center; gap: 0.5rem; color: #374151; text-decoration: none; font-size: 0.9375rem; transition: color 0.2s;" onmouseover="this.style.color='#2563eb'" onmouseout="this.style.color='#374151'">
                    <i class="fas fa-search"></i>
                    <span>Search PG</span>
                </a>
                <a href="${pageContext.request.contextPath}/find-roommate" style="display: flex; align-items: center; gap: 0.5rem; color: #374151; text-decoration: none; font-size: 0.9375rem; transition: color 0.2s;" onmouseover="this.style.color='#2563eb'" onmouseout="this.style.color='#374151'">
                    <i class="fas fa-users"></i>
                    <span>Roommate Finder</span>
                </a>
                <a href="${pageContext.request.contextPath}/tenant/saved-pgs" style="display: flex; align-items: center; gap: 0.5rem; color: #374151; text-decoration: none; font-size: 0.9375rem; transition: color 0.2s;" onmouseover="this.style.color='#2563eb'" onmouseout="this.style.color='#374151'">
                    <i class="fas fa-heart"></i>
                    <span>Saved PGs</span>
                </a>
                <a href="${pageContext.request.contextPath}/tenant/bookings" style="display: flex; align-items: center; gap: 0.5rem; color: #374151; text-decoration: none; font-size: 0.9375rem; transition: color 0.2s;" onmouseover="this.style.color='#2563eb'" onmouseout="this.style.color='#374151'">
                    <i class="fas fa-calendar-check"></i>
                    <span>My Bookings</span>
                </a>
                <a href="${pageContext.request.contextPath}/tenant/messages" style="display: flex; align-items: center; gap: 0.5rem; color: #374151; text-decoration: none; font-size: 0.9375rem; transition: color 0.2s;" onmouseover="this.style.color='#2563eb'" onmouseout="this.style.color='#374151'">
                    <i class="fas fa-comment-dots"></i>
                    <span>Messages</span>
                </a>
            </div>

            <!-- Right Side - Notification & Profile -->
            <div style="display: flex; align-items: center; gap: 1rem;">
                <!-- Notification Bell -->
                <button onclick="window.location.href='${pageContext.request.contextPath}/tenant/notifications'" style="position: relative; padding: 0.5rem; background: transparent; border: none; cursor: pointer; border-radius: 0.5rem; transition: background 0.2s;" onmouseover="this.style.background='#f3f4f6'" onmouseout="this.style.background='transparent'">
                    <i class="fas fa-bell" style="color: #6b7280; font-size: 1.25rem;"></i>
                </button>

                <!-- User Profile Dropdown -->
                <div style="position: relative;" class="profile-dropdown" id="profileDropdownContainer">
                    <button onclick="toggleProfileDropdown()" style="display: flex; align-items: center; gap: 0.5rem; background: transparent; border: none; cursor: pointer; padding: 0.5rem; border-radius: 0.5rem; transition: background 0.2s;" onmouseover="this.style.background='#f3f4f6'" onmouseout="this.style.background='transparent'">
                        <div style="width: 2.25rem; height: 2.25rem; border-radius: 50%; background: linear-gradient(135deg, #3b82f6, #14b8a6); display: flex; align-items: center; justify-content: center; color: white; font-weight: 600; font-size: 0.875rem;">
                            <c:choose>
                                <c:when test="${not empty sessionScope.userName}">
                                    ${sessionScope.userName.substring(0, 1).toUpperCase()}
                                </c:when>
                                <c:otherwise>T</c:otherwise>
                            </c:choose>
                        </div>
                        <div style="text-align: left;">
                            <div style="font-size: 0.875rem; font-weight: 600; color: #111827; line-height: 1.2;">${sessionScope.userName != null ? sessionScope.userName : 'Tenant'}</div>
                            <div style="font-size: 0.75rem; color: #6b7280; line-height: 1.2;">Tenant</div>
                        </div>
                        <i class="fas fa-chevron-down" style="color: #6b7280; font-size: 0.75rem;"></i>
                    </button>
                    
                    <!-- Dropdown Menu -->
                    <div class="profile-dropdown-menu" id="profileDropdownMenu" style="display: none; position: absolute; right: 0; top: 100%; margin-top: 0.5rem; width: 14rem; background: white; border-radius: 0.75rem; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -2px rgba(0,0,0,0.05); border: 1px solid #e5e7eb; overflow: hidden; z-index: 1000;">
                        <a href="${pageContext.request.contextPath}/tenant/profile" style="display: flex; align-items: center; gap: 0.75rem; padding: 0.75rem 1rem; text-decoration: none; color: #374151; transition: background 0.2s;" onmouseover="this.style.background='#f3f4f6'" onmouseout="this.style.background='white'">
                            <i class="fas fa-user" style="color: #6b7280;"></i>
                            <span style="font-size: 0.875rem;">My Profile</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/tenant/help" style="display: flex; align-items: center; gap: 0.75rem; padding: 0.75rem 1rem; text-decoration: none; color: #374151; transition: background 0.2s;" onmouseover="this.style.background='#f3f4f6'" onmouseout="this.style.background='white'">
                            <i class="fas fa-question-circle" style="color: #6b7280;"></i>
                            <span style="font-size: 0.875rem;">Help Center</span>
                        </a>
                        <div style="height: 1px; background: #e5e7eb; margin: 0.25rem 0;"></div>
                        <a href="${pageContext.request.contextPath}/logout" style="display: flex; align-items: center; gap: 0.75rem; padding: 0.75rem 1rem; text-decoration: none; color: #ef4444; transition: background 0.2s;" onmouseover="this.style.background='#fef2f2'" onmouseout="this.style.background='white'">
                            <i class="fas fa-sign-out-alt"></i>
                            <span style="font-size: 0.875rem;">Logout</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</nav>

<script>
function toggleProfileDropdown() {
    const dropdown = document.getElementById('profileDropdownMenu');
    if (dropdown.style.display === 'none' || dropdown.style.display === '') {
        dropdown.style.display = 'block';
    } else {
        dropdown.style.display = 'none';
    }
}

// Close dropdown when clicking outside
document.addEventListener('click', function(event) {
    const container = document.getElementById('profileDropdownContainer');
    if (container && !container.contains(event.target)) {
        const dropdown = document.getElementById('profileDropdownMenu');
        if (dropdown) {
            dropdown.style.display = 'none';
        }
    }
});
</script>

<style>
.profile-dropdown-menu {
    display: none;
    z-index: 1000;
}

.profile-dropdown:hover .profile-dropdown-menu {
    display: block;
}
</style>
