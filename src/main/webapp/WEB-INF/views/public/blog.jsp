<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog - PG Finder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f8fafc; color: #1e293b; }

        /* Hero */
        .blog-hero {
            background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 100%);
            padding: 72px 24px 56px;
            text-align: center;
            color: white;
        }
        .blog-hero h1 { font-size: 42px; font-weight: 800; margin-bottom: 12px; letter-spacing: -0.5px; }
        .blog-hero p { font-size: 18px; color: #bfdbfe; max-width: 520px; margin: 0 auto; }

        /* Categories */
        .categories-bar {
            background: white;
            border-bottom: 1px solid #e2e8f0;
            padding: 0 24px;
            display: flex;
            justify-content: center;
            gap: 4px;
            overflow-x: auto;
        }
        .cat-btn {
            padding: 16px 20px;
            border: none;
            background: none;
            font-size: 14px;
            font-weight: 500;
            color: #64748b;
            cursor: pointer;
            border-bottom: 3px solid transparent;
            white-space: nowrap;
            transition: all 0.2s;
        }
        .cat-btn:hover { color: #2563eb; }
        .cat-btn.active { color: #2563eb; border-bottom-color: #2563eb; font-weight: 600; }

        /* Main layout */
        .blog-main { max-width: 1200px; margin: 0 auto; padding: 48px 24px; }

        /* Featured post */
        .featured-post {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            display: grid;
            grid-template-columns: 1fr 1fr;
            margin-bottom: 48px;
            border: 1px solid #e2e8f0;
        }
        .featured-img { position: relative; min-height: 320px; }
        .featured-img img { width: 100%; height: 100%; object-fit: cover; display: block; }
        .featured-badge {
            position: absolute; top: 16px; left: 16px;
            background: #2563eb; color: white;
            padding: 5px 14px; border-radius: 20px;
            font-size: 12px; font-weight: 600; letter-spacing: 0.5px;
        }
        .featured-body {
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .post-meta { display: flex; gap: 16px; color: #94a3b8; font-size: 13px; margin-bottom: 16px; }
        .post-meta span { display: flex; align-items: center; gap: 5px; }
        .featured-body h2 { font-size: 26px; font-weight: 700; color: #0f172a; line-height: 1.3; margin-bottom: 14px; }
        .featured-body p { color: #64748b; line-height: 1.7; margin-bottom: 24px; font-size: 15px; }
        .read-more {
            display: inline-flex; align-items: center; gap: 8px;
            color: #2563eb; font-weight: 600; font-size: 15px;
            text-decoration: none; transition: gap 0.2s;
        }
        .read-more:hover { gap: 12px; }

        /* Posts grid */
        .section-title { font-size: 22px; font-weight: 700; color: #0f172a; margin-bottom: 24px; }
        .posts-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 24px; margin-bottom: 48px; }
        .post-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid #e2e8f0;
            transition: box-shadow 0.2s, transform 0.2s;
        }
        .post-card:hover { box-shadow: 0 8px 24px rgba(0,0,0,0.1); transform: translateY(-2px); }
        .post-card-img { position: relative; height: 200px; overflow: hidden; }
        .post-card-img img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.3s; }
        .post-card:hover .post-card-img img { transform: scale(1.04); }
        .tag-badge {
            position: absolute; top: 12px; left: 12px;
            padding: 4px 10px; border-radius: 20px;
            font-size: 11px; font-weight: 600; color: white;
        }
        .tag-pg { background: #16a34a; }
        .tag-roommate { background: #7c3aed; }
        .tag-city { background: #ea580c; }
        .tag-safety { background: #dc2626; }
        .tag-owner { background: #0284c7; }
        .post-card-body { padding: 20px; }
        .post-card-body .post-meta { margin-bottom: 10px; }
        .post-card-body h3 { font-size: 16px; font-weight: 700; color: #0f172a; line-height: 1.4; margin-bottom: 10px; }
        .post-card-body p { font-size: 14px; color: #64748b; line-height: 1.6; margin-bottom: 14px; }
        .post-card-body .read-more { font-size: 14px; }

        /* Pagination */
        .pagination { display: flex; justify-content: center; align-items: center; gap: 8px; margin-bottom: 64px; }
        .page-btn {
            width: 40px; height: 40px; border-radius: 8px;
            border: 1px solid #e2e8f0; background: white;
            display: flex; align-items: center; justify-content: center;
            cursor: pointer; font-size: 14px; font-weight: 500; color: #64748b;
            transition: all 0.2s;
        }
        .page-btn:hover { border-color: #2563eb; color: #2563eb; }
        .page-btn.active { background: #2563eb; color: white; border-color: #2563eb; }
        .page-btn:disabled { opacity: 0.4; cursor: not-allowed; }

        /* Newsletter */
        .newsletter {
            background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 100%);
            border-radius: 20px;
            padding: 56px 40px;
            text-align: center;
            color: white;
        }
        .newsletter i { font-size: 40px; margin-bottom: 16px; opacity: 0.9; }
        .newsletter h3 { font-size: 28px; font-weight: 700; margin-bottom: 10px; }
        .newsletter p { color: #bfdbfe; font-size: 16px; margin-bottom: 28px; max-width: 480px; margin-left: auto; margin-right: auto; }
        .newsletter-form { display: flex; gap: 12px; max-width: 440px; margin: 0 auto; }
        .newsletter-form input {
            flex: 1; padding: 14px 18px; border-radius: 10px;
            border: none; font-size: 15px; outline: none;
        }
        .newsletter-form button {
            padding: 14px 24px; background: white; color: #2563eb;
            border: none; border-radius: 10px; font-weight: 700;
            font-size: 15px; cursor: pointer; white-space: nowrap;
            transition: background 0.2s;
        }
        .newsletter-form button:hover { background: #f1f5f9; }

        @media (max-width: 768px) {
            .featured-post { grid-template-columns: 1fr; }
            .featured-img { min-height: 220px; }
            .posts-grid { grid-template-columns: 1fr; }
            .newsletter-form { flex-direction: column; }
            .blog-hero h1 { font-size: 28px; }
        }
    </style>
</head>
<body>
<%@ include file="../common/navbar.jsp" %>

<!-- Hero -->
<div class="blog-hero">
    <h1>PG Finder Blog</h1>
    <p>Tips, guides, and insights for finding your perfect PG accommodation</p>
</div>

<!-- Categories -->
<div class="categories-bar">
    <button class="cat-btn active">All Posts</button>
    <button class="cat-btn">PG Tips</button>
    <button class="cat-btn">Roommate Guide</button>
    <button class="cat-btn">City Guides</button>
    <button class="cat-btn">Safety Tips</button>
    <button class="cat-btn">For Owners</button>
</div>

<div class="blog-main">
    <!-- Featured Post -->
    <div class="featured-post">
        <div class="featured-img">
            <img src="https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800&h=600&fit=crop" alt="Featured">
            <span class="featured-badge">Featured</span>
        </div>
        <div class="featured-body">
            <div class="post-meta">
                <span><i class="far fa-calendar"></i> April 5, 2026</span>
                <span><i class="far fa-clock"></i> 5 min read</span>
            </div>
            <h2>10 Essential Tips for First-Time PG Seekers</h2>
            <p>Moving to a new city and looking for your first PG? Here are the essential tips you need to know to find the perfect accommodation that fits your budget and lifestyle.</p>
            <a href="#" class="read-more">Read More <i class="fas fa-arrow-right"></i></a>
        </div>
    </div>

    <!-- Posts Grid -->
    <div class="posts-grid">
        <article class="post-card">
            <div class="post-card-img">
                <img src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=600&h=400&fit=crop" alt="">
                <span class="tag-badge tag-pg">PG Tips</span>
            </div>
            <div class="post-card-body">
                <div class="post-meta"><span><i class="far fa-calendar"></i> Apr 3, 2026</span><span><i class="far fa-clock"></i> 4 min</span></div>
                <h3>How to Choose the Right PG Location</h3>
                <p>Location is everything when it comes to choosing a PG. Learn how to evaluate neighborhoods effectively.</p>
                <a href="#" class="read-more">Read More <i class="fas fa-arrow-right"></i></a>
            </div>
        </article>
        <article class="post-card">
            <div class="post-card-img">
                <img src="https://images.unsplash.com/photo-1556912173-46c336c7fd55?w=600&h=400&fit=crop" alt="">
                <span class="tag-badge tag-roommate">Roommate Guide</span>
            </div>
            <div class="post-card-body">
                <div class="post-meta"><span><i class="far fa-calendar"></i> Apr 1, 2026</span><span><i class="far fa-clock"></i> 6 min</span></div>
                <h3>Finding Compatible Roommates: A Complete Guide</h3>
                <p>Discover the secrets to finding roommates who match your lifestyle and make your PG experience enjoyable.</p>
                <a href="#" class="read-more">Read More <i class="fas fa-arrow-right"></i></a>
            </div>
        </article>
        <article class="post-card">
            <div class="post-card-img">
                <img src="https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=600&h=400&fit=crop" alt="">
                <span class="tag-badge tag-city">City Guides</span>
            </div>
            <div class="post-card-body">
                <div class="post-meta"><span><i class="far fa-calendar"></i> Mar 28, 2026</span><span><i class="far fa-clock"></i> 8 min</span></div>
                <h3>Best Areas for PG in Bangalore 2026</h3>
                <p>Explore the top neighborhoods in Bangalore for PG accommodations, from Koramangala to HSR Layout.</p>
                <a href="#" class="read-more">Read More <i class="fas fa-arrow-right"></i></a>
            </div>
        </article>
        <article class="post-card">
            <div class="post-card-img">
                <img src="https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=600&h=400&fit=crop" alt="">
                <span class="tag-badge tag-safety">Safety Tips</span>
            </div>
            <div class="post-card-body">
                <div class="post-meta"><span><i class="far fa-calendar"></i> Mar 25, 2026</span><span><i class="far fa-clock"></i> 5 min</span></div>
                <h3>Safety Checklist Before Moving to a PG</h3>
                <p>Essential safety measures to verify before finalizing your PG accommodation. Your security matters!</p>
                <a href="#" class="read-more">Read More <i class="fas fa-arrow-right"></i></a>
            </div>
        </article>
        <article class="post-card">
            <div class="post-card-img">
                <img src="https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=600&h=400&fit=crop" alt="">
                <span class="tag-badge tag-pg">PG Tips</span>
            </div>
            <div class="post-card-body">
                <div class="post-meta"><span><i class="far fa-calendar"></i> Mar 22, 2026</span><span><i class="far fa-clock"></i> 7 min</span></div>
                <h3>Budget-Friendly PG Options: Save Money Without Compromise</h3>
                <p>Learn how to find affordable PG accommodations that don't compromise on quality and comfort.</p>
                <a href="#" class="read-more">Read More <i class="fas fa-arrow-right"></i></a>
            </div>
        </article>
        <article class="post-card">
            <div class="post-card-img">
                <img src="https://images.unsplash.com/photo-1497366216548-37526070297c?w=600&h=400&fit=crop" alt="">
                <span class="tag-badge tag-owner">For Owners</span>
            </div>
            <div class="post-card-body">
                <div class="post-meta"><span><i class="far fa-calendar"></i> Mar 20, 2026</span><span><i class="far fa-clock"></i> 6 min</span></div>
                <h3>How to Attract Quality Tenants to Your PG</h3>
                <p>Tips for PG owners on creating attractive listings and finding reliable, long-term tenants.</p>
                <a href="#" class="read-more">Read More <i class="fas fa-arrow-right"></i></a>
            </div>
        </article>
        <article class="post-card">
            <div class="post-card-img">
                <img src="https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b?w=600&h=400&fit=crop" alt="">
                <span class="tag-badge tag-roommate">Roommate Guide</span>
            </div>
            <div class="post-card-body">
                <div class="post-meta"><span><i class="far fa-calendar"></i> Mar 18, 2026</span><span><i class="far fa-clock"></i> 5 min</span></div>
                <h3>Dealing with Roommate Conflicts: A Practical Guide</h3>
                <p>Learn effective strategies to resolve conflicts and maintain harmony with your roommates.</p>
                <a href="#" class="read-more">Read More <i class="fas fa-arrow-right"></i></a>
            </div>
        </article>
        <article class="post-card">
            <div class="post-card-img">
                <img src="https://images.unsplash.com/photo-1524758631624-e2822e304c36?w=600&h=400&fit=crop" alt="">
                <span class="tag-badge tag-pg">PG Tips</span>
            </div>
            <div class="post-card-body">
                <div class="post-meta"><span><i class="far fa-calendar"></i> Mar 15, 2026</span><span><i class="far fa-clock"></i> 4 min</span></div>
                <h3>Essential Amenities to Look for in a PG</h3>
                <p>From WiFi to laundry facilities, here are the must-have amenities for a comfortable PG stay.</p>
                <a href="#" class="read-more">Read More <i class="fas fa-arrow-right"></i></a>
            </div>
        </article>
        <article class="post-card">
            <div class="post-card-img">
                <img src="https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=600&h=400&fit=crop" alt="">
                <span class="tag-badge tag-city">City Guides</span>
            </div>
            <div class="post-card-body">
                <div class="post-meta"><span><i class="far fa-calendar"></i> Mar 12, 2026</span><span><i class="far fa-clock"></i> 7 min</span></div>
                <h3>Mumbai PG Guide: Top Localities for Working Professionals</h3>
                <p>Discover the best areas in Mumbai for PG accommodations near major IT hubs and business districts.</p>
                <a href="#" class="read-more">Read More <i class="fas fa-arrow-right"></i></a>
            </div>
        </article>
    </div>

    <!-- Pagination -->
    <div class="pagination">
        <button class="page-btn" disabled><i class="fas fa-chevron-left"></i></button>
        <button class="page-btn active">1</button>
        <button class="page-btn">2</button>
        <button class="page-btn">3</button>
        <button class="page-btn"><i class="fas fa-chevron-right"></i></button>
    </div>

    <!-- Newsletter -->
    <div class="newsletter">
        <i class="fas fa-envelope"></i>
        <h3>Subscribe to Our Newsletter</h3>
        <p>Get the latest tips, guides, and updates delivered straight to your inbox. Stay informed about PG trends and best practices.</p>
        <form class="newsletter-form" onsubmit="return false;">
            <input type="email" placeholder="Enter your email address">
            <button type="submit">Subscribe</button>
        </form>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>

<script>
    document.querySelectorAll('.cat-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            document.querySelectorAll('.cat-btn').forEach(b => b.classList.remove('active'));
            this.classList.add('active');
        });
    });
</script>
</body>
</html>
