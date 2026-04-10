<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reports & Flags - PG Finder Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50">
    <div class="flex">
        <jsp:include page="../includes/sidebar-admin.jsp"><jsp:param name="currentPage" value="reports" /></jsp:include>
        <main class="flex-1 min-h-screen" style="margin-left: 240px;">
            <jsp:include page="../includes/header-admin.jsp" />
            <div class="p-8">
                <h1 class="text-3xl font-bold text-gray-900 mb-2">Reports & Flags</h1>
                <p class="text-gray-600 mb-8">Manage user reports</p>
                <c:if test="${not empty sessionScope.success}">
                    <div class="bg-green-50 border border-green-200 text-green-800 px-4 py-3 rounded-lg mb-4">${sessionScope.success}</div>
                    <c:remove var="success" scope="session"/>
                </c:if>
                <c:choose>
                    <c:when test="${not empty reports}">
                        <c:forEach items="${reports}" var="report">
                            <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6 mb-4">
                                <div class="flex justify-between items-start mb-4">
                                    <div>
                                        <h3 class="text-lg font-bold text-gray-900">Report #${report.reportId}</h3>
                                        <p class="text-sm text-gray-600">By: ${report.reporterName} (${report.reporterEmail})</p>
                                    </div>
                                    <span class="px-3 py-1 rounded text-xs font-medium bg-yellow-100 text-yellow-700">${report.status}</span>
                                </div>
                                <div class="mb-4">
                                    <p class="text-sm mb-2"><strong>Type:</strong> ${report.reportedType}</p>
                                    <p class="text-sm mb-2"><strong>Reason:</strong> ${report.reportReason}</p>
                                    <p class="text-sm mb-2"><strong>Description:</strong> ${report.reportDescription}</p>
                                    <p class="text-sm text-gray-500"><fmt:formatDate value="${report.createdAt}" pattern="dd MMM yyyy HH:mm"/></p>
                                </div>
                                <c:if test="${report.status == 'pending' || report.status == 'investigating'}">
                                    <form method="post" class="flex gap-2">
                                        <input type="hidden" name="reportId" value="${report.reportId}">
                                        <select name="status" required class="px-3 py-2 border border-gray-300 rounded-lg text-sm">
                                            <option value="">Update Status</option>
                                            <option value="investigating">Investigating</option>
                                            <option value="resolved">Resolved</option>
                                            <option value="dismissed">Dismissed</option>
                                        </select>
                                        <input type="text" name="adminNotes" placeholder="Admin notes..." class="flex-1 px-3 py-2 border border-gray-300 rounded-lg text-sm">
                                        <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 text-sm font-medium">Update</button>
                                    </form>
                                </c:if>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-12 text-center">
                            <i class="fas fa-check-circle text-gray-300 text-5xl mb-4"></i>
                            <p class="text-gray-500">No reports found</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>
</body>
</html>
