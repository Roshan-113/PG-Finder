<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
#pgf-navbar { background:#fff!important;border-bottom:1px solid #e2e8f0!important;position:sticky!important;top:0!important;z-index:9999!important;box-shadow:0 1px 4px rgba(0,0,0,0.1)!important;font-family:'Segoe UI',sans-serif!important; }
#pgf-navbar-inner { max-width:1280px;margin:0 auto;padding:0 24px;display:flex!important;align-items:center!important;justify-content:space-between!important;height:64px!important; }
#pgf-logo a { display:flex!important;align-items:center!important;gap:8px!important;font-size:20px!important;font-weight:700!important;color:#2563eb!important;text-decoration:none!important; }
#pgf-logo a i { font-size:22px!important;color:#2563eb!important; }
#pgf-logo a span { color:#2563eb!important;font-weight:700!important; }
#pgf-menu { display:flex!important;align-items:center!important;gap:4px!important; }
.pgf-nav-link { padding:8px 14px!important;font-size:15px!important;font-weight:500!important;color:#4b5563!important;text-decoration:none!important;border-radius:8px!important;transition:all 0.2s!important;white-space:nowrap!important; }
.pgf-nav-link:hover { color:#2563eb!important;background:#eff6ff!important; }
.pgf-btn-login { display:inline-flex!important;align-items:center!important;padding:8px 18px!important;font-size:15px!important;font-weight:600!important;border-radius:8px!important;text-decoration:none!important;background:#2563eb!important;color:#fff!important;margin-left:8px!important;border:none!important;cursor:pointer!important;transition:background 0.2s!important; }
.pgf-btn-login:hover { background:#1d4ed8!important;color:#fff!important; }
.pgf-btn-signup { display:inline-flex!important;align-items:center!important;padding:7px 18px!important;font-size:15px!important;font-weight:600!important;border-radius:8px!important;text-decoration:none!important;background:transparent!important;color:#2563eb!important;border:2px solid #2563eb!important;margin-left:4px!important;cursor:pointer!important;transition:all 0.2s!important; }
.pgf-btn-signup:hover { background:#eff6ff!important; }
#pgf-user-menu { position:relative!important; }
#pgf-user-btn { display:flex!important;align-items:center!important;gap:8px!important;padding:6px 12px!important;background:none!important;border:1px solid #e2e8f0!important;border-radius:8px!important;font-size:15px!important;font-weight:500!important;color:#374151!important;cursor:pointer!important;font-family:inherit!important; }
#pgf-user-btn img { width:28px!important;height:28px!important;border-radius:50%!important;object-fit:cover!important; }
#pgf-user-btn i.fa-user-circle { font-size:20px!important;color:#6b7280!important; }
#pgf-dropdown { display:none!important;position:absolute!important;top:calc(100% + 8px)!important;right:0!important;background:#fff!important;border:1px solid #e2e8f0!important;border-radius:10px!important;box-shadow:0 10px 25px rgba(0,0,0,0.12)!important;min-width:190px!important;z-index:10000!important;overflow:hidden!important; }
#pgf-user-menu:hover #pgf-dropdown { display:block!important; }
#pgf-dropdown a { display:block!important;padding:10px 16px!important;font-size:14px!important;color:#374151!important;text-decoration:none!important; }
#pgf-dropdown a:hover { background:#f9fafb!important;color:#2563eb!important; }
#pgf-dropdown a.logout-link { border-top:1px solid #f1f5f9!important;color:#dc2626!important; }
#pgf-dropdown a.logout-link:hover { background:#fef2f2!important; }
</style>

<nav id="pgf-navbar">
    <div id="pgf-navbar-inner">
        <!-- Logo -->
        <div id="pgf-logo">
            <a href="${pageContext.request.contextPath}/">
                <img src="${pageContext.request.contextPath}/uploads/logo.png" alt="PG Finder" style="height:38px;width:38px;object-fit:contain;border-radius:8px;flex-shrink:0;">
                <span>PG Finder</span>
            </a>
        </div>

        <!-- Menu -->
        <div id="pgf-menu">
            <a href="${pageContext.request.contextPath}/" class="pgf-nav-link">Home</a>
            <a href="${pageContext.request.contextPath}/pg-listing" class="pgf-nav-link">Find PG</a>
            <a href="${pageContext.request.contextPath}/about" class="pgf-nav-link">About</a>
            <a href="${pageContext.request.contextPath}/contact" class="pgf-nav-link">Contact</a>

            <c:choose>
                <c:when test="${not empty sessionScope.userId}">
                    <div id="pgf-user-menu">
                        <button id="pgf-user-btn">
                            <c:choose>
                                <c:when test="${not empty sessionScope.userProfileImage}">
                                    <img src="${sessionScope.userProfileImage}" alt="Profile">
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-user-circle"></i>
                                </c:otherwise>
                            </c:choose>
                            <span>${sessionScope.userName}</span>
                            <i class="fas fa-chevron-down" style="font-size:10px;color:#9ca3af;"></i>
                        </button>
                        <div id="pgf-dropdown">
                            <c:choose>
                                <c:when test="${sessionScope.userRole == 'owner'}">
                                    <a href="${pageContext.request.contextPath}/owner/dashboard"><i class="fas fa-tachometer-alt" style="margin-right:8px;color:#6b7280;"></i>Dashboard</a>
                                    <a href="${pageContext.request.contextPath}/owner/profile"><i class="fas fa-user" style="margin-right:8px;color:#6b7280;"></i>Profile</a>
                                </c:when>
                                <c:when test="${sessionScope.userRole == 'admin'}">
                                    <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-shield-alt" style="margin-right:8px;color:#6b7280;"></i>Admin Panel</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/tenant/bookings"><i class="fas fa-calendar-check" style="margin-right:8px;color:#6b7280;"></i>My Bookings</a>
                                    <a href="${pageContext.request.contextPath}/tenant/saved-pgs"><i class="fas fa-heart" style="margin-right:8px;color:#6b7280;"></i>Saved PGs</a>
                                </c:otherwise>
                            </c:choose>
                            <a href="${pageContext.request.contextPath}/logout" class="logout-link"><i class="fas fa-sign-out-alt" style="margin-right:8px;"></i>Logout</a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="pgf-btn-login">Login</a>
                    <a href="${pageContext.request.contextPath}/register" class="pgf-btn-signup">Sign Up</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>
