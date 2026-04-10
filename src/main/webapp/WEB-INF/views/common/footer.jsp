<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
#pgf-footer{background:#111827!important;color:#d1d5db!important;padding:56px 0 0!important;font-family:'Segoe UI',sans-serif!important;margin-top:0!important;}
#pgf-footer-inner{max-width:1280px!important;margin:0 auto!important;padding:0 24px!important;}
#pgf-footer-grid{display:grid!important;grid-template-columns:2fr 1fr 1fr 1fr!important;gap:40px!important;padding-bottom:48px!important;border-bottom:1px solid rgba(255,255,255,0.08)!important;}
#pgf-footer .brand-title{font-size:22px!important;font-weight:700!important;color:#fff!important;margin:0 0 10px 0!important;display:flex!important;align-items:center!important;gap:10px!important;}
#pgf-footer .brand-title i{color:#60a5fa!important;}
#pgf-footer .brand-desc{font-size:14px!important;color:#9ca3af!important;line-height:1.7!important;margin:0 0 20px 0!important;max-width:260px!important;}
#pgf-footer .social-row{display:flex!important;gap:10px!important;}
#pgf-footer .social-row a{width:38px!important;height:38px!important;background:rgba(255,255,255,0.08)!important;border-radius:50%!important;display:flex!important;align-items:center!important;justify-content:center!important;color:#9ca3af!important;text-decoration:none!important;font-size:14px!important;transition:all 0.2s!important;}
#pgf-footer .social-row a:hover{background:#2563eb!important;color:#fff!important;}
#pgf-footer .col-title{font-size:15px!important;font-weight:600!important;color:#fff!important;margin:0 0 16px 0!important;}
#pgf-footer .col-list{list-style:none!important;padding:0!important;margin:0!important;display:flex!important;flex-direction:column!important;gap:10px!important;}
#pgf-footer .col-list li{font-size:14px!important;color:#9ca3af!important;display:flex!important;align-items:center!important;gap:8px!important;}
#pgf-footer .col-list li a{font-size:14px!important;color:#9ca3af!important;text-decoration:none!important;transition:color 0.2s!important;}
#pgf-footer .col-list li a:hover{color:#60a5fa!important;}
#pgf-footer .col-list li i{color:#60a5fa!important;font-size:13px!important;flex-shrink:0!important;}
#pgf-footer-bottom{padding:20px 0!important;display:flex!important;align-items:center!important;justify-content:space-between!important;flex-wrap:wrap!important;gap:12px!important;}
#pgf-footer-bottom p{font-size:13px!important;color:#6b7280!important;margin:0!important;}
#pgf-footer-bottom-links{display:flex!important;gap:20px!important;flex-wrap:wrap!important;}
#pgf-footer-bottom-links a{font-size:13px!important;color:#6b7280!important;text-decoration:none!important;transition:color 0.2s!important;}
#pgf-footer-bottom-links a:hover{color:#60a5fa!important;}
@media(max-width:900px){#pgf-footer-grid{grid-template-columns:1fr 1fr!important;}}
@media(max-width:560px){#pgf-footer-grid{grid-template-columns:1fr!important;}#pgf-footer-bottom{flex-direction:column!important;text-align:center!important;}}
</style>
<footer id="pgf-footer">
    <div id="pgf-footer-inner">
        <div id="pgf-footer-grid">
            <div>
                <div class="brand-title">
                    <img src="${pageContext.request.contextPath}/uploads/logo.png" alt="PG Finder" style="height:36px;width:36px;object-fit:contain;border-radius:8px;flex-shrink:0;">
                    PG Finder
                </div>
                <p class="brand-desc">Your trusted platform for finding the perfect PG accommodation across India.</p>
                <div class="social-row">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            <div>
                <div class="col-title">Company</div>
                <ul class="col-list">
                    <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/careers">Careers</a></li>
                    <li><a href="${pageContext.request.contextPath}/blog">Blog</a></li>
                </ul>
            </div>
            <div>
                <div class="col-title">Support</div>
                <ul class="col-list">
                    <li><a href="${pageContext.request.contextPath}/help">Help Center</a></li>
                    <li><a href="${pageContext.request.contextPath}/safety">Safety Tips</a></li>
                    <li><a href="${pageContext.request.contextPath}/faq">FAQs</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
                </ul>
            </div>
            <div>
                <div class="col-title">Contact</div>
                <ul class="col-list">
                    <li><i class="fas fa-envelope"></i> support@pgfinder.com</li>
                    <li><i class="fas fa-phone"></i> +91 98765 43210</li>
                    <li><i class="fas fa-map-marker-alt"></i> Bangalore, India</li>
                </ul>
            </div>
        </div>
        <div id="pgf-footer-bottom">
            <p>&copy; 2026 PG Finder. All rights reserved.</p>
            <div id="pgf-footer-bottom-links">
                <a href="${pageContext.request.contextPath}/terms">Terms of Service</a>
                <a href="${pageContext.request.contextPath}/privacy">Privacy Policy</a>
                <a href="${pageContext.request.contextPath}/cookie-policy">Cookie Policy</a>
            </div>
        </div>
    </div>
</footer>
