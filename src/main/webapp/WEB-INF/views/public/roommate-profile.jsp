<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div style="background-color:#f9fafb;min-height:100vh;padding:2rem 0;">
<div style="max-width:860px;margin:0 auto;padding:0 1.5rem;">

    <a href="${pageContext.request.contextPath}/find-roommate"
       style="display:inline-flex;align-items:center;gap:0.5rem;color:#6b7280;text-decoration:none;font-size:0.875rem;margin-bottom:1.5rem;">
        <i class="fas fa-arrow-left"></i> Back to Roommate Finder
    </a>

    <c:choose>
    <c:when test="${not empty profile}">

    <div style="background:white;border-radius:1rem;padding:2rem;box-shadow:0 1px 3px rgba(0,0,0,0.1);">

        <!-- Profile Header -->
        <div style="display:flex;gap:2rem;margin-bottom:2rem;padding-bottom:2rem;border-bottom:1px solid #e5e7eb;flex-wrap:wrap;">

            <!-- Avatar -->
            <c:choose>
                <c:when test="${not empty profile.profileImage}">
                    <img src="${profile.profileImage}" alt="${profile.name}"
                         style="width:120px;height:120px;border-radius:50%;object-fit:cover;border:4px solid #dbeafe;flex-shrink:0;">
                </c:when>
                <c:otherwise>
                    <div style="width:120px;height:120px;border-radius:50%;background:linear-gradient(135deg,#667eea,#764ba2);display:flex;align-items:center;justify-content:center;font-size:3rem;font-weight:700;color:white;flex-shrink:0;">
                        ${profile.name.substring(0,1).toUpperCase()}
                    </div>
                </c:otherwise>
            </c:choose>

            <div style="flex:1;min-width:200px;">
                <div style="display:flex;align-items:start;justify-content:space-between;flex-wrap:wrap;gap:1rem;margin-bottom:1rem;">
                    <div>
                        <h1 style="margin:0 0 0.25rem 0;font-size:1.875rem;font-weight:bold;color:#111827;">${profile.name}</h1>
                        <c:if test="${profile.verified}">
                            <span style="background:#dbeafe;color:#1e40af;padding:0.25rem 0.75rem;border-radius:9999px;font-size:0.75rem;font-weight:600;">
                                <i class="fas fa-check-circle"></i> Verified Tenant
                            </span>
                        </c:if>
                    </div>
                    <div style="background:#f0f9ff;border-radius:0.75rem;padding:1rem;text-align:center;min-width:90px;">
                        <div style="color:#0369a1;font-size:0.75rem;font-weight:600;margin-bottom:0.25rem;">Match</div>
                        <div style="color:#0369a1;font-size:1.75rem;font-weight:700;">90%</div>
                    </div>
                </div>

                <div style="display:flex;flex-direction:column;gap:0.5rem;margin-bottom:1.25rem;">
                    <div style="display:flex;align-items:center;gap:0.5rem;color:#6b7280;font-size:0.875rem;">
                        <i class="fas fa-map-marker-alt" style="color:#2563eb;width:14px;"></i>
                        <span>${profile.city}</span>
                    </div>
                    <div style="display:flex;align-items:center;gap:0.5rem;color:#6b7280;font-size:0.875rem;">
                        <i class="fas fa-home" style="color:#2563eb;width:14px;"></i>
                        <span><strong>PG:</strong> ${profile.pgName}
                            <c:if test="${not empty profile.roomNumber}">
                                &nbsp;&bull;&nbsp;<strong>Room:</strong> ${profile.roomNumber}
                            </c:if>
                        </span>
                    </div>
                </div>

                <button onclick="chatRoommate(${profile.userId}, '${profile.name}')"
                        style="padding:0.75rem 2rem;background:#2563eb;color:white;font-weight:600;border:none;border-radius:0.5rem;cursor:pointer;font-size:0.9375rem;transition:background 0.2s;"
                        onmouseover="this.style.background='#1d4ed8'" onmouseout="this.style.background='#2563eb'">
                    <i class="fas fa-comment"></i> Send Message
                </button>
            </div>
        </div>

        <!-- About -->
        <div style="margin-bottom:2rem;">
            <h2 style="margin:0 0 0.75rem 0;font-size:1.125rem;font-weight:700;color:#111827;">About</h2>
            <p style="color:#6b7280;line-height:1.7;margin:0;">
                Hi! I'm ${profile.name}, currently staying at ${profile.pgName} in ${profile.city}.
                I'm looking for a compatible roommate who values cleanliness and mutual respect.
                Feel free to message me to know more!
            </p>
        </div>

        <!-- Lifestyle -->
        <div style="margin-bottom:2rem;">
            <h2 style="margin:0 0 0.75rem 0;font-size:1.125rem;font-weight:700;color:#111827;">Lifestyle Preferences</h2>
            <div style="display:grid;grid-template-columns:repeat(2,1fr);gap:0.75rem;">
                <div style="display:flex;align-items:center;gap:0.75rem;padding:0.875rem;background:#f9fafb;border-radius:0.5rem;">
                    <i class="fas fa-smoking-ban" style="color:#22c55e;font-size:1.125rem;"></i>
                    <span style="color:#374151;font-weight:500;">Non-Smoker</span>
                </div>
                <div style="display:flex;align-items:center;gap:0.75rem;padding:0.875rem;background:#f9fafb;border-radius:0.5rem;">
                    <i class="fas fa-broom" style="color:#3b82f6;font-size:1.125rem;"></i>
                    <span style="color:#374151;font-weight:500;">Clean & Organized</span>
                </div>
                <div style="display:flex;align-items:center;gap:0.75rem;padding:0.875rem;background:#f9fafb;border-radius:0.5rem;">
                    <i class="fas fa-moon" style="color:#8b5cf6;font-size:1.125rem;"></i>
                    <span style="color:#374151;font-weight:500;">Respectful Hours</span>
                </div>
                <div style="display:flex;align-items:center;gap:0.75rem;padding:0.875rem;background:#f9fafb;border-radius:0.5rem;">
                    <i class="fas fa-handshake" style="color:#f59e0b;font-size:1.125rem;"></i>
                    <span style="color:#374151;font-weight:500;">Friendly</span>
                </div>
            </div>
        </div>

        <!-- Looking For -->
        <div>
            <h2 style="margin:0 0 0.75rem 0;font-size:1.125rem;font-weight:700;color:#111827;">Looking For</h2>
            <div style="background:#f0f9ff;border-radius:0.75rem;padding:1.25rem;">
                <ul style="margin:0;padding-left:1.5rem;color:#374151;line-height:1.9;">
                    <li>Respectful and responsible roommate</li>
                    <li>Someone who values cleanliness</li>
                    <li>Prefers a quiet, peaceful environment</li>
                    <li>Shares similar lifestyle habits</li>
                </ul>
            </div>
        </div>

    </div>

    </c:when>
    <c:otherwise>
        <div style="background:white;border-radius:1rem;padding:4rem 2rem;text-align:center;box-shadow:0 1px 3px rgba(0,0,0,0.1);">
            <i class="fas fa-user-slash" style="font-size:3rem;color:#d1d5db;margin-bottom:1rem;display:block;"></i>
            <h3 style="color:#374151;margin:0 0 0.5rem 0;">Profile Not Found</h3>
            <p style="color:#6b7280;margin:0 0 1.5rem 0;">This roommate profile doesn't exist or is no longer available.</p>
            <a href="${pageContext.request.contextPath}/find-roommate"
               style="display:inline-block;padding:0.75rem 1.5rem;background:#2563eb;color:white;border-radius:0.5rem;text-decoration:none;font-weight:600;">
                Browse Roommates
            </a>
        </div>
    </c:otherwise>
    </c:choose>

</div>
</div>

<script>
function chatRoommate(roommateId, roommateName) {
    const isLoggedIn = ${sessionScope.userId != null ? 'true' : 'false'};
    if (!isLoggedIn) {
        if (confirm('You need to login to send messages. Login now?')) {
            window.location.href = '${pageContext.request.contextPath}/login';
        }
        return;
    }
    window.location.href = '${pageContext.request.contextPath}/tenant/messages?roommateId=' + roommateId + '&roommateName=' + encodeURIComponent(roommateName);
}
</script>
