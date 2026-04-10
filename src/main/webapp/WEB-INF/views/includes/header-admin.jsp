<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="dashboard-header">
    <div class="dashboard-header-content">
        <!-- Search Bar -->
        <div class="dashboard-search">
            <i class="fas fa-search dashboard-search-icon"></i>
            <input type="text" id="adminSearchInput" placeholder="Search users, listings, reports..." onkeyup="handleAdminSearch(event)" />
        </div>

        <!-- Right Side - Notifications & Profile -->
        <div class="dashboard-header-actions">
            <!-- Notifications -->
            <button class="dashboard-notification-btn" onclick="toggleNotifications()" id="notificationBtn">
                <i class="fas fa-bell" style="font-size: 20px; color: var(--color-gray-600);"></i>
                <span class="notification-badge" id="notificationBadge" style="display: none;">3</span>
            </button>
            
            <!-- Notification Dropdown -->
            <div id="notificationDropdown" style="display: none; position: absolute; right: 80px; top: 60px; width: 320px; background: white; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); z-index: 1000;">
                <div style="padding: 16px; border-bottom: 1px solid #e5e7eb;">
                    <h3 style="font-weight: 600; font-size: 16px; color: #111827;">Notifications</h3>
                </div>
                <div style="max-height: 400px; overflow-y: auto;">
                    <div style="padding: 12px 16px; border-bottom: 1px solid #f3f4f6; cursor: pointer;" onmouseover="this.style.background='#f9fafb'" onmouseout="this.style.background='white'">
                        <div style="font-size: 14px; color: #111827; font-weight: 500;">New owner verification pending</div>
                        <div style="font-size: 12px; color: #6b7280; margin-top: 4px;">2 minutes ago</div>
                    </div>
                    <div style="padding: 12px 16px; border-bottom: 1px solid #f3f4f6; cursor: pointer;" onmouseover="this.style.background='#f9fafb'" onmouseout="this.style.background='white'">
                        <div style="font-size: 14px; color: #111827; font-weight: 500;">Report flagged for review</div>
                        <div style="font-size: 12px; color: #6b7280; margin-top: 4px;">15 minutes ago</div>
                    </div>
                    <div style="padding: 12px 16px; cursor: pointer;" onmouseover="this.style.background='#f9fafb'" onmouseout="this.style.background='white'">
                        <div style="font-size: 14px; color: #111827; font-weight: 500;">New listing submitted</div>
                        <div style="font-size: 12px; color: #6b7280; margin-top: 4px;">1 hour ago</div>
                    </div>
                </div>
                <div style="padding: 12px 16px; border-top: 1px solid #e5e7eb; text-align: center;">
                    <a href="${pageContext.request.contextPath}/admin/settings?tab=logs" style="color: #2563eb; font-size: 14px; font-weight: 500; text-decoration: none;">View All Activity</a>
                </div>
            </div>

            <!-- Profile -->
            <div class="dashboard-profile">
                <div class="dashboard-profile-avatar">
                    A
                </div>
                <div class="dashboard-profile-info">
                    <div class="dashboard-profile-name">Admin User</div>
                    <div class="dashboard-profile-email">admin@pgfinder.com</div>
                </div>
            </div>
        </div>
    </div>
</header>


<script>
// Toggle notification dropdown
function toggleNotifications() {
    const dropdown = document.getElementById('notificationDropdown');
    dropdown.style.display = dropdown.style.display === 'none' ? 'block' : 'none';
}

// Close dropdown when clicking outside
document.addEventListener('click', function(event) {
    const dropdown = document.getElementById('notificationDropdown');
    const btn = document.getElementById('notificationBtn');
    if (dropdown && btn && !dropdown.contains(event.target) && !btn.contains(event.target)) {
        dropdown.style.display = 'none';
    }
});

// Admin search functionality
function handleAdminSearch(event) {
    const searchTerm = event.target.value.toLowerCase().trim();
    
    if (event.key === 'Enter' && searchTerm) {
        // Determine current page and search accordingly
        const currentPath = window.location.pathname;
        
        if (currentPath.includes('/users')) {
            searchInTable(searchTerm, ['name', 'email', 'phone']);
        } else if (currentPath.includes('/listings')) {
            searchInTable(searchTerm, ['title', 'location', 'owner']);
        } else if (currentPath.includes('/reports')) {
            searchInTable(searchTerm, ['type', 'description', 'reporter']);
        } else if (currentPath.includes('/reviews')) {
            searchInTable(searchTerm, ['reviewer', 'listing', 'comment']);
        } else if (currentPath.includes('/approvals')) {
            searchInTable(searchTerm, ['name', 'email', 'document']);
        } else {
            // Global search - redirect to users page with search
            window.location.href = '${pageContext.request.contextPath}/admin/users?search=' + encodeURIComponent(searchTerm);
        }
    }
}

// Search within table on current page
function searchInTable(searchTerm, columns) {
    const tables = document.querySelectorAll('table tbody tr');
    let found = 0;
    
    tables.forEach(row => {
        const text = row.textContent.toLowerCase();
        if (text.includes(searchTerm)) {
            row.style.display = '';
            found++;
        } else {
            row.style.display = 'none';
        }
    });
    
    // Show message if no results
    if (found === 0 && tables.length > 0) {
        const tbody = tables[0].parentElement;
        const noResultRow = tbody.querySelector('.no-search-results');
        if (!noResultRow) {
            const tr = document.createElement('tr');
            tr.className = 'no-search-results';
            tr.innerHTML = '<td colspan="10" class="py-12 text-center text-gray-500"><i class="fas fa-search text-gray-300 text-4xl mb-3"></i><br>No results found for "' + searchTerm + '"</td>';
            tbody.appendChild(tr);
        }
    } else {
        const noResultRow = document.querySelector('.no-search-results');
        if (noResultRow) noResultRow.remove();
    }
}

// Clear search on input clear
document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('adminSearchInput');
    if (searchInput) {
        searchInput.addEventListener('input', function(e) {
            if (e.target.value === '') {
                const tables = document.querySelectorAll('table tbody tr');
                tables.forEach(row => row.style.display = '');
                const noResultRow = document.querySelector('.no-search-results');
                if (noResultRow) noResultRow.remove();
            }
        });
    }
});
</script>
