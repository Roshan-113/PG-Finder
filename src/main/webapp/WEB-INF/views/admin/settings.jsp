<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Settings - PG Finder Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50">
    <div class="flex">
        <jsp:include page="../includes/sidebar-admin.jsp">
            <jsp:param name="currentPage" value="settings" />
        </jsp:include>

        <main class="flex-1 min-h-screen" style="margin-left: 240px;">
            <jsp:include page="../includes/header-admin.jsp" />

            <div class="p-8">
                <h1 class="text-3xl font-bold text-gray-900 mb-2">System Settings</h1>
                <p class="text-gray-600 mb-8">Manage platform configuration and view activity logs</p>

                <c:if test="${not empty sessionScope.success}">
                    <div class="bg-green-50 border border-green-200 text-green-800 px-4 py-3 rounded-lg mb-4">
                        <i class="fas fa-check-circle mr-2"></i>${sessionScope.success}
                    </div>
                    <c:remove var="success" scope="session"/>
                </c:if>

                <c:if test="${not empty sessionScope.error}">
                    <div class="bg-red-50 border border-red-200 text-red-800 px-4 py-3 rounded-lg mb-4">
                        <i class="fas fa-exclamation-circle mr-2"></i>${sessionScope.error}
                    </div>
                    <c:remove var="error" scope="session"/>
                </c:if>

                <!-- Tabs -->
                <div class="flex gap-4 mb-6 border-b border-gray-200">
                    <a href="?tab=general" class="px-4 py-2 text-sm font-medium ${activeTab == 'general' || empty activeTab ? 'text-blue-600 border-b-2 border-blue-600' : 'text-gray-600 hover:text-gray-900'}">
                        <i class="fas fa-cog mr-2"></i>General Settings
                    </a>
                    <a href="?tab=logs" class="px-4 py-2 text-sm font-medium ${activeTab == 'logs' ? 'text-blue-600 border-b-2 border-blue-600' : 'text-gray-600 hover:text-gray-900'}">
                        <i class="fas fa-history mr-2"></i>Activity Logs
                    </a>
                </div>

                <!-- General Settings Tab -->
                <c:if test="${activeTab == 'general' || empty activeTab}">
                    <div class="bg-white rounded-xl shadow-sm border border-gray-100">
                        <div class="px-6 py-4 border-b border-gray-100">
                            <h2 class="text-xl font-bold text-gray-900">Platform Configuration</h2>
                            <p class="text-sm text-gray-600 mt-1">Configure system-wide settings and preferences</p>
                        </div>
                        
                        <c:choose>
                            <c:when test="${not empty settings}">
                                <c:forEach items="${settings}" var="setting" varStatus="status">
                                    <div class="flex justify-between items-center p-6 ${!status.last ? 'border-b border-gray-100' : ''}">
                                        <div class="flex-1">
                                            <h3 class="text-sm font-semibold text-gray-900 mb-1">${setting.settingKey}</h3>
                                            <p class="text-sm text-gray-600">${setting.description}</p>
                                        </div>
                                        <form method="post" class="flex gap-2 ml-4">
                                            <input type="hidden" name="settingKey" value="${setting.settingKey}">
                                            <c:choose>
                                                <c:when test="${setting.settingType == 'boolean'}">
                                                    <select name="settingValue" class="px-3 py-2 border border-gray-300 rounded-lg text-sm focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                                        <option value="true" ${setting.settingValue == 'true' ? 'selected' : ''}>Enabled</option>
                                                        <option value="false" ${setting.settingValue == 'false' ? 'selected' : ''}>Disabled</option>
                                                    </select>
                                                </c:when>
                                                <c:when test="${setting.settingType == 'number'}">
                                                    <input type="number" name="settingValue" value="${setting.settingValue}" class="px-3 py-2 border border-gray-300 rounded-lg text-sm w-32 focus:ring-2 focus:ring-blue-500 focus:border-blue-500" required>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="text" name="settingValue" value="${setting.settingValue}" class="px-3 py-2 border border-gray-300 rounded-lg text-sm w-64 focus:ring-2 focus:ring-blue-500 focus:border-blue-500" required>
                                                </c:otherwise>
                                            </c:choose>
                                            <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 text-sm font-medium transition-colors">
                                                <i class="fas fa-save mr-1"></i>Save
                                            </button>
                                        </form>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-12">
                                    <i class="fas fa-cog text-gray-300 text-5xl mb-4"></i>
                                    <p class="text-gray-500">No settings configured</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>

                <!-- Activity Logs Tab -->
                <c:if test="${activeTab == 'logs'}">
                    <div class="bg-white rounded-xl shadow-sm border border-gray-100">
                        <div class="px-6 py-4 border-b border-gray-100">
                            <h2 class="text-xl font-bold text-gray-900">Activity Logs</h2>
                            <p class="text-sm text-gray-600 mt-1">Track all administrative actions and system events</p>
                        </div>
                        
                        <div class="overflow-x-auto">
                            <table class="w-full">
                                <thead class="bg-gray-50 border-b border-gray-100">
                                    <tr>
                                        <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Timestamp</th>
                                        <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">User</th>
                                        <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Action Type</th>
                                        <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Description</th>
                                        <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">IP Address</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty logs}">
                                            <c:forEach items="${logs}" var="log">
                                                <tr class="border-b border-gray-50 hover:bg-gray-50">
                                                    <td class="py-3 px-4 text-sm text-gray-600">
                                                        <fmt:formatDate value="${log.createdAt}" pattern="dd MMM yyyy HH:mm:ss"/>
                                                    </td>
                                                    <td class="py-3 px-4 text-sm text-gray-900 font-medium">${log.userName}</td>
                                                    <td class="py-3 px-4 text-sm">
                                                        <span class="px-2 py-1 bg-blue-100 text-blue-700 rounded text-xs font-medium">${log.actionType}</span>
                                                    </td>
                                                    <td class="py-3 px-4 text-sm text-gray-600">${log.actionDescription}</td>
                                                    <td class="py-3 px-4 text-sm text-gray-500">${log.ipAddress != null ? log.ipAddress : '-'}</td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="5" class="py-12 text-center">
                                                    <i class="fas fa-history text-gray-300 text-5xl mb-4"></i>
                                                    <p class="text-gray-500">No activity logs found</p>
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${not empty logs}">
                            <div class="px-6 py-4 border-t border-gray-100 flex items-center justify-between">
                                <div class="text-sm text-gray-600">
                                    Showing page ${pageNumber}
                                </div>
                                <div class="flex gap-2">
                                    <c:if test="${pageNumber > 1}">
                                        <a href="?tab=logs&page=${pageNumber - 1}" class="px-3 py-2 border border-gray-300 rounded-lg text-sm hover:bg-gray-50">
                                            <i class="fas fa-chevron-left"></i> Previous
                                        </a>
                                    </c:if>
                                    <a href="?tab=logs&page=${pageNumber + 1}" class="px-3 py-2 border border-gray-300 rounded-lg text-sm hover:bg-gray-50">
                                        Next <i class="fas fa-chevron-right"></i>
                                    </a>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </main>
    </div>
</body>
</html>
