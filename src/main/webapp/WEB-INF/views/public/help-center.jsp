<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div style="background: #f9fafb; min-height: 100vh; padding: 3rem 0;">
    <div style="max-width: 1200px; margin: 0 auto; padding: 0 1.5rem;">
        <!-- Header -->
        <div style="text-align: center; margin-bottom: 3rem;">
            <h1 style="margin: 0 0 1rem 0; font-size: 2.5rem; font-weight: bold; color: #111827;">Help Center</h1>
            <p style="margin: 0; color: #6b7280; font-size: 1.125rem;">Find answers to your questions</p>
        </div>

        <!-- Search Box -->
        <div style="max-width: 600px; margin: 0 auto 3rem auto;">
            <div style="position: relative;">
                <i class="fas fa-search" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: #9ca3af;"></i>
                <input type="text" placeholder="Search for help..." 
                       style="width: 100%; padding: 1rem 1rem 1rem 3rem; border: 1px solid #d1d5db; border-radius: 0.75rem; font-size: 1rem; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
            </div>
        </div>

        <!-- FAQ Categories -->
        <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 1.5rem; margin-bottom: 3rem;">
            <div style="background: white; border-radius: 1rem; padding: 2rem; text-align: center; box-shadow: 0 1px 3px rgba(0,0,0,0.1); cursor: pointer; transition: transform 0.2s;" onmouseover="this.style.transform='translateY(-4px)'" onmouseout="this.style.transform='translateY(0)'">
                <div style="width: 4rem; height: 4rem; border-radius: 50%; background: #eff6ff; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem auto;">
                    <i class="fas fa-search" style="color: #2563eb; font-size: 1.5rem;"></i>
                </div>
                <h3 style="margin: 0 0 0.5rem 0; font-size: 1.125rem; font-weight: 700; color: #111827;">Finding PG</h3>
                <p style="margin: 0; color: #6b7280; font-size: 0.875rem;">How to search and book PG</p>
            </div>

            <div style="background: white; border-radius: 1rem; padding: 2rem; text-align: center; box-shadow: 0 1px 3px rgba(0,0,0,0.1); cursor: pointer; transition: transform 0.2s;" onmouseover="this.style.transform='translateY(-4px)'" onmouseout="this.style.transform='translateY(0)'">
                <div style="width: 4rem; height: 4rem; border-radius: 50%; background: #f0fdf4; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem auto;">
                    <i class="fas fa-credit-card" style="color: #10b981; font-size: 1.5rem;"></i>
                </div>
                <h3 style="margin: 0 0 0.5rem 0; font-size: 1.125rem; font-weight: 700; color: #111827;">Payments</h3>
                <p style="margin: 0; color: #6b7280; font-size: 0.875rem;">Payment methods and refunds</p>
            </div>

            <div style="background: white; border-radius: 1rem; padding: 2rem; text-align: center; box-shadow: 0 1px 3px rgba(0,0,0,0.1); cursor: pointer; transition: transform 0.2s;" onmouseover="this.style.transform='translateY(-4px)'" onmouseout="this.style.transform='translateY(0)'">
                <div style="width: 4rem; height: 4rem; border-radius: 50%; background: #fef3c7; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem auto;">
                    <i class="fas fa-user-shield" style="color: #f59e0b; font-size: 1.5rem;"></i>
                </div>
                <h3 style="margin: 0 0 0.5rem 0; font-size: 1.125rem; font-weight: 700; color: #111827;">Account & Safety</h3>
                <p style="margin: 0; color: #6b7280; font-size: 0.875rem;">Profile and security settings</p>
            </div>
        </div>

        <!-- FAQs -->
        <div style="background: white; border-radius: 1rem; padding: 2rem; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
            <h2 style="margin: 0 0 1.5rem 0; font-size: 1.5rem; font-weight: 700; color: #111827;">Frequently Asked Questions</h2>
            
            <div style="display: flex; flex-direction: column; gap: 1rem;">
                <!-- FAQ Item 1 -->
                <div style="border: 1px solid #e5e7eb; border-radius: 0.5rem; overflow: hidden;">
                    <button onclick="toggleFAQ(1)" style="width: 100%; padding: 1rem; background: white; border: none; text-align: left; cursor: pointer; display: flex; justify-content: space-between; align-items: center; font-weight: 600; color: #111827;">
                        <span>How do I book a PG?</span>
                        <i id="icon1" class="fas fa-chevron-down" style="color: #6b7280;"></i>
                    </button>
                    <div id="faq1" style="display: none; padding: 0 1rem 1rem 1rem; color: #6b7280;">
                        To book a PG, browse listings, select your preferred PG, click "Book Now", fill in your details, and complete the payment. You'll receive a confirmation email once the booking is successful.
                    </div>
                </div>

                <!-- FAQ Item 2 -->
                <div style="border: 1px solid #e5e7eb; border-radius: 0.5rem; overflow: hidden;">
                    <button onclick="toggleFAQ(2)" style="width: 100%; padding: 1rem; background: white; border: none; text-align: left; cursor: pointer; display: flex; justify-content: space-between; align-items: center; font-weight: 600; color: #111827;">
                        <span>What payment methods are accepted?</span>
                        <i id="icon2" class="fas fa-chevron-down" style="color: #6b7280;"></i>
                    </button>
                    <div id="faq2" style="display: none; padding: 0 1rem 1rem 1rem; color: #6b7280;">
                        We accept credit/debit cards, UPI, net banking, and digital wallets. All payments are secure and encrypted.
                    </div>
                </div>

                <!-- FAQ Item 3 -->
                <div style="border: 1px solid #e5e7eb; border-radius: 0.5rem; overflow: hidden;">
                    <button onclick="toggleFAQ(3)" style="width: 100%; padding: 1rem; background: white; border: none; text-align: left; cursor: pointer; display: flex; justify-content: space-between; align-items: center; font-weight: 600; color: #111827;">
                        <span>Can I cancel my booking?</span>
                        <i id="icon3" class="fas fa-chevron-down" style="color: #6b7280;"></i>
                    </button>
                    <div id="faq3" style="display: none; padding: 0 1rem 1rem 1rem; color: #6b7280;">
                        Yes, you can cancel your booking from "My Bookings" page. Refund policy depends on the cancellation timing and PG owner's policy.
                    </div>
                </div>

                <!-- FAQ Item 4 -->
                <div style="border: 1px solid #e5e7eb; border-radius: 0.5rem; overflow: hidden;">
                    <button onclick="toggleFAQ(4)" style="width: 100%; padding: 1rem; background: white; border: none; text-align: left; cursor: pointer; display: flex; justify-content: space-between; align-items: center; font-weight: 600; color: #111827;">
                        <span>How do I contact the PG owner?</span>
                        <i id="icon4" class="fas fa-chevron-down" style="color: #6b7280;"></i>
                    </button>
                    <div id="faq4" style="display: none; padding: 0 1rem 1rem 1rem; color: #6b7280;">
                        You can send inquiries through the "Send Inquiry" button on the PG details page. Messages will be available in your Messages section.
                    </div>
                </div>

                <!-- FAQ Item 5 -->
                <div style="border: 1px solid #e5e7eb; border-radius: 0.5rem; overflow: hidden;">
                    <button onclick="toggleFAQ(5)" style="width: 100%; padding: 1rem; background: white; border: none; text-align: left; cursor: pointer; display: flex; justify-content: space-between; align-items: center; font-weight: 600; color: #111827;">
                        <span>How does the roommate finder work?</span>
                        <i id="icon5" class="fas fa-chevron-down" style="color: #6b7280;"></i>
                    </button>
                    <div id="faq5" style="display: none; padding: 0 1rem 1rem 1rem; color: #6b7280;">
                        Browse roommate profiles based on compatibility scores, lifestyle preferences, and budget. Click "Connect" to send a connection request and start chatting.
                    </div>
                </div>
            </div>
        </div>

        <!-- Contact Support -->
        <div style="background: linear-gradient(135deg, #2563eb, #1d4ed8); border-radius: 1rem; padding: 3rem; text-align: center; margin-top: 3rem; color: white;">
            <h2 style="margin: 0 0 1rem 0; font-size: 1.75rem; font-weight: 700;">Still need help?</h2>
            <p style="margin: 0 0 2rem 0; font-size: 1.125rem; opacity: 0.9;">Our support team is here to assist you</p>
            <div style="display: flex; gap: 1rem; justify-content: center;">
                <a href="mailto:support@pgfinder.com" style="padding: 0.875rem 1.5rem; background: white; color: #2563eb; font-weight: 600; border-radius: 0.5rem; text-decoration: none; display: inline-flex; align-items: center; gap: 0.5rem;">
                    <i class="fas fa-envelope"></i>
                    Email Support
                </a>
                <a href="tel:+919876543210" style="padding: 0.875rem 1.5rem; background: rgba(255,255,255,0.2); color: white; font-weight: 600; border-radius: 0.5rem; text-decoration: none; display: inline-flex; align-items: center; gap: 0.5rem;">
                    <i class="fas fa-phone"></i>
                    Call Us
                </a>
            </div>
        </div>
    </div>
</div>

<script>
function toggleFAQ(num) {
    const faq = document.getElementById('faq' + num);
    const icon = document.getElementById('icon' + num);
    
    if (faq.style.display === 'none' || faq.style.display === '') {
        faq.style.display = 'block';
        icon.classList.remove('fa-chevron-down');
        icon.classList.add('fa-chevron-up');
    } else {
        faq.style.display = 'none';
        icon.classList.remove('fa-chevron-up');
        icon.classList.add('fa-chevron-down');
    }
}
</script>
