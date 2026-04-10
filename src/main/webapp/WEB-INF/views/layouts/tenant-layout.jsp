<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'PG Finder'}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50">
    <!-- Top Navigation Bar -->
    <nav class="bg-white border-b border-gray-200 sticky top-0" style="z-index: 50;">
        <div class="max-w-7xl mx-auto px-6">
            <div class="flex items-center justify-between h-16">
                <!-- Logo -->
                <div class="flex items-center gap-2">
                    <img src="${pageContext.request.contextPath}/uploads/logo.png" alt="PG Finder" style="height:40px;width:40px;object-fit:contain;flex-shrink:0;border-radius:8px;">
                    <div>
                        <div class="font-bold text-lg text-gray-900">PG Finder</div>
                        <div class="text-xs text-gray-500">Smart PG Discovery</div>
                    </div>
                </div>

                <!-- Navigation Links -->
                <div class="flex items-center gap-6">
                    <a href="${pageContext.request.contextPath}/" 
                       class="flex items-center gap-2 text-gray-700 hover:text-blue-600 transition-colors ${currentPage == 'home' ? 'text-blue-600 font-medium' : ''}">
                        <i class="fas fa-home"></i>
                        <span>Home</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/find-pg" 
                       class="flex items-center gap-2 text-gray-700 hover:text-blue-600 transition-colors ${currentPage == 'search' ? 'text-blue-600 font-medium' : ''}">
                        <i class="fas fa-search"></i>
                        <span>Search PG</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/find-roommate" 
                       class="flex items-center gap-2 text-gray-700 hover:text-blue-600 transition-colors ${currentPage == 'find-roommate' ? 'text-blue-600 font-medium' : ''}">
                        <i class="fas fa-users"></i>
                        <span>Roommate Finder</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/tenant/saved-pgs" 
                       class="flex items-center gap-2 text-gray-700 hover:text-blue-600 transition-colors ${currentPage == 'saved' ? 'text-blue-600 font-medium' : ''}">
                        <i class="fas fa-heart"></i>
                        <span>Saved PGs</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/tenant/bookings" 
                       class="flex items-center gap-2 text-gray-700 hover:text-blue-600 transition-colors ${currentPage == 'bookings' ? 'text-blue-600 font-medium' : ''}">
                        <i class="fas fa-calendar-check"></i>
                        <span>My Bookings</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/tenant/messages" 
                       class="flex items-center gap-2 text-gray-700 hover:text-blue-600 transition-colors ${currentPage == 'messages' ? 'text-blue-600 font-medium' : ''}">
                        <i class="fas fa-comment-dots"></i>
                        <span>Messages</span>
                    </a>
                </div>

                <!-- Right Side - Notifications & Profile -->
                <div class="flex items-center gap-4">
                    <!-- Notifications -->
                    <button onclick="window.location.href='${pageContext.request.contextPath}/tenant/notifications'" class="relative p-2 hover:bg-gray-100 rounded-lg transition-colors">
                        <i class="fas fa-bell text-gray-600" style="font-size: 20px;"></i>
                    </button>

                    <!-- Profile Dropdown -->
                    <div class="relative profile-dropdown">
                        <button class="flex items-center gap-2 hover:bg-gray-50 rounded-lg p-2 transition-colors">
                            <div class="w-9 h-9 rounded-full flex items-center justify-center text-white font-semibold text-sm"
                                 style="background: linear-gradient(to bottom right, #3b82f6, #14b8a6);">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.userName}">
                                        ${sessionScope.userName.substring(0, 1).toUpperCase()}
                                    </c:when>
                                    <c:otherwise>T</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="text-left">
                                <div class="text-sm font-medium text-gray-900">${sessionScope.userName != null ? sessionScope.userName : 'Tenant'}</div>
                                <div class="text-xs text-gray-500">Tenant</div>
                            </div>
                            <i class="fas fa-chevron-down text-gray-400" style="font-size: 12px;"></i>
                        </button>
                        
                        <!-- Dropdown Menu -->
                        <div class="profile-dropdown-menu absolute right-0 mt-2 w-56 bg-white rounded-lg shadow-lg border border-gray-200 hidden">
                            <a href="${pageContext.request.contextPath}/tenant/profile" class="flex items-center gap-3 px-4 py-3 hover:bg-gray-50 transition-colors">
                                <i class="fas fa-user text-gray-600"></i>
                                <span class="text-sm text-gray-700">My Profile</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/help" class="flex items-center gap-3 px-4 py-3 hover:bg-gray-50 transition-colors">
                                <i class="fas fa-question-circle text-gray-600"></i>
                                <span class="text-sm text-gray-700">Help Center</span>
                            </a>
                            <div class="border-t border-gray-200"></div>
                            <a href="${pageContext.request.contextPath}/logout" class="flex items-center gap-3 px-4 py-3 hover:bg-red-50 transition-colors">
                                <i class="fas fa-sign-out-alt text-red-600"></i>
                                <span class="text-sm text-red-600">Logout</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main>
        <jsp:include page="${contentPage}" />
    </main>

    <!-- Footer -->
    <footer class="bg-gray-900 text-white mt-16">
        <div class="max-w-7xl mx-auto px-6 py-12">
            <div class="grid grid-cols-4 gap-8">
                <!-- Brand -->
                <div>
                    <div class="flex items-center gap-2 mb-4">
                        <div style="width:38px;height:38px;background:rgba(255,255,255,0.15);border-radius:8px;display:flex;align-items:center;justify-content:center;flex-shrink:0;border:1.5px solid rgba(255,255,255,0.3);">
                            <img src="${pageContext.request.contextPath}/uploads/logo.png" alt="PG Finder" style="height:30px;width:30px;object-fit:contain;">
                        </div>
                        <div class="font-bold text-lg">PG Finder</div>
                    </div>
                    <p class="text-gray-400 text-sm mb-4">Find your perfect PG accommodation and compatible roommates with ease. Safe, verified, and hassle-free.</p>
                    <div class="flex gap-3">
                        <a href="#" class="w-8 h-8 rounded-lg bg-gray-800 flex items-center justify-center hover:bg-gray-700 transition-colors">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="w-8 h-8 rounded-lg bg-gray-800 flex items-center justify-center hover:bg-gray-700 transition-colors">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a href="#" class="w-8 h-8 rounded-lg bg-gray-800 flex items-center justify-center hover:bg-gray-700 transition-colors">
                            <i class="fab fa-instagram"></i>
                        </a>
                        <a href="#" class="w-8 h-8 rounded-lg bg-gray-800 flex items-center justify-center hover:bg-gray-700 transition-colors">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                    </div>
                </div>

                <!-- Company -->
                <div>
                    <h3 class="font-bold mb-4">Company</h3>
                    <ul class="space-y-2 text-sm text-gray-400">
                        <li><a href="${pageContext.request.contextPath}/about" class="hover:text-white transition-colors">About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact" class="hover:text-white transition-colors">Contact Us</a></li>
                        <li><a href="#" class="hover:text-white transition-colors">Careers</a></li>
                        <li><a href="#" class="hover:text-white transition-colors">Blog</a></li>
                    </ul>
                </div>

                <!-- Support -->
                <div>
                    <h3 class="font-bold mb-4">Support</h3>
                    <ul class="space-y-2 text-sm text-gray-400">
                        <li><a href="${pageContext.request.contextPath}/help" class="hover:text-white transition-colors">Help Center</a></li>
                        <li><a href="#" class="hover:text-white transition-colors">Safety Tips</a></li>
                        <li><a href="#" class="hover:text-white transition-colors">FAQs</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact" class="hover:text-white transition-colors">Contact Us</a></li>
                    </ul>
                </div>

                <!-- Contact -->
                <div>
                    <h3 class="font-bold mb-4">Contact</h3>
                    <ul class="space-y-2 text-sm text-gray-400">
                        <li class="flex items-center gap-2">
                            <i class="fas fa-envelope"></i>
                            support@pgfinder.com
                        </li>
                        <li class="flex items-center gap-2">
                            <i class="fas fa-phone"></i>
                            +91 98765 43210
                        </li>
                        <li class="flex items-center gap-2">
                            <i class="fas fa-map-marker-alt"></i>
                            Bangalore, India
                        </li>
                    </ul>
                </div>
            </div>

            <div class="border-t border-gray-800 mt-8 pt-8 flex items-center justify-between text-sm text-gray-400">
                <p>© 2026 PG Finder. All rights reserved.</p>
                <div class="flex gap-6">
                    <a href="#" class="hover:text-white transition-colors">Terms of Service</a>
                    <a href="#" class="hover:text-white transition-colors">Privacy Policy</a>
                    <a href="#" class="hover:text-white transition-colors">Cookie Policy</a>
                </div>
            </div>
        </div>
    </footer>

    <style>
    .profile-dropdown-menu {
        display: none;
        z-index: 1000;
    }
    
    .profile-dropdown:hover .profile-dropdown-menu {
        display: block;
    }
    </style>

    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
