// Tenant Module Validation - Simple and Clean

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

// Validate search form
function validateSearchForm() {
    let isValid = true;
    
    const city = document.getElementById('searchCity');
    const minRent = document.getElementById('minRent');
    const maxRent = document.getElementById('maxRent');
    
    // Validate rent range
    if (minRent && maxRent) {
        const min = parseFloat(minRent.value);
        const max = parseFloat(maxRent.value);
        
        if (min && max && min > max) {
            showError('maxRent', 'Max rent must be greater than min rent');
            isValid = false;
        }
    }
    
    return isValid;
}

// Validate booking form
function validateBookingForm() {
    let isValid = true;
    
    const moveInDate = document.getElementById('moveInDate');
    
    if (moveInDate && !moveInDate.value) {
        showError('moveInDate', 'Please select move-in date');
        isValid = false;
    } else if (moveInDate && moveInDate.value) {
        const selectedDate = new Date(moveInDate.value);
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        
        if (selectedDate < today) {
            showError('moveInDate', 'Move-in date cannot be in the past');
            isValid = false;
        }
    }
    
    return isValid;
}

// Validate profile form
function validateProfileForm() {
    let isValid = true;
    
    const name = document.getElementById('name');
    const phone = document.getElementById('phone');
    
    if (name && !name.value.trim()) {
        showError('name', 'Name is required');
        isValid = false;
    } else if (name && name.value.trim().length < 2) {
        showError('name', 'Name must be at least 2 characters');
        isValid = false;
    }
    
    if (phone && phone.value.trim()) {
        const phonePattern = /^[6-9]\d{9}$/;
        if (!phonePattern.test(phone.value.trim())) {
            showError('phone', 'Phone must be 10 digits starting with 6-9');
            isValid = false;
        }
    }
    
    return isValid;
}

// Validate message form
function validateMessageForm() {
    let isValid = true;
    
    const message = document.getElementById('messageText');
    
    if (message && !message.value.trim()) {
        showError('messageText', 'Message cannot be empty');
        isValid = false;
    } else if (message && message.value.trim().length < 10) {
        showError('messageText', 'Message must be at least 10 characters');
        isValid = false;
    }
    
    return isValid;
}

// Save/Unsave PG
function toggleSavePG(listingId, button) {
    const isSaved = button.classList.contains('saved');
    const action = isSaved ? 'unsave' : 'save';
    
    fetch('/pg-finder/tenant/saved-pgs', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `action=${action}&listingId=${listingId}`
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            if (isSaved) {
                button.classList.remove('saved');
                button.innerHTML = '<i class="far fa-heart"></i>';
                button.title = 'Save PG';
            } else {
                button.classList.add('saved');
                button.innerHTML = '<i class="fas fa-heart"></i>';
                button.title = 'Unsave PG';
            }
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Failed to update. Please try again.');
    });
}

// Confirm booking cancellation
function confirmCancelBooking(bookingId) {
    if (confirm('Are you sure you want to cancel this booking?')) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '/pg-finder/tenant/bookings';
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'cancel';
        
        const bookingInput = document.createElement('input');
        bookingInput.type = 'hidden';
        bookingInput.name = 'bookingId';
        bookingInput.value = bookingId;
        
        form.appendChild(actionInput);
        form.appendChild(bookingInput);
        document.body.appendChild(form);
        form.submit();
    }
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', function() {
    
    // Search form
    const searchForm = document.getElementById('searchForm');
    if (searchForm) {
        searchForm.addEventListener('submit', function(e) {
            if (!validateSearchForm()) {
                e.preventDefault();
                return false;
            }
        });
        
        // Clear errors on input
        const searchInputs = searchForm.querySelectorAll('input, select');
        searchInputs.forEach(input => {
            input.addEventListener('input', function() {
                clearError(this.id);
            });
        });
    }
    
    // Booking form
    const bookingForm = document.getElementById('bookingForm');
    if (bookingForm) {
        bookingForm.addEventListener('submit', function(e) {
            if (!validateBookingForm()) {
                e.preventDefault();
                return false;
            }
        });
        
        const moveInDate = document.getElementById('moveInDate');
        if (moveInDate) {
            moveInDate.addEventListener('change', function() {
                clearError('moveInDate');
            });
        }
    }
    
    // Profile form
    const profileForm = document.getElementById('profileForm');
    if (profileForm) {
        profileForm.addEventListener('submit', function(e) {
            if (!validateProfileForm()) {
                e.preventDefault();
                return false;
            }
        });
        
        const name = document.getElementById('name');
        const phone = document.getElementById('phone');
        
        if (name) {
            name.addEventListener('blur', function() {
                if (this.value.trim()) {
                    if (this.value.trim().length < 2) {
                        showError('name', 'Name must be at least 2 characters');
                    } else {
                        clearError('name');
                    }
                }
            });
            name.addEventListener('input', function() {
                clearError('name');
            });
        }
        
        if (phone) {
            phone.addEventListener('blur', function() {
                if (this.value.trim()) {
                    const phonePattern = /^[6-9]\d{9}$/;
                    if (!phonePattern.test(this.value.trim())) {
                        showError('phone', 'Phone must be 10 digits starting with 6-9');
                    } else {
                        clearError('phone');
                    }
                }
            });
            phone.addEventListener('input', function() {
                clearError('phone');
            });
        }
    }
    
    // Message form
    const messageForm = document.getElementById('messageForm');
    if (messageForm) {
        messageForm.addEventListener('submit', function(e) {
            if (!validateMessageForm()) {
                e.preventDefault();
                return false;
            }
        });
        
        const messageText = document.getElementById('messageText');
        if (messageText) {
            messageText.addEventListener('input', function() {
                clearError('messageText');
            });
        }
    }
});
