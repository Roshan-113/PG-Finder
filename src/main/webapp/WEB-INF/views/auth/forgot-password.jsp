<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - PG Finder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth-validation.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body style="min-height: 100vh; background: linear-gradient(to bottom right, #eff6ff, #dbeafe); display: flex; align-items: center; justify-content: center; padding: 3rem 1rem;">
    <div class="max-w-md w-full">
        <div id="step1">
            <!-- Header -->
            <div class="text-center mb-8">
                <div class="inline-flex items-center justify-center w-16 h-16 rounded-full mb-4" style="background-color: var(--color-primary-600);">
                    <i class="fas fa-lock text-white" style="font-size: 32px;"></i>
                </div>
                <h2 class="text-3xl font-bold text-gray-900 mb-2">Forgot Password?</h2>
                <p class="text-gray-600">No worries, we'll send you reset instructions</p>
            </div>

            <!-- Form -->
            <div class="bg-white rounded-2xl shadow-xl p-8">
                <form id="forgotPasswordForm" onsubmit="showSuccess(event)" class="space-y-6">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Email Address</label>
                        <div class="relative">
                            <i class="fas fa-envelope absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400" style="font-size: 20px;"></i>
                            <input type="email" id="email" name="email"
                                   class="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                                   placeholder="Enter your email" />
                        </div>
                        <p id="errorMsg" class="text-red-500 text-sm mt-1" style="display: none;"></p>
                    </div>

                    <button type="submit" id="submitBtn"
                            class="w-full px-6 py-3 text-white rounded-lg font-medium transition-colors"
                            style="background-color: var(--color-primary-600);">
                        Send Reset Link
                    </button>
                </form>

                <div class="mt-6 text-center">
                    <a href="${pageContext.request.contextPath}/login" class="flex items-center justify-center gap-2 text-primary-600 hover:text-primary-700 font-medium">
                        <i class="fas fa-arrow-left" style="font-size: 16px;"></i>
                        Back to Login
                    </a>
                </div>
            </div>
        </div>

        <!-- Success State (Hidden Initially) -->
        <div id="step2" style="display: none;">
            <div class="text-center mb-8">
                <div class="inline-flex items-center justify-center w-16 h-16 rounded-full mb-4" style="background-color: #dcfce7;">
                    <i class="fas fa-check-circle" style="font-size: 32px; color: #16a34a;"></i>
                </div>
                <h2 class="text-3xl font-bold text-gray-900 mb-2">Check Your Email</h2>
                <p class="text-gray-600">We've sent password reset instructions to</p>
                <p class="text-primary-600 font-medium mt-2" id="emailDisplay"></p>
            </div>

            <div class="bg-white rounded-2xl shadow-xl p-8">
                <div class="space-y-4 mb-6">
                    <div class="rounded-lg p-4" style="background-color: #eff6ff; border: 1px solid #bfdbfe;">
                        <h3 class="font-semibold text-gray-900 mb-2">What's next?</h3>
                        <ul class="space-y-2 text-sm text-gray-700">
                            <li class="flex items-start gap-2">
                                <span class="text-primary-600 mt-0.5">1.</span>
                                <span>Check your email inbox (and spam folder)</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-primary-600 mt-0.5">2.</span>
                                <span>Click the reset password link in the email</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="text-primary-600 mt-0.5">3.</span>
                                <span>Create a new password for your account</span>
                            </li>
                        </ul>
                    </div>

                    <p class="text-sm text-gray-600 text-center">
                        Didn't receive the email? 
                        <button onclick="showStep1()" class="text-primary-600 hover:text-primary-700 font-medium">
                            Try again
                        </button>
                    </p>
                </div>

                <a href="${pageContext.request.contextPath}/login"
                   class="block w-full px-6 py-3 text-center text-white rounded-lg font-medium transition-colors"
                   style="background-color: var(--color-primary-600);">
                    Back to Login
                </a>
            </div>
        </div>

        <!-- Help Text -->
        <div class="mt-6 text-center">
            <p class="text-sm text-gray-600">
                Need help? 
                <a href="#" class="text-primary-600 hover:text-primary-700 font-medium">Contact Support</a>
            </p>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/auth-validation.js"></script>
    <script>
        function showSuccess(event) {
            event.preventDefault();
            const email = document.getElementById('email').value;
            const submitBtn = document.getElementById('submitBtn');
            
            submitBtn.textContent = 'Sending...';
            submitBtn.disabled = true;
            
            setTimeout(() => {
                document.getElementById('emailDisplay').textContent = email;
                document.getElementById('step1').style.display = 'none';
                document.getElementById('step2').style.display = 'block';
            }, 1500);
        }

        function showStep1() {
            document.getElementById('step1').style.display = 'block';
            document.getElementById('step2').style.display = 'none';
            document.getElementById('submitBtn').textContent = 'Send Reset Link';
            document.getElementById('submitBtn').disabled = false;
        }
    </script>

    <style>
        .space-y-2 > * + * { margin-top: 0.5rem; }
        .space-y-4 > * + * { margin-top: 1rem; }
        .space-y-6 > * + * { margin-top: 1.5rem; }
    </style>
</body>
</html>
