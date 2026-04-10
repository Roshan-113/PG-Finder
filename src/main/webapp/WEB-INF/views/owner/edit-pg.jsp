<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${empty listing}">
    <div class="bg-red-50 border border-red-200 rounded-lg p-4 mb-6">
        <p class="text-red-800">Error: Listing not found. Please go back to <a href="${pageContext.request.contextPath}/owner/listings" class="underline">My Listings</a>.</p>
    </div>
    <script>
        setTimeout(function() {
            window.location.href = '${pageContext.request.contextPath}/owner/listings';
        }, 3000);
    </script>
</c:if>

<c:if test="${not empty listing}">
<div class="mb-8">
    <h1 class="text-3xl font-bold text-gray-900">Edit PG</h1>
    <p class="text-gray-600 mt-2">Update your property details</p>
</div>

<div class="bg-white rounded-xl p-8 border border-gray-200 shadow-sm">
    <form id="editPGForm" onsubmit="submitEditForm(event)" data-listing-id="${listing.listingId}">
        <input type="hidden" name="listingId" id="listingId" value="${listing.listingId}">
        
        <!-- Basic Information -->
        <div class="mb-8">
            <h3 class="text-xl font-bold text-gray-900 mb-6">Basic Information</h3>
            <div class="grid grid-cols-2 gap-6">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">PG Name *</label>
                    <input type="text" name="title" value="${listing.title}" placeholder="Enter PG name" 
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                    <span class="text-red-500 text-sm hidden error-message">This field is required</span>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">PG Type *</label>
                    <select name="pgType" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                        <option value="">Select type</option>
                        <option value="boys" ${listing.pgType == 'boys' ? 'selected' : ''}>Boys PG</option>
                        <option value="girls" ${listing.pgType == 'girls' ? 'selected' : ''}>Girls PG</option>
                    </select>
                    <span class="text-red-500 text-sm hidden error-message">Please select a PG type</span>
                </div>
                <div class="col-span-2">
                    <label class="block text-sm font-medium text-gray-700 mb-2">Description *</label>
                    <textarea name="description" rows="4" placeholder="Describe your PG" 
                              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>${listing.description}</textarea>
                    <span class="text-red-500 text-sm hidden error-message">This field is required</span>
                </div>
            </div>
        </div>

        <!-- Location Details -->
        <div class="mb-8">
            <h3 class="text-xl font-bold text-gray-900 mb-6">Location Details</h3>
            <div class="grid grid-cols-2 gap-6">
                <div class="col-span-2">
                    <label class="block text-sm font-medium text-gray-700 mb-2">Address *</label>
                    <input type="text" name="address" value="${listing.address}" placeholder="Street address" 
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">City *</label>
                    <input type="text" name="city" value="${listing.city}" placeholder="e.g., Bangalore" 
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">State *</label>
                    <input type="text" name="state" value="${listing.state}" placeholder="e.g., Karnataka" 
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Pincode *</label>
                    <input type="text" name="pincode" value="${listing.pincode}" placeholder="e.g., 560034" 
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                </div>
            </div>
        </div>

        <!-- Room Details -->
        <div class="mb-8">
            <h3 class="text-xl font-bold text-gray-900 mb-6">Room Details</h3>
            <div class="grid grid-cols-2 gap-6">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Total Rooms *</label>
                    <input type="number" name="totalRooms" value="${listing.totalRooms}" placeholder="0" min="1"
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                    <span class="text-red-500 text-sm hidden error-message">Must be at least 1</span>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Available Rooms *</label>
                    <input type="number" name="availableRooms" value="${listing.availableRooms}" placeholder="0" min="0"
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                    <span class="text-red-500 text-sm hidden error-message">Cannot exceed total rooms</span>
                </div>
            </div>
        </div>

        <!-- Pricing -->
        <div class="mb-8">
            <h3 class="text-xl font-bold text-gray-900 mb-6">Pricing</h3>
            <div class="grid grid-cols-2 gap-6">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Rent Per Month *</label>
                    <input type="number" name="rentPerMonth" value="${listing.rentPerMonth}" placeholder="₹ 0" min="0" step="0.01"
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                    <span class="text-red-500 text-sm hidden error-message">Must be a positive amount</span>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Security Deposit *</label>
                    <input type="number" name="securityDeposit" value="${listing.securityDeposit}" placeholder="₹ 0" min="0" step="0.01"
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                    <span class="text-red-500 text-sm hidden error-message">Must be a positive amount</span>
                </div>
            </div>
        </div>

        <!-- Amenities -->
        <div class="mb-8">
            <h3 class="text-xl font-bold text-gray-900 mb-6">Amenities</h3>
            <div class="grid grid-cols-3 gap-4">
                <label class="flex items-center gap-2 cursor-pointer">
                    <input type="checkbox" name="wifiAvailable" ${listing.wifiAvailable ? 'checked' : ''} class="w-4 h-4 text-blue-600 rounded">
                    <span class="text-gray-700">WiFi</span>
                </label>
                <label class="flex items-center gap-2 cursor-pointer">
                    <input type="checkbox" name="acAvailable" ${listing.acAvailable ? 'checked' : ''} class="w-4 h-4 text-blue-600 rounded">
                    <span class="text-gray-700">AC</span>
                </label>
                <label class="flex items-center gap-2 cursor-pointer">
                    <input type="checkbox" name="foodIncluded" ${listing.foodIncluded ? 'checked' : ''} class="w-4 h-4 text-blue-600 rounded">
                    <span class="text-gray-700">Food</span>
                </label>
                <label class="flex items-center gap-2 cursor-pointer">
                    <input type="checkbox" name="laundryAvailable" ${listing.laundryAvailable ? 'checked' : ''} class="w-4 h-4 text-blue-600 rounded">
                    <span class="text-gray-700">Laundry</span>
                </label>
                <label class="flex items-center gap-2 cursor-pointer">
                    <input type="checkbox" name="parkingAvailable" ${listing.parkingAvailable ? 'checked' : ''} class="w-4 h-4 text-blue-600 rounded">
                    <span class="text-gray-700">Parking</span>
                </label>
            </div>
        </div>

        <!-- House Rules -->
        <div class="mb-8">
            <h3 class="text-xl font-bold text-gray-900 mb-6">House Rules</h3>
            <textarea name="rules" rows="4" placeholder="Enter house rules" 
                      class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">${listing.rules}</textarea>
        </div>

        <!-- Submit Buttons -->
        <div class="flex gap-4">
            <button type="submit" class="px-8 py-3 rounded-lg font-semibold text-white transition-all shadow-md"
                    style="background-color: #3b82f6;">
                <i class="fas fa-save"></i> Update PG
            </button>
            <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/owner/listings'" 
                    class="px-8 py-3 rounded-lg font-semibold border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                Cancel
            </button>
        </div>
    </form>
</div>

<script>
function submitEditForm(event) {
    event.preventDefault();
    
    const form = event.target;
    const submitBtn = form.querySelector('button[type="submit"]');
    const originalText = submitBtn.innerHTML;
    
    // Get listing ID - try multiple methods
    let listingId = null;
    
    // Method 1: From hidden input by ID
    const listingIdById = document.getElementById('listingId');
    if (listingIdById && listingIdById.value) {
        listingId = listingIdById.value;
        console.log('Method 1 (by ID):', listingId);
    }
    
    // Method 2: From hidden input by name
    if (!listingId) {
        const listingIdByName = form.querySelector('input[name="listingId"]');
        if (listingIdByName && listingIdByName.value) {
            listingId = listingIdByName.value;
            console.log('Method 2 (by name):', listingId);
        }
    }
    
    // Method 3: From form data attribute
    if (!listingId) {
        listingId = form.getAttribute('data-listing-id');
        console.log('Method 3 (data attribute):', listingId);
    }
    
    // Method 4: From URL parameter
    if (!listingId) {
        const urlParams = new URLSearchParams(window.location.search);
        listingId = urlParams.get('id');
        console.log('Method 4 (URL param):', listingId);
    }
    
    console.log('Final listing ID:', listingId);
    
    if (!listingId || listingId === '' || listingId === 'null') {
        alert('Error: Listing ID is missing. Redirecting to listings page...');
        window.location.href = '${pageContext.request.contextPath}/owner/listings';
        return;
    }
    
    // Clear previous error states
    form.querySelectorAll('.border-red-500').forEach(el => {
        el.classList.remove('border-red-500');
    });
    form.querySelectorAll('.error-message').forEach(el => {
        el.classList.add('hidden');
    });
    
    // Validate required fields
    const requiredFields = form.querySelectorAll('[required]');
    let isValid = true;
    let firstInvalidField = null;
    
    requiredFields.forEach(field => {
        if (!field.value || field.value.trim() === '') {
            isValid = false;
            field.classList.add('border-red-500');
            const errorMsg = field.parentElement.querySelector('.error-message');
            if (errorMsg) {
                errorMsg.classList.remove('hidden');
            }
            if (!firstInvalidField) {
                firstInvalidField = field;
            }
        }
    });
    
    if (!isValid) {
        alert('Please fill in all required fields marked with *');
        if (firstInvalidField) {
            firstInvalidField.focus();
            firstInvalidField.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
        return;
    }
    
    // Validate numeric fields
    const totalRooms = parseInt(form.querySelector('[name="totalRooms"]').value);
    const availableRooms = parseInt(form.querySelector('[name="availableRooms"]').value);
    const rentPerMonth = parseFloat(form.querySelector('[name="rentPerMonth"]').value);
    const securityDeposit = parseFloat(form.querySelector('[name="securityDeposit"]').value);
    
    if (totalRooms < 1) {
        alert('Total rooms must be at least 1');
        form.querySelector('[name="totalRooms"]').classList.add('border-red-500');
        form.querySelector('[name="totalRooms"]').focus();
        return;
    }
    
    if (availableRooms < 0) {
        alert('Available rooms cannot be negative');
        form.querySelector('[name="availableRooms"]').classList.add('border-red-500');
        form.querySelector('[name="availableRooms"]').focus();
        return;
    }
    
    if (availableRooms > totalRooms) {
        alert('Available rooms (' + availableRooms + ') cannot exceed total rooms (' + totalRooms + ')');
        const availableRoomsField = form.querySelector('[name="availableRooms"]');
        availableRoomsField.classList.add('border-red-500');
        const errorMsg = availableRoomsField.parentElement.querySelector('.error-message');
        if (errorMsg) {
            errorMsg.classList.remove('hidden');
        }
        availableRoomsField.focus();
        return;
    }
    
    if (rentPerMonth <= 0) {
        alert('Rent per month must be greater than 0');
        form.querySelector('[name="rentPerMonth"]').classList.add('border-red-500');
        form.querySelector('[name="rentPerMonth"]').focus();
        return;
    }
    
    if (securityDeposit < 0) {
        alert('Security deposit cannot be negative');
        form.querySelector('[name="securityDeposit"]').classList.add('border-red-500');
        form.querySelector('[name="securityDeposit"]').focus();
        return;
    }
    
    // Validate pincode format
    const pincode = form.querySelector('[name="pincode"]').value.trim();
    if (!/^\d{6}$/.test(pincode)) {
        alert('Pincode must be exactly 6 digits');
        form.querySelector('[name="pincode"]').classList.add('border-red-500');
        form.querySelector('[name="pincode"]').focus();
        return;
    }
    
    submitBtn.disabled = true;
    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Updating...';
    
    // Create FormData and explicitly add all fields
    const formData = new FormData();
    
    // CRITICAL: Add listing ID first - this is required!
    console.log('Adding listingId to formData:', listingId);
    formData.append('listingId', listingId);
    
    // Add text fields
    formData.append('title', form.querySelector('[name="title"]').value);
    formData.append('description', form.querySelector('[name="description"]').value);
    formData.append('address', form.querySelector('[name="address"]').value);
    formData.append('city', form.querySelector('[name="city"]').value);
    formData.append('state', form.querySelector('[name="state"]').value);
    formData.append('pincode', form.querySelector('[name="pincode"]').value);
    formData.append('pgType', form.querySelector('[name="pgType"]').value);
    formData.append('totalRooms', form.querySelector('[name="totalRooms"]').value);
    formData.append('availableRooms', form.querySelector('[name="availableRooms"]').value);
    formData.append('rentPerMonth', form.querySelector('[name="rentPerMonth"]').value);
    formData.append('securityDeposit', form.querySelector('[name="securityDeposit"]').value);
    
    // Add checkboxes (only send 'on' if checked)
    const wifiCheckbox = form.querySelector('[name="wifiAvailable"]');
    const acCheckbox = form.querySelector('[name="acAvailable"]');
    const foodCheckbox = form.querySelector('[name="foodIncluded"]');
    const laundryCheckbox = form.querySelector('[name="laundryAvailable"]');
    const parkingCheckbox = form.querySelector('[name="parkingAvailable"]');
    
    if (wifiCheckbox && wifiCheckbox.checked) formData.append('wifiAvailable', 'on');
    if (acCheckbox && acCheckbox.checked) formData.append('acAvailable', 'on');
    if (foodCheckbox && foodCheckbox.checked) formData.append('foodIncluded', 'on');
    if (laundryCheckbox && laundryCheckbox.checked) formData.append('laundryAvailable', 'on');
    if (parkingCheckbox && parkingCheckbox.checked) formData.append('parkingAvailable', 'on');
    
    // Add rules (optional)
    const rulesField = form.querySelector('[name="rules"]');
    if (rulesField && rulesField.value) {
        formData.append('rules', rulesField.value);
    }
    
    // Debug: Log form data
    console.log('Form data being sent:');
    const formDataObj = {};
    for (let [key, value] of formData.entries()) {
        console.log(key + ': ' + value);
        formDataObj[key] = value;
    }
    
    // Convert FormData to URL-encoded string for better compatibility
    const urlEncodedData = new URLSearchParams(formData).toString();
    console.log('URL Encoded Data:', urlEncodedData);
    
    fetch('${pageContext.request.contextPath}/owner/edit-pg', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: urlEncodedData
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            alert('PG updated successfully!');
            window.location.href = '${pageContext.request.contextPath}/owner/listings';
        } else {
            alert('Failed to update PG. ' + (data.error || 'Unknown error'));
            submitBtn.disabled = false;
            submitBtn.innerHTML = originalText;
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred while updating. Please try again.');
        submitBtn.disabled = false;
        submitBtn.innerHTML = originalText;
    });
}

// Real-time validation
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('editPGForm');
    if (!form) return;
    
    // Validate available rooms against total rooms
    const totalRoomsInput = form.querySelector('[name="totalRooms"]');
    const availableRoomsInput = form.querySelector('[name="availableRooms"]');
    
    function validateRooms() {
        const total = parseInt(totalRoomsInput.value) || 0;
        const available = parseInt(availableRoomsInput.value) || 0;
        
        if (available > total) {
            availableRoomsInput.classList.add('border-red-500');
            const errorMsg = availableRoomsInput.parentElement.querySelector('.error-message');
            if (errorMsg) {
                errorMsg.classList.remove('hidden');
            }
        } else {
            availableRoomsInput.classList.remove('border-red-500');
            const errorMsg = availableRoomsInput.parentElement.querySelector('.error-message');
            if (errorMsg) {
                errorMsg.classList.add('hidden');
            }
        }
    }
    
    if (totalRoomsInput) totalRoomsInput.addEventListener('input', validateRooms);
    if (availableRoomsInput) availableRoomsInput.addEventListener('input', validateRooms);
    
    // Clear error on input
    form.querySelectorAll('input, select, textarea').forEach(field => {
        field.addEventListener('input', function() {
            if (this.value && this.value.trim() !== '') {
                this.classList.remove('border-red-500');
                const errorMsg = this.parentElement.querySelector('.error-message');
                if (errorMsg) {
                    errorMsg.classList.add('hidden');
                }
            }
        });
    });
});
</script>

<script src="${pageContext.request.contextPath}/js/owner-validation.js"></script>
</c:if>
