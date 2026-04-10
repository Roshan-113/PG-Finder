<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Admin Panel'} - PG Finder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
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
                        <div class="text-xs" style="opacity: 0.8;">Admin Panel</div>
                    </div>
                </div>
            </div>

            <!-- Navigation -->
            <nav class="flex-1 p-4 overflow-y-auto">
                <a href="${pageContext.request.contextPath}/admin/dashboard" 
                   class="admin-menu-item ${currentPage == 'dashboard' ? 'active' : ''}">
                    <i class="fas fa-home"></i>
                    <span>Dashboard</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/listings" 
                   class="admin-menu-item ${currentPage == 'listings' ? 'active' : ''}">
                    <i class="fas fa-building"></i>
                    <span>PG Listings</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/users" 
                   class="admin-menu-item ${currentPage == 'users' ? 'active' : ''}">
                    <i class="fas fa-users"></i>
                    <span>User Management</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/approvals" 
                   class="admin-menu-item ${currentPage == 'approvals' ? 'active' : ''}">
                    <i class="fas fa-shield-alt"></i>
                    <span>Owner Verification</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/reviews" 
                   class="admin-menu-item ${currentPage == 'reviews' ? 'active' : ''}">
                    <i class="fas fa-star"></i>
                    <span>Reviews Moderation</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/reports" 
                   class="admin-menu-item ${currentPage == 'reports' ? 'active' : ''}">
                    <i class="fas fa-flag"></i>
                    <span>Reports & Flags</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/settings" 
                   class="admin-menu-item ${currentPage == 'settings' ? 'active' : ''}">
                    <i class="fas fa-cog"></i>
                    <span>System Settings</span>
                </a>
            </nav>

            <!-- Logout Button -->
            <div class="p-4">
                <button onclick="window.location.href='${pageContext.request.contextPath}/logout'" 
                        class="w-full flex items-center justify-center gap-2 px-4 py-3 rounded-lg font-semibold shadow-md transition-colors"
                        style="background-color: #ffffff; color: #2563eb;">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </button>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="flex-1 min-h-screen" style="margin-left: 240px;">
            <!-- Top Header -->
            <header class="bg-white border-b border-gray-200 sticky top-0" style="z-index: 30;">
                <div class="flex items-center justify-between px-8 py-4">
                    <!-- Search Bar -->
                    <div class="flex-1 max-w-xl relative">
                        <i class="fas fa-search" style="position: absolute; left: 0.75rem; top: 50%; transform: translateY(-50%); color: #9ca3af; font-size: 18px;"></i>
                        <input type="text" placeholder="Search..." 
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg"
                               style="padding-left: 2.5rem; outline: none;">
                    </div>

                    <!-- Right Side -->
                    <div class="flex items-center gap-4">
                        <!-- Notifications -->
                        <button class="relative p-2 hover:bg-gray-100 rounded-lg transition-colors">
                            <i class="fas fa-bell text-gray-600" style="font-size: 20px;"></i>
                            <span class="absolute top-1 right-1 w-2 h-2 bg-red-500 rounded-full"></span>
                        </button>

                        <!-- Profile -->
                        <div class="flex items-center gap-3 cursor-pointer hover:bg-gray-50 rounded-lg p-2 transition-colors">
                            <div class="w-10 h-10 rounded-full flex items-center justify-center text-white font-semibold shadow-md"
                                 style="background: linear-gradient(to bottom right, #3b82f6, #14b8a6);">
                                A
                            </div>
                            <div>
                                <div class="text-sm font-medium text-gray-900">${sessionScope.userName != null ? sessionScope.userName : 'Admin'}</div>
                                <div class="text-xs text-gray-500">${sessionScope.userEmail != null ? sessionScope.userEmail : 'admin@pgfinder.com'}</div>
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
    .admin-menu-item {
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

    .admin-menu-item:not(.active):hover {
        background: rgba(255, 255, 255, 0.1);
    }

    .admin-menu-item.active {
        background-color: #ffffff;
        color: #2563eb;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    }

    .admin-menu-item i {
        font-size: 18px;
        width: 18px;
    }
    </style>

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
