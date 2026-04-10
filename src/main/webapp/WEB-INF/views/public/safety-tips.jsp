<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="py-20 bg-gray-50">
    <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-12">
            <h1 class="text-4xl font-bold text-gray-900 mb-4">Safety Tips</h1>
            <p class="text-xl text-gray-600">Your safety is our priority. Follow these guidelines for a secure PG experience.</p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
            <!-- For Tenants -->
            <div class="bg-white rounded-xl shadow-lg p-8">
                <div class="flex items-center gap-3 mb-6">
                    <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
                        <i class="fas fa-user-shield text-blue-600 text-2xl"></i>
                    </div>
                    <h2 class="text-2xl font-bold text-gray-900">For Tenants</h2>
                </div>
                
                <div class="space-y-4">
                    <div class="flex gap-3">
                        <i class="fas fa-check-circle text-green-500 mt-1"></i>
                        <div>
                            <h4 class="font-semibold text-gray-900">Visit Before Booking</h4>
                            <p class="text-gray-600 text-sm">Always visit the PG in person before making any payment or commitment.</p>
                        </div>
                    </div>
                    
                    <div class="flex gap-3">
                        <i class="fas fa-check-circle text-green-500 mt-1"></i>
                        <div>
                            <h4 class="font-semibold text-gray-900">Verify Documents</h4>
                            <p class="text-gray-600 text-sm">Check the owner's identity proof and property documents.</p>
                        </div>
                    </div>
                    
                    <div class="flex gap-3">
                        <i class="fas fa-check-circle text-green-500 mt-1"></i>
                        <div>
                            <h4 class="font-semibold text-gray-900">Read Agreement Carefully</h4>
                            <p class="text-gray-600 text-sm">Review all terms and conditions before signing any rental agreement.</p>
                        </div>
                    </div>
                    
                    <div class="flex gap-3">
                        <i class="fas fa-check-circle text-green-500 mt-1"></i>
                        <div>
                            <h4 class="font-semibold text-gray-900">Secure Payment Methods</h4>
                            <p class="text-gray-600 text-sm">Use secure payment methods and always get receipts for all transactions.</p>
                        </div>
                    </div>
                    
                    <div class="flex gap-3">
                        <i class="fas fa-check-circle text-green-500 mt-1"></i>
                        <div>
                            <h4 class="font-semibold text-gray-900">Check Safety Features</h4>
                            <p class="text-gray-600 text-sm">Ensure the PG has proper locks, fire safety equipment, and emergency exits.</p>
                        </div>
                    </div>
                    
                    <div class="flex gap-3">
                        <i class="fas fa-check-circle text-green-500 mt-1"></i>
                        <div>
                            <h4 class="font-semibold text-gray-900">Trust Your Instincts</h4>
                            <p class="text-gray-600 text-sm">If something feels wrong, don't proceed. Your safety comes first.</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- For Owners -->
            <div class="bg-white rounded-xl shadow-lg p-8">
                <div class="flex items-center gap-3 mb-6">
                    <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center">
                        <i class="fas fa-home text-purple-600 text-2xl"></i>
                    </div>
                    <h2 class="text-2xl font-bold text-gray-900">For Owners</h2>
                </div>
                
                <div class="space-y-4">
                    <div class="flex gap-3">
                        <i class="fas fa-check-circle text-green-500 mt-1"></i>
                        <div>
                            <h4 class="font-semibold text-gray-900">Verify Tenant Identity</h4>
                            <p class="text-gray-600 text-sm">Always verify tenant's ID proof and background before renting.</p>
                        </div>
                    </div>
                    
                    <div class="flex gap-3">
                        <i class="fas fa-check-circle text-green-500 mt-1"></i>
                        <div>
                            <h4 class="font-semibold text-gray-900">Written Agreement</h4>
                            <p class="text-gray-600 text-sm">Create a detailed rental agreement covering all terms and conditions.</p>
                        </div>
                    </div>
                    
                    <div class="flex gap-3">
                        <i class="fas fa-check-circle text-green-500 mt-1"></i>
                        <div>
                            <h4 class="font-semibold text-gray-900">Maintain Safety Standards</h4>
                            <p class="text-gray-600 text-sm">Ensure your property meets all safety and legal requirements.</p>
                        </div>
                    </div>
                    
                    <div class="flex gap-3">
                        <i class="fas fa-check-circle text-green-500 mt-1"></i>
                        <div>
                            <h4 class="font-semibold text-gray-900">Accurate Listings</h4>
                            <p class="text-gray-600 text-sm">Provide honest and accurate information in your PG listings.</p>
                        </div>
                    </div>
                    
                    <div class="flex gap-3">
                        <i class="fas fa-check-circle text-green-500 mt-1"></i>
                        <div>
                            <h4 class="font-semibold text-gray-900">Regular Maintenance</h4>
                            <p class="text-gray-600 text-sm">Keep the property well-maintained and address issues promptly.</p>
                        </div>
                    </div>
                    
                    <div class="flex gap-3">
                        <i class="fas fa-check-circle text-green-500 mt-1"></i>
                        <div>
                            <h4 class="font-semibold text-gray-900">Clear Communication</h4>
                            <p class="text-gray-600 text-sm">Maintain transparent communication with tenants about rules and policies.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Warning Section -->
        <div class="mt-12 bg-red-50 border-l-4 border-red-500 p-6 rounded-lg">
            <div class="flex gap-3">
                <i class="fas fa-exclamation-triangle text-red-500 text-2xl"></i>
                <div>
                    <h3 class="text-lg font-semibold text-red-900 mb-2">Report Suspicious Activity</h3>
                    <p class="text-red-800 mb-3">If you encounter any suspicious behavior, fraud, or safety concerns, please report immediately.</p>
                    <a href="${pageContext.request.contextPath}/contact" class="inline-flex items-center gap-2 bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700">
                        <i class="fas fa-flag"></i>
                        Report Issue
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>
