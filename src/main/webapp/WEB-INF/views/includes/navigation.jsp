<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="bg-white border-b border-gray-200 sticky top-0 z-40 shadow-sm">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-16">
            <!-- Logo -->
            <a href="${pageContext.request.contextPath}/" class="flex items-center gap-3 cursor-pointer group">
                <img src="${pageContext.request.contextPath}/uploads/logo.png" alt="PG Finder" style="height:40px;width:40px;object-fit:contain;flex-shrink:0;border-radius:8px;">
                <div class="flex flex-col">
                    <span class="text-xl font-bold text-gray-900 leading-tight">PG Finder</span>
                    <span class="text-xs text-gray-500 leading-tight">Smart PG Discovery</span>
                </div>
            </a>
            
            <!-- Desktop Navigation -->
            <div class="hidden md:flex items-center gap-1">
                <a href="${pageContext.request.contextPath}/" 
                   class="flex items-center gap-2 px-4 py-2 rounded-lg transition-colors ${currentPage == 'home' ? 'bg-primary-50 text-primary-700' : 'text-gray-700 hover:bg-gray-100'}">
                    <i class="fas fa-home"></i>
                    <span>Home</span>
                </a>
                <a href="${pageContext.request.contextPath}/find-pg" 
                   class="flex items-center gap-2 px-4 py-2 rounded-lg transition-colors ${currentPage == 'find-pg' ? 'bg-primary-50 text-primary-700' : 'text-gray-700 hover:bg-gray-100'}">
                    <i class="fas fa-search"></i>
                    <span>Find PG</span>
                </a>
                <a href="${pageContext.request.contextPath}/find-roommate" 
                   class="flex items-center gap-2 px-4 py-2 rounded-lg transition-colors ${currentPage == 'find-roommate' ? 'bg-primary-50 text-primary-700' : 'text-gray-700 hover:bg-gray-100'}">
                    <i class="fas fa-users"></i>
                    <span>Find Roommate</span>
                </a>
                <a href="${pageContext.request.contextPath}/reviews" 
                   class="flex items-center gap-2 px-4 py-2 rounded-lg transition-colors ${currentPage == 'reviews' ? 'bg-primary-50 text-primary-700' : 'text-gray-700 hover:bg-gray-100'}">
                    <i class="fas fa-star"></i>
                    <span>Reviews</span>
                </a>
            </div>
            
            <!-- Desktop Actions -->
            <div class="hidden md:flex items-center gap-3">
                <c:choose>
                    <c:when test="${not empty sessionScope.userEmail}">
                        <!-- User is logged in -->
                        <c:choose>
                            <c:when test="${sessionScope.userRole == 'owner'}">
                                <a href="${pageContext.request.contextPath}/owner/dashboard" 
                                   class="inline-flex items-center justify-center px-4 py-2 text-base font-medium rounded-lg transition-all text-gray-700 hover:bg-gray-100">
                                    <i class="fas fa-tachometer-alt mr-2"></i>
                                    Dashboard
                                </a>
                            </c:when>
                            <c:when test="${sessionScope.userRole == 'admin'}">
                                <a href="${pageContext.request.contextPath}/admin/dashboard" 
                                   class="inline-flex items-center justify-center px-4 py-2 text-base font-medium rounded-lg transition-all text-gray-700 hover:bg-gray-100">
                                    <i class="fas fa-tachometer-alt mr-2"></i>
                                    Dashboard
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/tenant/bookings" 
                                   class="inline-flex items-center justify-center px-4 py-2 text-base font-medium rounded-lg transition-all text-gray-700 hover:bg-gray-100">
                                    <i class="fas fa-calendar mr-2"></i>
                                    My Bookings
                                </a>
                            </c:otherwise>
                        </c:choose>
                        <a href="${pageContext.request.contextPath}/logout" 
                           class="inline-flex items-center justify-center px-4 py-2 text-base font-medium rounded-lg transition-all shadow-sm"
                           style="background-color: var(--color-primary-600); color: white;">
                            <i class="fas fa-sign-out-alt mr-2"></i>
                            Logout
                        </a>
                    </c:when>
                    <c:otherwise>
                        <!-- User is not logged in -->
                        <a href="${pageContext.request.contextPath}/login" 
                           class="inline-flex items-center justify-center px-4 py-2 text-base font-medium rounded-lg transition-all text-gray-700 hover:bg-gray-100">
                            <i class="fas fa-user mr-2"></i>
                            Login
                        </a>
                        <a href="${pageContext.request.contextPath}/register" 
                           class="inline-flex items-center justify-center px-4 py-2 text-base font-medium rounded-lg transition-all shadow-sm"
                           style="background-color: var(--color-primary-600); color: white;">
                            Get Started
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- Mobile Menu Button -->
            <button class="md:hidden text-gray-700 hover:text-gray-900" onclick="toggleMobileMenu()">
                <i class="fas fa-bars" style="font-size: 24px;"></i>
            </button>
        </div>
        
        <!-- Mobile Menu -->
        <div id="mobileMenu" class="hidden md:hidden py-4 border-t border-gray-200">
            <div class="flex flex-col gap-2">
                <a href="${pageContext.request.contextPath}/" 
                   class="flex items-center gap-2 px-4 py-2 rounded-lg transition-colors ${currentPage == 'home' ? 'bg-primary-50 text-primary-700' : 'text-gray-700 hover:bg-gray-100'}">
                    <i class="fas fa-home"></i>
                    <span>Home</span>
                </a>
                <a href="${pageContext.request.contextPath}/find-pg" 
                   class="flex items-center gap-2 px-4 py-2 rounded-lg transition-colors ${currentPage == 'find-pg' ? 'bg-primary-50 text-primary-700' : 'text-gray-700 hover:bg-gray-100'}">
                    <i class="fas fa-search"></i>
                    <span>Find PG</span>
                </a>
                <a href="${pageContext.request.contextPath}/find-roommate" 
                   class="flex items-center gap-2 px-4 py-2 rounded-lg transition-colors ${currentPage == 'find-roommate' ? 'bg-primary-50 text-primary-700' : 'text-gray-700 hover:bg-gray-100'}">
                    <i class="fas fa-users"></i>
                    <span>Find Roommate</span>
                </a>
                <a href="${pageContext.request.contextPath}/reviews" 
                   class="flex items-center gap-2 px-4 py-2 rounded-lg transition-colors ${currentPage == 'reviews' ? 'bg-primary-50 text-primary-700' : 'text-gray-700 hover:bg-gray-100'}">
                    <i class="fas fa-star"></i>
                    <span>Reviews</span>
                </a>
                <div class="flex flex-col gap-2 mt-4">
                    <c:choose>
                        <c:when test="${not empty sessionScope.userEmail}">
                            <!-- User is logged in -->
                            <c:choose>
                                <c:when test="${sessionScope.userRole == 'owner'}">
                                    <a href="${pageContext.request.contextPath}/owner/dashboard" 
                                       class="inline-flex items-center justify-center px-4 py-2 text-base font-medium rounded-lg transition-all border-2"
                                       style="border-color: var(--color-primary-600); color: var(--color-primary-600);">
                                        <i class="fas fa-tachometer-alt mr-2"></i>
                                        Dashboard
                                    </a>
                                </c:when>
                                <c:when test="${sessionScope.userRole == 'admin'}">
                                    <a href="${pageContext.request.contextPath}/admin/dashboard" 
                                       class="inline-flex items-center justify-center px-4 py-2 text-base font-medium rounded-lg transition-all border-2"
                                       style="border-color: var(--color-primary-600); color: var(--color-primary-600);">
                                        <i class="fas fa-tachometer-alt mr-2"></i>
                                        Dashboard
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/tenant/bookings" 
                                       class="inline-flex items-center justify-center px-4 py-2 text-base font-medium rounded-lg transition-all border-2"
                                       style="border-color: var(--color-primary-600); color: var(--color-primary-600);">
                                        <i class="fas fa-calendar mr-2"></i>
                                        My Bookings
                                    </a>
                                </c:otherwise>
                            </c:choose>
                            <a href="${pageContext.request.contextPath}/logout" 
                               class="inline-flex items-center justify-center px-4 py-2 text-base font-medium rounded-lg transition-all shadow-sm"
                               style="background-color: var(--color-primary-600); color: white;">
                                <i class="fas fa-sign-out-alt mr-2"></i>
                                Logout
                            </a>
                        </c:when>
                        <c:otherwise>
                            <!-- User is not logged in -->
                            <a href="${pageContext.request.contextPath}/login" 
                               class="inline-flex items-center justify-center px-4 py-2 text-base font-medium rounded-lg transition-all border-2"
                               style="border-color: var(--color-primary-600); color: var(--color-primary-600);">
                                Login
                            </a>
                            <a href="${pageContext.request.contextPath}/register" 
                               class="inline-flex items-center justify-center px-4 py-2 text-base font-medium rounded-lg transition-all shadow-sm"
                               style="background-color: var(--color-primary-600); color: white;">
                                Get Started
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</nav>

<style>
.bg-primary-50 {
    background-color: var(--color-primary-50);
}
.text-primary-700 {
    color: var(--color-primary-700);
}
</style>

<script>
function toggleMobileMenu() {
    const menu = document.getElementById('mobileMenu');
    menu.classList.toggle('hidden');
}
</script>
