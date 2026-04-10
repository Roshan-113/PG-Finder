<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="bg-gray-50 min-h-screen py-16">
    <div class="max-w-2xl mx-auto px-4 text-center">
        <div class="bg-white rounded-2xl shadow-lg border border-gray-100 p-12">
            <div class="w-24 h-24 mx-auto mb-6 rounded-full bg-green-100 flex items-center justify-center">
                <i class="fas fa-check text-green-600" style="font-size: 48px;"></i>
            </div>
            <h1 class="text-3xl font-bold text-gray-900 mb-4">Booking Confirmed!</h1>
            <p class="text-lg text-gray-600 mb-8">
                Your booking has been successfully confirmed. You will receive a confirmation email shortly.
            </p>

            <div class="bg-gray-50 rounded-xl p-6 mb-8 text-left">
                <h2 class="font-semibold text-gray-900 mb-4">Booking Details</h2>
                <div class="space-y-3">
                    <div class="flex justify-between">
                        <span class="text-gray-600">Booking ID:</span>
                        <span class="font-semibold">#BK123456</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-gray-600">PG Name:</span>
                        <span class="font-semibold">Sunshine PG</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-gray-600">Room Type:</span>
                        <span class="font-semibold">Double Sharing</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-gray-600">Check-in Date:</span>
                        <span class="font-semibold">Mar 15, 2026</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-gray-600">Amount Paid:</span>
                        <span class="font-semibold text-green-600">₹12,000</span>
                    </div>
                </div>
            </div>

            <div class="flex gap-4 justify-center">
                <button onclick="window.location.href='${pageContext.request.contextPath}/tenant/bookings'" 
                        class="px-6 py-3 rounded-lg font-semibold text-white"
                        style="background-color: var(--color-primary-600);">
                    View My Bookings
                </button>
                <button onclick="window.location.href='${pageContext.request.contextPath}/'" 
                        class="px-6 py-3 rounded-lg font-semibold border border-gray-300 hover:bg-gray-50">
                    Go to Home
                </button>
            </div>
        </div>
    </div>
</div>

<style>
.space-y-3 > * + * {
    margin-top: 0.75rem;
}
</style>
