<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password - PG Finder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth-validation.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body style="min-height: 100vh; background: linear-gradient(to bottom right, #eff6ff, #dbeafe); display: flex; align-items: center; justify-content: center; padding: 3rem 1rem;">
    <div class="max-w-md w-full">
        <!-- Success Message (Hidden Initially) -->
        <div id="successMsg" class="mb-6 rounded-lg p-4 flex items-center gap-3" style="background-color: #dcfce7; border: 1px solid #86efac; display: none;">
            <i class="fas fa-check-circle" style="font-size: 24px; color: #16a34a;"></i>
            <div>
                <p class="font-semibold" style="color: #14532d;">Password Changed Successfully!</p>
                <p class="text-sm" style="color: #166534;">Redirecting to settings...</p>
            </div>
        </div>

        <!-- Header -->
        <div class="text-center mb-8">
            <div class="inline-flex items-center justify-center w-16 h-16 rounded-full mb-4" style="background-color: var(--color-primary-600);">
                <i class="fas fa-lock text-white" style="font-size: 32px;"></i>
            </div>
            <h2 class="text-3xl font-bold text-gray-900 mb-2">Change Password</h2>
            <p class="text-gray-600">Create a strong password to secure your account</p>
        </div>

        <!-- Form -->
        <div class="bg-white rounded-2xl shadow-xl p-8">
            <form id="resetPasswordForm" onsubmit="handleSubmit(event)" class="space-y-6">
                <!-- Current Password -->
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Current Password</label>
                    <div class="relative">
                        <i class="fas fa-lock absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400" style="font-size: 20px;"></i>
                        <input type="password" id="currentPassword" name="currentPassword"
                               class="w-full pl-10 pr-12 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                               placeholder="Enter current password" />
                        <button type="button" onclick="togglePassword('currentPassword', 'toggleIcon1')" 
                                class="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400 hover:text-gray-600">
                            <i class="fas fa-eye" id="toggleIcon1" style="font-size: 20px;"></i>
                        </button>
                    </div>
                    <p id="currentPasswordError" class="text-red-500 text-sm mt-1" style="display: none;"></p>
                </div>

                <!-- New Password -->
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">New Password</label>
                    <div class="relative">
                        <i class="fas fa-lock absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400" style="font-size: 20px;"></i>
                        <input type="password" id="newPassword" name="newPassword" oninput="validatePassword()"
                               class="w-full pl-10 pr-12 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                               placeholder="Enter new password" />
                        <button type="button" onclick="togglePassword('newPassword', 'toggleIcon2')" 
                                class="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400 hover:text-gray-600">
                            <i class="fas fa-eye" id="toggleIcon2" style="font-size: 20px;"></i>
                        </button>
                    </div>
                    <p id="newPasswordError" class="text-red-500 text-sm mt-1" style="display: none;"></p>

                    <!-- Password Requirements -->
                    <div id="passwordRequirements" class="mt-3 space-y-2" style="display: none;">
                        <div class="flex items-center gap-2 text-sm" id="req1">
                            <i class="fas fa-circle-exclamation text-gray-400" style="font-size: 16px;"></i>
                            <span class="text-gray-600">At least 8 characters</span>
                        </div>
                        <div class="flex items-center gap-2 text-sm" id="req2">
                            <i class="fas fa-circle-exclamation text-gray-400" style="font-size: 16px;"></i>
                            <span class="text-gray-600">Contains uppercase letter</span>
                        </div>
                        <div class="flex items-center gap-2 text-sm" id="req3">
                            <i class="fas fa-circle-exclamation text-gray-400" style="font-size: 16px;"></i>
                            <span class="text-gray-600">Contains lowercase letter</span>
                        </div>
                        <div class="flex items-center gap-2 text-sm" id="req4">
                            <i class="fas fa-circle-exclamation text-gray-400" style="font-size: 16px;"></i>
                            <span class="text-gray-600">Contains number</span>
                        </div>
                        <div class="flex items-center gap-2 text-sm" id="req5">
                            <i class="fas fa-circle-exclamation text-gray-400" style="font-size: 16px;"></i>
                            <span class="text-gray-600">Contains special character</span>
                        </div>
                    </div>
                </div>

                <!-- Confirm Password -->
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Confirm New Password</label>
                    <div class="relative">
                        <i class="fas fa-lock absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400" style="font-size: 20px;"></i>
                        <input type="password" id="confirmPassword" name="confirmPassword"
                               class="w-full pl-10 pr-12 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                               placeholder="Confirm new password" />
                        <button type="button" onclick="togglePassword('confirmPassword', 'toggleIcon3')" 
                                class="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400 hover:text-gray-600">
                            <i class="fas fa-eye" id="toggleIcon3" style="font-size: 20px;"></i>
                        </button>
                    </div>
                    <p id="confirmPasswordError" class="text-red-500 text-sm mt-1" style="display: none;"></p>
                </div>

                <!-- Buttons -->
                <div class="flex gap-3 pt-4">
                    <button type="button" onclick="window.history.back()"
                            class="flex-1 px-6 py-3 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 font-medium transition-colors">
                        Cancel
                    </button>
                    <button type="submit" id="submitBtn"
                            class="flex-1 px-6 py-3 text-white rounded-lg font-medium transition-colors"
                            style="background-color: var(--color-primary-600);">
                        Change Password
                    </button>
                </div>
            </form>
        </div>

        <!-- Back to Settings -->
        <div class="text-center mt-6">
            <a href="${pageContext.request.contextPath}/tenant/settings" class="text-primary-600 hover:text-primary-700 font-medium">
                ← Back to Settings
            </a>
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

        function validatePassword() {
            const password = document.getElementById('newPassword').value;
            const requirements = document.getElementById('passwordRequirements');
            
            if (password) {
                requirements.style.display = 'block';
                
                // Check each requirement
                const checks = [
                    { id: 'req1', test: password.length >= 8 },
                    { id: 'req2', test: /[A-Z]/.test(password) },
                    { id: 'req3', test: /[a-z]/.test(password) },
                    { id: 'req4', test: /[0-9]/.test(password) },
                    { id: 'req5', test: /[!@#$%^&*]/.test(password) }
                ];
                
                checks.forEach(check => {
                    const elem = document.getElementById(check.id);
                    const icon = elem.querySelector('i');
                    const span = elem.querySelector('span');
                    
                    if (check.test) {
                        icon.classList.remove('fa-circle-exclamation', 'text-gray-400');
                        icon.classList.add('fa-check-circle', 'text-green-500');
                        span.classList.remove('text-gray-600');
                        span.classList.add('text-green-700');
                    } else {
                        icon.classList.remove('fa-check-circle', 'text-green-500');
                        icon.classList.add('fa-circle-exclamation', 'text-gray-400');
                        span.classList.remove('text-green-700');
                        span.classList.add('text-gray-600');
                    }
                });
            } else {
                requirements.style.display = 'none';
            }
        }

        function handleSubmit(event) {
            event.preventDefault();
            
            const currentPassword = document.getElementById('currentPassword').value;
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            // Clear previous errors
            document.getElementById('currentPasswordError').style.display = 'none';
            document.getElementById('newPasswordError').style.display = 'none';
            document.getElementById('confirmPasswordError').style.display = 'none';
            
            let hasError = false;
            
            // Validate current password
            if (!currentPassword) {
                document.getElementById('currentPasswordError').textContent = 'Current password is required';
                document.getElementById('currentPasswordError').style.display = 'block';
                hasError = true;
            }
            
            // Validate new password
            if (!newPassword) {
                document.getElementById('newPasswordError').textContent = 'New password is required';
                document.getElementById('newPasswordError').style.display = 'block';
                hasError = true;
            } else if (newPassword.length < 8) {
                document.getElementById('newPasswordError').textContent = 'Password must be at least 8 characters';
                document.getElementById('newPasswordError').style.display = 'block';
                hasError = true;
            } else if (!/[A-Z]/.test(newPassword) || !/[a-z]/.test(newPassword) || !/[0-9]/.test(newPassword) || !/[!@#$%^&*]/.test(newPassword)) {
                document.getElementById('newPasswordError').textContent = 'Password does not meet all requirements';
                document.getElementById('newPasswordError').style.display = 'block';
                hasError = true;
            }
            
            // Validate confirm password
            if (!confirmPassword) {
                document.getElementById('confirmPasswordError').textContent = 'Please confirm your password';
                document.getElementById('confirmPasswordError').style.display = 'block';
                hasError = true;
            } else if (newPassword !== confirmPassword) {
                document.getElementById('confirmPasswordError').textContent = 'Passwords do not match';
                document.getElementById('confirmPasswordError').style.display = 'block';
                hasError = true;
            }
            
            // Check if new password is same as current
            if (currentPassword === newPassword) {
                document.getElementById('newPasswordError').textContent = 'New password must be different from current password';
                document.getElementById('newPasswordError').style.display = 'block';
                hasError = true;
            }
            
            if (!hasError) {
                // Show success message
                document.getElementById('successMsg').style.display = 'flex';
                document.getElementById('submitBtn').textContent = 'Changed!';
                document.getElementById('submitBtn').disabled = true;
                
                // Redirect after 2 seconds
                setTimeout(() => {
                    window.location.href = '${pageContext.request.contextPath}/tenant/settings';
                }, 2000);
            }
        }
    </script>

    <style>
        .space-y-2 > * + * { margin-top: 0.5rem; }
        .space-y-6 > * + * { margin-top: 1.5rem; }
    </style>
</body>
</html>
