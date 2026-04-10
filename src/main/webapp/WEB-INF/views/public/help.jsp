<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help Center - PG Finder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f8fafc; color: #1e293b; }

        /* Hero */
        .help-hero {
            background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 100%);
            padding: 72px 24px 56px;
            text-align: center;
            color: white;
        }
        .help-hero h1 { font-size: 42px; font-weight: 800; margin-bottom: 12px; }
        .help-hero p { font-size: 17px; color: #bfdbfe; margin-bottom: 32px; }

        /* Search */
        .search-box {
            max-width: 560px; margin: 0 auto;
            background: white; border-radius: 14px;
            display: flex; align-items: center;
            padding: 6px 6px 6px 20px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.15);
        }
        .search-box i { color: #94a3b8; font-size: 18px; margin-right: 12px; }
        .search-box input {
            flex: 1; border: none; outline: none;
            font-size: 15px; color: #1e293b; background: transparent;
        }
        .search-box button {
            padding: 12px 24px; background: #2563eb; color: white;
            border: none; border-radius: 10px; font-weight: 600;
            font-size: 14px; cursor: pointer; transition: background 0.2s;
        }
        .search-box button:hover { background: #1d4ed8; }

        /* Categories */
        .help-main { max-width: 1100px; margin: 0 auto; padding: 56px 24px; }
        .categories-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 56px; }
        .cat-card {
            background: white;
            border-radius: 14px;
            padding: 28px 20px;
            border: 1px solid #e2e8f0;
            text-align: center;
            cursor: pointer;
            transition: box-shadow 0.2s, transform 0.2s, border-color 0.2s;
            text-decoration: none;
        }
        .cat-card:hover { box-shadow: 0 6px 20px rgba(0,0,0,0.08); transform: translateY(-2px); border-color: #2563eb; }
        .cat-icon {
            width: 56px; height: 56px; border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            font-size: 22px; margin: 0 auto 14px;
        }
        .cat-icon.blue { background: #dbeafe; color: #2563eb; }
        .cat-icon.green { background: #dcfce7; color: #16a34a; }
        .cat-icon.purple { background: #f3e8ff; color: #7c3aed; }
        .cat-icon.orange { background: #ffedd5; color: #ea580c; }
        .cat-card h3 { font-size: 15px; font-weight: 700; color: #0f172a; margin-bottom: 6px; }
        .cat-card p { font-size: 13px; color: #64748b; line-height: 1.5; margin-bottom: 12px; }
        .cat-card .cat-link { font-size: 13px; color: #2563eb; font-weight: 600; }

        /* FAQ section */
        .faq-section { margin-bottom: 56px; }
        .faq-section-title {
            font-size: 22px; font-weight: 700; color: #0f172a;
            margin-bottom: 20px; padding-bottom: 12px;
            border-bottom: 2px solid #e2e8f0;
        }
        .faq-item {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            margin-bottom: 10px;
            overflow: hidden;
        }
        .faq-question {
            width: 100%; padding: 18px 20px;
            display: flex; justify-content: space-between; align-items: center;
            background: none; border: none; cursor: pointer;
            text-align: left; transition: background 0.2s;
        }
        .faq-question:hover { background: #f8fafc; }
        .faq-question span { font-size: 15px; font-weight: 600; color: #0f172a; }
        .faq-question i { color: #94a3b8; font-size: 14px; transition: transform 0.3s; flex-shrink: 0; margin-left: 12px; }
        .faq-answer {
            padding: 0 20px;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease, padding 0.3s ease;
        }
        .faq-answer p { font-size: 14px; color: #64748b; line-height: 1.7; padding-bottom: 18px; }
        .faq-item.open .faq-answer { max-height: 200px; }
        .faq-item.open .faq-question i { transform: rotate(180deg); }
        .faq-item.open .faq-question { background: #f8fafc; }

        /* Popular articles */
        .articles-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 16px; margin-bottom: 56px; }
        .article-card {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 20px;
            display: flex;
            align-items: center;
            gap: 16px;
            cursor: pointer;
            transition: box-shadow 0.2s, border-color 0.2s;
            text-decoration: none;
        }
        .article-card:hover { box-shadow: 0 4px 12px rgba(0,0,0,0.08); border-color: #2563eb; }
        .article-icon {
            width: 44px; height: 44px; border-radius: 10px;
            background: #dbeafe; color: #2563eb;
            display: flex; align-items: center; justify-content: center;
            font-size: 18px; flex-shrink: 0;
        }
        .article-card h4 { font-size: 14px; font-weight: 600; color: #0f172a; margin-bottom: 4px; }
        .article-card p { font-size: 13px; color: #64748b; }

        /* Contact support */
        .contact-support {
            background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%);
            border: 1px solid #bfdbfe;
            border-radius: 20px;
            padding: 48px 40px;
            text-align: center;
        }
        .contact-support i { font-size: 44px; color: #2563eb; margin-bottom: 16px; }
        .contact-support h3 { font-size: 26px; font-weight: 700; color: #0f172a; margin-bottom: 8px; }
        .contact-support p { font-size: 15px; color: #64748b; margin-bottom: 28px; }
        .contact-options { display: flex; justify-content: center; gap: 16px; flex-wrap: wrap; }
        .contact-opt {
            padding: 14px 28px; border-radius: 10px;
            font-weight: 600; font-size: 15px; cursor: pointer;
            display: flex; align-items: center; gap: 8px;
            text-decoration: none; transition: all 0.2s;
        }
        .contact-opt.primary { background: #2563eb; color: white; border: none; }
        .contact-opt.primary:hover { background: #1d4ed8; }
        .contact-opt.secondary { background: white; color: #2563eb; border: 2px solid #2563eb; }
        .contact-opt.secondary:hover { background: #eff6ff; }

        @media (max-width: 768px) {
            .categories-grid { grid-template-columns: repeat(2, 1fr); }
            .articles-grid { grid-template-columns: 1fr; }
            .help-hero h1 { font-size: 28px; }
            .contact-options { flex-direction: column; align-items: center; }
        }
    </style>
</head>
<body>
<%@ include file="../common/navbar.jsp" %>

<!-- Hero -->
<div class="help-hero">
    <h1>How can we help you?</h1>
    <p>Search our help center or browse categories below</p>
    <div class="search-box">
        <i class="fas fa-search"></i>
        <input type="text" placeholder="Search for help articles...">
        <button>Search</button>
    </div>
</div>

<div class="help-main">

    <!-- Categories -->
    <div class="categories-grid">
        <a href="#getting-started" class="cat-card">
            <div class="cat-icon blue"><i class="fas fa-user-circle"></i></div>
            <h3>Getting Started</h3>
            <p>Create an account and start your search</p>
            <span class="cat-link">5 articles →</span>
        </a>
        <a href="#finding-pg" class="cat-card">
            <div class="cat-icon green"><i class="fas fa-search"></i></div>
            <h3>Finding a PG</h3>
            <p>Tips for searching and booking your perfect PG</p>
            <span class="cat-link">8 articles →</span>
        </a>
        <a href="#for-owners" class="cat-card">
            <div class="cat-icon purple"><i class="fas fa-home"></i></div>
            <h3>For Owners</h3>
            <p>List your PG and manage bookings easily</p>
            <span class="cat-link">6 articles →</span>
        </a>
        <a href="#safety" class="cat-card">
            <div class="cat-icon orange"><i class="fas fa-shield-alt"></i></div>
            <h3>Safety & Security</h3>
            <p>Stay safe while using PG Finder</p>
            <span class="cat-link">4 articles →</span>
        </a>
    </div>

    <!-- Popular Articles -->
    <div style="margin-bottom: 48px;">
        <div class="faq-section-title">Popular Articles</div>
        <div class="articles-grid">
            <a href="#" class="article-card">
                <div class="article-icon"><i class="fas fa-user-plus"></i></div>
                <div>
                    <h4>How to create an account</h4>
                    <p>Step-by-step guide to register as tenant or owner</p>
                </div>
            </a>
            <a href="#" class="article-card">
                <div class="article-icon"><i class="fas fa-search"></i></div>
                <div>
                    <h4>How to search for PGs</h4>
                    <p>Using filters and search to find your ideal PG</p>
                </div>
            </a>
            <a href="#" class="article-card">
                <div class="article-icon"><i class="fas fa-calendar-check"></i></div>
                <div>
                    <h4>How to book a PG</h4>
                    <p>Complete the booking process step by step</p>
                </div>
            </a>
            <a href="#" class="article-card">
                <div class="article-icon"><i class="fas fa-plus-circle"></i></div>
                <div>
                    <h4>How to list your PG</h4>
                    <p>Add your property and start receiving inquiries</p>
                </div>
            </a>
            <a href="#" class="article-card">
                <div class="article-icon"><i class="fas fa-key"></i></div>
                <div>
                    <h4>Reset your password</h4>
                    <p>Recover access to your account quickly</p>
                </div>
            </a>
            <a href="#" class="article-card">
                <div class="article-icon"><i class="fas fa-star"></i></div>
                <div>
                    <h4>How to leave a review</h4>
                    <p>Share your experience to help other tenants</p>
                </div>
            </a>
        </div>
    </div>

    <!-- FAQ - Getting Started -->
    <div class="faq-section" id="getting-started">
        <div class="faq-section-title">Getting Started</div>

        <div class="faq-item">
            <button class="faq-question" onclick="toggleFaq(this)">
                <span>How do I create an account?</span>
                <i class="fas fa-chevron-down"></i>
            </button>
            <div class="faq-answer"><p>Click on "Register" in the top navigation, choose your role (Tenant or Owner), and fill in your details. You'll receive a verification email to activate your account.</p></div>
        </div>
        <div class="faq-item">
            <button class="faq-question" onclick="toggleFaq(this)">
                <span>Is PG Finder free to use?</span>
                <i class="fas fa-chevron-down"></i>
            </button>
            <div class="faq-answer"><p>Yes! PG Finder is completely free for tenants to search and book PGs. Property owners can also list their PGs for free.</p></div>
        </div>
        <div class="faq-item">
            <button class="faq-question" onclick="toggleFaq(this)">
                <span>Which cities do you cover?</span>
                <i class="fas fa-chevron-down"></i>
            </button>
            <div class="faq-answer"><p>We currently cover major cities across India including Bangalore, Mumbai, Delhi, Pune, Hyderabad, Chennai, Kolkata, and more. We're constantly expanding to new cities.</p></div>
        </div>
    </div>

    <!-- FAQ - Finding PG -->
    <div class="faq-section" id="finding-pg">
        <div class="faq-section-title">Finding a PG</div>

        <div class="faq-item">
            <button class="faq-question" onclick="toggleFaq(this)">
                <span>How do I search for PGs?</span>
                <i class="fas fa-chevron-down"></i>
            </button>
            <div class="faq-answer"><p>Use the search bar on the homepage to enter your preferred city, budget, and gender preference. You can also use advanced filters to narrow down your search by amenities, room type, and more.</p></div>
        </div>
        <div class="faq-item">
            <button class="faq-question" onclick="toggleFaq(this)">
                <span>How do I book a PG?</span>
                <i class="fas fa-chevron-down"></i>
            </button>
            <div class="faq-answer"><p>Once you find a PG you like, click "View Details" to see more information. Then click "Book Now" to fill in your details and confirm your booking. The owner will contact you to finalize the arrangement.</p></div>
        </div>
        <div class="faq-item">
            <button class="faq-question" onclick="toggleFaq(this)">
                <span>Can I visit the PG before booking?</span>
                <i class="fas fa-chevron-down"></i>
            </button>
            <div class="faq-answer"><p>Absolutely! We highly recommend visiting the PG and meeting the owner before making any commitments. Use the contact information provided to schedule a visit.</p></div>
        </div>
        <div class="faq-item">
            <button class="faq-question" onclick="toggleFaq(this)">
                <span>How do I contact a PG owner?</span>
                <i class="fas fa-chevron-down"></i>
            </button>
            <div class="faq-answer"><p>Once you find a PG you like, click "View Details" and then use the "Contact Owner" button to send a message or view their contact information. You need to be logged in to contact owners.</p></div>
        </div>
    </div>

    <!-- FAQ - For Owners -->
    <div class="faq-section" id="for-owners">
        <div class="faq-section-title">For PG Owners</div>

        <div class="faq-item">
            <button class="faq-question" onclick="toggleFaq(this)">
                <span>How do I list my PG?</span>
                <i class="fas fa-chevron-down"></i>
            </button>
            <div class="faq-answer"><p>Register as an owner, go to your dashboard, and click "Add New PG". Fill in all the required details including photos, amenities, pricing, and location. Your listing will be reviewed and activated within 24 hours.</p></div>
        </div>
        <div class="faq-item">
            <button class="faq-question" onclick="toggleFaq(this)">
                <span>How long does verification take?</span>
                <i class="fas fa-chevron-down"></i>
            </button>
            <div class="faq-answer"><p>Our team typically reviews and verifies new listings within 24–48 hours. You'll receive an email notification once your listing is approved.</p></div>
        </div>
        <div class="faq-item">
            <button class="faq-question" onclick="toggleFaq(this)">
                <span>Can I edit my listing after posting?</span>
                <i class="fas fa-chevron-down"></i>
            </button>
            <div class="faq-answer"><p>Yes, you can edit your listing anytime from your owner dashboard. Changes to pricing or major details may require re-verification.</p></div>
        </div>
    </div>

    <!-- Contact Support -->
    <div class="contact-support" id="safety">
        <i class="fas fa-headset"></i>
        <h3>Still need help?</h3>
        <p>Our support team is available Monday–Saturday, 9 AM to 6 PM. We typically respond within 2 hours.</p>
        <div class="contact-options">
            <a href="${pageContext.request.contextPath}/contact" class="contact-opt primary">
                <i class="fas fa-envelope"></i> Send a Message
            </a>
            <a href="tel:+919876543210" class="contact-opt secondary">
                <i class="fas fa-phone"></i> +91 98765 43210
            </a>
        </div>
    </div>

</div>

<%@ include file="../common/footer.jsp" %>

<script>
function toggleFaq(btn) {
    const item = btn.closest('.faq-item');
    const isOpen = item.classList.contains('open');
    // Close all
    document.querySelectorAll('.faq-item.open').forEach(i => i.classList.remove('open'));
    // Open clicked if it was closed
    if (!isOpen) item.classList.add('open');
}
</script>
</body>
</html>
