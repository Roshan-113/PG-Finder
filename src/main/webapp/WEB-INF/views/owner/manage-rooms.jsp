<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="mb-8">
    <h1 class="text-3xl font-bold text-gray-900">Manage Rooms & Availability</h1>
    <p class="text-gray-600 mt-2">Update room availability for your properties</p>
</div>

<c:choose>
    <c:when test="${not empty listings}">
        <!-- Listings Table -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
            <div class="px-6 py-4 border-b border-gray-200">
                <h3 class="text-lg font-bold text-gray-900">Your Properties</h3>
            </div>
            <table class="w-full">
                <thead class="bg-gray-50 border-b border-gray-200">
                    <tr>
                        <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">PG Name</th>
                        <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Type</th>
                        <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Total Rooms</th>
                        <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Available</th>
                        <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Occupied</th>
                        <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Rent</th>
                        <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Actions</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-200">
                    <c:forEach var="listing" items="${listings}">
                        <tr class="hover:bg-gray-50 transition-colors">
                            <td class="px-6 py-4 whitespace-nowrap font-medium text-gray-900">${listing.title}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-gray-600">
                                <c:choose>
                                    <c:when test="${listing.pgType == 'boys'}">Boys PG</c:when>
                                    <c:when test="${listing.pgType == 'girls'}">Girls PG</c:when>
                                    <c:otherwise>Co-living</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-gray-600">${listing.totalRooms}</td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-3 py-1 rounded-full text-xs font-semibold" style="background-color: #dcfce7; color: #166534;">
                                    ${listing.availableRooms}
                                </span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-gray-600">${listing.totalRooms - listing.availableRooms}</td>
                            <td class="px-6 py-4 whitespace-nowrap font-semibold text-gray-900">
                                ₹<fmt:formatNumber value="${listing.rentPerMonth}" pattern="#,##0"/>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <button onclick="updateAvailability(${listing.listingId}, '${listing.title}', ${listing.totalRooms}, ${listing.availableRooms})" 
                                        class="px-4 py-2 text-white rounded-lg transition-colors text-sm font-medium" style="background-color: #3b82f6; display: inline-block;">
                                    <i class="fas fa-edit"></i> Update
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:when>
    <c:otherwise>
        <div class="bg-white rounded-xl p-12 text-center border border-gray-200 shadow-sm">
            <i class="fas fa-home text-gray-300" style="font-size: 4rem; margin-bottom: 1rem;"></i>
            <h3 class="text-xl font-bold text-gray-900 mb-2">No Properties Yet</h3>
            <p class="text-gray-600 mb-6">Add your first property to start managing rooms</p>
            <a href="${pageContext.request.contextPath}/owner/add-pg" 
               class="inline-block px-6 py-3 bg-blue-600 text-white rounded-lg font-semibold hover:bg-blue-700 transition-colors">
                <i class="fas fa-plus"></i> Add Property
            </a>
        </div>
    </c:otherwise>
</c:choose>

<script>
function updateAvailability(listingId, pgName, totalRooms, currentAvailable) {
    const newAvailable = prompt(
        'Update available rooms for: ' + pgName + 
        '\nTotal Rooms: ' + totalRooms + 
        '\nCurrent Available: ' + currentAvailable + 
        '\n\nEnter new available rooms (0-' + totalRooms + '):', 
        currentAvailable
    );
    
    if (newAvailable === null) return; // User cancelled
    
    const available = parseInt(newAvailable);
    
    if (isNaN(available)) {
        alert('Please enter a valid number');
        return;
    }
    
    if (available < 0 || available > totalRooms) {
        alert('Available rooms must be between 0 and ' + totalRooms);
        return;
    }
    
    const formData = new FormData();
    formData.append('action', 'updateAvailability');
    formData.append('listingId', listingId);
    formData.append('availableRooms', available);
    
    fetch('${pageContext.request.contextPath}/owner/manage-rooms', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'action=updateAvailability&listingId=' + listingId + '&availableRooms=' + available
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert(data.message || 'Availability updated successfully!');
            location.reload();
        } else {
            alert(data.message || 'Failed to update availability');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred while updating availability');
    });
}
</script>
