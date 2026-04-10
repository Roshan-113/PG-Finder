<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Careers - PG Finder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f8fafc; color: #1e293b; }

        /* Hero */
        .careers-hero {
            background: linear-gradient(135deg, #0f172a 0%, #1e3a8a 60%, #2563eb 100%);
            padding: 80px 24px 64px;
            text-align: center;
            color: white;
            position: relative;
            overflow: hidden;
        }
        .careers-hero::before {
            content: '';
            position: absolute; top: -80px; left: -80px;
            width: 320px; height: 320px;
            background: rgba(255,255,255,0.05);
            border-radius: 50%;
        }
        .careers-hero::after {
            content: '';
            position: absolute; bottom: -100px; right: -60px;
            width: 400px; height: 400px;
            background: rgba(147,197,253,0.08);
            border-radius: 50%;
        }
        .careers-hero h1 { font-size: 48px; font-weight: 800; margin-bottom: 14px; letter-spacing: -1px; position: relative; z-index: 1; }
        .careers-hero p { font-size: 18px; color: #bfdbfe; max-width: 560px; margin: 0 auto; position: relative; z-index: 1; }

        /* Stats bar */
        .stats-bar {
            background: white;
            border-bottom: 1px solid #e2e8f0;
            padding: 24px;
            display: flex;
            justify-content: center;
            gap: 64px;
        }
        .stat-item { text-align: center; }
        .stat-item .num { font-size: 28px; font-weight: 800; color: #2563eb; }
        .stat-item .lbl { font-size: 13px; color: #64748b; margin-top: 2px; }

        /* Sections */
        .section { max-width: 1100px; margin: 0 auto; padding: 64px 24px; }
        .section-header { text-align: center; margin-bottom: 48px; }
        .section-header h2 { font-size: 34px; font-weight: 800; color: #0f172a; margin-bottom: 10px; }
        .section-header p { font-size: 16px; color: #64748b; }

        /* Why join us */
        .perks-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 24px; }
        .perk-card {
            background: white;
            border-radius: 16px;
            padding: 32px 24px;
            text-align: center;
            border: 1px solid #e2e8f0;
            transition: box-shadow 0.2s, transform 0.2s;
        }
        .perk-card:hover { box-shadow: 0 8px 24px rgba(0,0,0,0.08); transform: translateY(-3px); }
        .perk-icon {
            width: 64px; height: 64px; border-radius: 16px;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 16px; font-size: 26px;
        }
        .perk-icon.blue { background: #dbeafe; color: #2563eb; }
        .perk-icon.green { background: #dcfce7; color: #16a34a; }
        .perk-icon.purple { background: #f3e8ff; color: #7c3aed; }
        .perk-icon.orange { background: #ffedd5; color: #ea580c; }
        .perk-card h3 { font-size: 17px; font-weight: 700; color: #0f172a; margin-bottom: 8px; }
        .perk-card p { font-size: 14px; color: #64748b; line-height: 1.6; }

        /* Jobs section */
        .jobs-section { background: #f1f5f9; padding: 64px 0; }
        .jobs-inner { max-width: 1100px; margin: 0 auto; padding: 0 24px; }
        .job-card {
            background: white;
            border-radius: 14px;
            padding: 28px 32px;
            border: 1px solid #e2e8f0;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 24px;
            transition: box-shadow 0.2s;
        }
        .job-card:hover { box-shadow: 0 4px 16px rgba(0,0,0,0.08); }
        .job-info { flex: 1; }
        .job-title-row { display: flex; align-items: center; gap: 12px; margin-bottom: 10px; flex-wrap: wrap; }
        .job-title-row h3 { font-size: 20px; font-weight: 700; color: #0f172a; }
        .job-type {
            padding: 4px 12px; border-radius: 20px;
            font-size: 12px; font-weight: 600;
        }
        .type-blue { background: #dbeafe; color: #1d4ed8; }
        .type-green { background: #dcfce7; color: #15803d; }
        .type-purple { background: #f3e8ff; color: #6d28d9; }
        .type-orange { background: #ffedd5; color: #c2410c; }
        .job-details { display: flex; gap: 20px; color: #64748b; font-size: 13px; margin-bottom: 12px; flex-wrap: wrap; }
        .job-details span { display: flex; align-items: center; gap: 5px; }
        .job-desc { font-size: 14px; color: #475569; line-height: 1.6; margin-bottom: 14px; }
        .job-tags { display: flex; gap: 8px; flex-wrap: wrap; }
        .job-tag {
            padding: 4px 12px; background: #f1f5f9;
            border-radius: 6px; font-size: 12px;
            color: #475569; font-weight: 500;
        }
        .apply-btn {
            padding: 12px 28px; background: #2563eb; color: white;
            border: none; border-radius: 10px; font-weight: 600;
            font-size: 14px; cursor: pointer; white-space: nowrap;
            transition: background 0.2s;
        }
        .apply-btn:hover { background: #1d4ed8; }

        /* CTA */
        .cta-section {
            background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 100%);
            padding: 72px 24px;
            text-align: center;
            color: white;
        }
        .cta-section i { font-size: 44px; margin-bottom: 16px; opacity: 0.9; }
        .cta-section h2 { font-size: 34px; font-weight: 800; margin-bottom: 12px; }
        .cta-section p { font-size: 17px; color: #bfdbfe; margin-bottom: 28px; }
        .cta-btn {
            padding: 16px 36px; background: white; color: #2563eb;
            border: none; border-radius: 12px; font-weight: 700;
            font-size: 16px; cursor: pointer; transition: background 0.2s;
        }
        .cta-btn:hover { background: #f1f5f9; }

        @media (max-width: 768px) {
            .perks-grid { grid-template-columns: repeat(2, 1fr); }
            .stats-bar { gap: 32px; }
            .job-card { flex-direction: column; align-items: flex-start; }
            .careers-hero h1 { font-size: 32px; }
        }
    </style>
</head>
<body>
<%@ include file="../common/navbar.jsp" %>

<!-- Hero -->
<div class="careers-hero">
    <h1>Join Our Team</h1>
    <p>Help us revolutionize the PG accommodation industry and make a difference in people's lives</p>
</div>

<!-- Stats -->
<div class="stats-bar">
    <div class="stat-item"><div class="num">50+</div><div class="lbl">Team Members</div></div>
    <div class="stat-item"><div class="num">4</div><div class="lbl">Open Positions</div></div>
    <div class="stat-item"><div class="num">4.8★</div><div class="lbl">Glassdoor Rating</div></div>
    <div class="stat-item"><div class="num">100%</div><div class="lbl">Remote Friendly</div></div>
</div>

<!-- Why Join Us -->
<div class="section">
    <div class="section-header">
        <h2>Why Work With Us?</h2>
        <p>We're building something special, and we want you to be part of it</p>
    </div>
    <div class="perks-grid">
        <div class="perk-card">
            <div class="perk-icon blue"><i class="fas fa-rocket"></i></div>
            <h3>Fast Growth</h3>
            <p>Join a rapidly growing startup with endless opportunities to advance your career</p>
        </div>
        <div class="perk-card">
            <div class="perk-icon green"><i class="fas fa-users"></i></div>
            <h3>Great Team</h3>
            <p>Work with talented, passionate people who genuinely care about the mission</p>
        </div>
        <div class="perk-card">
            <div class="perk-icon purple"><i class="fas fa-laptop-code"></i></div>
            <h3>Remote Friendly</h3>
            <p>Flexible work arrangements and a healthy work-life balance for everyone</p>
        </div>
        <div class="perk-card">
            <div class="perk-icon orange"><i class="fas fa-chart-line"></i></div>
            <h3>Career Growth</h3>
            <p>Clear career paths, mentorship, and continuous learning opportunities</p>
        </div>
    </div>
</div>

<!-- Open Positions -->
<div class="jobs-section">
    <div class="jobs-inner">
        <div class="section-header">
            <h2>Open Positions</h2>
            <p>Find your perfect role and apply today</p>
        </div>

        <div class="job-card">
            <div class="job-info">
                <div class="job-title-row">
                    <h3>Full Stack Developer</h3>
                    <span class="job-type type-blue">Full-time</span>
                </div>
                <div class="job-details">
                    <span><i class="fas fa-map-marker-alt"></i> Bangalore / Remote</span>
                    <span><i class="fas fa-briefcase"></i> 2–4 years</span>
                    <span><i class="fas fa-rupee-sign"></i> 8–15 LPA</span>
                </div>
                <p class="job-desc">We're looking for a talented full stack developer to help build and scale our platform. Experience with Java, Spring Boot, React, and MySQL required.</p>
                <div class="job-tags">
                    <span class="job-tag">Java</span>
                    <span class="job-tag">Spring Boot</span>
                    <span class="job-tag">React</span>
                    <span class="job-tag">MySQL</span>
                </div>
            </div>
            <button class="apply-btn" onclick="window.location.href='${pageContext.request.contextPath}/contact'">Apply Now</button>
        </div>

        <div class="job-card">
            <div class="job-info">
                <div class="job-title-row">
                    <h3>Product Designer</h3>
                    <span class="job-type type-green">Full-time</span>
                </div>
                <div class="job-details">
                    <span><i class="fas fa-map-marker-alt"></i> Bangalore / Remote</span>
                    <span><i class="fas fa-briefcase"></i> 3–5 years</span>
                    <span><i class="fas fa-rupee-sign"></i> 10–18 LPA</span>
                </div>
                <p class="job-desc">Join our design team to create beautiful, intuitive user experiences. Strong portfolio and experience with Figma required.</p>
                <div class="job-tags">
                    <span class="job-tag">UI/UX</span>
                    <span class="job-tag">Figma</span>
                    <span class="job-tag">User Research</span>
                    <span class="job-tag">Prototyping</span>
                </div>
            </div>
            <button class="apply-btn" onclick="window.location.href='${pageContext.request.contextPath}/contact'">Apply Now</button>
        </div>

        <div class="job-card">
            <div class="job-info">
                <div class="job-title-row">
                    <h3>Marketing Manager</h3>
                    <span class="job-type type-purple">Full-time</span>
                </div>
                <div class="job-details">
                    <span><i class="fas fa-map-marker-alt"></i> Bangalore</span>
                    <span><i class="fas fa-briefcase"></i> 4–6 years</span>
                    <span><i class="fas fa-rupee-sign"></i> 12–20 LPA</span>
                </div>
                <p class="job-desc">Lead our marketing efforts to grow our user base. Experience in digital marketing, SEO, and content strategy required.</p>
                <div class="job-tags">
                    <span class="job-tag">Digital Marketing</span>
                    <span class="job-tag">SEO</span>
                    <span class="job-tag">Content Strategy</span>
                    <span class="job-tag">Analytics</span>
                </div>
            </div>
            <button class="apply-btn" onclick="window.location.href='${pageContext.request.contextPath}/contact'">Apply Now</button>
        </div>

        <div class="job-card">
            <div class="job-info">
                <div class="job-title-row">
                    <h3>Customer Success Manager</h3>
                    <span class="job-type type-orange">Full-time</span>
                </div>
                <div class="job-details">
                    <span><i class="fas fa-map-marker-alt"></i> Bangalore / Remote</span>
                    <span><i class="fas fa-briefcase"></i> 2–4 years</span>
                    <span><i class="fas fa-rupee-sign"></i> 6–12 LPA</span>
                </div>
                <p class="job-desc">Help our users succeed by providing excellent support and building strong relationships. Great communication skills required.</p>
                <div class="job-tags">
                    <span class="job-tag">Customer Support</span>
                    <span class="job-tag">Communication</span>
                    <span class="job-tag">Problem Solving</span>
                </div>
            </div>
            <button class="apply-btn" onclick="window.location.href='${pageContext.request.contextPath}/contact'">Apply Now</button>
        </div>
    </div>
</div>

<!-- CTA -->
<div class="cta-section">
    <i class="fas fa-envelope"></i>
    <h2>Don't See Your Role?</h2>
    <p>We're always looking for talented people. Send us your resume and let's talk!</p>
    <button class="cta-btn" onclick="window.location.href='${pageContext.request.contextPath}/contact'">Get in Touch</button>
</div>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
