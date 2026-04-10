<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Owner Panel'} - PG Finder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50">
    <div class="flex">
        <!-- Sidebar - Blue Gradient -->
        <aside class="fixed left-0 top-0 flex flex-col" style="width: 240px; height: 100vh; background: linear-gradient(to bottom, #3b82f6, #2563eb);">
            <!-- Logo -->
            <div class="p-6" style="border-bottom: 1px solid rgba(255,255,255,0.2);">
                <div class="flex items-center gap-3 text-white">
                    <div style="width:46px;height:46px;background:rgba(255,255,255,0.15);border-radius:10px;display:flex;align-items:center;justify-content:center;flex-shrink:0;border:1.5px solid rgba(255,255,255,0.3);">
                        <img src="${pageContext.request.contextPath}/uploads/logo.png" alt="PG Finder" style="height:36px;width:36px;object-fit:contain;">
                    </div>
                    <div>
                        <div class="font-bold text-xl">PG Finder</div>
                        <div class="text-xs" style="opacity: 0.8;">Owner Panel</div>
                    </div>
                </div>
            </div>

            <!-- Navigation - Scrollable -->
            <nav class="flex-1 p-4" style="overflow-y: auto; overflow-x: hidden;">
                <a href="${pageContext.request.contextPath}/owner/dashboard" 
                   class="owner-menu-item ${currentPage == 'dashboard' ? 'active' : ''}">
                    <i class="fas fa-home"></i>
                    <span>Dashboard</span>
                </a>
                <a href="${pageContext.request.contextPath}/owner/listings" 
                   class="owner-menu-item ${currentPage == 'listings' ? 'active' : ''}">
                    <i class="fas fa-building"></i>
                    <span>My Listings</span>
                </a>
                <a href="${pageContext.request.contextPath}/owner/add-pg" 
                   class="owner-menu-item ${currentPage == 'add-pg' ? 'active' : ''}">
                    <i class="fas fa-plus"></i>
                    <span>Add New PG</span>
                </a>
                <a href="${pageContext.request.contextPath}/owner/manage-rooms" 
                   class="owner-menu-item ${currentPage == 'manage-rooms' ? 'active' : ''}">
                    <i class="fas fa-door-open"></i>
                    <span>Manage Rooms</span>
                </a>
                <a href="${pageContext.request.contextPath}/owner/bookings" 
                   class="owner-menu-item ${currentPage == 'bookings' ? 'active' : ''}">
                    <i class="fas fa-calendar-check"></i>
                    <span>Bookings</span>
                </a>
                <a href="${pageContext.request.contextPath}/owner/inquiries" 
                   class="owner-menu-item ${currentPage == 'inquiries' ? 'active' : ''}">
                    <i class="fas fa-comment-dots"></i>
                    <span>Inquiries</span>
                </a>
                <a href="${pageContext.request.contextPath}/owner/reviews" 
                   class="owner-menu-item ${currentPage == 'reviews' ? 'active' : ''}">
                    <i class="fas fa-star"></i>
                    <span>Reviews</span>
                </a>
                <a href="${pageContext.request.contextPath}/owner/photos" 
                   class="owner-menu-item ${currentPage == 'photos' ? 'active' : ''}">
                    <i class="fas fa-images"></i>
                    <span>Photos</span>
                </a>
                <a href="${pageContext.request.contextPath}/owner/documents" 
                   class="owner-menu-item ${currentPage == 'documents' ? 'active' : ''}">
                    <i class="fas fa-file-alt"></i>
                    <span>Documents</span>
                </a>
                <a href="${pageContext.request.contextPath}/owner/earnings" 
                   class="owner-menu-item ${currentPage == 'earnings' ? 'active' : ''}">
                    <i class="fas fa-dollar-sign"></i>
                    <span>Earnings</span>
                </a>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="flex-1 min-h-screen" style="margin-left: 240px;">
            <!-- Top Header -->
            <header class="bg-white border-b border-gray-200 sticky top-0" style="z-index: 30;">
                <div class="flex items-center justify-between px-8 py-4">
                    <!-- Search Bar -->
                    <div class="flex-1 max-w-xl relative">
                        <i class="fas fa-search" style="position: absolute; left: 0.75rem; top: 50%; transform: translateY(-50%); color: #9ca3af; font-size: 18px;"></i>
                        <input type="text" placeholder="Search your properties..." 
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg"
                               style="padding-left: 2.5rem; outline: none;">
                    </div>

                    <!-- Right Side -->
                    <div class="flex items-center gap-4">
                        <!-- Notifications -->
                        <a href="${pageContext.request.contextPath}/owner/notifications" class="relative p-2 hover:bg-gray-100 rounded-lg transition-colors" style="text-decoration: none;">
                            <i class="fas fa-bell text-gray-600" style="font-size: 20px;"></i>
                            <span class="absolute top-1 right-1 w-2 h-2 bg-red-500 rounded-full"></span>
                        </a>

                        <!-- Profile Dropdown -->
                        <div class="relative profile-dropdown">
                            <button onclick="toggleProfileDropdown(event)" class="flex items-center gap-3 cursor-pointer hover:bg-gray-50 rounded-lg p-2 transition-colors">
                                <div class="w-10 h-10 rounded-full flex items-center justify-center text-white font-semibold shadow-md"
                                     style="background: linear-gradient(to bottom right, #3b82f6, #14b8a6);">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.userName}">
                                            ${sessionScope.userName.substring(0, 1).toUpperCase()}
                                        </c:when>
                                        <c:otherwise>O</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="text-left">
                                    <div class="text-sm font-medium text-gray-900">${sessionScope.userName != null ? sessionScope.userName : 'Owner'}</div>
                                    <div class="text-xs text-gray-500">${sessionScope.userEmail != null ? sessionScope.userEmail : 'owner@pgfinder.com'}</div>
                                </div>
                                <i class="fas fa-chevron-down text-gray-400 dropdown-arrow" style="font-size: 12px; transition: transform 0.2s;"></i>
                            </button>
                            
                            <!-- Dropdown Menu -->
                            <div id="profileDropdownMenu" class="profile-dropdown-menu absolute right-0 mt-2 w-56 bg-white rounded-lg shadow-lg border border-gray-200" style="display: none; z-index: 1000;">
                                <a href="${pageContext.request.contextPath}/owner/profile" class="flex items-center gap-3 px-4 py-3 hover:bg-gray-50 transition-colors" style="text-decoration: none;">
                                    <i class="fas fa-user text-gray-600"></i>
                                    <span class="text-sm text-gray-700">My Profile</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/owner/settings" class="flex items-center gap-3 px-4 py-3 hover:bg-gray-50 transition-colors" style="text-decoration: none;">
                                    <i class="fas fa-cog text-gray-600"></i>
                                    <span class="text-sm text-gray-700">Settings</span>
                                </a>
                                <div class="border-t border-gray-200"></div>
                                <a href="${pageContext.request.contextPath}/logout" class="flex items-center gap-3 px-4 py-3 hover:bg-red-50 transition-colors" style="text-decoration: none;">
                                    <i class="fas fa-sign-out-alt text-red-600"></i>
                                    <span class="text-sm text-red-600">Logout</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </header>

            <!-- Page Content -->
            <div class="p-8">
                <jsp:include page="${contentPage}" />
            </div>
        </main>
    </div>

    <style>
    .owner-menu-item {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        padding: 0.75rem 1rem;
        border-radius: 0.5rem;
        margin-bottom: 0.5rem;
        font-size: 0.875rem;
        font-weight: 500;
        transition: all 0.2s;
        color: white;
        text-decoration: none;
    }

    .owner-menu-item:not(.active):hover {
        background: rgba(255, 255, 255, 0.1);
    }

    .owner-menu-item.active {
        background-color: #ffffff;
        color: #2563eb;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    }

    .owner-menu-item i {
        font-size: 18px;
        width: 18px;
    }

    /* Scrollbar styling for sidebar */
    nav::-webkit-scrollbar {
        width: 6px;
    }

    nav::-webkit-scrollbar-track {
        background: rgba(255, 255, 255, 0.1);
        border-radius: 3px;
    }

    nav::-webkit-scrollbar-thumb {
        background: rgba(255, 255, 255, 0.3);
        border-radius: 3px;
    }

    nav::-webkit-scrollbar-thumb:hover {
        background: rgba(255, 255, 255, 0.5);
    }
    </style>

    <script>
    // Profile dropdown toggle
    function toggleProfileDropdown(event) {
        event.stopPropagation();
        const menu = document.getElementById('profileDropdownMenu');
        const arrow = document.querySelector('.dropdown-arrow');
        
        if (menu.style.display === 'none' || menu.style.display === '') {
            menu.style.display = 'block';
            arrow.style.transform = 'rotate(180deg)';
        } else {
            menu.style.display = 'none';
            arrow.style.transform = 'rotate(0deg)';
        }
    }

    // Close dropdown when clicking outside
    document.addEventListener('click', function(event) {
        const dropdown = document.querySelector('.profile-dropdown');
        const menu = document.getElementById('profileDropdownMenu');
        
        if (dropdown && !dropdown.contains(event.target)) {
            menu.style.display = 'none';
            document.querySelector('.dropdown-arrow').style.transform = 'rotate(0deg)';
        }
    });
    </script>

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
