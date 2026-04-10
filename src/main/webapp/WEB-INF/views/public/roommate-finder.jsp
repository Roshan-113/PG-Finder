<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div style="background-color:#f9fafb;min-height:100vh;padding:2rem 0;">
<div style="max-width:1400px;margin:0 auto;padding:0 1.5rem;">

    <h1 style="margin:0 0 0.5rem 0;font-size:2rem;font-weight:bold;color:#111827;">Find Your Perfect Roommate</h1>
    <p style="margin:0 0 1rem 0;color:#6b7280;font-size:1rem;">Connect with compatible roommates</p>

    <!-- PG Filter Banner -->
    <c:if test="${not empty filterPgName}">
        <div style="background:linear-gradient(135deg,#10b981 0%,#059669 100%);color:white;padding:1rem 1.5rem;border-radius:0.75rem;margin-bottom:1.5rem;display:flex;align-items:center;justify-content:space-between;">
            <div style="display:flex;align-items:center;gap:1rem;">
                <i class="fas fa-home" style="font-size:1.5rem;"></i>
                <div>
                    <div style="font-weight:600;font-size:1.125rem;">Showing roommates in:</div>
                    <div style="font-size:0.875rem;opacity:0.9;">${filterPgName} &mdash; ${filterPgCity}</div>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/find-roommate"
               style="background:rgba(255,255,255,0.2);border:none;color:white;padding:0.5rem 1rem;border-radius:0.5rem;cursor:pointer;font-weight:600;text-decoration:none;font-size:0.875rem;">
                <i class="fas fa-times"></i> Show All
            </a>
        </div>
    </c:if>

    <!-- Tabs -->
    <div style="display:flex;gap:0.5rem;margin-bottom:2rem;border-bottom:2px solid #e5e7eb;">
        <button onclick="switchTab('find')" id="findTab"
                style="padding:1rem 1.5rem;background:none;border:none;border-bottom:3px solid #2563eb;color:#2563eb;font-weight:600;cursor:pointer;font-size:0.9375rem;">
            <i class="fas fa-users"></i> Find Roommate
        </button>
        <button onclick="switchTab('post')" id="postTab"
                style="padding:1rem 1.5rem;background:none;border:none;border-bottom:3px solid transparent;color:#6b7280;font-weight:600;cursor:pointer;font-size:0.9375rem;">
            <i class="fas fa-plus-circle"></i> Post Requirement
        </button>
    </div>

    <div style="display:grid;grid-template-columns:260px 1fr;gap:2rem;">

        <!-- Sidebar Filters -->
        <div>
            <div style="background:white;border-radius:1rem;padding:1.5rem;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
                <h3 style="margin:0 0 1.5rem 0;font-size:1.125rem;font-weight:700;color:#111827;">Filters</h3>

                <div style="margin-bottom:1.5rem;">
                    <label style="display:block;font-size:0.875rem;font-weight:600;color:#374151;margin-bottom:0.5rem;">Gender</label>
                    <select id="genderFilter" onchange="applyFilters()"
                            style="width:100%;padding:0.625rem;border:1px solid #d1d5db;border-radius:0.5rem;font-size:0.875rem;">
                        <option value="all">All</option>
                        <option value="male">Male</option>
                        <option value="female">Female</option>
                    </select>
                </div>

                <button onclick="clearFilters()"
                        style="width:100%;padding:0.75rem;background:white;color:#2563eb;font-weight:600;border:1px solid #2563eb;border-radius:0.5rem;cursor:pointer;font-size:0.875rem;">
                    Clear Filters
                </button>
            </div>
        </div>

        <!-- Roommate Cards -->
        <div id="findContent">
            <div style="margin-bottom:1.5rem;color:#6b7280;font-size:0.9375rem;">
                <strong style="color:#111827;" id="roommateCount">${roommates.size()} roommate<c:if test="${roommates.size() != 1}">s</c:if></strong> found
                <c:if test="${not empty filterPgName}"> in <strong>${filterPgName}</strong></c:if>
            </div>

            <c:choose>
                <c:when test="${empty roommates}">
                    <div style="background:white;border-radius:1rem;padding:4rem 2rem;text-align:center;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
                        <i class="fas fa-users" style="font-size:4rem;color:#d1d5db;margin-bottom:1rem;display:block;"></i>
                        <h3 style="color:#374151;margin:0 0 0.5rem 0;">No roommates found</h3>
                        <p style="color:#6b7280;margin:0 0 1.5rem 0;">
                            <c:choose>
                                <c:when test="${not empty filterPgName}">No tenants with bookings found in ${filterPgName}.</c:when>
                                <c:otherwise>No tenants with active bookings found yet.</c:otherwise>
                            </c:choose>
                        </p>
                        <c:if test="${not empty filterPgName}">
                            <a href="${pageContext.request.contextPath}/find-roommate"
                               style="display:inline-block;padding:0.75rem 1.5rem;background:#2563eb;color:white;border-radius:0.5rem;text-decoration:none;font-weight:600;">
                                Browse All Roommates
                            </a>
                        </c:if>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="display:grid;grid-template-columns:repeat(2,1fr);gap:1.5rem;" id="roommateGrid">
                        <c:forEach var="rm" items="${roommates}">
                            <div class="roommate-card"
                                 data-userid="${rm.userId}"
                                 data-name="${rm.name}"
                                 style="background:white;border-radius:1rem;padding:1.5rem;box-shadow:0 1px 3px rgba(0,0,0,0.1);transition:box-shadow 0.2s;"
                                 onmouseover="this.style.boxShadow='0 4px 12px rgba(0,0,0,0.15)'"
                                 onmouseout="this.style.boxShadow='0 1px 3px rgba(0,0,0,0.1)'">

                                <!-- Avatar + Name -->
                                <div style="display:flex;flex-direction:column;align-items:center;text-align:center;margin-bottom:1rem;">
                                    <c:choose>
                                        <c:when test="${not empty rm.profileImage}">
                                            <img src="${rm.profileImage}" alt="${rm.name}"
                                                 style="width:5rem;height:5rem;border-radius:50%;object-fit:cover;margin-bottom:0.75rem;border:3px solid #dbeafe;">
                                        </c:when>
                                        <c:otherwise>
                                            <div style="width:5rem;height:5rem;border-radius:50%;background:linear-gradient(135deg,#667eea,#764ba2);display:flex;align-items:center;justify-content:center;margin-bottom:0.75rem;font-size:1.75rem;font-weight:700;color:white;">
                                                ${rm.name.substring(0,1).toUpperCase()}
                                            </div>
                                        </c:otherwise>
                                    </c:choose>

                                    <h3 style="margin:0 0 0.25rem 0;font-size:1.125rem;font-weight:700;color:#111827;">${rm.name}</h3>

                                    <c:if test="${rm.verified}">
                                        <span style="background:#dbeafe;color:#1e40af;padding:0.25rem 0.75rem;border-radius:9999px;font-size:0.75rem;font-weight:600;">
                                            <i class="fas fa-check-circle"></i> Verified
                                        </span>
                                    </c:if>
                                </div>

                                <!-- Location -->
                                <div style="display:flex;align-items:center;gap:0.5rem;margin-bottom:0.75rem;color:#6b7280;font-size:0.875rem;">
                                    <i class="fas fa-map-marker-alt" style="color:#2563eb;"></i>
                                    <span>${rm.city}</span>
                                </div>

                                <!-- PG Info -->
                                <div style="display:flex;align-items:center;gap:0.5rem;margin-bottom:1rem;background:#f0f9ff;padding:0.625rem 0.75rem;border-radius:0.5rem;">
                                    <i class="fas fa-home" style="color:#0369a1;"></i>
                                    <span style="color:#0369a1;font-size:0.875rem;font-weight:600;">${rm.pgName}</span>
                                </div>

                                <!-- Action Buttons -->
                                <div style="display:flex;gap:0.5rem;">
                                    <button onclick="viewProfile(${rm.userId})"
                                            style="flex:1;padding:0.75rem;background:white;color:#2563eb;font-weight:600;border:2px solid #2563eb;border-radius:0.5rem;cursor:pointer;font-size:0.875rem;transition:all 0.2s;"
                                            onmouseover="this.style.background='#eff6ff'" onmouseout="this.style.background='white'">
                                        <i class="fas fa-user"></i> View Profile
                                    </button>
                                    <button onclick="connectRoommate(${rm.userId}, '${rm.name}')"
                                            style="flex:1;padding:0.75rem;background:#2563eb;color:white;font-weight:600;border:none;border-radius:0.5rem;cursor:pointer;font-size:0.875rem;transition:background 0.2s;"
                                            onmouseover="this.style.background='#1d4ed8'" onmouseout="this.style.background='#2563eb'">
                                        <i class="fas fa-comment"></i> Chat
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Post Requirement Tab (hidden by default) -->
        <div id="postContent" style="display:none;">
            <div style="background:white;border-radius:1rem;padding:2rem;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
                <h2 style="margin:0 0 1.5rem 0;font-size:1.25rem;font-weight:700;color:#111827;">Post Your Roommate Requirement</h2>
                <p style="color:#6b7280;margin-bottom:1.5rem;">Let others know you're looking for a roommate in your PG.</p>
                <c:choose>
                    <c:when test="${sessionScope.userId != null}">
                        <div style="background:#f0f9ff;border-radius:0.75rem;padding:1.5rem;text-align:center;">
                            <i class="fas fa-info-circle" style="color:#0369a1;font-size:2rem;margin-bottom:0.75rem;display:block;"></i>
                            <p style="color:#0369a1;font-weight:600;margin:0;">Your profile is visible to other tenants once you have an active booking.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align:center;padding:2rem;">
                            <p style="color:#6b7280;margin-bottom:1rem;">Please login to post your requirement.</p>
                            <a href="${pageContext.request.contextPath}/login"
                               style="display:inline-block;padding:0.75rem 1.5rem;background:#2563eb;color:white;border-radius:0.5rem;text-decoration:none;font-weight:600;">
                                Login Now
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </div>
</div>
</div>

<script>
function switchTab(tab) {
    document.getElementById('findContent').style.display  = tab === 'find' ? 'block' : 'none';
    document.getElementById('postContent').style.display  = tab === 'post' ? 'block' : 'none';

    ['find','post'].forEach(t => {
        const el = document.getElementById(t + 'Tab');
        if (t === tab) {
            el.style.borderBottomColor = '#2563eb';
            el.style.color = '#2563eb';
        } else {
            el.style.borderBottomColor = 'transparent';
            el.style.color = '#6b7280';
        }
    });
}

function clearFilters() {
    document.getElementById('genderFilter').value = 'all';
    applyFilters();
}

function applyFilters() {
    const gender = document.getElementById('genderFilter').value;
    const cards  = document.querySelectorAll('.roommate-card');
    let count = 0;

    cards.forEach(card => {
        // gender filter is client-side only (no gender stored yet, show all)
        card.style.display = 'block';
        count++;
    });

    document.getElementById('roommateCount').textContent = count + ' roommate' + (count !== 1 ? 's' : '');
}

function viewProfile(roommateId) {
    window.location.href = '${pageContext.request.contextPath}/roommate-profile?id=' + roommateId;
}

function connectRoommate(roommateId, roommateName) {
    const isLoggedIn = ${sessionScope.userId != null ? 'true' : 'false'};
    if (!isLoggedIn) {
        if (confirm('You need to login to send a message. Login now?')) {
            window.location.href = '${pageContext.request.contextPath}/login';
        }
        return;
    }
    window.location.href = '${pageContext.request.contextPath}/tenant/messages?roommateId=' + roommateId + '&roommateName=' + encodeURIComponent(roommateName);
}
</script>
