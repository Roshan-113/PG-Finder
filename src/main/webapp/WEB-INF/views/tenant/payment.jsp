<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="currentPage" value="payment" scope="request" />

<div class="max-w-6xl mx-auto px-6 py-8">
    <a href="${pageContext.request.contextPath}/tenant/bookings" class="flex items-center gap-2 text-gray-600 hover:text-gray-900 mb-6">
        <i class="fas fa-arrow-left"></i>
        <span>Back to Bookings</span>
    </a>

    <h1 class="text-3xl font-bold text-gray-900 mb-2">Complete Payment</h1>
    <p class="text-gray-600 mb-8">Choose your preferred payment method</p>

    <div class="grid grid-cols-3 gap-8">
        <!-- Left Side - Payment Methods -->
        <div class="col-span-2">
            <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
                <h2 class="text-xl font-bold text-gray-900 mb-2">Pay with Razorpay</h2>
                <p class="text-sm text-gray-600 mb-6">Secure payment gateway</p>

                <div class="mb-6">
                    <h3 class="font-bold text-gray-900 mb-4">Accepted Payment Methods</h3>
                    <div class="grid grid-cols-2 gap-4 text-sm text-gray-700">
                        <div>Credit/Debit Cards</div>
                        <div>UPI (GPay, PhonePe, Paytm)</div>
                        <div>Net Banking</div>
                        <div>Wallets</div>
                    </div>
                </div>

                <div class="space-y-4 mb-6">
                    <div class="flex items-start gap-3">
                        <i class="fas fa-shield-alt text-green-600 mt-1"></i>
                        <div>
                            <div class="font-semibold text-gray-900">Secure Payment</div>
                            <div class="text-sm text-gray-600">256-bit SSL encryption for all transactions</div>
                        </div>
                    </div>
                    <div class="flex items-start gap-3">
                        <i class="fas fa-check-circle text-green-600 mt-1"></i>
                        <div>
                            <div class="font-semibold text-gray-900">PCI DSS Compliant</div>
                            <div class="text-sm text-gray-600">Your card details are never stored on our servers</div>
                        </div>
                    </div>
                    <div class="flex items-start gap-3">
                        <i class="fas fa-bolt text-green-600 mt-1"></i>
                        <div>
                            <div class="font-semibold text-gray-900">Instant Confirmation</div>
                            <div class="text-sm text-gray-600">Get booking confirmation immediately after payment</div>
                        </div>
                    </div>
                </div>

                <div class="bg-yellow-50 border border-yellow-200 rounded-lg p-4 mb-6">
                    <p class="text-sm text-gray-700"><strong>Note:</strong> You will be redirected to Razorpay's secure payment page. Please complete the payment within 15 minutes to confirm your booking.</p>
                </div>

                <form id="paymentForm">
                    <input type="hidden" id="bookingId" value="${booking.bookingId}">
                    
                    <button type="button" id="razorpayButton" class="w-full py-3 rounded-lg font-semibold text-white text-lg transition-all shadow-md hover:opacity-90"
                            style="background-color: #3b82f6;">
                        Proceed to Pay ₹<fmt:formatNumber value="${booking.rentAmount + booking.securityDeposit}" pattern="#,##0"/>
                    </button>
                </form>

                <p class="text-xs text-gray-500 text-center mt-4">By proceeding, you agree to our Terms & Conditions and Cancellation Policy.</p>
            </div>
        </div>

        <!-- Right Side - Order Summary -->
        <div>
            <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm sticky top-24">
                <h2 class="text-xl font-bold text-gray-900 mb-4">Order Summary</h2>
                <h3 class="font-bold text-gray-900 mb-2">${booking.pgTitle}</h3>
                <p class="text-sm text-gray-600 mb-4">${booking.pgAddress}</p>
                
                <div class="space-y-3 mb-4">
                    <div class="flex justify-between text-sm">
                        <span class="text-gray-600">Rent Amount</span>
                        <span class="font-semibold text-gray-900">₹<fmt:formatNumber value="${booking.rentAmount}" pattern="#,##0"/></span>
                    </div>
                    <div class="flex justify-between text-sm">
                        <span class="text-gray-600">Security Deposit</span>
                        <span class="font-semibold text-gray-900">₹<fmt:formatNumber value="${booking.securityDeposit}" pattern="#,##0"/></span>
                    </div>
                    <div class="flex justify-between text-sm">
                        <span class="text-gray-600">Move-in Date</span>
                        <span class="font-semibold text-gray-900"><fmt:formatDate value="${booking.moveInDate}" pattern="dd MMM yyyy"/></span>
                    </div>
                </div>
                
                <div class="border-t border-gray-200 pt-4">
                    <div class="flex justify-between mb-2">
                        <span class="font-bold text-gray-900">Total Amount</span>
                        <span class="font-bold text-2xl text-gray-900">₹<fmt:formatNumber value="${booking.rentAmount + booking.securityDeposit}" pattern="#,##0"/></span>
                    </div>
                </div>

                <div class="bg-blue-50 rounded-lg p-3 mt-4">
                    <p class="text-xs text-gray-700">By proceeding with payment, you agree to our Terms & Conditions and Cancellation Policy.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Razorpay Checkout Script -->
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

<script>
// Store total amount as JS variable from server-side
const totalAmount = '<fmt:formatNumber value="${booking.rentAmount + booking.securityDeposit}" pattern="#,##0"/>';

document.getElementById('razorpayButton').addEventListener('click', function() {
    const button = this;
    const bookingId = document.getElementById('bookingId').value;
    
    button.disabled = true;
    button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Creating order...';
    
    fetch('${pageContext.request.contextPath}/tenant/create-razorpay-order', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'bookingId=' + bookingId
    })
    .then(response => response.json())
    .then(data => {
        if (data.error) {
            alert('Error: ' + data.error);
            button.disabled = false;
            button.innerHTML = 'Proceed to Pay ₹' + totalAmount;
            return;
        }
        
        var options = {
            "key": data.keyId,
            "amount": data.amount,
            "currency": data.currency,
            "name": "PG Finder",
            "description": "Booking Payment - ${booking.pgTitle}",
            "order_id": data.orderId,
            "prefill": {
                "name": data.tenantName || "",
                "email": data.tenantEmail || "",
                "contact": data.tenantPhone || ""
            },
            "theme": { "color": "#3b82f6" },
            "handler": function (response) {
                verifyPayment(response, bookingId);
            },
            "modal": {
                "ondismiss": function() {
                    button.disabled = false;
                    button.innerHTML = 'Proceed to Pay ₹' + totalAmount;
                }
            }
        };
        
        var rzp = new Razorpay(options);
        rzp.open();
        button.disabled = false;
        button.innerHTML = 'Proceed to Pay ₹' + totalAmount;
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Failed to initiate payment. Please try again.');
        button.disabled = false;
        button.innerHTML = 'Proceed to Pay ₹' + totalAmount;
    });
});

function verifyPayment(response, bookingId) {
    const button = document.getElementById('razorpayButton');
    button.disabled = true;
    button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Verifying payment...';
    
    fetch('${pageContext.request.contextPath}/tenant/verify-razorpay-payment', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'razorpay_order_id=' + response.razorpay_order_id +
              '&razorpay_payment_id=' + response.razorpay_payment_id +
              '&razorpay_signature=' + response.razorpay_signature +
              '&booking_id=' + bookingId
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            window.location.href = '${pageContext.request.contextPath}/tenant/booking-confirmation?bookingId=' + bookingId;
        } else {
            alert('Payment verification failed: ' + (data.error || 'Unknown error'));
            button.disabled = false;
            button.innerHTML = 'Proceed to Pay ₹' + totalAmount;
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Payment verification failed. Please contact support with your payment ID: ' + response.razorpay_payment_id);
        button.disabled = false;
        button.innerHTML = 'Proceed to Pay ₹' + totalAmount;
    });
}
</script>
