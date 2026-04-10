// Validation patterns
const patterns = {
    email: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
    phone: /^[6-9]\d{9}$/,
    password: /^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).{8,}$/
};

// Show error message
function showError(fieldId, message) {
    const field = document.getElementById(fieldId);
    if (!field) return;
    
    field.style.borderColor = '#dc2626';
    
    // Remove existing error
    const existingError = document.getElementById(fieldId + '-error');
    if (existingError) {
        existingError.remove();
    }
    
    // Create error message
    const errorDiv = document.createElement('div');
    errorDiv.id = fieldId + '-error';
    errorDiv.style.color = '#dc2626';
    errorDiv.style.fontSize = '14px';
    errorDiv.style.marginTop = '4px';
    errorDiv.textContent = message;
    
    // Insert after the field's parent container
    const container = field.closest('div[style*="position: relative"]') || field.parentElement;
    container.parentElement.insertBefore(errorDiv, container.nextSibling);
}

// Clear error message
function clearError(fieldId) {
    const field = document.getElementById(fieldId);
    if (field) {
        field.style.borderColor = '';
        const error = document.getElementById(fieldId + '-error');
        if (error) {
            error.remove();
        }
    }
}

// Validate email
function validateEmail(fieldId) {
    const field = document.getElementById(fieldId);
    if (!field) return true;
    
    const value = field.value.trim();
    
    if (!value) {
        showError(fieldId, 'Email is required');
        return false;
    }
    
    if (!patterns.email.test(value)) {
        showError(fieldId, 'Please enter a valid email address');
        return false;
    }
    
    clearError(fieldId);
    field.style.borderColor = '#16a34a';
    return true;
}

// Validate phone
function validatePhone(fieldId) {
    const field = document.getElementById(fieldId);
    if (!field) return true;
    
    const value = field.value.trim();
    
    if (!value) {
        showError(fieldId, 'Phone number is required');
        return false;
    }
    
    if (!patterns.phone.test(value)) {
        showError(fieldId, 'Phone must be 10 digits starting with 6-9');
        return false;
    }
    
    clearError(fieldId);
    field.style.borderColor = '#16a34a';
    return true;
}

// Validate password
function validatePassword(fieldId) {
    const field = document.getElementById(fieldId);
    if (!field) return true;
    
    const value = field.value;
    
    if (!value) {
        showError(fieldId, 'Password is required');
        return false;
    }
    
    if (value.length < 8) {
        showError(fieldId, 'Password must be at least 8 characters');
        return false;
    }
    
    if (!patterns.password.test(value)) {
        showError(fieldId, 'Password must include uppercase, lowercase, number and special character');
        return false;
    }
    
    clearError(fieldId);
    field.style.borderColor = '#16a34a';
    return true;
}

// Validate name
function validateName(fieldId) {
    const field = document.getElementById(fieldId);
    if (!field) return true;
    
    const value = field.value.trim();
    
    if (!value) {
        showError(fieldId, 'Name is required');
        return false;
    }
    
    if (value.length < 2) {
        showError(fieldId, 'Name must be at least 2 characters');
        return false;
    }
    
    clearError(fieldId);
    field.style.borderColor = '#16a34a';
    return true;
}

// Validate confirm password
function validateConfirmPassword(passwordId, confirmId) {
    const password = document.getElementById(passwordId);
    const confirm = document.getElementById(confirmId);
    
    if (!password || !confirm) return true;
    
    const confirmValue = confirm.value;
    
    if (!confirmValue) {
        showError(confirmId, 'Please confirm your password');
        return false;
    }
    
    if (password.value !== confirmValue) {
        showError(confirmId, 'Passwords do not match');
        return false;
    }
    
    clearError(confirmId);
    confirm.style.borderColor = '#16a34a';
    return true;
}

// Validate login form
function validateLoginForm() {
    let isValid = true;
    
    if (!validateEmail('email')) {
        isValid = false;
    }
    
    const password = document.getElementById('password');
    if (password && !password.value) {
        showError('password', 'Password is required');
        isValid = false;
    } else if (password) {
        clearError('password');
    }
    
    return isValid;
}

// Validate registration form
function validateRegistrationForm() {
    let isValid = true;
    
    if (!validateName('name')) isValid = false;
    if (!validateEmail('email')) isValid = false;
    if (!validatePhone('phone')) isValid = false;
    if (!validatePassword('password')) isValid = false;
    if (!validateConfirmPassword('password', 'confirmPassword')) isValid = false;
    
    // Check terms checkbox
    const termsCheckbox = document.querySelector('input[name="terms"]');
    if (termsCheckbox && !termsCheckbox.checked) {
        alert('Please accept the Terms of Service and Privacy Policy');
        isValid = false;
    }
    
    return isValid;
}

// Initialize validation on page load
document.addEventListener('DOMContentLoaded', function() {
    
    // Login form
    const loginForm = document.getElementById('loginForm');
    if (loginForm) {
        loginForm.addEventListener('submit', function(e) {
            if (!validateLoginForm()) {
                e.preventDefault();
                e.stopPropagation();
                return false;
            }
        });
        
        // Real-time validation
        const emailField = document.getElementById('email');
        if (emailField) {
            emailField.addEventListener('blur', function() {
                validateEmail('email');
            });
            emailField.addEventListener('input', function() {
                clearError('email');
            });
        }
        
        const passwordField = document.getElementById('password');
        if (passwordField) {
            passwordField.addEventListener('input', function() {
                clearError('password');
            });
        }
    }
    
    // Registration form
    const regForm = document.getElementById('registrationForm');
    if (regForm) {
        regForm.addEventListener('submit', function(e) {
            if (!validateRegistrationForm()) {
                e.preventDefault();
                e.stopPropagation();
                return false;
            }
        });
        
        // Real-time validation
        const nameField = document.getElementById('name');
        if (nameField) {
            nameField.addEventListener('blur', function() {
                validateName('name');
            });
            nameField.addEventListener('input', function() {
                clearError('name');
            });
        }
        
        const emailField = document.getElementById('email');
        if (emailField) {
            emailField.addEventListener('blur', function() {
                validateEmail('email');
            });
            emailField.addEventListener('input', function() {
                clearError('email');
            });
        }
        
        const phoneField = document.getElementById('phone');
        if (phoneField) {
            phoneField.addEventListener('blur', function() {
                validatePhone('phone');
            });
            phoneField.addEventListener('input', function() {
                clearError('phone');
            });
        }
        
        const passwordField = document.getElementById('password');
        if (passwordField) {
            passwordField.addEventListener('blur', function() {
                validatePassword('password');
            });
            passwordField.addEventListener('input', function() {
                clearError('password');
            });
        }
        
        const confirmField = document.getElementById('confirmPassword');
        if (confirmField) {
            confirmField.addEventListener('blur', function() {
                validateConfirmPassword('password', 'confirmPassword');
            });
            confirmField.addEventListener('input', function() {
                clearError('confirmPassword');
            });
        }
    }
    
    // Admin login form
    const adminForm = document.getElementById('adminLoginForm');
    if (adminForm) {
        adminForm.addEventListener('submit', function(e) {
            if (!validateLoginForm()) {
                e.preventDefault();
                e.stopPropagation();
                return false;
            }
        });
        
        // Real-time validation
        const emailField = document.getElementById('email');
        if (emailField) {
            emailField.addEventListener('blur', function() {
                validateEmail('email');
            });
            emailField.addEventListener('input', function() {
                clearError('email');
            });
        }
        
        const passwordField = document.getElementById('password');
        if (passwordField) {
            passwordField.addEventListener('input', function() {
                clearError('password');
            });
        }
    }
    
    // Forgot password form
    const forgotForm = document.getElementById('forgotPasswordForm');
    if (forgotForm) {
        forgotForm.addEventListener('submit', function(e) {
            if (!validateEmail('email')) {
                e.preventDefault();
                e.stopPropagation();
                return false;
            }
        });
        
        const emailField = document.getElementById('email');
        if (emailField) {
            emailField.addEventListener('blur', function() {
                validateEmail('email');
            });
            emailField.addEventListener('input', function() {
                clearError('email');
            });
        }
    }
    
    // Reset password form
    const resetForm = document.getElementById('resetPasswordForm');
    if (resetForm) {
        resetForm.addEventListener('submit', function(e) {
            let isValid = true;
            if (!validatePassword('newPassword')) isValid = false;
            if (!validateConfirmPassword('newPassword', 'confirmPassword')) isValid = false;
            
            if (!isValid) {
                e.preventDefault();
                e.stopPropagation();
                return false;
            }
        });
    }
    
    // Contact form
    const contactForm = document.getElementById('contactForm');
    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            let isValid = true;
            
            // Validate name
            if (!validateName('name')) isValid = false;
            
            // Validate email
            if (!validateEmail('email')) isValid = false;
            
            // Validate subject
            const subject = document.getElementById('subject');
            if (subject && !subject.value.trim()) {
                showError('subject', 'Subject is required');
                isValid = false;
            } else if (subject && subject.value.trim().length < 5) {
                showError('subject', 'Subject must be at least 5 characters');
                isValid = false;
            } else if (subject) {
                clearError('subject');
            }
            
            // Validate message
            const message = document.getElementById('message');
            if (message && !message.value.trim()) {
                showError('message', 'Message is required');
                isValid = false;
            } else if (message && message.value.trim().length < 10) {
                showError('message', 'Message must be at least 10 characters');
                isValid = false;
            } else if (message) {
                clearError('message');
            }
            
            if (!isValid) {
                e.preventDefault();
                e.stopPropagation();
                return false;
            }
        });
        
        // Real-time validation for contact form
        const nameField = document.getElementById('name');
        if (nameField) {
            nameField.addEventListener('blur', function() {
                validateName('name');
            });
            nameField.addEventListener('input', function() {
                clearError('name');
            });
        }
        
        const emailField = document.getElementById('email');
        if (emailField) {
            emailField.addEventListener('blur', function() {
                validateEmail('email');
            });
            emailField.addEventListener('input', function() {
                clearError('email');
            });
        }
        
        const subjectField = document.getElementById('subject');
        if (subjectField) {
            subjectField.addEventListener('input', function() {
                clearError('subject');
            });
        }
        
        const messageField = document.getElementById('message');
        if (messageField) {
            messageField.addEventListener('input', function() {
                clearError('message');
            });
        }
    }
});
