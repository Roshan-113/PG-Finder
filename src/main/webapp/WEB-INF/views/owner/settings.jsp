<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="mb-8">
    <h1 class="text-3xl font-bold text-gray-900">Settings</h1>
    <p class="text-gray-600 mt-2">Manage your account preferences</p>
</div>

<div class="grid grid-cols-3 gap-8">
    <!-- Settings Menu -->
    <div class="col-span-1">
        <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-4">
            <nav class="space-y-1">
                <a href="#account" class="flex items-center gap-3 px-4 py-3 rounded-lg bg-blue-50 text-blue-600 font-medium">
                    <i class="fas fa-user"></i>
                    <span>Account</span>
                </a>
                <a href="#security" class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-50">
                    <i class="fas fa-lock"></i>
                    <span>Security</span>
                </a>
                <a href="#notifications" class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-50">
                    <i class="fas fa-bell"></i>
                    <span>Notifications</span>
                </a>
                <a href="#privacy" class="flex items-center gap-3 px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-50">
                    <i class="fas fa-shield-alt"></i>
                    <span>Privacy</span>
                </a>
            </nav>
        </div>
    </div>

    <!-- Settings Content -->
    <div class="col-span-2 space-y-6">
        <!-- Account Settings -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
            <h3 class="text-lg font-bold text-gray-900 mb-6">Account Settings</h3>
            <div class="space-y-4">
                <div style="display: flex; justify-content: space-between; align-items: center; padding: 1rem 0; border-bottom: 1px solid #e5e7eb;">
                    <div>
                        <div style="font-weight: 600; color: #111827;">Email Notifications</div>
                        <div style="font-size: 0.875rem; color: #6b7280;">Receive email updates about your properties</div>
                    </div>
                    <label style="display: inline-flex; align-items: center; cursor: pointer;">
                        <input type="checkbox" checked onchange="toggleNotification('email', this.checked)" style="width: 20px; height: 20px; cursor: pointer;">
                    </label>
                </div>
                <div style="display: flex; justify-content: space-between; align-items: center; padding: 1rem 0; border-bottom: 1px solid #e5e7eb;">
                    <div>
                        <div style="font-weight: 600; color: #111827;">SMS Notifications</div>
                        <div style="font-size: 0.875rem; color: #6b7280;">Get SMS alerts for bookings</div>
                    </div>
                    <label style="display: inline-flex; align-items: center; cursor: pointer;">
                        <input type="checkbox" checked onchange="toggleNotification('sms', this.checked)" style="width: 20px; height: 20px; cursor: pointer;">
                    </label>
                </div>
                <div style="display: flex; justify-content: space-between; align-items: center; padding: 1rem 0;">
                    <div>
                        <div style="font-weight: 600; color: #111827;">Marketing Emails</div>
                        <div style="font-size: 0.875rem; color: #6b7280;">Receive promotional content</div>
                    </div>
                    <label style="display: inline-flex; align-items: center; cursor: pointer;">
                        <input type="checkbox" onchange="toggleNotification('marketing', this.checked)" style="width: 20px; height: 20px; cursor: pointer;">
                    </label>
                </div>
            </div>
        </div>

        <!-- Change Password -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
            <h3 class="text-lg font-bold text-gray-900 mb-6">Change Password</h3>
            <form id="passwordForm" onsubmit="validatePasswordForm(event)" class="space-y-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Current Password</label>
                    <input type="password" id="currentPassword" name="currentPassword"
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">New Password</label>
                    <input type="password" id="newPassword" name="newPassword"
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Confirm New Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword"
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                </div>
                <button type="submit" 
                        class="px-6 py-3 rounded-lg font-semibold text-white transition-all shadow-md"
                        style="background-color: #3b82f6;">
                    Update Password
                </button>
            </form>
        </div>

        <!-- Danger Zone -->
        <div class="bg-white rounded-xl shadow-sm border border-red-200 p-6">
            <h3 class="text-lg font-bold text-red-600 mb-4">Danger Zone</h3>
            <p class="text-sm text-gray-600 mb-4">Once you delete your account, there is no going back. Please be certain.</p>
            <button onclick="confirmDeleteAccount()" class="px-6 py-3 rounded-lg font-semibold text-white transition-colors" style="background-color: #dc2626; display: inline-block;">
                <i class="fas fa-trash-alt"></i> Delete Account
            </button>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/owner-validation.js"></script>
<script>
function validatePasswordForm(event) {
    event.preventDefault();
    
    const currentPassword = document.getElementById('currentPassword').value;
    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    
    if (!currentPassword || !newPassword || !confirmPassword) {
        alert('Please fill all password fields');
        return false;
    }
    
    if (newPassword.length < 8) {
        alert('New password must be at least 8 characters long');
        return false;
    }
    
    if (newPassword !== confirmPassword) {
        alert('New passwords do not match');
        return false;
    }
    
    const formData = new FormData();
    formData.append('action', 'changePassword');
    formData.append('currentPassword', currentPassword);
    formData.append('newPassword', newPassword);
    formData.append('confirmPassword', confirmPassword);
    
    const submitBtn = event.target.querySelector('button[type="submit"]');
    const originalText = submitBtn.innerHTML;
    submitBtn.disabled = true;
    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Updating...';
    
    fetch('${pageContext.request.contextPath}/owner/settings', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'action=changePassword&currentPassword=' + encodeURIComponent(currentPassword) + 
              '&newPassword=' + encodeURIComponent(newPassword) + 
              '&confirmPassword=' + encodeURIComponent(confirmPassword)
    })
    .then(response => response.json())
    .then(data => {
        alert(data.message);
        if (data.success) {
            document.getElementById('passwordForm').reset();
        }
        submitBtn.disabled = false;
        submitBtn.innerHTML = originalText;
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred');
        submitBtn.disabled = false;
        submitBtn.innerHTML = originalText;
    });
    
    return false;
}

function confirmDeleteAccount() {
    if (confirm('Are you sure you want to delete your account? This action cannot be undone.')) {
        if (confirm('This will permanently delete all your data. Are you absolutely sure?')) {
            alert('Account deletion requested. Please contact support to complete this process.');
        }
    }
}

function toggleNotification(type, enabled) {
    console.log('Toggle ' + type + ' notification: ' + enabled);
    // You can add AJAX call here to save preference to database
    // For now, just log it
}
</script>
