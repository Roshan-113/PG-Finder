// Admin Module Validation Functions

// Validation patterns
const adminPatterns = {
    email: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
    phone: /^[6-9]\d{9}$/,
    number: /^\d+$/,
    decimal: /^\d+(\.\d{1,2})?$/
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

// Validate user action (approve/reject/suspend/activate)
function validateUserAction(userId, action) {
    if (!userId || isNaN(userId)) {
        alert('Invalid user ID');
        return false;
    }
    
    const validActions = ['approve', 'reject', 'suspend', 'activate', 'delete'];
    if (!validActions.includes(action)) {
        alert('Invalid action');
        return false;
    }
    
    // Confirm destructive actions
    if (action === 'delete') {
        return confirm('Are you sure you want to delete this user? This action cannot be undone.');
    }
    
    if (action === 'suspend') {
        return confirm('Are you sure you want to suspend this user?');
    }
    
    return true;
}

// Validate listing action (approve/reject/suspend)
function validateListingAction(listingId, action) {
    if (!listingId || isNaN(listingId)) {
        alert('Invalid listing ID');
        return false;
    }
    
    const validActions = ['approve', 'reject', 'suspend', 'activate', 'delete'];
    if (!validActions.includes(action)) {
        alert('Invalid action');
        return false;
    }
    
    // Confirm destructive actions
    if (action === 'delete') {
        return confirm('Are you sure you want to delete this listing? This action cannot be undone.');
    }
    
    if (action === 'reject') {
        const reason = prompt('Please provide a reason for rejection:');
        if (!reason || reason.trim().length < 10) {
            alert('Rejection reason must be at least 10 characters');
            return false;
        }
        // Store reason for submission
        document.getElementById('rejectionReason').value = reason;
    }
    
    return true;
}

// Validate report action
function validateReportAction(reportId, action) {
    if (!reportId || isNaN(reportId)) {
        alert('Invalid report ID');
        return false;
    }
    
    const validActions = ['resolve', 'dismiss', 'escalate'];
    if (!validActions.includes(action)) {
        alert('Invalid action');
        return false;
    }
    
    if (action === 'resolve' || action === 'dismiss') {
        const notes = prompt('Please add notes for this action:');
        if (!notes || notes.trim().length < 10) {
            alert('Notes must be at least 10 characters');
            return false;
        }
        // Store notes for submission
        const notesField = document.getElementById('actionNotes');
        if (notesField) {
            notesField.value = notes;
        }
    }
    
    return true;
}

// Validate review moderation
function validateReviewAction(reviewId, action) {
    if (!reviewId || isNaN(reviewId)) {
        alert('Invalid review ID');
        return false;
    }
    
    const validActions = ['approve', 'reject', 'delete'];
    if (!validActions.includes(action)) {
        alert('Invalid action');
        return false;
    }
    
    if (action === 'delete') {
        return confirm('Are you sure you want to delete this review? This action cannot be undone.');
    }
    
    if (action === 'reject') {
        const reason = prompt('Please provide a reason for rejection:');
        if (!reason || reason.trim().length < 10) {
            alert('Rejection reason must be at least 10 characters');
            return false;
        }
    }
    
    return true;
}

// Validate system settings form
function validateSystemSettings() {
    let isValid = true;
    
    // Validate commission rate
    const commissionRate = document.getElementById('commissionRate');
    if (commissionRate) {
        const rate = parseFloat(commissionRate.value);
        if (isNaN(rate) || rate < 0 || rate > 100) {
            showError('commissionRate', 'Commission rate must be between 0 and 100');
            isValid = false;
        } else {
            clearError('commissionRate');
        }
    }
    
    // Validate max photos
    const maxPhotos = document.getElementById('maxPhotos');
    if (maxPhotos) {
        const photos = parseInt(maxPhotos.value);
        if (isNaN(photos) || photos < 1 || photos > 50) {
            showError('maxPhotos', 'Max photos must be between 1 and 50');
            isValid = false;
        } else {
            clearError('maxPhotos');
        }
    }
    
    // Validate booking advance days
    const bookingAdvanceDays = document.getElementById('bookingAdvanceDays');
    if (bookingAdvanceDays) {
        const days = parseInt(bookingAdvanceDays.value);
        if (isNaN(days) || days < 1 || days > 365) {
            showError('bookingAdvanceDays', 'Booking advance days must be between 1 and 365');
            isValid = false;
        } else {
            clearError('bookingAdvanceDays');
        }
    }
    
    // Validate email settings
    const smtpHost = document.getElementById('smtpHost');
    if (smtpHost && !smtpHost.value.trim()) {
        showError('smtpHost', 'SMTP host is required');
        isValid = false;
    } else if (smtpHost) {
        clearError('smtpHost');
    }
    
    const smtpPort = document.getElementById('smtpPort');
    if (smtpPort) {
        const port = parseInt(smtpPort.value);
        if (isNaN(port) || port < 1 || port > 65535) {
            showError('smtpPort', 'SMTP port must be between 1 and 65535');
            isValid = false;
        } else {
            clearError('smtpPort');
        }
    }
    
    const smtpEmail = document.getElementById('smtpEmail');
    if (smtpEmail && smtpEmail.value.trim()) {
        if (!adminPatterns.email.test(smtpEmail.value.trim())) {
            showError('smtpEmail', 'Please enter a valid email address');
            isValid = false;
        } else {
            clearError('smtpEmail');
        }
    }
    
    return isValid;
}

// Validate date range filter
function validateDateRange() {
    const startDate = document.getElementById('startDate');
    const endDate = document.getElementById('endDate');
    
    if (startDate && endDate && startDate.value && endDate.value) {
        const start = new Date(startDate.value);
        const end = new Date(endDate.value);
        
        if (start > end) {
            showError('endDate', 'End date must be after start date');
            return false;
        }
        
        clearError('startDate');
        clearError('endDate');
    }
    
    return true;
}

// Validate bulk action
function validateBulkAction(action, selectedIds) {
    if (!selectedIds || selectedIds.length === 0) {
        alert('Please select at least one item');
        return false;
    }
    
    const validActions = ['approve', 'reject', 'suspend', 'activate', 'delete'];
    if (!validActions.includes(action)) {
        alert('Invalid action');
        return false;
    }
    
    const confirmMessage = `Are you sure you want to ${action} ${selectedIds.length} item(s)?`;
    return confirm(confirmMessage);
}

// Get selected checkboxes
function getSelectedIds(checkboxName) {
    const checkboxes = document.querySelectorAll(`input[name="${checkboxName}"]:checked`);
    return Array.from(checkboxes).map(cb => cb.value);
}

// Select/Deselect all checkboxes
function toggleSelectAll(masterCheckbox, checkboxName) {
    const checkboxes = document.querySelectorAll(`input[name="${checkboxName}"]`);
    checkboxes.forEach(cb => {
        cb.checked = masterCheckbox.checked;
    });
}

// Export data validation
function validateExport(format) {
    const validFormats = ['csv', 'excel', 'pdf'];
    if (!validFormats.includes(format)) {
        alert('Invalid export format');
        return false;
    }
    return true;
}

// Filter table data
function filterTable(searchTerm, tableId) {
    const table = document.getElementById(tableId);
    if (!table) return;
    
    const rows = table.querySelectorAll('tbody tr');
    const term = searchTerm.toLowerCase();
    
    rows.forEach(row => {
        const text = row.textContent.toLowerCase();
        row.style.display = text.includes(term) ? '' : 'none';
    });
}

// Sort table by column
function sortTable(tableId, columnIndex, ascending = true) {
    const table = document.getElementById(tableId);
    if (!table) return;
    
    const tbody = table.querySelector('tbody');
    const rows = Array.from(tbody.querySelectorAll('tr'));
    
    rows.sort((a, b) => {
        const aValue = a.cells[columnIndex].textContent.trim();
        const bValue = b.cells[columnIndex].textContent.trim();
        
        // Try numeric comparison first
        const aNum = parseFloat(aValue);
        const bNum = parseFloat(bValue);
        
        if (!isNaN(aNum) && !isNaN(bNum)) {
            return ascending ? aNum - bNum : bNum - aNum;
        }
        
        // Fall back to string comparison
        return ascending ? 
            aValue.localeCompare(bValue) : 
            bValue.localeCompare(aValue);
    });
    
    rows.forEach(row => tbody.appendChild(row));
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

// Confirm action with custom message
function confirmAction(message, callback) {
    if (confirm(message)) {
        if (typeof callback === 'function') {
            callback();
        }
        return true;
    }
    return false;
}

// Initialize admin dashboard
document.addEventListener('DOMContentLoaded', function() {
    
    // System settings form
    const settingsForm = document.getElementById('systemSettingsForm');
    if (settingsForm) {
        settingsForm.addEventListener('submit', function(e) {
            if (!validateSystemSettings()) {
                e.preventDefault();
                return false;
            }
        });
        
        // Real-time validation for numeric fields
        const numericFields = settingsForm.querySelectorAll('input[type="number"]');
        numericFields.forEach(field => {
            field.addEventListener('blur', function() {
                validateSystemSettings();
            });
            field.addEventListener('input', function() {
                clearError(this.id);
            });
        });
    }
    
    // Date range filters
    const startDate = document.getElementById('startDate');
    const endDate = document.getElementById('endDate');
    
    if (startDate && endDate) {
        startDate.addEventListener('change', validateDateRange);
        endDate.addEventListener('change', validateDateRange);
    }
    
    // Search functionality
    const searchInput = document.querySelector('.admin-search input');
    if (searchInput) {
        const tableId = searchInput.getAttribute('data-table-id');
        if (tableId) {
            searchInput.addEventListener('input', function(e) {
                filterTable(e.target.value, tableId);
            });
        }
    }
    
    // Master checkbox for bulk selection
    const masterCheckbox = document.getElementById('selectAll');
    if (masterCheckbox) {
        const checkboxName = masterCheckbox.getAttribute('data-checkbox-name');
        if (checkboxName) {
            masterCheckbox.addEventListener('change', function() {
                toggleSelectAll(this, checkboxName);
            });
        }
    }
    
    // Bulk action buttons
    const bulkActionButtons = document.querySelectorAll('.bulk-action-btn');
    bulkActionButtons.forEach(button => {
        button.addEventListener('click', function() {
            const action = this.getAttribute('data-action');
            const checkboxName = this.getAttribute('data-checkbox-name');
            const selectedIds = getSelectedIds(checkboxName);
            
            if (validateBulkAction(action, selectedIds)) {
                // Submit form or make AJAX request
                console.log(`Performing ${action} on:`, selectedIds);
            }
        });
    });
});
