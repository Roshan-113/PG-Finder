<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div style="background: #f9fafb;">
    <!-- Hero Section -->
    <div style="background: linear-gradient(135deg, #2563eb, #1d4ed8); color: white; padding: 4rem 0;">
        <div style="max-width: 1200px; margin: 0 auto; padding: 0 1.5rem; text-align: center;">
            <h1 style="margin: 0 0 1rem 0; font-size: 3rem; font-weight: bold;">About PG Finder</h1>
            <p style="margin: 0; font-size: 1.25rem; opacity: 0.9;">Making PG accommodation search simple, safe, and hassle-free</p>
        </div>
    </div>

    <!-- Mission Section -->
    <div style="max-width: 1200px; margin: 0 auto; padding: 4rem 1.5rem;">
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 3rem; align-items: center;">
            <div>
                <h2 style="margin: 0 0 1rem 0; font-size: 2rem; font-weight: bold; color: #111827;">Our Mission</h2>
                <p style="margin: 0 0 1rem 0; color: #6b7280; font-size: 1.125rem; line-height: 1.75;">
                    We're on a mission to revolutionize the way people find and book PG accommodations. Our platform connects tenants with verified PG owners, making the entire process transparent, secure, and efficient.
                </p>
                <p style="margin: 0; color: #6b7280; font-size: 1.125rem; line-height: 1.75;">
                    Whether you're a student, working professional, or someone looking for a comfortable stay, PG Finder helps you discover your perfect home away from home.
                </p>
            </div>
            <div style="background: #eff6ff; border-radius: 1rem; padding: 3rem; text-align: center;">
                <i class="fas fa-home" style="font-size: 5rem; color: #2563eb; margin-bottom: 1rem;"></i>
                <h3 style="margin: 0; font-size: 1.5rem; font-weight: bold; color: #111827;">10,000+ Happy Tenants</h3>
            </div>
        </div>
    </div>

    <!-- Features Section -->
    <div style="background: white; padding: 4rem 0;">
        <div style="max-width: 1200px; margin: 0 auto; padding: 0 1.5rem;">
            <h2 style="margin: 0 0 3rem 0; font-size: 2rem; font-weight: bold; color: #111827; text-align: center;">Why Choose PG Finder?</h2>
            
            <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 2rem;">
                <div style="text-align: center;">
                    <div style="width: 4rem; height: 4rem; border-radius: 50%; background: #eff6ff; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem auto;">
                        <i class="fas fa-shield-alt" style="color: #2563eb; font-size: 1.5rem;"></i>
                    </div>
                    <h3 style="margin: 0 0 0.5rem 0; font-size: 1.25rem; font-weight: 700; color: #111827;">Verified Listings</h3>
                    <p style="margin: 0; color: #6b7280;">All PG listings are verified for authenticity and safety</p>
                </div>

                <div style="text-align: center;">
                    <div style="width: 4rem; height: 4rem; border-radius: 50%; background: #f0fdf4; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem auto;">
                        <i class="fas fa-users" style="color: #10b981; font-size: 1.5rem;"></i>
                    </div>
                    <h3 style="margin: 0 0 0.5rem 0; font-size: 1.25rem; font-weight: 700; color: #111827;">Roommate Matching</h3>
                    <p style="margin: 0; color: #6b7280;">Find compatible roommates based on lifestyle preferences</p>
                </div>

                <div style="text-align: center;">
                    <div style="width: 4rem; height: 4rem; border-radius: 50%; background: #fef3c7; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem auto;">
                        <i class="fas fa-lock" style="color: #f59e0b; font-size: 1.5rem;"></i>
                    </div>
                    <h3 style="margin: 0 0 0.5rem 0; font-size: 1.25rem; font-weight: 700; color: #111827;">Secure Payments</h3>
                    <p style="margin: 0; color: #6b7280;">Safe and encrypted payment processing</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Team Section -->
    <div style="max-width: 1200px; margin: 0 auto; padding: 4rem 1.5rem;">
        <h2 style="margin: 0 0 3rem 0; font-size: 2rem; font-weight: bold; color: #111827; text-align: center;">Our Values</h2>
        
        <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 2rem;">
            <div style="background: white; border-radius: 1rem; padding: 2rem; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                <h3 style="margin: 0 0 1rem 0; font-size: 1.25rem; font-weight: 700; color: #111827;">
                    <i class="fas fa-heart" style="color: #ef4444; margin-right: 0.5rem;"></i>
                    Customer First
                </h3>
                <p style="margin: 0; color: #6b7280;">We prioritize our users' needs and strive to provide the best experience possible.</p>
            </div>

            <div style="background: white; border-radius: 1rem; padding: 2rem; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                <h3 style="margin: 0 0 1rem 0; font-size: 1.25rem; font-weight: 700; color: #111827;">
                    <i class="fas fa-check-circle" style="color: #10b981; margin-right: 0.5rem;"></i>
                    Trust & Transparency
                </h3>
                <p style="margin: 0; color: #6b7280;">We believe in honest communication and transparent processes.</p>
            </div>

            <div style="background: white; border-radius: 1rem; padding: 2rem; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                <h3 style="margin: 0 0 1rem 0; font-size: 1.25rem; font-weight: 700; color: #111827;">
                    <i class="fas fa-lightbulb" style="color: #f59e0b; margin-right: 0.5rem;"></i>
                    Innovation
                </h3>
                <p style="margin: 0; color: #6b7280;">We continuously improve our platform with new features and technologies.</p>
            </div>

            <div style="background: white; border-radius: 1rem; padding: 2rem; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                <h3 style="margin: 0 0 1rem 0; font-size: 1.25rem; font-weight: 700; color: #111827;">
                    <i class="fas fa-handshake" style="color: #2563eb; margin-right: 0.5rem;"></i>
                    Community
                </h3>
                <p style="margin: 0; color: #6b7280;">We build a supportive community of tenants, owners, and roommates.</p>
            </div>
        </div>
    </div>

    <!-- CTA Section -->
    <div style="background: linear-gradient(135deg, #2563eb, #1d4ed8); color: white; padding: 4rem 0;">
        <div style="max-width: 1200px; margin: 0 auto; padding: 0 1.5rem; text-align: center;">
            <h2 style="margin: 0 0 1rem 0; font-size: 2rem; font-weight: bold;">Ready to Find Your Perfect PG?</h2>
            <p style="margin: 0 0 2rem 0; font-size: 1.125rem; opacity: 0.9;">Join thousands of happy tenants who found their home with us</p>
            <a href="${pageContext.request.contextPath}/find-pg" style="padding: 1rem 2rem; background: white; color: #2563eb; font-weight: 600; border-radius: 0.5rem; text-decoration: none; display: inline-block; font-size: 1.125rem;">
                Start Searching
            </a>
        </div>
    </div>
</div>
