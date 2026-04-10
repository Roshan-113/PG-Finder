<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="currentPage" value="profile" scope="request" />

<div style="padding: 2rem; max-width: 900px; margin: 0 auto;">
    <h1 style="margin-bottom: 2rem; font-size: 2rem; font-weight: 700;">My Profile</h1>
    
    <!-- Success/Error Messages -->
    <c:if test="${not empty successMessage}">
        <div style="padding: 1rem; background-color: #dcfce7; border: 1px solid #86efac; border-radius: 0.5rem; margin-bottom: 1.5rem; color: #166534;">
            <i class="fas fa-check-circle"></i> ${successMessage}
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div style="padding: 1rem; background-color: #fee2e2; border: 1px solid #fca5a5; border-radius: 0.5rem; margin-bottom: 1.5rem; color: #991b1b;">
            <i class="fas fa-exclamation-circle"></i> ${errorMessage}
        </div>
    </c:if>
    
    <!-- Profile Information Card -->
    <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm mb-6">
        <div style="display: flex; align-items: center; gap: 2rem; margin-bottom: 2rem;">
            <div style="width: 100px; height: 100px; background-color: #dbeafe; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                <c:choose>
                    <c:when test="${not empty sessionScope.userName}">
                        <span style="font-size: 48px; color: #3b82f6; font-weight: 600;">${sessionScope.userName.substring(0, 1).toUpperCase()}</span>
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-user" style="font-size: 48px; color: #3b82f6;"></i>
                    </c:otherwise>
                </c:choose>
            </div>
            <div>
                <h2 style="font-size: 1.5rem; font-weight: 600;">${sessionScope.userName != null ? sessionScope.userName : 'Tenant'}</h2>
                <p style="color: #6b7280;">Tenant Account</p>
                <p style="color: #6b7280; font-size: 0.875rem;">${sessionScope.userEmail}</p>
            </div>
        </div>

        <form id="profileForm" method="post" action="${pageContext.request.contextPath}/tenant/profile">
            <input type="hidden" name="action" value="updateProfile">
            <div style="display: grid; gap: 1rem;">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Full Name *</label>
                    <div style="position: relative;">
                        <i class="fas fa-user" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: #6b7280; font-size: 18px;"></i>
                        <input type="text" id="name" name="name" value="${sessionScope.userName != null ? sessionScope.userName : ''}" 
                               style="width: 100%; padding: 0.75rem 1rem 0.75rem 2.5rem; border: 1px solid #d1d5db; border-radius: 0.5rem; box-sizing: border-box;">
                        <span id="nameError" style="color: #dc2626; font-size: 0.875rem; display: none;"></span>
                    </div>
                </div>
                
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Email</label>
                    <div style="position: relative;">
                        <i class="fas fa-envelope" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: #6b7280; font-size: 18px;"></i>
                        <input type="email" id="email" name="email" value="${sessionScope.userEmail != null ? sessionScope.userEmail : ''}" readonly
                               style="width: 100%; padding: 0.75rem 1rem 0.75rem 2.5rem; border: 1px solid #d1d5db; border-radius: 0.5rem; background: #f9fafb; box-sizing: border-box; cursor: not-allowed;">
                    </div>
                    <p style="color: #6b7280; font-size: 0.75rem; margin-top: 0.25rem;">Email cannot be changed</p>
                </div>
                
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Phone Number</label>
                    <div style="position: relative;">
                        <i class="fas fa-phone" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: #6b7280; font-size: 18px;"></i>
                        <input type="tel" id="phone" name="phone" value="${sessionScope.userPhone != null ? sessionScope.userPhone : ''}" placeholder="Enter 10-digit phone number" maxlength="10"
                               style="width: 100%; padding: 0.75rem 1rem 0.75rem 2.5rem; border: 1px solid #d1d5db; border-radius: 0.5rem; box-sizing: border-box;">
                        <span id="phoneError" style="color: #dc2626; font-size: 0.875rem; display: none;"></span>
                    </div>
                </div>
                
                <button type="submit" style="margin-top: 1rem; padding: 0.75rem 1.5rem; background-color: #2563eb; color: white; font-weight: 600; border-radius: 0.5rem; border: none; cursor: pointer; transition: background-color 0.2s;" onmouseover="this.style.backgroundColor='#1d4ed8'" onmouseout="this.style.backgroundColor='#2563eb'">
                    <i class="fas fa-save"></i> Update Profile
                </button>
            </div>
        </form>
    </div>

    <!-- Change Password Card -->
    <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
        <h3 style="font-size: 1.25rem; font-weight: 600; margin-bottom: 1.5rem;">Change Password</h3>
        
        <form id="passwordForm" method="post" action="${pageContext.request.contextPath}/tenant/profile">
            <input type="hidden" name="action" value="changePassword">
            <div style="display: grid; gap: 1rem;">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Current Password *</label>
                    <div style="position: relative;">
                        <i class="fas fa-lock" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: #6b7280; font-size: 18px;"></i>
                        <input type="password" id="currentPassword" name="currentPassword" placeholder="Enter current password"
                               style="width: 100%; padding: 0.75rem 1rem 0.75rem 2.5rem; border: 1px solid #d1d5db; border-radius: 0.5rem; box-sizing: border-box;">
                        <span id="currentPasswordError" style="color: #dc2626; font-size: 0.875rem; display: none;"></span>
                    </div>
                </div>
                
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">New Password *</label>
                    <div style="position: relative;">
                        <i class="fas fa-lock" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: #6b7280; font-size: 18px;"></i>
                        <input type="password" id="newPassword" name="newPassword" placeholder="Enter new password"
                               style="width: 100%; padding: 0.75rem 1rem 0.75rem 2.5rem; border: 1px solid #d1d5db; border-radius: 0.5rem; box-sizing: border-box;">
                        <span id="newPasswordError" style="color: #dc2626; font-size: 0.875rem; display: none;"></span>
                    </div>
                    <p style="color: #6b7280; font-size: 0.75rem; margin-top: 0.25rem;">Minimum 6 characters</p>
                </div>
                
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Confirm New Password *</label>
                    <div style="position: relative;">
                        <i class="fas fa-lock" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: #6b7280; font-size: 18px;"></i>
                        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm new password"
                               style="width: 100%; padding: 0.75rem 1rem 0.75rem 2.5rem; border: 1px solid #d1d5db; border-radius: 0.5rem; box-sizing: border-box;">
                        <span id="confirmPasswordError" style="color: #dc2626; font-size: 0.875rem; display: none;"></span>
                    </div>
                </div>
                
                <button type="submit" style="margin-top: 1rem; padding: 0.75rem 1.5rem; background-color: #2563eb; color: white; font-weight: 600; border-radius: 0.5rem; border: none; cursor: pointer; transition: background-color 0.2s;" onmouseover="this.style.backgroundColor='#1d4ed8'" onmouseout="this.style.backgroundColor='#2563eb'">
                    <i class="fas fa-key"></i> Change Password
                </button>
            </div>
        </form>
    </div>
</div>

<script>
// Profile form validation
document.getElementById('profileForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    const name = document.getElementById('name').value.trim();
    const phone = document.getElementById('phone').value.trim();
    
    let isValid = true;
    
    // Validate name
    if (name === '') {
        document.getElementById('nameError').textContent = 'Name is required';
        document.getElementById('nameError').style.display = 'block';
        isValid = false;
    } else {
        document.getElementById('nameError').style.display = 'none';
    }
    
    // Validate phone (optional, but if provided must be 10 digits)
    if (phone !== '' && !/^\d{10}$/.test(phone)) {
        document.getElementById('phoneError').textContent = 'Phone must be 10 digits';
        document.getElementById('phoneError').style.display = 'block';
        isValid = false;
    } else {
        document.getElementById('phoneError').style.display = 'none';
    }
    
    if (isValid) {
        this.submit();
    }
});

// Password form validation
document.getElementById('passwordForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    const currentPassword = document.getElementById('currentPassword').value;
    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    
    let isValid = true;
    
    // Validate current password
    if (currentPassword === '') {
        document.getElementById('currentPasswordError').textContent = 'Current password is required';
        document.getElementById('currentPasswordError').style.display = 'block';
        isValid = false;
    } else {
        document.getElementById('currentPasswordError').style.display = 'none';
    }
    
    // Validate new password
    if (newPassword === '') {
        document.getElementById('newPasswordError').textContent = 'New password is required';
        document.getElementById('newPasswordError').style.display = 'block';
        isValid = false;
    } else if (newPassword.length < 6) {
        document.getElementById('newPasswordError').textContent = 'Password must be at least 6 characters';
        document.getElementById('newPasswordError').style.display = 'block';
        isValid = false;
    } else {
        document.getElementById('newPasswordError').style.display = 'none';
    }
    
    // Validate confirm password
    if (confirmPassword === '') {
        document.getElementById('confirmPasswordError').textContent = 'Please confirm your password';
        document.getElementById('confirmPasswordError').style.display = 'block';
        isValid = false;
    } else if (newPassword !== confirmPassword) {
        document.getElementById('confirmPasswordError').textContent = 'Passwords do not match';
        document.getElementById('confirmPasswordError').style.display = 'block';
        isValid = false;
    } else {
        document.getElementById('confirmPasswordError').style.display = 'none';
    }
    
    if (isValid) {
        this.submit();
    }
});
</script>
