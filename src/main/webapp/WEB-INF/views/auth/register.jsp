<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account - PG Finder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth-validation.css">
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
                        <div style="font-size: 0.875rem; opacity: 0.95;">Join Our Growing Community</div>
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
        
        <!-- Right Side - Register Form -->
        <div style="flex: 1; background: #f5f5f5; display: flex; align-items: center; justify-content: center; padding: 2rem; overflow-y: auto;">
            <div style="width: 100%; max-width: 450px;">
                <div style="margin-bottom: 2rem;">
                    <h1 style="margin: 0 0 0.5rem 0; font-size: 2rem; font-weight: bold; color: #1a1a1a;">Create Account</h1>
                    <p style="margin: 0; color: #666; font-size: 1rem;">Join thousands finding their perfect stay</p>
                </div>
                
                <!-- Error Message -->
                <c:if test="${not empty error}">
                    <div style="background: #fef2f2; border: 1px solid #fecaca; border-radius: 0.5rem; padding: 1rem; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.75rem;">
                        <i class="fas fa-exclamation-circle" style="color: #dc2626; font-size: 1.25rem;"></i>
                        <span style="color: #991b1b; font-size: 0.875rem;">${error}</span>
                    </div>
                </c:if>
                
                <form id="registrationForm" action="${pageContext.request.contextPath}/register" method="post">
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
                    
                    <!-- Full Name -->
                    <div style="margin-bottom: 1.25rem;">
                        <label style="display: block; font-size: 0.875rem; font-weight: 500; color: #333; margin-bottom: 0.5rem;">Full Name</label>
                        <div style="position: relative;">
                            <i class="fas fa-user" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: #9ca3af;"></i>
                            <input type="text" id="name" name="name" placeholder="Enter your name"
                                   style="width: 100%; padding: 0.875rem 1rem 0.875rem 2.75rem; border: 1px solid #d1d5db; border-radius: 0.5rem; font-size: 0.875rem; outline: none; transition: border-color 0.2s; box-sizing: border-box;"
                                   onfocus="this.style.borderColor='#2563eb'" onblur="this.style.borderColor='#d1d5db'">
                        </div>
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
                    
                    <!-- Phone -->
                    <div style="margin-bottom: 1.25rem;">
                        <label style="display: block; font-size: 0.875rem; font-weight: 500; color: #333; margin-bottom: 0.5rem;">Phone Number</label>
                        <div style="position: relative;">
                            <i class="fas fa-phone" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: #9ca3af;"></i>
                            <input type="tel" id="phone" name="phone" placeholder="+91 98765 43210" maxlength="10"
                                   style="width: 100%; padding: 0.875rem 1rem 0.875rem 2.75rem; border: 1px solid #d1d5db; border-radius: 0.5rem; font-size: 0.875rem; outline: none; transition: border-color 0.2s; box-sizing: border-box;"
                                   onfocus="this.style.borderColor='#2563eb'" onblur="this.style.borderColor='#d1d5db'">
                        </div>
                    </div>
                    
                    <!-- Password -->
                    <div style="margin-bottom: 1.25rem;">
                        <label style="display: block; font-size: 0.875rem; font-weight: 500; color: #333; margin-bottom: 0.5rem;">Password</label>
                        <div style="position: relative;">
                            <i class="fas fa-lock" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: #9ca3af;"></i>
                            <input type="password" name="password" id="password" placeholder="Create a password"
                                   style="width: 100%; padding: 0.875rem 3rem 0.875rem 2.75rem; border: 1px solid #d1d5db; border-radius: 0.5rem; font-size: 0.875rem; outline: none; transition: border-color 0.2s; box-sizing: border-box;"
                                   onfocus="this.style.borderColor='#2563eb'" onblur="this.style.borderColor='#d1d5db'">
                            <i class="fas fa-eye" id="toggleIcon1" onclick="togglePassword('password', 'toggleIcon1')" 
                               style="position: absolute; right: 1rem; top: 50%; transform: translateY(-50%); color: #9ca3af; cursor: pointer;"></i>
                        </div>
                    </div>
                    
                    <!-- Confirm Password -->
                    <div style="margin-bottom: 1.25rem;">
                        <label style="display: block; font-size: 0.875rem; font-weight: 500; color: #333; margin-bottom: 0.5rem;">Confirm Password</label>
                        <div style="position: relative;">
                            <i class="fas fa-lock" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: #9ca3af;"></i>
                            <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Confirm your password"
                                   style="width: 100%; padding: 0.875rem 3rem 0.875rem 2.75rem; border: 1px solid #d1d5db; border-radius: 0.5rem; font-size: 0.875rem; outline: none; transition: border-color 0.2s; box-sizing: border-box;"
                                   onfocus="this.style.borderColor='#2563eb'" onblur="this.style.borderColor='#d1d5db'">
                            <i class="fas fa-eye" id="toggleIcon2" onclick="togglePassword('confirmPassword', 'toggleIcon2')" 
                               style="position: absolute; right: 1rem; top: 50%; transform: translateY(-50%); color: #9ca3af; cursor: pointer;"></i>
                        </div>
                    </div>
                    
                    <!-- Terms -->
                    <div style="margin-bottom: 1.5rem;">
                        <label style="display: flex; align-items: start; gap: 0.5rem; cursor: pointer; font-size: 0.875rem; color: #666;">
                            <input type="checkbox" name="terms" style="width: 1rem; height: 1rem; margin-top: 0.125rem;">
                            <span>I agree to the <a href="#" style="color: #2563eb; text-decoration: none;">Terms of Service</a> and <a href="#" style="color: #2563eb; text-decoration: none;">Privacy Policy</a></span>
                        </label>
                    </div>
                    
                    <!-- Create Account Button -->
                    <button type="submit" style="width: 100%; padding: 0.875rem; background: #2563eb; color: white; font-weight: 600; border-radius: 0.5rem; border: none; cursor: pointer; font-size: 1rem; transition: background 0.2s; margin-bottom: 1.5rem;"
                            onmouseover="this.style.background='#1d4ed8'" onmouseout="this.style.background='#2563eb'">
                        Create Account <i class="fas fa-arrow-right" style="margin-left: 0.5rem;"></i>
                    </button>
                    
                    <!-- Divider -->
                    <div style="text-align: center; margin-bottom: 1.5rem;">
                        <span style="color: #9ca3af; font-size: 0.875rem;">Or sign up with</span>
                    </div>
                    
                    <!-- Social Login -->
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.75rem; margin-bottom: 1.5rem;">
                        <button type="button" style="padding: 0.75rem; border: 1px solid #d1d5db; background: white; border-radius: 0.5rem; cursor: pointer; display: flex; align-items: center; justify-content: center; gap: 0.5rem; font-size: 0.875rem; font-weight: 500; transition: background 0.2s;"
                                onmouseover="this.style.background='#f9fafb'" onmouseout="this.style.background='white'">
                            <i class="fab fa-google" style="font-size: 1.125rem; color: #ea4335;"></i>
                            Google
                        </button>
                        <button type="button" style="padding: 0.75rem; border: 1px solid #d1d5db; background: white; border-radius: 0.5rem; cursor: pointer; display: flex; align-items: center; justify-content: center; gap: 0.5rem; font-size: 0.875rem; font-weight: 500; transition: background 0.2s;"
                                onmouseover="this.style.background='#f9fafb'" onmouseout="this.style.background='white'">
                            <i class="fab fa-facebook" style="font-size: 1.125rem; color: #1877f2;"></i>
                            Facebook
                        </button>
                    </div>
                    
                    <!-- Sign In Link -->
                    <div style="text-align: center;">
                        <span style="color: #666; font-size: 0.875rem;">Already have an account? </span>
                        <a href="${pageContext.request.contextPath}/login" style="color: #2563eb; font-weight: 600; text-decoration: none; font-size: 0.875rem;">Sign In</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/auth-validation.js"></script>
    <script>
        function togglePassword(inputId, iconId) {
            const input = document.getElementById(inputId);
            const icon = document.getElementById(iconId);
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
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
    </script>
</body>
</html>
