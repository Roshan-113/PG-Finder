<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="currentPage" value="booking" scope="request" />

<div class="max-w-6xl mx-auto px-6 py-8">
    <h1 class="text-3xl font-bold text-gray-900 mb-2">Complete Your Booking</h1>
    <p class="text-gray-600 mb-8">Fill in the details below to book your stay</p>

    <form id="bookingForm" method="post" action="${pageContext.request.contextPath}/tenant/book-pg">
        <input type="hidden" name="listingId" value="${listing.listingId}">
        
        <div class="grid grid-cols-3 gap-8">
            <!-- Left Side - Form -->
            <div class="col-span-2 space-y-6">
                <!-- Property Details -->
                <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                    <h2 class="text-xl font-bold text-gray-900 mb-4">Property Details</h2>
                    <div class="flex items-center gap-4">
                        <div class="text-4xl">🏠</div>
                        <div>
                            <h3 class="font-bold text-lg text-gray-900">${listing.title}</h3>
                            <p class="text-sm text-gray-600">${listing.address}, ${listing.city}</p>
                            <p class="text-lg font-bold text-gray-900 mt-1">₹<fmt:formatNumber value="${listing.rentPerMonth}" pattern="#,##0"/>/month</p>
                        </div>
                    </div>
                </div>

                <!-- Booking Details -->
                <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                    <h2 class="text-xl font-bold text-gray-900 mb-4">Booking Details</h2>
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Move-in Date *</label>
                            <input type="date" id="moveInDate" name="moveInDate"
                                   min="<fmt:formatDate value='<%= new java.util.Date() %>' pattern='yyyy-MM-dd'/>"
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <span id="moveInDateError" class="text-red-600 text-sm hidden"></span>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Duration (Months) *</label>
                            <input type="number" id="duration" name="duration" value="1" min="1" max="12"
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <span id="durationError" class="text-red-600 text-sm hidden"></span>
                        </div>
                    </div>
                </div>

                <!-- Personal Details -->
                <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                    <h2 class="text-xl font-bold text-gray-900 mb-4">Personal Details</h2>
                    <div class="space-y-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Full Name *</label>
                            <input type="text" id="fullName" name="fullName" value="${sessionScope.userName}"
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <span id="fullNameError" class="text-red-600 text-sm hidden"></span>
                        </div>
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Email *</label>
                                <input type="email" id="email" name="email" value="${sessionScope.userEmail}" readonly
                                       class="w-full px-4 py-2 border border-gray-300 rounded-lg bg-gray-50 cursor-not-allowed">
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">Phone Number *</label>
                                <input type="tel" id="phone" name="phone" placeholder="10-digit number" maxlength="10"
                                       value="${sessionScope.userPhone}"
                                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <span id="phoneError" class="text-red-600 text-sm hidden"></span>
                            </div>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Special Requests (Optional)</label>
                            <textarea rows="3" id="specialRequests" name="specialRequests" placeholder="Any special requirements or requests..."
                                      class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"></textarea>
                        </div>
                    </div>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="w-full py-3 rounded-lg font-semibold text-white text-lg transition-all shadow-md"
                        style="background-color: #2563eb;" onmouseover="this.style.backgroundColor='#1d4ed8'" onmouseout="this.style.backgroundColor='#2563eb'">
                    <i class="fas fa-check-circle mr-2"></i>Confirm Booking
                </button>
            </div>

            <!-- Right Side - Summary -->
            <div>
                <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm sticky top-24">
                    <h2 class="text-xl font-bold text-gray-900 mb-4">Booking Summary</h2>
                    <div class="space-y-3 mb-4">
                        <div class="flex justify-between text-sm">
                            <span class="text-gray-600">Monthly Rent</span>
                            <span class="font-semibold text-gray-900">₹<fmt:formatNumber value="${listing.rentPerMonth}" pattern="#,##0"/></span>
                        </div>
                        <div class="flex justify-between text-sm">
                            <span class="text-gray-600">Security Deposit</span>
                            <span class="font-semibold text-gray-900">₹<fmt:formatNumber value="${listing.securityDeposit}" pattern="#,##0"/></span>
                        </div>
                        <div class="flex justify-between text-sm">
                            <span class="text-gray-600">Duration</span>
                            <span class="font-semibold text-gray-900" id="durationDisplay">1 month(s)</span>
                        </div>
                    </div>
                    <div class="border-t border-gray-200 pt-4 mb-4">
                        <div class="flex justify-between">
                            <span class="font-bold text-gray-900">Total Amount</span>
                            <span class="font-bold text-2xl text-gray-900" id="totalAmount">₹<fmt:formatNumber value="${listing.rentPerMonth + listing.securityDeposit}" pattern="#,##0"/></span>
                        </div>
                    </div>
                    <div class="bg-blue-50 rounded-lg p-3">
                        <p class="text-xs text-gray-700"><strong>Note:</strong> Your booking will be confirmed after submission. The owner will contact you for payment details.</p>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
// Form validation
document.getElementById('bookingForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    let isValid = true;
    
    // Reset all error styles
    document.querySelectorAll('.border-red-500').forEach(el => {
        el.classList.remove('border-red-500');
        el.classList.add('border-gray-300');
    });
    
    // Validate move-in date
    const moveInDate = document.getElementById('moveInDate');
    const moveInDateError = document.getElementById('moveInDateError');
    if (!moveInDate.value) {
        moveInDateError.textContent = 'Please select a move-in date';
        moveInDateError.classList.remove('hidden');
        moveInDate.classList.remove('border-gray-300');
        moveInDate.classList.add('border-red-500');
        isValid = false;
    } else {
        const selectedDate = new Date(moveInDate.value);
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        if (selectedDate < today) {
            moveInDateError.textContent = 'Move-in date cannot be in the past';
            moveInDateError.classList.remove('hidden');
            moveInDate.classList.remove('border-gray-300');
            moveInDate.classList.add('border-red-500');
            isValid = false;
        } else {
            moveInDateError.classList.add('hidden');
        }
    }
    
    // Validate duration
    const duration = document.getElementById('duration');
    const durationError = document.getElementById('durationError');
    if (!duration.value || duration.value < 1 || duration.value > 12) {
        durationError.textContent = 'Duration must be between 1 and 12 months';
        durationError.classList.remove('hidden');
        duration.classList.remove('border-gray-300');
        duration.classList.add('border-red-500');
        isValid = false;
    } else {
        durationError.classList.add('hidden');
    }
    
    // Validate full name
    const fullName = document.getElementById('fullName');
    const fullNameError = document.getElementById('fullNameError');
    if (!fullName.value.trim()) {
        fullNameError.textContent = 'Full name is required';
        fullNameError.classList.remove('hidden');
        fullName.classList.remove('border-gray-300');
        fullName.classList.add('border-red-500');
        isValid = false;
    } else {
        fullNameError.classList.add('hidden');
    }
    
    // Validate phone
    const phone = document.getElementById('phone');
    const phoneError = document.getElementById('phoneError');
    if (!phone.value.trim()) {
        phoneError.textContent = 'Phone number is required';
        phoneError.classList.remove('hidden');
        phone.classList.remove('border-gray-300');
        phone.classList.add('border-red-500');
        isValid = false;
    } else if (!/^\d{10}$/.test(phone.value.trim())) {
        phoneError.textContent = 'Phone number must be exactly 10 digits';
        phoneError.classList.remove('hidden');
        phone.classList.remove('border-gray-300');
        phone.classList.add('border-red-500');
        isValid = false;
    } else {
        phoneError.classList.add('hidden');
    }
    
    if (isValid) {
        this.submit();
    } else {
        // Scroll to first error
        const firstError = document.querySelector('.text-red-600:not(.hidden)');
        if (firstError) {
            firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
    }
});

// Update duration display and total amount
const monthlyRent = ${listing.rentPerMonth};
const securityDeposit = ${listing.securityDeposit};

function updateTotal() {
    const duration = parseInt(document.getElementById('duration').value) || 1;
    document.getElementById('durationDisplay').textContent = duration + ' month(s)';
    
    // Calculate total: (Monthly Rent × Duration) + Security Deposit
    const totalRent = monthlyRent * duration;
    const totalAmount = totalRent + securityDeposit;
    
    // Format with Indian number format
    document.getElementById('totalAmount').textContent = '₹' + totalAmount.toLocaleString('en-IN');
}

document.getElementById('duration').addEventListener('input', updateTotal);

// Initialize on page load
updateTotal();

// Phone number validation - only allow digits
document.getElementById('phone').addEventListener('input', function() {
    this.value = this.value.replace(/\D/g, '');
});

// Remove red border on input
document.querySelectorAll('input').forEach(input => {
    input.addEventListener('input', function() {
        if (this.classList.contains('border-red-500')) {
            this.classList.remove('border-red-500');
            this.classList.add('border-gray-300');
        }
    });
});
</script>

<style>
.border-red-500 {
    border-color: #ef4444 !important;
}
.border-gray-300 {
    border-color: #d1d5db;
}
</style>
