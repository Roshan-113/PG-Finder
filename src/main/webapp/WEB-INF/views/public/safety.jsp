<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Safety Tips - PG Finder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f8fafc; color: #1e293b; }

        /* Hero */
        .safety-hero {
            background: linear-gradient(135deg, #7f1d1d 0%, #dc2626 60%, #ef4444 100%);
            padding: 80px 24px 64px;
            text-align: center;
            color: white;
            position: relative;
            overflow: hidden;
        }
        .safety-hero::before {
            content: '';
            position: absolute; top: -60px; left: -60px;
            width: 280px; height: 280px;
            background: rgba(255,255,255,0.06);
            border-radius: 50%;
        }
        .safety-hero::after {
            content: '';
            position: absolute; bottom: -80px; right: -40px;
            width: 360px; height: 360px;
            background: rgba(252,165,165,0.08);
            border-radius: 50%;
        }
        .hero-icon {
            width: 80px; height: 80px; background: rgba(255,255,255,0.15);
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            margin: 0 auto 20px; font-size: 36px; position: relative; z-index: 1;
        }
        .safety-hero h1 { font-size: 46px; font-weight: 800; margin-bottom: 14px; position: relative; z-index: 1; }
        .safety-hero p { font-size: 18px; color: #fecaca; max-width: 540px; margin: 0 auto; position: relative; z-index: 1; }

        /* Section wrapper */
        .section { max-width: 1100px; margin: 0 auto; padding: 64px 24px; }
        .section-header { text-align: center; margin-bottom: 48px; }
        .section-header h2 { font-size: 34px; font-weight: 800; color: #0f172a; margin-bottom: 10px; }
        .section-header p { font-size: 16px; color: #64748b; }

        /* Before booking grid */
        .booking-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 24px; }
        .booking-card {
            border-radius: 16px;
            padding: 32px;
            border: 1px solid;
        }
        .booking-card.blue { background: #eff6ff; border-color: #bfdbfe; }
        .booking-card.green { background: #f0fdf4; border-color: #bbf7d0; }
        .booking-card.purple { background: #faf5ff; border-color: #e9d5ff; }
        .booking-card.orange { background: #fff7ed; border-color: #fed7aa; }
        .booking-card-icon {
            width: 56px; height: 56px; border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            font-size: 22px; margin-bottom: 16px;
        }
        .booking-card.blue .booking-card-icon { background: #2563eb; color: white; }
        .booking-card.green .booking-card-icon { background: #16a34a; color: white; }
        .booking-card.purple .booking-card-icon { background: #7c3aed; color: white; }
        .booking-card.orange .booking-card-icon { background: #ea580c; color: white; }
        .booking-card h3 { font-size: 20px; font-weight: 700; color: #0f172a; margin-bottom: 16px; }
        .check-list { list-style: none; display: flex; flex-direction: column; gap: 10px; }
        .check-list li { display: flex; align-items: flex-start; gap: 10px; font-size: 14px; color: #374151; line-height: 1.5; }
        .check-list li i { margin-top: 2px; flex-shrink: 0; }
        .booking-card.blue .check-list li i { color: #2563eb; }
        .booking-card.green .check-list li i { color: #16a34a; }
        .booking-card.purple .check-list li i { color: #7c3aed; }
        .booking-card.orange .check-list li i { color: #ea580c; }

        /* During stay */
        .stay-section { background: #f1f5f9; padding: 64px 0; }
        .stay-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
        .stay-card {
            background: white;
            border-radius: 14px;
            padding: 24px;
            border: 1px solid #e2e8f0;
            transition: box-shadow 0.2s;
        }
        .stay-card:hover { box-shadow: 0 4px 16px rgba(0,0,0,0.08); }
        .stay-icon {
            width: 52px; height: 52px; border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 20px; margin-bottom: 14px;
        }
        .stay-icon.red { background: #fee2e2; color: #dc2626; }
        .stay-icon.blue { background: #dbeafe; color: #2563eb; }
        .stay-icon.green { background: #dcfce7; color: #16a34a; }
        .stay-icon.purple { background: #f3e8ff; color: #7c3aed; }
        .stay-icon.yellow { background: #fef9c3; color: #ca8a04; }
        .stay-icon.indigo { background: #e0e7ff; color: #4338ca; }
        .stay-card h3 { font-size: 16px; font-weight: 700; color: #0f172a; margin-bottom: 12px; }
        .bullet-list { list-style: none; display: flex; flex-direction: column; gap: 7px; }
        .bullet-list li { font-size: 13px; color: #64748b; padding-left: 14px; position: relative; line-height: 1.5; }
        .bullet-list li::before { content: '•'; position: absolute; left: 0; color: #94a3b8; }

        /* Red flags */
        .red-flags-section { max-width: 860px; margin: 0 auto; padding: 64px 24px; }
        .red-flags-box {
            background: #fff5f5;
            border: 1px solid #fecaca;
            border-left: 5px solid #dc2626;
            border-radius: 16px;
            padding: 36px;
            display: flex;
            gap: 24px;
        }
        .red-flags-icon {
            width: 52px; height: 52px; background: #dc2626;
            border-radius: 12px; display: flex; align-items: center;
            justify-content: center; font-size: 22px; color: white; flex-shrink: 0;
        }
        .red-flags-box h3 { font-size: 22px; font-weight: 700; color: #0f172a; margin-bottom: 16px; }
        .flag-list { list-style: none; display: flex; flex-direction: column; gap: 10px; }
        .flag-list li { display: flex; align-items: flex-start; gap: 10px; font-size: 14px; color: #374151; }
        .flag-list li i { color: #dc2626; margin-top: 2px; flex-shrink: 0; }

        /* Emergency numbers */
        .emergency-section {
            background: linear-gradient(135deg, #7f1d1d 0%, #dc2626 100%);
            padding: 72px 24px;
            text-align: center;
            color: white;
        }
        .emergency-section h2 { font-size: 34px; font-weight: 800; margin-bottom: 10px; }
        .emergency-section > p { font-size: 17px; color: #fecaca; margin-bottom: 40px; }
        .emergency-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; max-width: 700px; margin: 0 auto 40px; }
        .emergency-card {
            background: rgba(255,255,255,0.12);
            border: 1px solid rgba(255,255,255,0.2);
            border-radius: 16px;
            padding: 28px 20px;
            text-align: center;
            backdrop-filter: blur(4px);
        }
        .emergency-card i { font-size: 32px; margin-bottom: 10px; }
        .emergency-card h3 { font-size: 16px; font-weight: 600; margin-bottom: 6px; }
        .emergency-card .num { font-size: 36px; font-weight: 800; }
        .emergency-cta-btn {
            padding: 16px 36px; background: white; color: #dc2626;
            border: none; border-radius: 12px; font-weight: 700;
            font-size: 16px; cursor: pointer; transition: background 0.2s;
        }
        .emergency-cta-btn:hover { background: #f1f5f9; }

        @media (max-width: 768px) {
            .booking-grid { grid-template-columns: 1fr; }
            .stay-grid { grid-template-columns: 1fr; }
            .emergency-grid { grid-template-columns: 1fr; }
            .red-flags-box { flex-direction: column; }
            .safety-hero h1 { font-size: 30px; }
        }
    </style>
</head>
<body>
<%@ include file="../common/navbar.jsp" %>

<!-- Hero -->
<div class="safety-hero">
    <div class="hero-icon"><i class="fas fa-shield-alt"></i></div>
    <h1>Safety Tips</h1>
    <p>Your safety is our priority. Follow these guidelines for a secure PG experience</p>
</div>

<!-- Before Booking -->
<div class="section">
    <div class="section-header">
        <h2>Before Booking a PG</h2>
        <p>Essential checks to perform before making your decision</p>
    </div>
    <div class="booking-grid">
        <div class="booking-card blue">
            <div class="booking-card-icon"><i class="fas fa-eye"></i></div>
            <h3>Visit in Person</h3>
            <ul class="check-list">
                <li><i class="fas fa-check-circle"></i> Always visit the PG before booking</li>
                <li><i class="fas fa-check-circle"></i> Check the actual room, not just photos</li>
                <li><i class="fas fa-check-circle"></i> Visit during different times of day</li>
                <li><i class="fas fa-check-circle"></i> Inspect common areas and facilities</li>
            </ul>
        </div>
        <div class="booking-card green">
            <div class="booking-card-icon"><i class="fas fa-file-contract"></i></div>
            <h3>Verify Documents</h3>
            <ul class="check-list">
                <li><i class="fas fa-check-circle"></i> Check owner's ID proof and property documents</li>
                <li><i class="fas fa-check-circle"></i> Read the rental agreement carefully</li>
                <li><i class="fas fa-check-circle"></i> Get everything in writing</li>
                <li><i class="fas fa-check-circle"></i> Keep copies of all documents</li>
            </ul>
        </div>
        <div class="booking-card purple">
            <div class="booking-card-icon"><i class="fas fa-map-marker-alt"></i></div>
            <h3>Check Location</h3>
            <ul class="check-list">
                <li><i class="fas fa-check-circle"></i> Research the neighborhood safety</li>
                <li><i class="fas fa-check-circle"></i> Check proximity to police station</li>
                <li><i class="fas fa-check-circle"></i> Verify public transport availability</li>
                <li><i class="fas fa-check-circle"></i> Look for well-lit streets and areas</li>
            </ul>
        </div>
        <div class="booking-card orange">
            <div class="booking-card-icon"><i class="fas fa-lock"></i></div>
            <h3>Security Features</h3>
            <ul class="check-list">
                <li><i class="fas fa-check-circle"></i> Check for CCTV cameras in common areas</li>
                <li><i class="fas fa-check-circle"></i> Verify door locks and window security</li>
                <li><i class="fas fa-check-circle"></i> Ask about security guard availability</li>
                <li><i class="fas fa-check-circle"></i> Check fire safety equipment</li>
            </ul>
        </div>
    </div>
</div>

<!-- During Stay -->
<div class="stay-section">
    <div class="section" style="padding-top: 0; padding-bottom: 0;">
        <div class="section-header">
            <h2>During Your Stay</h2>
            <p>Best practices for staying safe in your PG</p>
        </div>
        <div class="stay-grid">
            <div class="stay-card">
                <div class="stay-icon red"><i class="fas fa-user-shield"></i></div>
                <h3>Personal Safety</h3>
                <ul class="bullet-list">
                    <li>Keep your room locked at all times</li>
                    <li>Don't share keys with strangers</li>
                    <li>Be cautious with personal information</li>
                    <li>Trust your instincts</li>
                </ul>
            </div>
            <div class="stay-card">
                <div class="stay-icon blue"><i class="fas fa-wallet"></i></div>
                <h3>Financial Safety</h3>
                <ul class="bullet-list">
                    <li>Get receipts for all payments</li>
                    <li>Use digital payment methods</li>
                    <li>Keep valuables in a safe place</li>
                    <li>Don't lend money to strangers</li>
                </ul>
            </div>
            <div class="stay-card">
                <div class="stay-icon green"><i class="fas fa-phone-alt"></i></div>
                <h3>Emergency Contacts</h3>
                <ul class="bullet-list">
                    <li>Save local police number</li>
                    <li>Keep emergency contacts handy</li>
                    <li>Share your location with family</li>
                    <li>Know nearest hospital location</li>
                </ul>
            </div>
            <div class="stay-card">
                <div class="stay-icon purple"><i class="fas fa-fire-extinguisher"></i></div>
                <h3>Fire Safety</h3>
                <ul class="bullet-list">
                    <li>Know fire exit locations</li>
                    <li>Don't overload electrical outlets</li>
                    <li>Keep fire extinguisher accessible</li>
                    <li>Report electrical issues immediately</li>
                </ul>
            </div>
            <div class="stay-card">
                <div class="stay-icon yellow"><i class="fas fa-utensils"></i></div>
                <h3>Food Safety</h3>
                <ul class="bullet-list">
                    <li>Check food hygiene standards</li>
                    <li>Store food properly</li>
                    <li>Report food quality issues</li>
                    <li>Keep kitchen area clean</li>
                </ul>
            </div>
            <div class="stay-card">
                <div class="stay-icon indigo"><i class="fas fa-users"></i></div>
                <h3>Roommate Safety</h3>
                <ul class="bullet-list">
                    <li>Set clear boundaries</li>
                    <li>Communicate openly</li>
                    <li>Respect each other's privacy</li>
                    <li>Report concerning behavior</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- Red Flags -->
<div class="red-flags-section">
    <div class="red-flags-box">
        <div class="red-flags-icon"><i class="fas fa-exclamation-triangle"></i></div>
        <div>
            <h3>Red Flags to Watch Out For</h3>
            <ul class="flag-list">
                <li><i class="fas fa-times-circle"></i> Owner refuses to show property documents</li>
                <li><i class="fas fa-times-circle"></i> No written agreement or receipt provided</li>
                <li><i class="fas fa-times-circle"></i> Pressure to pay advance without viewing the property</li>
                <li><i class="fas fa-times-circle"></i> Poor security measures or no proper locks</li>
                <li><i class="fas fa-times-circle"></i> Unrealistic promises or too-good-to-be-true deals</li>
                <li><i class="fas fa-times-circle"></i> Negative reviews or complaints from current tenants</li>
            </ul>
        </div>
    </div>
</div>

<!-- Emergency Numbers -->
<div class="emergency-section">
    <h2>Emergency Contact Numbers</h2>
    <p>Save these numbers for emergencies</p>
    <div class="emergency-grid">
        <div class="emergency-card">
            <i class="fas fa-phone-alt"></i>
            <h3>Police</h3>
            <div class="num">100</div>
        </div>
        <div class="emergency-card">
            <i class="fas fa-ambulance"></i>
            <h3>Ambulance</h3>
            <div class="num">108</div>
        </div>
        <div class="emergency-card">
            <i class="fas fa-fire-extinguisher"></i>
            <h3>Fire</h3>
            <div class="num">101</div>
        </div>
    </div>
    <p style="margin-bottom: 20px; color: #fecaca;">Need help or want to report an issue?</p>
    <button class="emergency-cta-btn" onclick="window.location.href='${pageContext.request.contextPath}/contact'">Contact Support</button>
</div>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
