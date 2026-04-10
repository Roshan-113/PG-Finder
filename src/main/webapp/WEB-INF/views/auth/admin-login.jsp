<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - PG Finder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth-validation.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body style="margin: 0; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;">
    <!-- Full Screen Background with Image -->
    <div style="min-height: 100vh; display: flex; align-items: center; justify-content: center; position: relative; overflow: hidden;">
        <!-- Background Image -->
        <div style="position: absolute; inset: 0; background-image: url('https://images.unsplash.com/photo-1497366216548-37526070297c?w=1920&h=1080&fit=crop'); background-size: cover; background-position: center;"></div>
        
        <!-- Blue Gradient Overlay -->
        <div style="position: absolute; inset: 0; background: linear-gradient(135deg, rgba(37, 99, 235, 0.95) 0%, rgba(29, 78, 216, 0.92) 50%, rgba(30, 64, 175, 0.95) 100%);"></div>
        
        <!-- Pattern Overlay -->
        <div style="position: absolute; inset: 0; opacity: 0.08; background-image: url('data:image/svg+xml,%3Csvg width=\'60\' height=\'60\' viewBox=\'0 0 60 60\' xmlns=\'http://www.w3.org/2000/svg\'%3E%3Cg fill=\'none\' fill-rule=\'evenodd\'%3E%3Cg fill=\'%23ffffff\' fill-opacity=\'1\'%3E%3Cpath d=\'M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z\'/%3E%3C/g%3E%3C/g%3E%3C/svg%3e');"></div>
        
        <!-- Login Card -->
        <div style="position: relative; z-index: 10; width: 100%; max-width: 420px; margin: 0 1rem;">
            <div style="background: white; border-radius: 1rem; box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25); padding: 3rem;">
                    <div style="text-align: center; margin-bottom: 2.5rem;">
                    <img src="${pageContext.request.contextPath}/uploads/logo.png" alt="PG Finder" style="height: 56px; width: auto; object-fit: contain; margin-bottom: 1rem;">
                    <h1 style="margin: 0 0 0.5rem 0; font-size: 1.875rem; font-weight: bold; color: #1a1a1a;">PG FINDER</h1>
                    <div style="display: inline-flex; align-items: center; justify-content: center; width: 3rem; height: 3rem; background: #eff6ff; border-radius: 50%; margin-bottom: 1rem;">
                        <i class="fas fa-shield-alt" style="font-size: 1.5rem; color: #2563eb;"></i>
                    </div>
                    <h2 style="margin: 0 0 0.5rem 0; font-size: 1.5rem; font-weight: bold; color: #1a1a1a;">Admin Login</h2>
                    <p style="margin: 0; color: #6b7280; font-size: 0.875rem;">Access admin dashboard</p>
                </div>

                <!-- Error Message -->
                <c:if test="${not empty error}">
                    <div style="background: #fef2f2; border: 1px solid #fecaca; border-radius: 0.5rem; padding: 1rem; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.75rem;">
                        <i class="fas fa-exclamation-circle" style="color: #dc2626; font-size: 1.25rem;"></i>
                        <span style="color: #991b1b; font-size: 0.875rem;">${error}</span>
                    </div>
                </c:if>

                <!-- Login Form -->
                <form id="adminLoginForm" action="${pageContext.request.contextPath}/admin-login" method="post">
                    <!-- Email -->
                    <div style="margin-bottom: 1.25rem;">
                        <label style="display: block; font-size: 0.875rem; font-weight: 600; color: #1f2937; margin-bottom: 0.5rem;">Email Address</label>
                        <div style="position: relative;">
                            <i class="fas fa-envelope" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: #9ca3af; font-size: 1.125rem;"></i>
                            <input type="email" id="email" name="email" placeholder="name@company.com"
                                   style="width: 100%; padding: 0.875rem 1rem 0.875rem 2.75rem; border: 2px solid #e5e7eb; border-radius: 0.5rem; font-size: 0.875rem; outline: none; transition: all 0.2s; box-sizing: border-box;"
                                   onfocus="this.style.borderColor='#2563eb'; this.style.boxShadow='0 0 0 3px rgba(37, 99, 235, 0.1)'" 
                                   onblur="this.style.borderColor='#e5e7eb'; this.style.boxShadow='none'">
                        </div>
                    </div>

                    <!-- Password -->
                    <div style="margin-bottom: 1rem;">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.5rem;">
                            <label style="font-size: 0.875rem; font-weight: 600; color: #1f2937;">Password</label>
                            <a href="${pageContext.request.contextPath}/forgot-password" style="font-size: 0.75rem; color: #2563eb; text-decoration: none; font-weight: 500;">Forgot password?</a>
                        </div>
                        <div style="position: relative;">
                            <i class="fas fa-lock" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: #9ca3af; font-size: 1.125rem;"></i>
                            <input type="password" name="password" id="password" placeholder="Enter your password"
                                   style="width: 100%; padding: 0.875rem 3rem 0.875rem 2.75rem; border: 2px solid #e5e7eb; border-radius: 0.5rem; font-size: 0.875rem; outline: none; transition: all 0.2s; box-sizing: border-box;"
                                   onfocus="this.style.borderColor='#2563eb'; this.style.boxShadow='0 0 0 3px rgba(37, 99, 235, 0.1)'" 
                                   onblur="this.style.borderColor='#e5e7eb'; this.style.boxShadow='none'">
                            <i class="fas fa-eye" id="toggleIcon" onclick="togglePassword()" 
                               style="position: absolute; right: 1rem; top: 50%; transform: translateY(-50%); color: #9ca3af; cursor: pointer; font-size: 1.125rem;"></i>
                        </div>
                    </div>

                    <!-- Remember Device -->
                    <div style="margin-bottom: 1.5rem;">
                        <label style="display: flex; align-items: center; gap: 0.5rem; cursor: pointer; font-size: 0.875rem; color: #4b5563;">
                            <input type="checkbox" name="remember" style="width: 1.125rem; height: 1.125rem; border-radius: 0.25rem; border: 2px solid #d1d5db; cursor: pointer;">
                            <span>Remember this device</span>
                        </label>
                    </div>

                    <!-- Sign In Button -->
                    <button type="submit" style="width: 100%; padding: 0.875rem; background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%); color: white; font-weight: 600; border-radius: 0.5rem; border: none; cursor: pointer; font-size: 1rem; transition: all 0.2s; box-shadow: 0 4px 6px -1px rgba(37, 99, 235, 0.3); margin-bottom: 1.5rem;"
                            onmouseover="this.style.transform='translateY(-1px)'; this.style.boxShadow='0 10px 15px -3px rgba(37, 99, 235, 0.4)'" 
                            onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 6px -1px rgba(37, 99, 235, 0.3)'">
                        Sign In as Admin <i class="fas fa-arrow-right" style="margin-left: 0.5rem;"></i>
                    </button>

                    <!-- Back to Homepage -->
                    <div style="text-align: center; padding-top: 1rem; border-top: 1px solid #e5e7eb;">
                        <span style="color: #6b7280; font-size: 0.875rem;">Not an admin? </span>
                        <a href="${pageContext.request.contextPath}/" style="color: #2563eb; font-weight: 600; text-decoration: none; font-size: 0.875rem;">Go back to homepage</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/auth-validation.js"></script>
    <script>
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const toggleIcon = document.getElementById('toggleIcon');
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }
    </script>
</body>
</html>
