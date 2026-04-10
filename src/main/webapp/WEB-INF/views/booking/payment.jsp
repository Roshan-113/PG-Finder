<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="bg-gray-50 min-h-screen py-8">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gray-900">Complete Payment</h1>
            <p class="text-gray-600 mt-2">Secure payment powered by Razorpay</p>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <!-- Payment Form -->
            <div class="lg:col-span-2 space-y-6">
                <!-- Razorpay Logo -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-4 flex items-center justify-between">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 bg-blue-600 rounded flex items-center justify-center">
                            <i class="fas fa-lock text-white" style="font-size: 20px;"></i>
                        </div>
                        <div>
                            <div class="font-semibold text-gray-900">Secure Payment</div>
                            <div class="text-xs text-gray-500">Powered by Razorpay</div>
                        </div>
                    </div>
                    <img src="https://razorpay.com/assets/razorpay-glyph.svg" alt="Razorpay" class="h-8" />
                </div>

                <!-- Payment Methods -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <h2 class="text-xl font-semibold text-gray-900 mb-4">Select Payment Method</h2>
                    <div class="space-y-3">
                        <label class="flex items-center gap-3 p-4 border-2 border-blue-600 bg-blue-50 rounded-lg cursor-pointer">
                            <input type="radio" name="paymentMethod" value="upi" checked class="w-5 h-5 text-blue-600">
                            <i class="fas fa-mobile-alt text-blue-600" style="font-size: 24px;"></i>
                            <div class="flex-1">
                                <div class="font-semibold text-gray-900">UPI</div>
                                <div class="text-xs text-gray-500">Pay using Google Pay, PhonePe, Paytm</div>
                            </div>
                        </label>
                        <label class="flex items-center gap-3 p-4 border border-gray-300 rounded-lg cursor-pointer hover:bg-gray-50 transition-colors">
                            <input type="radio" name="paymentMethod" value="card" class="w-5 h-5 text-blue-600">
                            <i class="fas fa-credit-card text-gray-600" style="font-size: 24px;"></i>
                            <div class="flex-1">
                                <div class="font-semibold text-gray-900">Credit/Debit Card</div>
                                <div class="text-xs text-gray-500">Visa, Mastercard, Rupay, Amex</div>
                            </div>
                        </label>
                        <label class="flex items-center gap-3 p-4 border border-gray-300 rounded-lg cursor-pointer hover:bg-gray-50 transition-colors">
                            <input type="radio" name="paymentMethod" value="netbanking" class="w-5 h-5 text-blue-600">
                            <i class="fas fa-university text-gray-600" style="font-size: 24px;"></i>
                            <div class="flex-1">
                                <div class="font-semibold text-gray-900">Net Banking</div>
                                <div class="text-xs text-gray-500">All major banks supported</div>
                            </div>
                        </label>
                        <label class="flex items-center gap-3 p-4 border border-gray-300 rounded-lg cursor-pointer hover:bg-gray-50 transition-colors">
                            <input type="radio" name="paymentMethod" value="wallet" class="w-5 h-5 text-blue-600">
                            <i class="fas fa-wallet text-gray-600" style="font-size: 24px;"></i>
                            <div class="flex-1">
                                <div class="font-semibold text-gray-900">Wallets</div>
                                <div class="text-xs text-gray-500">Paytm, PhonePe, Amazon Pay</div>
                            </div>
                        </label>
                    </div>
                </div>

                <!-- UPI Payment Form -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <h3 class="font-semibold text-gray-900 mb-4">Enter UPI ID</h3>
                    <div class="space-y-4">
                        <div>
                            <input type="text" placeholder="yourname@upi"
                                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" />
                            <p class="text-xs text-gray-500 mt-2">Enter your UPI ID (e.g., yourname@paytm)</p>
                        </div>
                    </div>

                    <button onclick="window.location.href='${pageContext.request.contextPath}/booking-success'" 
                            class="w-full mt-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 font-semibold transition-colors shadow-md">
                        <i class="fas fa-lock mr-2"></i>
                        Pay ₹22,500
                    </button>
                    
                    <div class="mt-4 flex items-center justify-center gap-2 text-xs text-gray-500">
                        <i class="fas fa-shield-alt text-green-600"></i>
                        <span>Your payment is secured with 256-bit encryption</span>
                    </div>
                </div>

                <!-- Accepted Payment Methods -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <h3 class="font-semibold text-gray-900 mb-4">We Accept</h3>
                    <div class="flex flex-wrap items-center gap-4">
                        <div class="px-3 py-2 border border-gray-200 rounded">
                            <i class="fab fa-cc-visa text-blue-600" style="font-size: 32px;"></i>
                        </div>
                        <div class="px-3 py-2 border border-gray-200 rounded">
                            <i class="fab fa-cc-mastercard text-red-600" style="font-size: 32px;"></i>
                        </div>
                        <div class="px-3 py-2 border border-gray-200 rounded">
                            <i class="fab fa-cc-amex text-blue-500" style="font-size: 32px;"></i>
                        </div>
                        <div class="px-3 py-2 border border-gray-200 rounded">
                            <i class="fas fa-mobile-alt text-purple-600" style="font-size: 32px;"></i>
                        </div>
                        <div class="px-3 py-2 border border-gray-200 rounded">
                            <i class="fas fa-university text-gray-600" style="font-size: 32px;"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Order Summary -->
            <div class="lg:col-span-1">
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 sticky top-4">
                    <h2 class="text-xl font-semibold text-gray-900 mb-4">Order Summary</h2>
                    
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
                            <span class="text-gray-600">Check-in Date:</span>
                            <span class="font-semibold text-gray-900">15 Mar 2026</span>
                        </div>
                        <div class="flex justify-between text-sm">
                            <span class="text-gray-600">Duration:</span>
                            <span class="font-semibold text-gray-900">6 Months</span>
                        </div>
                        <div class="border-t border-gray-200 pt-3 space-y-2">
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
                        </div>
                        <div class="border-t border-gray-200 pt-3 flex justify-between">
                            <span class="font-bold text-gray-900">Total Amount:</span>
                            <span class="text-2xl font-bold text-blue-600">₹22,500</span>
                        </div>
                    </div>
                    
                    <!-- Promo Code -->
                    <div class="mt-4 pt-4 border-t border-gray-200">
                        <div class="flex gap-2">
                            <input type="text" placeholder="Promo code"
                                   class="flex-1 px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500" />
                            <button class="px-4 py-2 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200 text-sm font-medium transition-colors">
                                Apply
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.space-y-2 > * + * { margin-top: 0.5rem; }
.space-y-3 > * + * { margin-top: 0.75rem; }
.space-y-4 > * + * { margin-top: 1rem; }
.space-y-6 > * + * { margin-top: 1.5rem; }
</style>
