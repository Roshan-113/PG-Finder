<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="max-w-5xl mx-auto px-6 py-12">
    <!-- Header -->
    <div class="text-center mb-12">
        <div class="w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-4" style="background-color: #dbeafe;">
            <i class="fas fa-question-circle" style="color: #3b82f6; font-size: 40px;"></i>
        </div>
        <h1 class="text-4xl font-bold text-gray-900 mb-4">How can we help you?</h1>
        <p class="text-lg text-gray-600">Search for answers or browse our help topics</p>
    </div>

    <!-- Search Bar -->
    <div class="max-w-2xl mx-auto mb-12">
        <div class="relative">
            <i class="fas fa-search" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: #9ca3af; font-size: 20px;"></i>
            <input type="text" placeholder="Search for help..." 
                   class="w-full px-4 py-4 border border-gray-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 shadow-sm"
                   style="padding-left: 3rem;">
        </div>
    </div>

    <!-- Contact Options -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
        <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm text-center hover:shadow-md transition-shadow">
            <div class="w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4" style="background-color: #dbeafe;">
                <i class="fas fa-phone" style="color: #3b82f6; font-size: 28px;"></i>
            </div>
            <h3 class="font-bold text-lg text-gray-900 mb-2">Call Us</h3>
            <p class="text-sm text-gray-600 mb-3">Mon-Sat 9 AM - 6 PM</p>
            <p class="font-semibold text-blue-600">+91 98765 43210</p>
        </div>

        <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm text-center hover:shadow-md transition-shadow">
            <div class="w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4" style="background-color: #dbeafe;">
                <i class="fas fa-envelope" style="color: #3b82f6; font-size: 28px;"></i>
            </div>
            <h3 class="font-bold text-lg text-gray-900 mb-2">Email Us</h3>
            <p class="text-sm text-gray-600 mb-3">We reply within 24 hours</p>
            <p class="font-semibold text-blue-600">support@pgfinder.com</p>
        </div>

        <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm text-center hover:shadow-md transition-shadow">
            <div class="w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4" style="background-color: #dbeafe;">
                <i class="fas fa-comment-dots" style="color: #3b82f6; font-size: 28px;"></i>
            </div>
            <h3 class="font-bold text-lg text-gray-900 mb-2">Live Chat</h3>
            <p class="text-sm text-gray-600 mb-3">Chat with our support team</p>
            <button class="font-semibold text-blue-600 hover:text-blue-700">Start Chat</button>
        </div>
    </div>

    <!-- FAQ Section -->
    <div class="bg-white rounded-xl p-8 border border-gray-200 shadow-sm">
        <h2 class="text-2xl font-bold text-gray-900 mb-8">Frequently Asked Questions</h2>

        <!-- Booking & Payments -->
        <div class="mb-8">
            <div class="flex items-center gap-3 mb-4">
                <i class="fas fa-credit-card text-gray-700" style="font-size: 20px;"></i>
                <h3 class="text-xl font-bold text-gray-900">Booking & Payments</h3>
            </div>
            <div class="space-y-3">
                <div class="p-4 hover:bg-gray-50 rounded-lg cursor-pointer transition-colors">
                    <div class="flex items-center justify-between">
                        <span class="text-gray-700">How do I book a PG?</span>
                        <i class="fas fa-chevron-right text-gray-400"></i>
                    </div>
                </div>
                <div class="p-4 hover:bg-gray-50 rounded-lg cursor-pointer transition-colors">
                    <div class="flex items-center justify-between">
                        <span class="text-gray-700">What payment methods are accepted?</span>
                        <i class="fas fa-chevron-right text-gray-400"></i>
                    </div>
                </div>
                <div class="p-4 hover:bg-gray-50 rounded-lg cursor-pointer transition-colors">
                    <div class="flex items-center justify-between">
                        <span class="text-gray-700">Can I cancel my booking?</span>
                        <i class="fas fa-chevron-right text-gray-400"></i>
                    </div>
                </div>
                <div class="p-4 hover:bg-gray-50 rounded-lg cursor-pointer transition-colors">
                    <div class="flex items-center justify-between">
                        <span class="text-gray-700">How do I get a refund?</span>
                        <i class="fas fa-chevron-right text-gray-400"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Account & Profile -->
        <div class="mb-8">
            <div class="flex items-center gap-3 mb-4">
                <i class="fas fa-user text-gray-700" style="font-size: 20px;"></i>
                <h3 class="text-xl font-bold text-gray-900">Account & Profile</h3>
            </div>
            <div class="space-y-3">
                <div class="p-4 hover:bg-gray-50 rounded-lg cursor-pointer transition-colors">
                    <div class="flex items-center justify-between">
                        <span class="text-gray-700">How do I update my profile?</span>
                        <i class="fas fa-chevron-right text-gray-400"></i>
                    </div>
                </div>
                <div class="p-4 hover:bg-gray-50 rounded-lg cursor-pointer transition-colors">
                    <div class="flex items-center justify-between">
                        <span class="text-gray-700">How do I change my password?</span>
                        <i class="fas fa-chevron-right text-gray-400"></i>
                    </div>
                </div>
                <div class="p-4 hover:bg-gray-50 rounded-lg cursor-pointer transition-colors">
                    <div class="flex items-center justify-between">
                        <span class="text-gray-700">I forgot my password</span>
                        <i class="fas fa-chevron-right text-gray-400"></i>
                    </div>
                </div>
                <div class="p-4 hover:bg-gray-50 rounded-lg cursor-pointer transition-colors">
                    <div class="flex items-center justify-between">
                        <span class="text-gray-700">How do I delete my account?</span>
                        <i class="fas fa-chevron-right text-gray-400"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- PG Search & Listings -->
        <div>
            <div class="flex items-center gap-3 mb-4">
                <i class="fas fa-search text-gray-700" style="font-size: 20px;"></i>
                <h3 class="text-xl font-bold text-gray-900">PG Search & Listings</h3>
            </div>
            <div class="space-y-3">
                <div class="p-4 hover:bg-gray-50 rounded-lg cursor-pointer transition-colors">
                    <div class="flex items-center justify-between">
                        <span class="text-gray-700">How do I search for PGs?</span>
                        <i class="fas fa-chevron-right text-gray-400"></i>
                    </div>
                </div>
                <div class="p-4 hover:bg-gray-50 rounded-lg cursor-pointer transition-colors">
                    <div class="flex items-center justify-between">
                        <span class="text-gray-700">How do I save a PG?</span>
                        <i class="fas fa-chevron-right text-gray-400"></i>
                    </div>
                </div>
                <div class="p-4 hover:bg-gray-50 rounded-lg cursor-pointer transition-colors">
                    <div class="flex items-center justify-between">
                        <span class="text-gray-700">Are the PG listings verified?</span>
                        <i class="fas fa-chevron-right text-gray-400"></i>
                    </div>
                </div>
                <div class="p-4 hover:bg-gray-50 rounded-lg cursor-pointer transition-colors">
                    <div class="flex items-center justify-between">
                        <span class="text-gray-700">Can I contact the owner directly?</span>
                        <i class="fas fa-chevron-right text-gray-400"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.space-y-3 > * + * {
    margin-top: 0.75rem;
}
</style>
