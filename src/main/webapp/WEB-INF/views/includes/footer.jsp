<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<footer style="background-color: #111827; color: #d1d5db; padding-top: 3rem; padding-bottom: 1.5rem;">
    <div style="max-width: 80rem; margin: 0 auto; padding: 0 1rem;">
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 2rem; margin-bottom: 2rem;">
            <!-- Brand -->
            <div>
                <div style="display:flex;align-items:center;gap:0.75rem;margin-bottom:1rem;">
                    <div style="width:46px;height:46px;background:rgba(255,255,255,0.15);border-radius:10px;display:flex;align-items:center;justify-content:center;flex-shrink:0;border:1.5px solid rgba(255,255,255,0.3);">
                        <img src="${pageContext.request.contextPath}/uploads/logo.png" alt="PG Finder" style="height:36px;width:36px;object-fit:contain;">
                    </div>
                    <span style="font-size: 1.25rem; font-weight: bold; color: white;">PG Finder</span>
                </div>
                <p style="font-size: 0.875rem; color: #9ca3af; margin-bottom: 1rem; line-height: 1.5;">
                    Find your perfect PG accommodation and compatible roommates with ease. Safe, verified, and hassle-free.
                </p>
                <div class="flex gap-3">
                    <a href="#" style="width: 2.25rem; height: 2.25rem; background-color: #1f2937; border-radius: 0.5rem; display: flex; align-items: center; justify-content: center; transition: background-color 0.2s;"
                       onmouseover="this.style.backgroundColor='#3b82f6'" onmouseout="this.style.backgroundColor='#1f2937'">
                        <i class="fab fa-facebook" style="font-size: 18px; color: #9ca3af;"></i>
                    </a>
                    <a href="#" style="width: 2.25rem; height: 2.25rem; background-color: #1f2937; border-radius: 0.5rem; display: flex; align-items: center; justify-content: center; transition: background-color 0.2s;"
                       onmouseover="this.style.backgroundColor='#3b82f6'" onmouseout="this.style.backgroundColor='#1f2937'">
                        <i class="fab fa-twitter" style="font-size: 18px; color: #9ca3af;"></i>
                    </a>
                    <a href="#" style="width: 2.25rem; height: 2.25rem; background-color: #1f2937; border-radius: 0.5rem; display: flex; align-items: center; justify-content: center; transition: background-color 0.2s;"
                       onmouseover="this.style.backgroundColor='#3b82f6'" onmouseout="this.style.backgroundColor='#1f2937'">
                        <i class="fab fa-instagram" style="font-size: 18px; color: #9ca3af;"></i>
                    </a>
                    <a href="#" style="width: 2.25rem; height: 2.25rem; background-color: #1f2937; border-radius: 0.5rem; display: flex; align-items: center; justify-content: center; transition: background-color 0.2s;"
                       onmouseover="this.style.backgroundColor='#3b82f6'" onmouseout="this.style.backgroundColor='#1f2937'">
                        <i class="fab fa-linkedin" style="font-size: 18px; color: #9ca3af;"></i>
                    </a>
                </div>
            </div>
            
            <!-- Company -->
            <div>
                <h4 style="color: white; font-weight: 600; margin-bottom: 1rem; font-size: 1rem;">Company</h4>
                <ul style="display: flex; flex-direction: column; gap: 0.5rem;">
                    <li><a href="${pageContext.request.contextPath}/about" style="font-size: 0.875rem; color: #9ca3af; text-decoration: none; transition: color 0.2s;"
                           onmouseover="this.style.color='#60a5fa'" onmouseout="this.style.color='#9ca3af'">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact" style="font-size: 0.875rem; color: #9ca3af; text-decoration: none; transition: color 0.2s;"
                           onmouseover="this.style.color='#60a5fa'" onmouseout="this.style.color='#9ca3af'">Contact Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/careers" style="font-size: 0.875rem; color: #9ca3af; text-decoration: none; transition: color 0.2s;"
                           onmouseover="this.style.color='#60a5fa'" onmouseout="this.style.color='#9ca3af'">Careers</a></li>
                    <li><a href="${pageContext.request.contextPath}/blog" style="font-size: 0.875rem; color: #9ca3af; text-decoration: none; transition: color 0.2s;"
                           onmouseover="this.style.color='#60a5fa'" onmouseout="this.style.color='#9ca3af'">Blog</a></li>
                </ul>
            </div>
            
            <!-- Support -->
            <div>
                <h4 style="color: white; font-weight: 600; margin-bottom: 1rem; font-size: 1rem;">Support</h4>
                <ul style="display: flex; flex-direction: column; gap: 0.5rem;">
                    <li><a href="${pageContext.request.contextPath}/help" style="font-size: 0.875rem; color: #9ca3af; text-decoration: none; transition: color 0.2s;"
                           onmouseover="this.style.color='#60a5fa'" onmouseout="this.style.color='#9ca3af'">Help Center</a></li>
                    <li><a href="${pageContext.request.contextPath}/safety" style="font-size: 0.875rem; color: #9ca3af; text-decoration: none; transition: color 0.2s;"
                           onmouseover="this.style.color='#60a5fa'" onmouseout="this.style.color='#9ca3af'">Safety Tips</a></li>
                    <li><a href="${pageContext.request.contextPath}/faq" style="font-size: 0.875rem; color: #9ca3af; text-decoration: none; transition: color 0.2s;"
                           onmouseover="this.style.color='#60a5fa'" onmouseout="this.style.color='#9ca3af'">FAQs</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact" style="font-size: 0.875rem; color: #9ca3af; text-decoration: none; transition: color 0.2s;"
                           onmouseover="this.style.color='#60a5fa'" onmouseout="this.style.color='#9ca3af'">Contact Us</a></li>
                </ul>
            </div>
            
            <!-- Contact -->
            <div>
                <h4 style="color: white; font-weight: 600; margin-bottom: 1rem; font-size: 1rem;">Contact</h4>
                <ul style="display: flex; flex-direction: column; gap: 0.75rem;">
                    <li style="display: flex; align-items: center; gap: 0.5rem; font-size: 0.875rem; color: #9ca3af;">
                        <i class="fas fa-envelope" style="color: #3b82f6; font-size: 16px;"></i>
                        <span>support@pgfinder.com</span>
                    </li>
                    <li style="display: flex; align-items: center; gap: 0.5rem; font-size: 0.875rem; color: #9ca3af;">
                        <i class="fas fa-phone" style="color: #3b82f6; font-size: 16px;"></i>
                        <span>+91 98765 43210</span>
                    </li>
                    <li style="display: flex; align-items: center; gap: 0.5rem; font-size: 0.875rem; color: #9ca3af;">
                        <i class="fas fa-map-marker-alt" style="color: #3b82f6; font-size: 16px;"></i>
                        <span>Bangalore, India</span>
                    </li>
                </ul>
            </div>
        </div>
        
        <!-- Bottom Bar -->
        <div style="border-top: 1px solid #374151; padding-top: 1.5rem;">
            <div style="display: flex; flex-direction: column; justify-content: space-between; align-items: center; gap: 1rem;">
                <p style="font-size: 0.875rem; color: #6b7280;">
                    © 2026 PG Finder. All rights reserved.
                </p>
                <div style="display: flex; flex-wrap: wrap; gap: 1rem; justify-content: center;">
                    <a href="${pageContext.request.contextPath}/terms" style="font-size: 0.875rem; color: #6b7280; text-decoration: none; transition: color 0.2s;"
                       onmouseover="this.style.color='#60a5fa'" onmouseout="this.style.color='#6b7280'">Terms of Service</a>
                    <a href="${pageContext.request.contextPath}/privacy" style="font-size: 0.875rem; color: #6b7280; text-decoration: none; transition: color 0.2s;"
                       onmouseover="this.style.color='#60a5fa'" onmouseout="this.style.color='#6b7280'">Privacy Policy</a>
                    <a href="${pageContext.request.contextPath}/privacy#cookies" style="font-size: 0.875rem; color: #6b7280; text-decoration: none; transition: color 0.2s;"
                       onmouseover="this.style.color='#60a5fa'" onmouseout="this.style.color='#6b7280'">Cookie Policy</a>
                </div>
            </div>
        </div>
    </div>
</footer>

<style>
@media (min-width: 768px) {
    footer > div > div:first-child {
        grid-template-columns: repeat(2, 1fr);
    }
}
@media (min-width: 1024px) {
    footer > div > div:first-child {
        grid-template-columns: repeat(4, 1fr);
    }
}
@media (min-width: 768px) {
    footer > div > div:last-child > div {
        flex-direction: row;
    }
}
</style>
