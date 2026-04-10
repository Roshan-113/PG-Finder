<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div style="background: #f9fafb; min-height: 100vh; padding: 3rem 0;">
    <div style="max-width: 1200px; margin: 0 auto; padding: 0 1.5rem;">
        <!-- Header -->
        <div style="text-align: center; margin-bottom: 3rem;">
            <h1 style="margin: 0 0 1rem 0; font-size: 2.5rem; font-weight: bold; color: #111827;">Contact Us</h1>
            <p style="margin: 0; color: #6b7280; font-size: 1.125rem;">We'd love to hear from you</p>
        </div>

        <c:if test="${not empty success}">
            <div style="max-width: 800px; margin: 0 auto 2rem auto; padding: 1rem; background: #d1fae5; border: 1px solid #10b981; border-radius: 0.5rem; color: #065f46;">
                <i class="fas fa-check-circle"></i> ${success}
            </div>
        </c:if>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem;">
            <!-- Contact Form -->
            <div style="background: white; border-radius: 1rem; padding: 2rem; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                <h2 style="margin: 0 0 1.5rem 0; font-size: 1.5rem; font-weight: 700; color: #111827;">Send us a Message</h2>
                
                <form id="contactForm" method="post" action="${pageContext.request.contextPath}/contact">
                    <div style="display: flex; flex-direction: column; gap: 1.25rem;">
                        <div>
                            <label style="display: block; font-size: 0.875rem; font-weight: 600; color: #374151; margin-bottom: 0.5rem;">Your Name *</label>
                            <input type="text" id="name" name="name"
                                   style="width: 100%; padding: 0.75rem; border: 1px solid #d1d5db; border-radius: 0.5rem; font-size: 0.875rem;">
                        </div>
                        
                        <div>
                            <label style="display: block; font-size: 0.875rem; font-weight: 600; color: #374151; margin-bottom: 0.5rem;">Email Address *</label>
                            <input type="email" id="email" name="email"
                                   style="width: 100%; padding: 0.75rem; border: 1px solid #d1d5db; border-radius: 0.5rem; font-size: 0.875rem;">
                        </div>
                        
                        <div>
                            <label style="display: block; font-size: 0.875rem; font-weight: 600; color: #374151; margin-bottom: 0.5rem;">Subject *</label>
                            <input type="text" id="subject" name="subject"
                                   style="width: 100%; padding: 0.75rem; border: 1px solid #d1d5db; border-radius: 0.5rem; font-size: 0.875rem;">
                        </div>
                        
                        <div>
                            <label style="display: block; font-size: 0.875rem; font-weight: 600; color: #374151; margin-bottom: 0.5rem;">Message *</label>
                            <textarea id="message" name="message" rows="5"
                                      style="width: 100%; padding: 0.75rem; border: 1px solid #d1d5db; border-radius: 0.5rem; font-size: 0.875rem;"></textarea>
                        </div>
                        
                        <button type="submit" style="padding: 0.875rem; background: #2563eb; color: white; font-weight: 600; border: none; border-radius: 0.5rem; cursor: pointer; font-size: 1rem; transition: background 0.2s;"
                                onmouseover="this.style.background='#1d4ed8'" onmouseout="this.style.background='#2563eb'">
                            <i class="fas fa-paper-plane"></i> Send Message
                        </button>
                    </div>
                </form>
            </div>

            <!-- Contact Information -->
            <div>
                <div style="background: white; border-radius: 1rem; padding: 2rem; box-shadow: 0 1px 3px rgba(0,0,0,0.1); margin-bottom: 1.5rem;">
                    <h2 style="margin: 0 0 1.5rem 0; font-size: 1.5rem; font-weight: 700; color: #111827;">Get in Touch</h2>
                    
                    <div style="display: flex; flex-direction: column; gap: 1.5rem;">
                        <div style="display: flex; align-items: start; gap: 1rem;">
                            <div style="width: 3rem; height: 3rem; border-radius: 50%; background: #eff6ff; display: flex; align-items: center; justify-content: center; flex-shrink: 0;">
                                <i class="fas fa-envelope" style="color: #2563eb; font-size: 1.25rem;"></i>
                            </div>
                            <div>
                                <h3 style="margin: 0 0 0.25rem 0; font-weight: 600; color: #111827;">Email</h3>
                                <a href="mailto:support@pgfinder.com" style="color: #2563eb; text-decoration: none;">support@pgfinder.com</a>
                            </div>
                        </div>

                        <div style="display: flex; align-items: start; gap: 1rem;">
                            <div style="width: 3rem; height: 3rem; border-radius: 50%; background: #f0fdf4; display: flex; align-items: center; justify-content: center; flex-shrink: 0;">
                                <i class="fas fa-phone" style="color: #10b981; font-size: 1.25rem;"></i>
                            </div>
                            <div>
                                <h3 style="margin: 0 0 0.25rem 0; font-weight: 600; color: #111827;">Phone</h3>
                                <a href="tel:+919876543210" style="color: #2563eb; text-decoration: none;">+91 98765 43210</a>
                            </div>
                        </div>

                        <div style="display: flex; align-items: start; gap: 1rem;">
                            <div style="width: 3rem; height: 3rem; border-radius: 50%; background: #fef3c7; display: flex; align-items: center; justify-content: center; flex-shrink: 0;">
                                <i class="fas fa-map-marker-alt" style="color: #f59e0b; font-size: 1.25rem;"></i>
                            </div>
                            <div>
                                <h3 style="margin: 0 0 0.25rem 0; font-weight: 600; color: #111827;">Address</h3>
                                <p style="margin: 0; color: #6b7280;">Bangalore, India</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Business Hours -->
                <div style="background: linear-gradient(135deg, #2563eb, #1d4ed8); border-radius: 1rem; padding: 2rem; color: white;">
                    <h3 style="margin: 0 0 1rem 0; font-size: 1.25rem; font-weight: 700;">Business Hours</h3>
                    <div style="display: flex; flex-direction: column; gap: 0.5rem; font-size: 0.9375rem;">
                        <div style="display: flex; justify-content: space-between;">
                            <span>Monday - Friday</span>
                            <span>9:00 AM - 6:00 PM</span>
                        </div>
                        <div style="display: flex; justify-content: space-between;">
                            <span>Saturday</span>
                            <span>10:00 AM - 4:00 PM</span>
                        </div>
                        <div style="display: flex; justify-content: space-between;">
                            <span>Sunday</span>
                            <span>Closed</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/auth-validation.js"></script>
