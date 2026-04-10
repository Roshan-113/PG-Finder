<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="space-y-6">
    <!-- Page Header -->
    <div class="mb-6">
        <h2 class="text-3xl font-bold text-gray-900">Inquiries & Support</h2>
        <p class="text-gray-600 mt-1">Manage all customer inquiries and support requests</p>
    </div>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
        <div class="bg-white rounded-lg p-4 border border-gray-200">
            <div class="text-sm text-gray-600 mb-1">Total Inquiries</div>
            <div class="text-2xl font-bold">156</div>
        </div>
        <div class="bg-white rounded-lg p-4 border border-gray-200">
            <div class="text-sm text-gray-600 mb-1">Pending</div>
            <div class="text-2xl font-bold text-amber-600">23</div>
        </div>
        <div class="bg-white rounded-lg p-4 border border-gray-200">
            <div class="text-sm text-gray-600 mb-1">Resolved</div>
            <div class="text-2xl font-bold text-green-600">128</div>
        </div>
        <div class="bg-white rounded-lg p-4 border border-gray-200">
            <div class="text-sm text-gray-600 mb-1">Avg Response Time</div>
            <div class="text-2xl font-bold text-blue-600">2.5h</div>
        </div>
    </div>

    <!-- Inquiries List -->
    <div class="bg-white rounded-lg p-6 border border-gray-200">
        <h3 class="text-lg font-bold mb-4">All Inquiries</h3>
        <div class="space-y-4">
            <!-- Inquiry Item 1 -->
            <div class="p-4 border border-gray-200 rounded-lg hover:border-primary-300 transition-colors">
                <div class="flex items-start justify-between mb-3">
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 bg-primary-100 rounded-full flex items-center justify-center text-primary-700 font-semibold text-lg">
                            R
                        </div>
                        <div>
                            <h4 class="font-semibold">Rahul Kumar</h4>
                            <div class="flex items-center gap-2 text-sm text-gray-600">
                                <i class="fas fa-clock text-xs"></i>
                                <span>2 hours ago</span>
                            </div>
                        </div>
                    </div>
                    <span class="px-3 py-1 bg-green-100 text-green-700 rounded-full text-xs font-semibold">
                        New
                    </span>
                </div>
                <div class="mb-3">
                    <span class="text-sm text-gray-600">Subject: </span>
                    <span class="text-sm font-semibold text-primary-700">Payment Issue</span>
                </div>
                <div class="mb-3 p-3 bg-gray-50 rounded-lg">
                    <p class="text-gray-700 text-sm">Unable to complete payment for booking. Getting error message.</p>
                </div>
                <div class="flex items-center gap-4 mb-3 text-sm text-gray-600">
                    <div class="flex items-center gap-1">
                        <i class="fas fa-envelope text-xs"></i>
                        <span>rahul@example.com</span>
                    </div>
                    <div class="flex items-center gap-1">
                        <i class="fas fa-phone text-xs"></i>
                        <span>+91 98765 43210</span>
                    </div>
                </div>
                <div class="flex gap-2">
                    <button class="flex items-center gap-1 px-3 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 text-sm">
                        <i class="fas fa-reply"></i>
                        Reply
                    </button>
                    <button class="flex items-center gap-1 px-3 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 text-sm text-gray-700">
                        <i class="fas fa-check-circle"></i>
                        Mark as Resolved
                    </button>
                </div>
            </div>

            <!-- Inquiry Item 2 -->
            <div class="p-4 border border-gray-200 rounded-lg hover:border-primary-300 transition-colors">
                <div class="flex items-start justify-between mb-3">
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 bg-purple-100 rounded-full flex items-center justify-center text-purple-700 font-semibold text-lg">
                            P
                        </div>
                        <div>
                            <h4 class="font-semibold">Priya Sharma</h4>
                            <div class="flex items-center gap-2 text-sm text-gray-600">
                                <i class="fas fa-clock text-xs"></i>
                                <span>5 hours ago</span>
                            </div>
                        </div>
                    </div>
                    <span class="px-3 py-1 bg-blue-100 text-blue-700 rounded-full text-xs font-semibold">
                        In Progress
                    </span>
                </div>
                <div class="mb-3">
                    <span class="text-sm text-gray-600">Subject: </span>
                    <span class="text-sm font-semibold text-primary-700">Account Verification</span>
                </div>
                <div class="mb-3 p-3 bg-gray-50 rounded-lg">
                    <p class="text-gray-700 text-sm">Need help with account verification process. Documents uploaded but not verified yet.</p>
                </div>
                <div class="flex items-center gap-4 mb-3 text-sm text-gray-600">
                    <div class="flex items-center gap-1">
                        <i class="fas fa-envelope text-xs"></i>
                        <span>priya@example.com</span>
                    </div>
                    <div class="flex items-center gap-1">
                        <i class="fas fa-phone text-xs"></i>
                        <span>+91 98765 43211</span>
                    </div>
                </div>
                <div class="flex gap-2">
                    <button class="flex items-center gap-1 px-3 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 text-sm">
                        <i class="fas fa-reply"></i>
                        Reply
                    </button>
                    <button class="flex items-center gap-1 px-3 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 text-sm text-gray-700">
                        <i class="fas fa-check-circle"></i>
                        Mark as Resolved
                    </button>
                </div>
            </div>

            <!-- Inquiry Item 3 -->
            <div class="p-4 border border-gray-200 rounded-lg hover:border-primary-300 transition-colors opacity-60">
                <div class="flex items-start justify-between mb-3">
                    <div class="flex items-center gap-3">
                        <div class="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center text-green-700 font-semibold text-lg">
                            A
                        </div>
                        <div>
                            <h4 class="font-semibold">Amit Patel</h4>
                            <div class="flex items-center gap-2 text-sm text-gray-600">
                                <i class="fas fa-clock text-xs"></i>
                                <span>1 day ago</span>
                            </div>
                        </div>
                    </div>
                    <span class="px-3 py-1 bg-gray-100 text-gray-700 rounded-full text-xs font-semibold">
                        Resolved
                    </span>
                </div>
                <div class="mb-3">
                    <span class="text-sm text-gray-600">Subject: </span>
                    <span class="text-sm font-semibold text-primary-700">Refund Request</span>
                </div>
                <div class="mb-3 p-3 bg-gray-50 rounded-lg">
                    <p class="text-gray-700 text-sm">Request for refund due to cancellation. Issue has been resolved.</p>
                </div>
                <div class="text-sm text-gray-500 italic">This inquiry has been resolved</div>
            </div>
        </div>
    </div>
</div>

<style>
.space-y-6 > * + * {
    margin-top: 1.5rem;
}
.space-y-4 > * + * {
    margin-top: 1rem;
}
.gap-4 {
    gap: 1rem;
}
.gap-3 {
    gap: 0.75rem;
}
.gap-2 {
    gap: 0.5rem;
}
.gap-1 {
    gap: 0.25rem;
}
</style>
