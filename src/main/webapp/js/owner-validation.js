// Owner Module Validation Functions

// Validation patterns
const ownerPatterns = {
    number: /^\d+$/,
    decimal: /^\d+(\.\d{1,2})?$/,
    pincode: /^\d{6}$/,
    phone: /^[6-9]\d{9}$/
};

// Show error message
function showError(fieldId, message) {
    const field = document.getElementById(fieldId);
    if (!field) return;
    
    field.style.borderColor = '#dc2626';
    
    const existingError = document.getElementById(fieldId + '-error');
    if (existingError) {
        existingError.remove();
    }
    
    const errorDiv = document.createElement('div');
    errorDiv.id = fieldId + '-error';
    errorDiv.style.color = '#dc2626';
    errorDiv.style.fontSize = '14px';
    errorDiv.style.marginTop = '4px';
    errorDiv.textContent = message;
    
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

// Validate inquiry response
function validateInquiryResponse(inquiryId) {
    const textarea = document.getElementById('response-' + inquiryId);
    if (!textarea) {
        alert('Response field not found');
        return false;
    }
    
    const responseText = textarea.value.trim();
    if (responseText === '') {
        showError('response-' + inquiryId, 'Please enter a response');
        textarea.focus();
        return false;
    }
    
    if (responseText.length < 10) {
        showError('response-' + inquiryId, 'Response must be at least 10 characters long');
        textarea.focus();
        return false;
    }
    
    if (responseText.length > 1000) {
        showError('response-' + inquiryId, 'Response must not exceed 1000 characters');
        textarea.focus();
        return false;
    }
    
    clearError('response-' + inquiryId);
    return true;
}

// Validate room edit
function validateRoomEdit(roomNo, rent) {
    let isValid = true;
    
    if (!roomNo || roomNo.trim() === '') {
        alert('Room number is required');
        isValid = false;
    }
    
    if (!rent || isNaN(rent) || parseFloat(rent) <= 0) {
        alert('Please enter a valid rent amount');
        isValid = false;
    } else if (parseFloat(rent) < 1000) {
        alert('Rent must be at least ₹1,000');
        isValid = false;
    } else if (parseFloat(rent) > 100000) {
        alert('Rent cannot exceed ₹1,00,000');
        isValid = false;
    }
    
    return isValid;
}

// Validate photo upload
function validatePhotoUpload(files) {
    if (!files || files.length === 0) {
        alert('Please select at least one photo');
        return false;
    }
    
    const maxFiles = 10;
    if (files.length > maxFiles) {
        alert(`You can upload maximum ${maxFiles} photos at once`);
        return false;
    }
    
    const maxSize = 5 * 1024 * 1024; // 5MB
    const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/webp'];
    
    for (let i = 0; i < files.length; i++) {
        const file = files[i];
        
        if (!allowedTypes.includes(file.type)) {
            alert('Only JPG, PNG, and WebP images are allowed');
            return false;
        }
        
        if (file.size > maxSize) {
            alert(`Each photo must be less than 5MB. File "${file.name}" is too large.`);
            return false;
        }
    }
    
    return true;
}

// Validate booking action
function validateBookingAction(bookingId, action) {
    if (!bookingId || isNaN(bookingId)) {
        alert('Invalid booking ID');
        return false;
    }
    
    const validActions = ['confirm', 'reject', 'cancel'];
    if (!validActions.includes(action)) {
        alert('Invalid action');
        return false;
    }
    
    // Confirm destructive actions
    if (action === 'reject') {
        return confirm('Are you sure you want to reject this booking?');
    }
    
    if (action === 'cancel') {
        return confirm('Are you sure you want to cancel this booking?');
    }
    
    return true;
}

// Validate PG listing form
function validatePGListingForm() {
    let isValid = true;
    
    // Validate PG name
    const pgName = document.getElementById('pgName');
    if (pgName && !pgName.value.trim()) {
        showError('pgName', 'PG name is required');
        isValid = false;
    } else if (pgName && pgName.value.trim().length < 3) {
        showError('pgName', 'PG name must be at least 3 characters');
        isValid = false;
    } else if (pgName) {
        clearError('pgName');
    }
    
    // Validate address
    const address = document.getElementById('address');
    if (address && !address.value.trim()) {
        showError('address', 'Address is required');
        isValid = false;
    } else if (address && address.value.trim().length < 10) {
        showError('address', 'Address must be at least 10 characters');
        isValid = false;
    } else if (address) {
        clearError('address');
    }
    
    // Validate city
    const city = document.getElementById('city');
    if (city && !city.value.trim()) {
        showError('city', 'City is required');
        isValid = false;
    } else if (city) {
        clearError('city');
    }
    
    // Validate pincode
    const pincode = document.getElementById('pincode');
    if (pincode && !pincode.value.trim()) {
        showError('pincode', 'Pincode is required');
        isValid = false;
    } else if (pincode && !ownerPatterns.pincode.test(pincode.value.trim())) {
        showError('pincode', 'Pincode must be 6 digits');
        isValid = false;
    } else if (pincode) {
        clearError('pincode');
    }
    
    // Validate rent
    const rent = document.getElementById('rent');
    if (rent && !rent.value) {
        showError('rent', 'Rent is required');
        isValid = false;
    } else if (rent && (isNaN(rent.value) || parseFloat(rent.value) < 1000)) {
        showError('rent', 'Rent must be at least ₹1,000');
        isValid = false;
    } else if (rent && parseFloat(rent.value) > 100000) {
        showError('rent', 'Rent cannot exceed ₹1,00,000');
        isValid = false;
    } else if (rent) {
        clearError('rent');
    }
    
    // Validate total rooms
    const totalRooms = document.getElementById('totalRooms');
    if (totalRooms && !totalRooms.value) {
        showError('totalRooms', 'Total rooms is required');
        isValid = false;
    } else if (totalRooms && (isNaN(totalRooms.value) || parseInt(totalRooms.value) < 1)) {
        showError('totalRooms', 'Total rooms must be at least 1');
        isValid = false;
    } else if (totalRooms && parseInt(totalRooms.value) > 100) {
        showError('totalRooms', 'Total rooms cannot exceed 100');
        isValid = false;
    } else if (totalRooms) {
        clearError('totalRooms');
    }
    
    // Validate contact number
    const contactNumber = document.getElementById('contactNumber');
    if (contactNumber && !contactNumber.value.trim()) {
        showError('contactNumber', 'Contact number is required');
        isValid = false;
    } else if (contactNumber && !ownerPatterns.phone.test(contactNumber.value.trim())) {
        showError('contactNumber', 'Phone must be 10 digits starting with 6-9');
        isValid = false;
    } else if (contactNumber) {
        clearError('contactNumber');
    }
    
    return isValid;
}

// Validate document upload
function validateDocumentUpload(files) {
    if (!files || files.length === 0) {
        alert('Please select a document');
        return false;
    }
    
    const maxSize = 10 * 1024 * 1024; // 10MB
    const allowedTypes = ['application/pdf', 'image/jpeg', 'image/jpg', 'image/png'];
    
    for (let i = 0; i < files.length; i++) {
        const file = files[i];
        
        if (!allowedTypes.includes(file.type)) {
            alert('Only PDF, JPG, and PNG files are allowed');
            return false;
        }
        
        if (file.size > maxSize) {
            alert(`File "${file.name}" is too large. Maximum size is 10MB.`);
            return false;
        }
    }
    
    return true;
}

// Confirm action
function confirmAction(message, callback) {
    if (confirm(message)) {
        if (typeof callback === 'function') {
            callback();
        }
        return true;
    }
    return false;
}

// Show loading state
function showLoading(button) {
    if (button) {
        button.disabled = true;
        const originalText = button.innerHTML;
        button.setAttribute('data-original-text', originalText);
        button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
    }
}

// Hide loading state
function hideLoading(button) {
    if (button) {
        button.disabled = false;
        const originalText = button.getAttribute('data-original-text');
        if (originalText) {
            button.innerHTML = originalText;
        }
    }
}

// Initialize owner dashboard
document.addEventListener('DOMContentLoaded', function() {
    
    // PG listing form
    const pgListingForm = document.getElementById('pgListingForm');
    if (pgListingForm) {
        pgListingForm.addEventListener('submit', function(e) {
            if (!validatePGListingForm()) {
                e.preventDefault();
                return false;
            }
        });
        
        // Real-time validation
        const fields = ['pgName', 'address', 'city', 'pincode', 'rent', 'totalRooms', 'contactNumber'];
        fields.forEach(fieldId => {
            const field = document.getElementById(fieldId);
            if (field) {
                field.addEventListener('blur', function() {
                    validatePGListingForm();
                });
                field.addEventListener('input', function() {
                    clearError(fieldId);
                });
            }
        });
    }
    
    // Photo upload validation
    const photoInput = document.getElementById('photoUpload');
    if (photoInput) {
        photoInput.addEventListener('change', function() {
            validatePhotoUpload(this.files);
        });
    }
    
    // Document upload validation
    const documentInput = document.getElementById('documentUpload');
    if (documentInput) {
        documentInput.addEventListener('change', function() {
            validateDocumentUpload(this.files);
        });
    }
});
