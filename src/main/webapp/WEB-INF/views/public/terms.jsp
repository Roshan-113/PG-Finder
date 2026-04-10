<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Terms of Service - PG Finder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <%@ include file="../common/navbar.jsp" %>
    
    <div class="max-w-4xl mx-auto px-6 py-16">
        <h1 class="text-4xl font-bold text-gray-900 mb-4">Terms of Service</h1>
        <p class="text-gray-600 mb-8">Last updated: April 7, 2026</p>
        
        <div class="prose max-w-none">
            <div class="bg-white rounded-xl p-8 border border-gray-200 mb-6">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">1. Acceptance of Terms</h2>
                <p class="text-gray-700 leading-relaxed mb-4">
                    By accessing and using PG Finder, you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to these terms, please do not use our service.
                </p>
            </div>
            
            <div class="bg-white rounded-xl p-8 border border-gray-200 mb-6">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">2. Use of Service</h2>
                <p class="text-gray-700 leading-relaxed mb-4">
                    PG Finder provides a platform for connecting PG owners with potential tenants. You agree to:
                </p>
                <ul class="list-disc pl-6 text-gray-700 space-y-2">
                    <li>Provide accurate and complete information</li>
                    <li>Maintain the security of your account</li>
                    <li>Not use the service for any illegal purposes</li>
                    <li>Not post false or misleading information</li>
                    <li>Respect other users and their privacy</li>
                </ul>
            </div>
            
            <div class="bg-white rounded-xl p-8 border border-gray-200 mb-6">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">3. User Accounts</h2>
                <p class="text-gray-700 leading-relaxed mb-4">
                    You are responsible for maintaining the confidentiality of your account credentials. You agree to notify us immediately of any unauthorized use of your account.
                </p>
            </div>
            
            <div class="bg-white rounded-xl p-8 border border-gray-200 mb-6">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">4. Listings and Content</h2>
                <p class="text-gray-700 leading-relaxed mb-4">
                    PG owners are responsible for the accuracy of their listings. PG Finder does not guarantee the accuracy of any listing information. Users should verify all details before making any commitments.
                </p>
            </div>
            
            <div class="bg-white rounded-xl p-8 border border-gray-200 mb-6">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">5. Payments and Fees</h2>
                <p class="text-gray-700 leading-relaxed mb-4">
                    All payment transactions are between tenants and PG owners. PG Finder is not responsible for any payment disputes or issues.
                </p>
            </div>
            
            <div class="bg-white rounded-xl p-8 border border-gray-200 mb-6">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">6. Limitation of Liability</h2>
                <p class="text-gray-700 leading-relaxed mb-4">
                    PG Finder shall not be liable for any indirect, incidental, special, consequential, or punitive damages resulting from your use of the service.
                </p>
            </div>
            
            <div class="bg-white rounded-xl p-8 border border-gray-200 mb-6">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">7. Termination</h2>
                <p class="text-gray-700 leading-relaxed mb-4">
                    We reserve the right to terminate or suspend your account at any time for violations of these terms or for any other reason at our discretion.
                </p>
            </div>
            
            <div class="bg-white rounded-xl p-8 border border-gray-200 mb-6">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">8. Changes to Terms</h2>
                <p class="text-gray-700 leading-relaxed mb-4">
                    We reserve the right to modify these terms at any time. Continued use of the service after changes constitutes acceptance of the new terms.
                </p>
            </div>
            
            <div class="bg-white rounded-xl p-8 border border-gray-200">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">9. Contact Us</h2>
                <p class="text-gray-700 leading-relaxed mb-4">
                    If you have any questions about these Terms of Service, please contact us at:
                </p>
                <p class="text-gray-700">
                    <strong>Email:</strong> support@pgfinder.com<br>
                    <strong>Phone:</strong> +91 98765 43210
                </p>
            </div>
        </div>
    </div>
    
    <%@ include file="../common/footer.jsp" %>
</body>
</html>
