<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="mb-8">
    <h1 class="text-3xl font-bold text-gray-900">Notifications</h1>
    <p class="text-gray-600 mt-2">Stay updated with your PG activities</p>
</div>

<!-- Notification Filters -->
<div class="bg-white rounded-lg p-4 shadow-sm mb-6">
    <div class="flex items-center gap-4">
        <button class="px-4 py-2 rounded-lg font-medium text-white transition-all" style="background-color: #3b82f6;">
            All
        </button>
        <button class="px-4 py-2 rounded-lg font-medium text-gray-700 hover:bg-gray-100 transition-all">
            Bookings
        </button>
        <button class="px-4 py-2 rounded-lg font-medium text-gray-700 hover:bg-gray-100 transition-all">
            Reviews
        </button>
        <button class="px-4 py-2 rounded-lg font-medium text-gray-700 hover:bg-gray-100 transition-all">
            Inquiries
        </button>
        <div class="ml-auto">
            <button onclick="markAllAsRead()" class="text-sm text-blue-600 hover:text-blue-700 font-medium">
                Mark all as read
            </button>
        </div>
    </div>
</div>

<!-- Notifications List -->
<div class="space-y-4">
    <!-- Notification 1 - New Booking -->
    <div class="bg-white rounded-lg p-6 shadow-sm hover:shadow-md transition-shadow border-l-4 border-blue-500">
        <div class="flex items-start gap-4">
            <div class="w-12 h-12 rounded-full flex items-center justify-center flex-shrink-0" style="background-color: #dbeafe;">
                <i class="fas fa-calendar-check text-blue-600" style="font-size: 20px;"></i>
            </div>
            <div class="flex-1">
                <div class="flex items-start justify-between mb-2">
                    <div>
                        <h3 class="font-semibold text-gray-900">New Booking Request</h3>
                        <p class="text-sm text-gray-600 mt-1">
                            Rahul Kumar has requested to book a room at Sunrise PG for Men
                        </p>
                    </div>
                    <span class="text-xs text-gray-500 whitespace-nowrap ml-4">2 hours ago</span>
                </div>
                <div class="flex items-center gap-3 mt-3">
                    <button onclick="window.location.href='${pageContext.request.contextPath}/owner/bookings'" class="px-4 py-2 rounded-lg text-sm font-medium text-white transition-all" style="background-color: #22c55e;">
                        View Details
                    </button>
                    <button onclick="dismissNotification(this)" class="px-4 py-2 rounded-lg text-sm font-medium text-gray-700 hover:bg-gray-100 transition-all">
                        Dismiss
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Notification 2 - New Review -->
    <div class="bg-white rounded-lg p-6 shadow-sm hover:shadow-md transition-shadow border-l-4 border-yellow-500">
        <div class="flex items-start gap-4">
            <div class="w-12 h-12 rounded-full flex items-center justify-center flex-shrink-0" style="background-color: #fef3c7;">
                <i class="fas fa-star text-yellow-600" style="font-size: 20px;"></i>
            </div>
            <div class="flex-1">
                <div class="flex items-start justify-between mb-2">
                    <div>
                        <h3 class="font-semibold text-gray-900">New Review Received</h3>
                        <p class="text-sm text-gray-600 mt-1">
                            Priya Sharma left a 5-star review for Green Valley Girls Hostel
                        </p>
                    </div>
                    <span class="text-xs text-gray-500 whitespace-nowrap ml-4">5 hours ago</span>
                </div>
                <div class="flex items-center gap-3 mt-3">
                    <button onclick="window.location.href='${pageContext.request.contextPath}/owner/reviews'" class="px-4 py-2 rounded-lg text-sm font-medium text-white transition-all" style="background-color: #22c55e;">
                        View Review
                    </button>
                    <button onclick="dismissNotification(this)" class="px-4 py-2 rounded-lg text-sm font-medium text-gray-700 hover:bg-gray-100 transition-all">
                        Dismiss
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Notification 3 - New Inquiry -->
    <div class="bg-white rounded-lg p-6 shadow-sm hover:shadow-md transition-shadow border-l-4 border-purple-500">
        <div class="flex items-start gap-4">
            <div class="w-12 h-12 rounded-full flex items-center justify-center flex-shrink-0" style="background-color: #e9d5ff;">
                <i class="fas fa-comment-dots text-purple-600" style="font-size: 20px;"></i>
            </div>
            <div class="flex-1">
                <div class="flex items-start justify-between mb-2">
                    <div>
                        <h3 class="font-semibold text-gray-900">New Inquiry</h3>
                        <p class="text-sm text-gray-600 mt-1">
                            Amit Patel asked about room availability at Urban Nest Co-living
                        </p>
                    </div>
                    <span class="text-xs text-gray-500 whitespace-nowrap ml-4">1 day ago</span>
                </div>
                <div class="flex items-center gap-3 mt-3">
                    <button onclick="window.location.href='${pageContext.request.contextPath}/owner/inquiries'" class="px-4 py-2 rounded-lg text-sm font-medium text-white transition-all" style="background-color: #22c55e;">
                        Reply
                    </button>
                    <button onclick="dismissNotification(this)" class="px-4 py-2 rounded-lg text-sm font-medium text-gray-700 hover:bg-gray-100 transition-all">
                        Dismiss
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Notification 4 - Payment Received -->
    <div class="bg-gray-50 rounded-lg p-6 shadow-sm hover:shadow-md transition-shadow border-l-4 border-green-500 opacity-75">
        <div class="flex items-start gap-4">
            <div class="w-12 h-12 rounded-full flex items-center justify-center flex-shrink-0" style="background-color: #d1fae5;">
                <i class="fas fa-rupee-sign text-green-600" style="font-size: 20px;"></i>
            </div>
            <div class="flex-1">
                <div class="flex items-start justify-between mb-2">
                    <div>
                        <h3 class="font-semibold text-gray-900">Payment Received</h3>
                        <p class="text-sm text-gray-600 mt-1">
                            ₹12,000 payment received from Rahul Kumar for Sunrise PG
                        </p>
                    </div>
                    <span class="text-xs text-gray-500 whitespace-nowrap ml-4">2 days ago</span>
                </div>
                <div class="flex items-center gap-3 mt-3">
                    <button onclick="window.location.href='${pageContext.request.contextPath}/owner/earnings'" class="px-4 py-2 rounded-lg text-sm font-medium text-gray-700 hover:bg-gray-100 transition-all">
                        View Receipt
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Notification 5 - Document Verified -->
    <div class="bg-gray-50 rounded-lg p-6 shadow-sm hover:shadow-md transition-shadow border-l-4 border-green-500 opacity-75">
        <div class="flex items-start gap-4">
            <div class="w-12 h-12 rounded-full flex items-center justify-center flex-shrink-0" style="background-color: #d1fae5;">
                <i class="fas fa-check-circle text-green-600" style="font-size: 20px;"></i>
            </div>
            <div class="flex-1">
                <div class="flex items-start justify-between mb-2">
                    <div>
                        <h3 class="font-semibold text-gray-900">Document Verified</h3>
                        <p class="text-sm text-gray-600 mt-1">
                            Your property ownership document has been verified by admin
                        </p>
                    </div>
                    <span class="text-xs text-gray-500 whitespace-nowrap ml-4">3 days ago</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Notification 6 - Listing Approved -->
    <div class="bg-gray-50 rounded-lg p-6 shadow-sm hover:shadow-md transition-shadow border-l-4 border-green-500 opacity-75">
        <div class="flex items-start gap-4">
            <div class="w-12 h-12 rounded-full flex items-center justify-center flex-shrink-0" style="background-color: #d1fae5;">
                <i class="fas fa-check-circle text-green-600" style="font-size: 20px;"></i>
            </div>
            <div class="flex-1">
                <div class="flex items-start justify-between mb-2">
                    <div>
                        <h3 class="font-semibold text-gray-900">Listing Approved</h3>
                        <p class="text-sm text-gray-600 mt-1">
                            Your listing "Sunrise PG for Men" has been approved and is now live
                        </p>
                    </div>
                    <span class="text-xs text-gray-500 whitespace-nowrap ml-4">5 days ago</span>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Empty State (hidden when there are notifications) -->
<div class="bg-white rounded-lg p-12 shadow-sm text-center" style="display: none;">
    <i class="fas fa-bell-slash text-gray-300 text-6xl mb-4"></i>
    <h3 class="text-xl font-bold text-gray-900 mb-2">No Notifications</h3>
    <p class="text-gray-600">You're all caught up! Check back later for updates.</p>
</div>

<script>
// Dismiss notification
function dismissNotification(button) {
    const notification = button.closest('.bg-white, .bg-gray-50');
    notification.style.transition = 'opacity 0.3s, transform 0.3s';
    notification.style.opacity = '0';
    notification.style.transform = 'translateX(100%)';
    setTimeout(() => {
        notification.remove();
        // Check if there are any notifications left
        const remainingNotifications = document.querySelectorAll('.space-y-4 > div').length;
        if (remainingNotifications === 0) {
            document.querySelector('.space-y-4').innerHTML = `
                <div class="bg-white rounded-lg p-12 shadow-sm text-center">
                    <i class="fas fa-bell-slash text-gray-300 text-6xl mb-4"></i>
                    <h3 class="text-xl font-bold text-gray-900 mb-2">No Notifications</h3>
                    <p class="text-gray-600">You're all caught up! Check back later for updates.</p>
                </div>
            `;
        }
    }, 300);
}

// Mark all as read
function markAllAsRead() {
    const unreadNotifications = document.querySelectorAll('.bg-white');
    unreadNotifications.forEach(notification => {
        notification.classList.remove('bg-white');
        notification.classList.add('bg-gray-50');
        notification.style.opacity = '0.75';
    });
    alert('All notifications marked as read');
}
</script>
