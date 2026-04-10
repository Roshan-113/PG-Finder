<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="min-h-screen bg-gray-50 py-12">
    <div class="max-w-6xl mx-auto px-4">
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gray-900">Complete Your Payment</h1>
            <p class="text-gray-600 mt-2">Secure payment for your PG booking</p>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <!-- Payment Form -->
            <div class="lg:col-span-2 space-y-6">
                <!-- Payment Method Selection -->
                <div class="bg-white rounded-lg p-6 border border-gray-200">
                    <h3 class="text-lg font-bold mb-4">Select Payment Method</h3>
                    <div class="space-y-3">
                        <label class="flex items-center gap-3 p-4 border-2 border-primary-600 bg-primary-50 rounded-lg cursor-pointer">
                            <input type="radio" name="payment-method" value="upi" checked class="w-5 h-5 accent-primary-600" />
                            <div class="flex-1">
                                <div class="font-semibold text-gray-900">UPI</div>
                                <div class="text-sm text-gray-600">Pay using Google Pay, PhonePe, Paytm</div>
                            </div>
                            <i class="fas fa-mobile-alt text-2xl text-primary-600"></i>
                        </label>

                        <label class="flex items-center gap-3 p-4 border-2 border-gray-300 rounded-lg cursor-pointer hover:border-gray-400">
                            <input type="radio" name="payment-method" value="card" class="w-5 h-5 accent-primary-600" />
                            <div class="flex-1">
                                <div class="font-semibold text-gray-900">Credit/Debit Card</div>
                                <div class="text-sm text-gray-600">Visa, Mastercard, Rupay</div>
                            </div>
                            <i class="fas fa-credit-card text-2xl text-gray-400"></i>
                        </label>

                        <label class="flex items-center gap-3 p-4 border-2 border-gray-300 rounded-lg cursor-pointer hover:border-gray-400">
                            <input type="radio" name="payment-method" value="netbanking" class="w-5 h-5 accent-primary-600" />
                            <div class="flex-1">
                                <div class="font-semibold text-gray-900">Net Banking</div>
                                <div class="text-sm text-gray-600">All major banks supported</div>
                            </div>
                            <i class="fas fa-university text-2xl text-gray-400"></i>
                        </label>

                        <label class="flex items-center gap-3 p-4 border-2 border-gray-300 rounded-lg cursor-pointer hover:border-gray-400">
                            <input type="radio" name="payment-method" value="wallet" class="w-5 h-5 accent-primary-600" />
                            <div class="flex-1">
                                <div class="font-semibold text-gray-900">Wallet</div>
                                <div class="text-sm text-gray-600">Paytm, PhonePe, Amazon Pay</div>
                            </div>
                            <i class="fas fa-wallet text-2xl text-gray-400"></i>
                        </label>
                    </div>
                </div>

                <!-- UPI Payment Details -->
                <div id="upi-details" class="bg-white rounded-lg p-6 border border-gray-200">
                    <h3 class="text-lg font-bold mb-4">Enter UPI ID</h3>
                    <div class="mb-4">
                        <label class="block text-sm font-medium text-gray-700 mb-2">UPI ID</label>
                        <input type="text" placeholder="yourname@upi" class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500" />
                    </div>
                    <div class="flex gap-3">
                        <button class="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50">
                            <i class="fab fa-google-pay text-2xl"></i>
                        </button>
                        <button class="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50">
                            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/PhonePe_Logo.svg/320px-PhonePe_Logo.svg.png" alt="PhonePe" class="h-6" />
                        </button>
                        <button class="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50">
                            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Paytm_Logo_%28standalone%29.svg/320px-Paytm_Logo_%28standalone%29.svg.png" alt="Paytm" class="h-6" />
                        </button>
                    </div>
                </div>

                <!-- Card Payment Details (Hidden by default) -->
                <div id="card-details" class="bg-white rounded-lg p-6 border border-gray-200 hidden">
                    <h3 class="text-lg font-bold mb-4">Card Details</h3>
                    <div class="space-y-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Card Number</label>
                            <input type="text" placeholder="1234 5678 9012 3456" maxlength="19" class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500" />
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Cardholder Name</label>
                            <input type="text" placeholder="Name on card" class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500" />
                        </div>
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Expiry Date</label>
                                <input type="text" placeholder="MM/YY" maxlength="5" class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500" />
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">CVV</label>
                                <input type="text" placeholder="123" maxlength="3" class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500" />
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Terms and Conditions -->
                <div class="bg-white rounded-lg p-6 border border-gray-200">
                    <label class="flex items-start gap-3 cursor-pointer">
                        <input type="checkbox" class="w-5 h-5 mt-1 accent-primary-600" />
                        <div class="text-sm text-gray-700">
                            I agree to the <a href="#" class="text-primary-600 hover:text-primary-700">Terms & Conditions</a> and <a href="#" class="text-primary-600 hover:text-primary-700">Cancellation Policy</a>
                        </div>
                    </label>
                </div>

                <!-- Pay Button -->
                <button onclick="window.location.href='${pageContext.request.contextPath}/booking-confirmation'" class="w-full px-6 py-4 bg-green-600 text-white rounded-lg hover:bg-green-700 font-semibold text-lg shadow-lg transition-colors">
                    <i class="fas fa-lock mr-2"></i>
                    Pay ₹20,500 Securely
                </button>

                <!-- Security Info -->
                <div class="flex items-center justify-center gap-4 text-sm text-gray-600">
                    <div class="flex items-center gap-1">
                        <i class="fas fa-shield-alt text-green-600"></i>
                        <span>Secure Payment</span>
                    </div>
                    <div class="flex items-center gap-1">
                        <i class="fas fa-lock text-green-600"></i>
                        <span>SSL Encrypted</span>
                    </div>
                </div>
            </div>

            <!-- Booking Summary -->
            <div class="lg:col-span-1">
                <div class="bg-white rounded-lg p-6 border border-gray-200 sticky top-24">
                    <h3 class="text-lg font-bold mb-4">Booking Summary</h3>
                    
                    <!-- PG Details -->
                    <div class="mb-4 pb-4 border-b border-gray-200">
                        <img src="https://images.unsplash.com/photo-1639751907353-3629fc00d2b2?w=300" alt="PG" class="w-full h-32 object-cover rounded-lg mb-3" />
                        <h4 class="font-semibold text-gray-900 mb-1">Sunrise PG for Men</h4>
                        <div class="flex items-center gap-1 text-sm text-gray-600">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Koramangala, Bangalore</span>
                        </div>
                    </div>

                    <!-- Booking Details -->
                    <div class="space-y-3 mb-4 pb-4 border-b border-gray-200">
                        <div class="flex justify-between text-sm">
                            <span class="text-gray-600">Room Type</span>
                            <span class="font-semibold">Single Room</span>
                        </div>
                        <div class="flex justify-between text-sm">
                            <span class="text-gray-600">Move-in Date</span>
                            <span class="font-semibold">15 Mar 2024</span>
                        </div>
                        <div class="flex justify-between text-sm">
                            <span class="text-gray-600">Duration</span>
                            <span class="font-semibold">6 months</span>
                        </div>
                    </div>

                    <!-- Price Breakdown -->
                    <div class="space-y-3 mb-4 pb-4 border-b border-gray-200">
                        <div class="flex justify-between text-sm">
                            <span class="text-gray-700">Monthly Rent</span>
                            <span>₹10,000</span>
                        </div>
                        <div class="flex justify-between text-sm">
                            <span class="text-gray-700">Security Deposit</span>
                            <span>₹10,000</span>
                        </div>
                        <div class="flex justify-between text-sm">
                            <span class="text-gray-700">Service Fee</span>
                            <span>₹500</span>
                        </div>
                        <div class="flex justify-between text-sm text-green-600">
                            <span>Discount</span>
                            <span>-₹0</span>
                        </div>
                    </div>

                    <!-- Total -->
                    <div class="flex justify-between items-center mb-4">
                        <span class="text-lg font-bold text-gray-900">Total Amount</span>
                        <span class="text-2xl font-bold text-primary-600">₹20,500</span>
                    </div>

                    <!-- Promo Code -->
                    <div class="mb-4">
                        <div class="flex gap-2">
                            <input type="text" placeholder="Enter promo code" class="flex-1 px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-primary-500" />
                            <button class="px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 text-sm font-medium">
                                Apply
                            </button>
                        </div>
                    </div>

                    <!-- Info Box -->
                    <div class="p-3 bg-blue-50 rounded-lg border border-blue-200">
                        <div class="flex items-start gap-2">
                            <i class="fas fa-info-circle text-blue-600 mt-0.5"></i>
                            <p class="text-xs text-blue-900">
                                Security deposit will be refunded at the end of your stay after deducting any damages.
                            </p>
                        </div>
                    </div>
                </div>
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
.space-y-3 > * + * {
    margin-top: 0.75rem;
}
.gap-6 {
    gap: 1.5rem;
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

<script>
// Toggle payment method details
document.querySelectorAll('input[name="payment-method"]').forEach(radio => {
    radio.addEventListener('change', function() {
        document.getElementById('upi-details').classList.add('hidden');
        document.getElementById('card-details').classList.add('hidden');
        
        if (this.value === 'upi') {
            document.getElementById('upi-details').classList.remove('hidden');
        } else if (this.value === 'card') {
            document.getElementById('card-details').classList.remove('hidden');
        }
    });
});
</script>
