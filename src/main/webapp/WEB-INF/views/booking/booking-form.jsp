<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="bg-gray-50 min-h-screen py-8">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gray-900">Book Your PG</h1>
            <p class="text-gray-600 mt-2">Complete your booking details</p>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <!-- Left Side - Form -->
            <div class="lg:col-span-2">
                <form action="${pageContext.request.contextPath}/booking" method="post" onsubmit="return validateForm()" class="space-y-6">
            <!-- Personal Details -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
                <h2 class="text-xl font-semibold text-gray-900 mb-4">Personal Details</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Full Name *</label>
                        <input type="text" name="fullName" required
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500" />
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Email *</label>
                        <input type="email" name="email" required
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500" />
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Phone *</label>
                        <input type="tel" name="phone" required
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500" />
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Occupation *</label>
                        <select name="occupation" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500">
                            <option value="">Select Occupation</option>
                            <option value="student">Student</option>
                            <option value="professional">Working Professional</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Booking Details -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
                <h2 class="text-xl font-semibold text-gray-900 mb-4">Booking Details</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Room Type *</label>
                        <select name="roomType" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500">
                            <option value="">Select Room Type</option>
                            <option value="single">Single Room - ₹15,000</option>
                            <option value="double">Double Sharing - ₹12,000</option>
                            <option value="triple">Triple Sharing - ₹9,000</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Check-in Date *</label>
                        <input type="date" name="checkinDate" required
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500" />
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Duration *</label>
                        <select name="duration" required
                                class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500">
                            <option value="">Select Duration</option>
                            <option value="3">3 Months</option>
                            <option value="6">6 Months</option>
                            <option value="12">12 Months</option>
                        </select>
                    </div>
                </div>
            </div>

                    <!-- Submit -->
                    <div class="flex gap-4">
                        <button type="submit" class="flex-1 px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 font-semibold transition-colors">
                            Proceed to Payment
                        </button>
                        <button type="button" onclick="window.history.back()" 
                                class="px-6 py-3 rounded-lg font-semibold border border-gray-300 hover:bg-gray-50 transition-colors">
                            Cancel
                        </button>
                    </div>
                </form>
            </div>

            <!-- Right Side - Booking Summary -->
            <div class="lg:col-span-1">
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 sticky top-4">
                    <h2 class="text-xl font-semibold text-gray-900 mb-4">Booking Summary</h2>
                    
                    <!-- PG Image -->
                    <div class="mb-4">
                        <div class="h-40 bg-gradient-to-br from-blue-100 to-blue-200 rounded-lg flex items-center justify-center text-5xl">
                            🏠
                        </div>
                    </div>
                    
                    <!-- PG Details -->
                    <div class="mb-4">
                        <h3 class="text-lg font-bold text-gray-900 mb-1">Sunshine PG</h3>
                        <div class="flex items-center gap-1 text-sm text-gray-600 mb-2">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Koramangala, Bangalore</span>
                        </div>
                        <div class="flex items-center gap-1 text-yellow-600">
                            <i class="fas fa-star"></i>
                            <span class="font-semibold">4.5</span>
                            <span class="text-sm text-gray-500">(120 reviews)</span>
                        </div>
                    </div>
                    
                    <!-- Price Breakdown -->
                    <div class="border-t border-gray-200 pt-4 space-y-3">
                        <div class="flex justify-between text-sm">
                            <span class="text-gray-600">Room Type:</span>
                            <span class="font-semibold text-gray-900">Double Sharing</span>
                        </div>
                        <div class="flex justify-between text-sm">
                            <span class="text-gray-600">Monthly Rent:</span>
                            <span class="font-semibold text-gray-900">₹12,000</span>
                        </div>
                        <div class="flex justify-between text-sm">
                            <span class="text-gray-600">Security Deposit:</span>
                            <span class="font-semibold text-gray-900">₹10,000</span>
                        </div>
                        <div class="flex justify-between text-sm">
                            <span class="text-gray-600">Service Fee:</span>
                            <span class="font-semibold text-gray-900">₹500</span>
                        </div>
                        <div class="border-t border-gray-200 pt-3 flex justify-between">
                            <span class="font-bold text-gray-900">Total Amount:</span>
                            <span class="text-2xl font-bold text-blue-600">₹22,500</span>
                        </div>
                    </div>
                    
                    <!-- Amenities -->
                    <div class="mt-4 pt-4 border-t border-gray-200">
                        <h4 class="text-sm font-semibold text-gray-900 mb-2">Amenities</h4>
                        <div class="flex flex-wrap gap-2">
                            <span class="px-2 py-1 bg-blue-50 text-blue-700 text-xs rounded-md">WiFi</span>
                            <span class="px-2 py-1 bg-blue-50 text-blue-700 text-xs rounded-md">AC</span>
                            <span class="px-2 py-1 bg-blue-50 text-blue-700 text-xs rounded-md">Food</span>
                            <span class="px-2 py-1 bg-blue-50 text-blue-700 text-xs rounded-md">Laundry</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function validateForm() {
    const fullName = document.querySelector('input[name="fullName"]').value.trim();
    const email = document.querySelector('input[name="email"]').value.trim();
    const phone = document.querySelector('input[name="phone"]').value.trim();
    const occupation = document.querySelector('select[name="occupation"]').value;
    const roomType = document.querySelector('select[name="roomType"]').value;
    const checkinDate = document.querySelector('input[name="checkinDate"]').value;
    const duration = document.querySelector('select[name="duration"]').value;
    
    if (!fullName || !email || !phone || !occupation || !roomType || !checkinDate || !duration) {
        alert('Please fill in all required fields');
        return false;
    }
    
    // Validate email format
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        alert('Please enter a valid email address');
        return false;
    }
    
    // Validate phone format (10 digits)
    const phoneRegex = /^\d{10}$/;
    if (!phoneRegex.test(phone)) {
        alert('Please enter a valid 10-digit phone number');
        return false;
    }
    
    return true;
}
</script>

<style>
.space-y-6 > * + * { margin-top: 1.5rem; }
.space-y-3 > * + * { margin-top: 0.75rem; }
</style>
