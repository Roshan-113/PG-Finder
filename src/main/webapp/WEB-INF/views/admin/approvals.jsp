<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Owner Verification - PG Finder Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50">
    <div class="flex">
        <jsp:include page="../includes/sidebar-admin.jsp"><jsp:param name="currentPage" value="approvals" /></jsp:include>
        <main class="flex-1 min-h-screen" style="margin-left: 240px;">
            <jsp:include page="../includes/header-admin.jsp" />
            <div class="p-8">
                <h1 class="text-3xl font-bold text-gray-900 mb-2">Owner Verification</h1>
                <p class="text-gray-600 mb-8">Review and approve owner documents</p>
                <c:if test="${not empty sessionScope.success}">
                    <div class="bg-green-50 border border-green-200 text-green-800 px-4 py-3 rounded-lg mb-4">${sessionScope.success}</div>
                    <c:remove var="success" scope="session"/>
                </c:if>
                <div class="bg-white rounded-xl shadow-sm border border-gray-100">
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-gray-50 border-b border-gray-100">
                                <tr>
                                    <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Owner</th>
                                    <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Contact</th>
                                    <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Document</th>
                                    <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Uploaded</th>
                                    <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${documents}" var="doc">
                                    <tr class="border-b border-gray-50 hover:bg-gray-50">
                                        <td class="py-3 px-4 text-sm text-gray-900">${doc.owner_name}</td>
                                        <td class="py-3 px-4 text-sm text-gray-600">${doc.owner_email}<br><small>${doc.owner_phone}</small></td>
                                        <td class="py-3 px-4 text-sm"><span class="px-2 py-1 bg-gray-100 text-gray-700 rounded text-xs">${doc.document_type}</span></td>
                                        <td class="py-3 px-4 text-sm text-gray-600"><fmt:formatDate value="${doc.uploaded_at}" pattern="dd MMM yyyy"/></td>
                                        <td class="py-3 px-4 text-sm">
                                            <div class="flex gap-2">
                                                <a href="${pageContext.request.contextPath}/${doc.document_url}" target="_blank" class="px-2 py-1 bg-blue-100 text-blue-700 rounded hover:bg-blue-200">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <form method="post" style="display:inline;">
                                                    <input type="hidden" name="action" value="approve">
                                                    <input type="hidden" name="documentId" value="${doc.document_id}">
                                                    <button type="submit" class="px-2 py-1 bg-green-100 text-green-700 rounded hover:bg-green-200" onclick="return confirm('Approve?')">
                                                        <i class="fas fa-check"></i>
                                                    </button>
                                                </form>
                                                <form method="post" style="display:inline;">
                                                    <input type="hidden" name="action" value="reject">
                                                    <input type="hidden" name="documentId" value="${doc.document_id}">
                                                    <button type="submit" class="px-2 py-1 bg-red-100 text-red-700 rounded hover:bg-red-200" onclick="return confirm('Reject?')">
                                                        <i class="fas fa-times"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty documents}">
                                    <tr><td colspan="5" class="py-12 text-center text-gray-500">No pending documents</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
