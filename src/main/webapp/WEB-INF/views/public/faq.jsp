<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQs - PG Finder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <%@ include file="../common/navbar.jsp" %>
    
    <div class="max-w-4xl mx-auto px-6 py-16">
        <div class="text-center mb-12">
            <h1 class="text-4xl font-bold text-gray-900 mb-4">Frequently Asked Questions</h1>
            <p class="text-lg text-gray-600">Find answers to common questions about PG Finder</p>
        </div>
        
        <div class="space-y-4">
            <!-- General Questions -->
            <div class="mb-8">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">General Questions</h2>
                
                <details class="group bg-white rounded-xl border border-gray-200 mb-4">
                    <summary class="flex justify-between items-center cursor-pointer p-6 hover:bg-gray-50">
                        <span class="font-semibold text-gray-900">What is PG Finder?</span>
                        <i class="fas fa-chevron-down group-open:rotate-180 transition-transform text-gray-400"></i>
                    </summary>
                    <div class="px-6 pb-6 text-gray-700 leading-relaxed">
                        PG Finder is a platform that connects people looking for PG accommodations with property owners. We help you find verified PGs, compatible roommates, and make the entire process hassle-free.
                    </div>
                </details>
                
                <details class="group bg-white rounded-xl border border-gray-200 mb-4">
                    <summary class="flex justify-between items-center cursor-pointer p-6 hover:bg-gray-50">
                        <span class="font-semibold text-gray-900">Is PG Finder free to use?</span>
                        <i class="fas fa-chevron-down group-open:rotate-180 transition-transform text-gray-400"></i>
                    </summary>
                    <div class="px-6 pb-6 text-gray-700 leading-relaxed">
                        Yes! PG Finder is completely free for tenants to search and book PGs. Property owners can also list their PGs for free.
                    </div>
                </details>
                
                <details class="group bg-white rounded-xl border border-gray-200 mb-4">
                    <summary class="flex justify-between items-center cursor-pointer p-6 hover:bg-gray-50">
                        <span class="font-semibold text-gray-900">Which cities do you cover?</span>
                        <i class="fas fa-chevron-down group-open:rotate-180 transition-transform text-gray-400"></i>
                    </summary>
                    <div class="px-6 pb-6 text-gray-700 leading-relaxed">
                        We currently cover major cities across India including Bangalore, Mumbai, Delhi, Pune, Hyderabad, Chennai, and more. We're constantly expanding to new cities.
                    </div>
                </details>
            </div>
            
            <!-- For Tenants -->
            <div class="mb-8">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">For Tenants</h2>
                
                <details class="group bg-white rounded-xl border border-gray-200 mb-4">
                    <summary class="flex justify-between items-center cursor-pointer p-6 hover:bg-gray-50">
                        <span class="font-semibold text-gray-900">How do I search for a PG?</span>
                        <i class="fas fa-chevron-down group-open:rotate-180 transition-transform text-gray-400"></i>
                    </summary>
                    <div class="px-6 pb-6 text-gray-700 leading-relaxed">
                        Simply enter your preferred city, budget, and gender preference in the search bar on our homepage. You can also use advanced filters to refine your search based on amenities, room type, and more.
                    </div>
                </details>
                
                <details class="group bg-white rounded-xl border border-gray-200 mb-4">
                    <summary class="flex justify-between items-center cursor-pointer p-6 hover:bg-gray-50">
                        <span class="font-semibold text-gray-900">How do I book a PG?</span>
                        <i class="fas fa-chevron-down group-open:rotate-180 transition-transform text-gray-400"></i>
                    </summary>
                    <div class="px-6 pb-6 text-gray-700 leading-relaxed">
                        Once you find a PG you like, click "View Details" to see more information. Then click "Book Now" to fill in your details and confirm your booking. The owner will contact you to finalize the arrangement.
                    </div>
                </details>
                
                <details class="group bg-white rounded-xl border border-gray-200 mb-4">
                    <summary class="flex justify-between items-center cursor-pointer p-6 hover:bg-gray-50">
                        <span class="font-semibold text-gray-900">Can I visit the PG before booking?</span>
                        <i class="fas fa-chevron-down group-open:rotate-180 transition-transform text-gray-400"></i>
                    </summary>
                    <div class="px-6 pb-6 text-gray-700 leading-relaxed">
                        Absolutely! We highly recommend visiting the PG and meeting the owner before making any commitments. Use the contact information provided to schedule a visit.
                    </div>
                </details>
                
                <details class="group bg-white rounded-xl border border-gray-200 mb-4">
                    <summary class="flex justify-between items-center cursor-pointer p-6 hover:bg-gray-50">
                        <span class="font-semibold text-gray-900">How does the roommate matching work?</span>
                        <i class="fas fa-chevron-down group-open:rotate-180 transition-transform text-gray-400"></i>
                    </summary>
                    <div class="px-6 pb-6 text-gray-700 leading-relaxed">
                        Our roommate matching feature helps you find compatible roommates based on lifestyle preferences, habits, and interests. You can browse profiles and connect with potential roommates directly.
                    </div>
                </details>
            </div>
            
            <!-- For Owners -->
            <div class="mb-8">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">For PG Owners</h2>
                
                <details class="group bg-white rounded-xl border border-gray-200 mb-4">
                    <summary class="flex justify-between items-center cursor-pointer p-6 hover:bg-gray-50">
                        <span class="font-semibold text-gray-900">How do I list my PG?</span>
                        <i class="fas fa-chevron-down group-open:rotate-180 transition-transform text-gray-400"></i>
                    </summary>
                    <div class="px-6 pb-6 text-gray-700 leading-relaxed">
                        Register as an owner, go to your dashboard, and click "Add New PG". Fill in all the required details including photos, amenities, pricing, and location. Your listing will be reviewed and activated within 24 hours.
                    </div>
                </details>
                
                <details class="group bg-white rounded-xl border border-gray-200 mb-4">
                    <summary class="flex justify-between items-center cursor-pointer p-6 hover:bg-gray-50">
                        <span class="font-semibold text-gray-900">How long does verification take?</span>
                        <i class="fas fa-chevron-down group-open:rotate-180 transition-transform text-gray-400"></i>
                    </summary>
                    <div class="px-6 pb-6 text-gray-700 leading-relaxed">
                        Our team typically reviews and verifies new listings within 24-48 hours. You'll receive an email notification once your listing is approved.
                    </div>
                </details>
                
                <details class="group bg-white rounded-xl border border-gray-200 mb-4">
                    <summary class="flex justify-between items-center cursor-pointer p-6 hover:bg-gray-50">
                        <span class="font-semibold text-gray-900">Can I edit my listing after posting?</span>
                        <i class="fas fa-chevron-down group-open:rotate-180 transition-transform text-gray-400"></i>
                    </summary>
                    <div class="px-6 pb-6 text-gray-700 leading-relaxed">
                        Yes, you can edit your listing anytime from your owner dashboard. Changes to pricing or major details may require re-verification.
                    </div>
                </details>
            </div>
            
            <!-- Payment & Security -->
            <div class="mb-8">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">Payment & Security</h2>
                
                <details class="group bg-white rounded-xl border border-gray-200 mb-4">
                    <summary class="flex justify-between items-center cursor-pointer p-6 hover:bg-gray-50">
                        <span class="font-semibold text-gray-900">How do payments work?</span>
                        <i class="fas fa-chevron-down group-open:rotate-180 transition-transform text-gray-400"></i>
                    </summary>
                    <div class="px-6 pb-6 text-gray-700 leading-relaxed">
                        All payment transactions are directly between tenants and PG owners. PG Finder does not handle payments. We recommend using secure payment methods and getting proper receipts.
                    </div>
                </details>
                
                <details class="group bg-white rounded-xl border border-gray-200 mb-4">
                    <summary class="flex justify-between items-center cursor-pointer p-6 hover:bg-gray-50">
                        <span class="font-semibold text-gray-900">Is my personal information safe?</span>
                        <i class="fas fa-chevron-down group-open:rotate-180 transition-transform text-gray-400"></i>
                    </summary>
                    <div class="px-6 pb-6 text-gray-700 leading-relaxed">
                        Yes, we take data security seriously. Your personal information is encrypted and stored securely. We never share your data with third parties without your consent. Read our Privacy Policy for more details.
                    </div>
                </details>
                
                <details class="group bg-white rounded-xl border border-gray-200 mb-4">
                    <summary class="flex justify-between items-center cursor-pointer p-6 hover:bg-gray-50">
                        <span class="font-semibold text-gray-900">What if I face issues with a PG?</span>
                        <i class="fas fa-chevron-down group-open:rotate-180 transition-transform text-gray-400"></i>
                    </summary>
                    <div class="px-6 pb-6 text-gray-700 leading-relaxed">
                        Contact our support team immediately at support@pgfinder.com or call +91 98765 43210. We'll help mediate and resolve the issue. You can also report listings that violate our terms.
                    </div>
                </details>
            </div>
        </div>
        
        <!-- Still have questions -->
        <div class="bg-blue-50 rounded-xl p-8 text-center mt-12">
            <i class="fas fa-question-circle text-blue-600 text-4xl mb-4"></i>
            <h3 class="text-2xl font-bold text-gray-900 mb-2">Still have questions?</h3>
            <p class="text-gray-600 mb-6">Can't find the answer you're looking for? Contact our support team.</p>
            <a href="${pageContext.request.contextPath}/contact" 
               class="inline-block px-6 py-3 bg-blue-600 text-white rounded-lg font-semibold hover:bg-blue-700 transition-colors">
                Contact Support
            </a>
        </div>
    </div>
    
    <%@ include file="../common/footer.jsp" %>
</body>
</html>
