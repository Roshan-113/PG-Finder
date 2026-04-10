<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Privacy Policy - PG Finder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <%@ include file="../common/navbar.jsp" %>
    
    <div class="max-w-4xl mx-auto px-6 py-16">
        <h1 class="text-4xl font-bold text-gray-900 mb-4">Privacy Policy</h1>
        <p class="text-gray-600 mb-8">Last updated: April 7, 2026</p>
        
        <div class="prose max-w-none">
            <div class="bg-white rounded-xl p-8 border border-gray-200 mb-6">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">1. Information We Collect</h2>
                <p class="text-gray-700 leading-relaxed mb-4">
                    We collect information that you provide directly to us, including:
                </p>
                <ul class="list-disc pl-6 text-gray-700 space-y-2">
                    <li>Name, email address, and phone number</li>
                    <li>Profile information and preferences</li>
                    <li>PG listing details (for owners)</li>
                    <li>Messages and communications</li>
                    <li>Payment information (processed securely)</li>
                </ul>
            </div>
            
            <div class="bg-white rounded-xl p-8 border border-gray-200 mb-6">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">2. How We Use Your Information</h2>
                <p class="text-gray-700 leading-relaxed mb-4">
                    We use the information we collect to:
                </p>
                <ul class="list-disc pl-6 text-gray-700 space-y-2">
                    <li>Provide and improve our services</li>
                    <li>Connect tenants with PG owners</li>
                    <li>Send you updates and notifications</li>
                    <li>Respond to your inquiries and support requests</li>
                    <li>Prevent fraud and ensure platform security</li>
                </ul>
            </div>
            
            <div class="bg-white rounded-xl p-8 border border-gray-200 mb-6">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">3. Information Sharing</h2>
                <p class="text-gray-700 leading-relaxed mb-4">
                    We do not sell your personal information. We may share your information:
                </p>
                <ul class="list-disc pl-6 text-gray-700 space-y-2">
                    <li>With PG owners when you inquire about a listing</li>
                    <li>With service providers who assist our operations</li>
                    <li>When required by law or to protect our rights</li>
                    <li>With your consent or at your direction</li>
                </ul>
            </div>
            
            <div class="bg-white rounded-xl p-8 border border-gray-200 mb-6">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">4. Data Security</h2>
                <p class="text-gray-700 leading-relaxed mb-4">
                    We implement appropriate security measures to protect your personal information. However, no method of transmission over the internet is 100% secure.
                </p>
            </div>
            
            <div class="bg-white rounded-xl p-8 border border-gray-200 mb-6">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">5. Cookies and Tracking</h2>
                <p class="text-gray-700 leading-relaxed mb-4">
                    We use cookies and similar technologies to enhance your experience, analyze usage, and personalize content. You can control cookies through your browser settings.
                </p>
            </div>
            
            <div class="bg-white rounded-xl p-8 border border-gray-200 mb-6">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">6. Your Rights</h2>
                <p class="text-gray-700 leading-relaxed mb-4">
                    You have the right to:
                </p>
                <ul class="list-disc pl-6 text-gray-700 space-y-2">
                    <li>Access your personal information</li>
                    <li>Correct inaccurate data</li>
                    <li>Request deletion of your data</li>
                    <li>Opt-out of marketing communications</li>
                    <li>Export your data</li>
                </ul>
            </div>
            
            <div class="bg-white rounded-xl p-8 border border-gray-200 mb-6">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">7. Children's Privacy</h2>
                <p class="text-gray-700 leading-relaxed mb-4">
                    Our service is not intended for users under 18 years of age. We do not knowingly collect information from children.
                </p>
            </div>
            
            <div class="bg-white rounded-xl p-8 border border-gray-200 mb-6">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">8. Changes to Privacy Policy</h2>
                <p class="text-gray-700 leading-relaxed mb-4">
                    We may update this privacy policy from time to time. We will notify you of any changes by posting the new policy on this page.
                </p>
            </div>
            
            <div class="bg-white rounded-xl p-8 border border-gray-200">
                <h2 class="text-2xl font-bold text-gray-900 mb-4">9. Contact Us</h2>
                <p class="text-gray-700 leading-relaxed mb-4">
                    If you have questions about this Privacy Policy, please contact us at:
                </p>
                <p class="text-gray-700">
                    <strong>Email:</strong> privacy@pgfinder.com<br>
                    <strong>Phone:</strong> +91 98765 43210<br>
                    <strong>Address:</strong> Bangalore, India
                </p>
            </div>
        </div>
    </div>
    
    <%@ include file="../common/footer.jsp" %>
</body>
</html>
