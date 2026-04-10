<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="py-20 bg-gray-50">
    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-12">
            <h1 class="text-4xl font-bold text-gray-900 mb-4">Frequently Asked Questions</h1>
            <p class="text-xl text-gray-600">Find answers to common questions about PG Finder</p>
        </div>

        <div class="space-y-4">
            <!-- General Questions -->
            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <button class="faq-question w-full text-left p-6 flex justify-between items-center hover:bg-gray-50" onclick="toggleFAQ(this)">
                    <span class="font-semibold text-lg text-gray-900">What is PG Finder?</span>
                    <i class="fas fa-chevron-down text-gray-500 transition-transform"></i>
                </button>
                <div class="faq-answer hidden p-6 pt-0 text-gray-600">
                    PG Finder is a comprehensive platform that helps you find verified PG accommodations and compatible roommates. We connect tenants with property owners and provide tools for easy roommate matching and replacement.
                </div>
            </div>

            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <button class="faq-question w-full text-left p-6 flex justify-between items-center hover:bg-gray-50" onclick="toggleFAQ(this)">
                    <span class="font-semibold text-lg text-gray-900">Is PG Finder free to use?</span>
                    <i class="fas fa-chevron-down text-gray-500 transition-transform"></i>
                </button>
                <div class="faq-answer hidden p-6 pt-0 text-gray-600">
                    Yes! Searching for PGs and roommates is completely free for tenants. PG owners can list their first property for free, with premium plans available for additional features.
                </div>
            </div>

            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <button class="faq-question w-full text-left p-6 flex justify-between items-center hover:bg-gray-50" onclick="toggleFAQ(this)">
                    <span class="font-semibold text-lg text-gray-900">How do I search for a PG?</span>
                    <i class="fas fa-chevron-down text-gray-500 transition-transform"></i>
                </button>
                <div class="faq-answer hidden p-6 pt-0 text-gray-600">
                    Simply use our search feature on the homepage. Select your preferred city, set your budget, choose gender preference, and browse through verified listings. You can filter results by amenities, location, and more.
                </div>
            </div>

            <!-- Booking Questions -->
            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <button class="faq-question w-full text-left p-6 flex justify-between items-center hover:bg-gray-50" onclick="toggleFAQ(this)">
                    <span class="font-semibold text-lg text-gray-900">How do I book a PG?</span>
                    <i class="fas fa-chevron-down text-gray-500 transition-transform"></i>
                </button>
                <div class="faq-answer hidden p-6 pt-0 text-gray-600">
                    After finding a suitable PG, click on "Book Now", fill in your details, and make the payment. We recommend visiting the property in person before booking. You can also contact the owner directly through our messaging system.
                </div>
            </div>

            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <button class="faq-question w-full text-left p-6 flex justify-between items-center hover:bg-gray-50" onclick="toggleFAQ(this)">
                    <span class="font-semibold text-lg text-gray-900">What payment methods are accepted?</span>
                    <i class="fas fa-chevron-down text-gray-500 transition-transform"></i>
                </button>
                <div class="faq-answer hidden p-6 pt-0 text-gray-600">
                    We accept all major payment methods including credit/debit cards, UPI, net banking, and digital wallets through our secure payment partner Razorpay.
                </div>
            </div>

            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <button class="faq-question w-full text-left p-6 flex justify-between items-center hover:bg-gray-50" onclick="toggleFAQ(this)">
                    <span class="font-semibold text-lg text-gray-900">Can I cancel my booking?</span>
                    <i class="fas fa-chevron-down text-gray-500 transition-transform"></i>
                </button>
                <div class="faq-answer hidden p-6 pt-0 text-gray-600">
                    Cancellation policies vary by property. Please check the specific cancellation terms in your booking details or contact the PG owner directly.
                </div>
            </div>

            <!-- Roommate Questions -->
            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <button class="faq-question w-full text-left p-6 flex justify-between items-center hover:bg-gray-50" onclick="toggleFAQ(this)">
                    <span class="font-semibold text-lg text-gray-900">How does roommate matching work?</span>
                    <i class="fas fa-chevron-down text-gray-500 transition-transform"></i>
                </button>
                <div class="faq-answer hidden p-6 pt-0 text-gray-600">
                    Our roommate matching algorithm considers your lifestyle preferences, habits, budget, and location to suggest compatible roommates. You can browse profiles, chat with potential matches, and decide together.
                </div>
            </div>

            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <button class="faq-question w-full text-left p-6 flex justify-between items-center hover:bg-gray-50" onclick="toggleFAQ(this)">
                    <span class="font-semibold text-lg text-gray-900">What is roommate replacement?</span>
                    <i class="fas fa-chevron-down text-gray-500 transition-transform"></i>
                </button>
                <div class="faq-answer hidden p-6 pt-0 text-gray-600">
                    Our unique roommate replacement feature allows you to find a new roommate without changing your PG. Both existing and new roommates must mutually approve the arrangement.
                </div>
            </div>

            <!-- Owner Questions -->
            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <button class="faq-question w-full text-left p-6 flex justify-between items-center hover:bg-gray-50" onclick="toggleFAQ(this)">
                    <span class="font-semibold text-lg text-gray-900">How do I list my PG?</span>
                    <i class="fas fa-chevron-down text-gray-500 transition-transform"></i>
                </button>
                <div class="faq-answer hidden p-6 pt-0 text-gray-600">
                    Register as a PG owner, complete your profile, and click "Add PG Listing". Fill in property details, upload photos, set pricing, and submit for verification. Your listing will be live once approved.
                </div>
            </div>

            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <button class="faq-question w-full text-left p-6 flex justify-between items-center hover:bg-gray-50" onclick="toggleFAQ(this)">
                    <span class="font-semibold text-lg text-gray-900">How are listings verified?</span>
                    <i class="fas fa-chevron-down text-gray-500 transition-transform"></i>
                </button>
                <div class="faq-answer hidden p-6 pt-0 text-gray-600">
                    Our team reviews all listings to ensure they meet our quality standards. We verify property documents, photos, and owner information before approving any listing.
                </div>
            </div>

            <!-- Safety Questions -->
            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <button class="faq-question w-full text-left p-6 flex justify-between items-center hover:bg-gray-50" onclick="toggleFAQ(this)">
                    <span class="font-semibold text-lg text-gray-900">Is my personal information safe?</span>
                    <i class="fas fa-chevron-down text-gray-500 transition-transform"></i>
                </button>
                <div class="faq-answer hidden p-6 pt-0 text-gray-600">
                    Yes, we take data security seriously. All personal information is encrypted and stored securely. We never share your data with third parties without your consent. Read our Privacy Policy for more details.
                </div>
            </div>

            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <button class="faq-question w-full text-left p-6 flex justify-between items-center hover:bg-gray-50" onclick="toggleFAQ(this)">
                    <span class="font-semibold text-lg text-gray-900">What if I face issues with a PG or owner?</span>
                    <i class="fas fa-chevron-down text-gray-500 transition-transform"></i>
                </button>
                <div class="faq-answer hidden p-6 pt-0 text-gray-600">
                    Contact our support team immediately through the Help Center or email us at support@pgfinder.com. We'll investigate and help resolve the issue as quickly as possible.
                </div>
            </div>
        </div>

        <div class="mt-12 text-center bg-blue-50 rounded-lg p-8">
            <h3 class="text-2xl font-bold text-gray-900 mb-4">Still have questions?</h3>
            <p class="text-gray-600 mb-6">Our support team is here to help you</p>
            <a href="${pageContext.request.contextPath}/contact" class="inline-flex items-center gap-2 bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700">
                <i class="fas fa-envelope"></i>
                Contact Support
            </a>
        </div>
    </div>
</section>

<script>
function toggleFAQ(button) {
    const answer = button.nextElementSibling;
    const icon = button.querySelector('i');
    
    answer.classList.toggle('hidden');
    icon.classList.toggle('rotate-180');
}
</script>

<style>
.rotate-180 {
    transform: rotate(180deg);
}
</style>
