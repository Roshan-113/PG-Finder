<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - PG Finder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body style="margin: 0; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;">
    <div style="display: flex; min-height: 100vh;">
        <!-- Left Side - Blue Gradient with PG Image -->
        <div style="flex: 1; position: relative; overflow: hidden; display: flex; flex-direction: column; justify-content: space-between; color: white;">
            <!-- Background Image -->
            <div style="position: absolute; inset: 0; background-image: url('${pageContext.request.contextPath}/uploads/back.jpg'); background-size: 100% 100%; background-repeat: no-repeat;"></div>
            
            <!-- Blue Gradient Overlay -->
            <div style="position: absolute; inset: 0; background: linear-gradient(135deg, rgba(59, 130, 246, 0.92) 0%, rgba(37, 99, 235, 0.88) 50%, rgba(29, 78, 216, 0.92) 100%);"></div>
            
            <!-- Content -->
            <div style="position: relative; z-index: 10; padding: 3rem;">
                <!-- Logo -->
                <div style="display: flex; align-items: center; gap: 1rem; margin-bottom: 3rem;">
                    <div style="width:52px;height:52px;background:rgba(255,255,255,0.15);border-radius:12px;display:flex;align-items:center;justify-content:center;flex-shrink:0;border:1.5px solid rgba(255,255,255,0.3);">
                        <img src="${pageContext.request.contextPath}/uploads/logo.png" alt="PG Finder" style="height:40px;width:40px;object-fit:contain;">
                    </div>
                    <div>
                        <div style="font-size: 1.75rem; font-weight: bold; text-shadow: 0 2px 4px rgba(0,0,0,0.1);">PG Finder</div>
                        <div style="font-size: 0.875rem; opacity: 0.95;">Your 24/7 PG Discovery Partner</div>
                    </div>
                </div>
                
                <!-- Features -->
                <div style="display: flex; flex-direction: column; gap: 2rem; margin-top: 2rem;">
                    <div style="display: flex; align-items: start; gap: 1rem;">
                        <div style="width: 3rem; height: 3rem; background: rgba(255,255,255,0.2); border-radius: 0.5rem; display: flex; align-items: center; justify-content: center; flex-shrink: 0; backdrop-filter: blur(10px); box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                            <i class="fas fa-shield-alt" style="font-size: 1.5rem;"></i>
                        </div>
                        <div>
                            <h3 style="margin: 0 0 0.5rem 0; font-size: 1.125rem; font-weight: 600; text-shadow: 0 1px 2px rgba(0,0,0,0.1);">100% Verified Listings</h3>
                            <p style="margin: 0; font-size: 0.875rem; opacity: 0.95; line-height: 1.5;">All PG accommodations are verified for your safety and peace of mind.</p>
                        </div>
                    </div>
                    
                    <div style="display: flex; align-items: start; gap: 1rem;">
                        <div style="width: 3rem; height: 3rem; background: rgba(255,255,255,0.2); border-radius: 0.5rem; display: flex; align-items: center; justify-content: center; flex-shrink: 0; backdrop-filter: blur(10px); box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                            <i class="fas fa-users" style="font-size: 1.5rem;"></i>
                        </div>
                        <div>
                            <h3 style="margin: 0 0 0.5rem 0; font-size: 1.125rem; font-weight: 600; text-shadow: 0 1px 2px rgba(0,0,0,0.1);">Smart Roommate Matching</h3>
                            <p style="margin: 0; font-size: 0.875rem; opacity: 0.95; line-height: 1.5;">Find compatible roommates based on your lifestyle and preferences.</p>
                        </div>
                    </div>
                    
                    <div style="display: flex; align-items: start; gap: 1rem;">
                        <div style="width: 3rem; height: 3rem; background: rgba(255,255,255,0.2); border-radius: 0.5rem; display: flex; align-items: center; justify-content: center; flex-shrink: 0; backdrop-filter: blur(10px); box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                            <i class="fas fa-check-circle" style="font-size: 1.5rem;"></i>
                        </div>
                        <div>
                            <h3 style="margin: 0 0 0.5rem 0; font-size: 1.125rem; font-weight: 600; text-shadow: 0 1px 2px rgba(0,0,0,0.1);">Hassle-Free Experience</h3>
                            <p style="margin: 0; font-size: 0.875rem; opacity: 0.95; line-height: 1.5;">Easy booking process with transparent pricing and instant confirmations.</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Stats -->
            <div style="position: relative; z-index: 10; padding: 3rem;">
                <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 2rem;">
                    <div style="text-align: center;">
                        <div style="font-size: 2.5rem; font-weight: bold; margin-bottom: 0.25rem; text-shadow: 0 2px 4px rgba(0,0,0,0.1);">1000+</div>
                        <div style="font-size: 0.875rem; opacity: 0.95;">Verified PGs</div>
                    </div>
                    <div style="text-align: center;">
                        <div style="font-size: 2.5rem; font-weight: bold; margin-bottom: 0.25rem; text-shadow: 0 2px 4px rgba(0,0,0,0.1);">5000+</div>
                        <div style="font-size: 0.875rem; opacity: 0.95;">Happy Tenants</div>
                    </div>
                    <div style="text-align: center;">
                        <div style="font-size: 2.5rem; font-weight: bold; margin-bottom: 0.25rem; text-shadow: 0 2px 4px rgba(0,0,0,0.1);">95%</div>
                        <div style="font-size: 0.875rem; opacity: 0.95;">Success Rate</div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Right Side - Login Form -->
        <div style="flex: 1; background: #f5f5f5; display: flex; align-items: center; justify-content: center; padding: 2rem;">
            <div style="width: 100%; max-width: 450px;">
                <div style="margin-bottom: 2rem;">
                    <h1 style="margin: 0 0 0.5rem 0; font-size: 2rem; font-weight: bold; color: #1a1a1a;">Welcome Back!</h1>
                    <p style="margin: 0; color: #666; font-size: 1rem;">Sign in to continue to PG Finder</p>
                </div>
                
                <!-- Success Message -->
                <c:if test="${not empty success}">
                    <div style="background: #f0fdf4; border: 1px solid #86efac; border-radius: 0.5rem; padding: 1rem; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.75rem;">
                        <i class="fas fa-check-circle" style="color: #16a34a; font-size: 1.25rem;"></i>
                        <span style="color: #166534; font-size: 0.875rem;">${success}</span>
                    </div>
                </c:if>
                
                <!-- Error Message -->
                <c:if test="${not empty error}">
                    <div style="background: #fef2f2; border: 1px solid #fecaca; border-radius: 0.5rem; padding: 1rem; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.75rem;">
                        <i class="fas fa-exclamation-circle" style="color: #dc2626; font-size: 1.25rem;"></i>
                        <span style="color: #991b1b; font-size: 0.875rem;">${error}</span>
                    </div>
                </c:if>
                
                <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post">
                    <!-- User Type Selection -->
                    <div style="margin-bottom: 1.5rem;">
                        <label style="display: block; font-size: 0.875rem; font-weight: 500; color: #333; margin-bottom: 0.75rem;">I am a</label>
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.75rem;">
                            <button type="button" onclick="selectUserType('tenant', this)" 
                                    class="user-type-btn" style="padding: 1rem; border: 2px solid #2563eb; background: #eff6ff; border-radius: 0.5rem; cursor: pointer; transition: all 0.2s;">
                                <i class="fas fa-users" style="font-size: 1.25rem; color: #2563eb; display: block; margin-bottom: 0.5rem;"></i>
                                <div style="font-weight: 600; color: #1e40af; font-size: 0.875rem;">Tenant</div>
                            </button>
                            <button type="button" onclick="selectUserType('owner', this)"
                                    class="user-type-btn" style="padding: 1rem; border: 2px solid #e5e7eb; background: white; border-radius: 0.5rem; cursor: pointer; transition: all 0.2s;">
                                <i class="fas fa-building" style="font-size: 1.25rem; color: #9ca3af; display: block; margin-bottom: 0.5rem;"></i>
                                <div style="font-weight: 600; color: #6b7280; font-size: 0.875rem;">PG Owner</div>
                            </button>
                        </div>
                        <input type="hidden" name="userType" id="userType" value="tenant" />
                    </div>
                    
                    <!-- Email -->
                    <div style="margin-bottom: 1.25rem;">
                        <label style="display: block; font-size: 0.875rem; font-weight: 500; color: #333; margin-bottom: 0.5rem;">Email Address</label>
                        <div style="position: relative;">
                            <i class="fas fa-envelope" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: #9ca3af;"></i>
                            <input type="email" id="email" name="email" placeholder="your@email.com"
                                   style="width: 100%; padding: 0.875rem 1rem 0.875rem 2.75rem; border: 1px solid #d1d5db; border-radius: 0.5rem; font-size: 0.875rem; outline: none; transition: border-color 0.2s; box-sizing: border-box;"
                                   onfocus="this.style.borderColor='#2563eb'" onblur="this.style.borderColor='#d1d5db'">
                        </div>
                    </div>
                    
                    <!-- Password -->
                    <div style="margin-bottom: 1rem;">
                        <label style="display: block; font-size: 0.875rem; font-weight: 500; color: #333; margin-bottom: 0.5rem;">Password</label>
                        <div style="position: relative;">
                            <i class="fas fa-lock" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: #9ca3af;"></i>
                            <input type="password" name="password" id="password" placeholder="Enter your password"
                                   style="width: 100%; padding: 0.875rem 3rem 0.875rem 2.75rem; border: 1px solid #d1d5db; border-radius: 0.5rem; font-size: 0.875rem; outline: none; transition: border-color 0.2s; box-sizing: border-box;"
                                   onfocus="this.style.borderColor='#2563eb'" onblur="this.style.borderColor='#d1d5db'">
                            <i class="fas fa-eye" id="toggleIcon" onclick="togglePassword()" 
                               style="position: absolute; right: 1rem; top: 50%; transform: translateY(-50%); color: #9ca3af; cursor: pointer;"></i>
                        </div>
                    </div>
                    
                    <!-- Remember & Forgot -->
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
                        <label style="display: flex; align-items: center; gap: 0.5rem; cursor: pointer; font-size: 0.875rem; color: #666;">
                            <input type="checkbox" name="remember" style="width: 1rem; height: 1rem;">
                            <span>Remember me</span>
                        </label>
                        <a href="${pageContext.request.contextPath}/forgot-password" style="font-size: 0.875rem; color: #2563eb; text-decoration: none;">Forgot password?</a>
                    </div>
                    
                    
                    <!-- Sign In Button -->
                    <button type="submit" style="width: 100%; padding: 0.875rem; background: #2563eb; color: white; font-weight: 600; border-radius: 0.5rem; border: none; cursor: pointer; font-size: 1rem; transition: background 0.2s; margin-bottom: 1.5rem;"
                            onmouseover="this.style.background='#1d4ed8'" onmouseout="this.style.background='#2563eb'">
                        Sign In <i class="fas fa-arrow-right" style="margin-left: 0.5rem;"></i>
                    </button>
                    
                    <!-- Divider -->
                    <div style="text-align: center; margin-bottom: 1.5rem;">
                        <span style="color: #9ca3af; font-size: 0.875rem;">Or continue with</span>
                    </div>
                    
                    <!-- Social Login -->
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.75rem; margin-bottom: 1.5rem;">
                        <button type="button" onclick="loginWithGoogle()" style="padding: 0.75rem; border: 1px solid #d1d5db; background: white; border-radius: 0.5rem; cursor: pointer; display: flex; align-items: center; justify-content: center; gap: 0.5rem; font-size: 0.875rem; font-weight: 500; transition: background 0.2s;"
                                onmouseover="this.style.background='#f9fafb'" onmouseout="this.style.background='white'">
                            <i class="fab fa-google" style="font-size: 1.125rem; color: #ea4335;"></i>
                            Google
                        </button>
                        <button type="button" onclick="loginWithFacebook()" style="padding: 0.75rem; border: 1px solid #d1d5db; background: white; border-radius: 0.5rem; cursor: pointer; display: flex; align-items: center; justify-content: center; gap: 0.5rem; font-size: 0.875rem; font-weight: 500; transition: background 0.2s;"
                                onmouseover="this.style.background='#f9fafb'" onmouseout="this.style.background='white'">
                            <i class="fab fa-facebook" style="font-size: 1.125rem; color: #1877f2;"></i>
                            Facebook
                        </button>
                    </div>
                    
                    <!-- Sign Up Link -->
                    <div style="text-align: center; margin-bottom: 1rem;">
                        <span style="color: #666; font-size: 0.875rem;">Don't have an account? </span>
                        <a href="${pageContext.request.contextPath}/register" style="color: #2563eb; font-weight: 600; text-decoration: none; font-size: 0.875rem;">Sign up now</a>
                    </div>
                    
                    <!-- Admin Login Link -->
                    <div style="text-align: center; padding-top: 1rem; border-top: 1px solid #e5e7eb;">
                        <a href="${pageContext.request.contextPath}/admin-login" style="color: #6b7280; font-size: 0.875rem; text-decoration: none; display: inline-flex; align-items: center; gap: 0.5rem;">
                            <i class="fas fa-shield-alt"></i>
                            <span>Admin Login</span>
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/auth-validation.js"></script>
    <script src="https://accounts.google.com/gsi/client" async defer></script>
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

        function selectUserType(type, button) {
            document.getElementById('userType').value = type;
            const buttons = document.querySelectorAll('.user-type-btn');
            buttons.forEach(btn => {
                const icon = btn.querySelector('i');
                const text = btn.querySelector('div');
                if (btn === button) {
                    btn.style.borderColor = '#2563eb';
                    btn.style.background = '#eff6ff';
                    icon.style.color = '#2563eb';
                    text.style.color = '#1e40af';
                } else {
                    btn.style.borderColor = '#e5e7eb';
                    btn.style.background = 'white';
                    icon.style.color = '#9ca3af';
                    text.style.color = '#6b7280';
                }
            });
        }

        // Google OAuth Login
        function loginWithGoogle() {
            const userType = document.getElementById('userType').value;
            // Redirect to Google OAuth servlet with user type
            window.location.href = '${pageContext.request.contextPath}/auth/google?userType=' + userType;
        }

        // Facebook OAuth Login
        function loginWithFacebook() {
            alert('Facebook login will be implemented soon. Please use email/password or Google login for now.');
        }

        // Handle Google OAuth callback
        function handleCredentialResponse(response) {
            const userType = document.getElementById('userType').value;
            // Send the credential to your backend
            fetch('${pageContext.request.contextPath}/auth/google/callback', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    credential: response.credential,
                    userType: userType
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    window.location.href = data.redirectUrl;
                } else {
                    alert(data.message || 'Login failed. Please try again.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred during login. Please try again.');
            });
        }
    </script>
</body>
</html>
