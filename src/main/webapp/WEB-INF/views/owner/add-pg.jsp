<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="mb-8">
    <h1 class="text-3xl font-bold text-gray-900">Add New PG</h1>
    <p class="text-gray-600 mt-2">List your property on PG Finder</p>
</div>

<div class="bg-white rounded-xl p-8 border border-gray-200 shadow-sm">
    <form id="addPGForm" onsubmit="validateAddPGForm(event)">
        <!-- Basic Information -->
        <div class="mb-8">
            <h3 class="text-xl font-bold text-gray-900 mb-6">Basic Information</h3>
            <div class="grid grid-cols-2 gap-6">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">PG Name *</label>
                    <input type="text" id="pgName" name="pgName" placeholder="Enter PG name" 
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">PG Type *</label>
                    <select id="pgType" name="pgType" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option value="">Select type</option>
                        <option value="boys">Boys PG</option>
                        <option value="girls">Girls PG</option>
                    </select>
                </div>
                <div class="col-span-2">
                    <label class="block text-sm font-medium text-gray-700 mb-2">Description *</label>
                    <textarea id="description" name="description" rows="4" placeholder="Describe your PG" 
                              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"></textarea>
                </div>
            </div>
        </div>

        <!-- Location Details -->
        <div class="mb-8">
            <h3 class="text-xl font-bold text-gray-900 mb-6">Location Details</h3>
            <div class="grid grid-cols-2 gap-6">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Address *</label>
                    <input type="text" id="address" name="address" placeholder="Street address" 
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Area/Locality *</label>
                    <input type="text" id="locality" name="locality" placeholder="e.g., Koramangala" 
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">City *</label>
                    <input type="text" id="city" name="city" placeholder="e.g., Bangalore" 
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Pincode *</label>
                    <input type="text" id="pincode" name="pincode" placeholder="e.g., 560034" 
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
            </div>
        </div>

        <!-- Room Details -->
        <div class="mb-8">
            <h3 class="text-xl font-bold text-gray-900 mb-6">Room Details</h3>
            <div class="grid grid-cols-3 gap-6">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Total Rooms *</label>
                    <input type="number" id="totalRooms" name="totalRooms" placeholder="0" 
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Single Rooms</label>
                    <input type="number" id="singleRooms" name="singleRooms" placeholder="0" 
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Double Rooms</label>
                    <input type="number" id="doubleRooms" name="doubleRooms" placeholder="0" 
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
            </div>
        </div>

        <!-- Pricing -->
        <div class="mb-8">
            <h3 class="text-xl font-bold text-gray-900 mb-6">Pricing</h3>
            <div class="grid grid-cols-3 gap-6">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Starting Price *</label>
                    <input type="number" id="startingPrice" name="startingPrice" placeholder="₹ 0" 
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Security Deposit</label>
                    <input type="number" id="securityDeposit" name="securityDeposit" placeholder="₹ 0" 
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Maintenance Charges</label>
                    <input type="number" id="maintenance" name="maintenance" placeholder="₹ 0" 
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
            </div>
        </div>

        <!-- Amenities -->
        <div class="mb-8">
            <h3 class="text-xl font-bold text-gray-900 mb-6">Amenities</h3>
            <div class="grid grid-cols-3 gap-4">
                <label class="flex items-center gap-2 cursor-pointer">
                    <input type="checkbox" name="amenities" value="wifi" class="w-4 h-4 text-blue-600 rounded">
                    <span class="text-gray-700">WiFi</span>
                </label>
                <label class="flex items-center gap-2 cursor-pointer">
                    <input type="checkbox" name="amenities" value="ac" class="w-4 h-4 text-blue-600 rounded">
                    <span class="text-gray-700">AC</span>
                </label>
                <label class="flex items-center gap-2 cursor-pointer">
                    <input type="checkbox" name="amenities" value="food" class="w-4 h-4 text-blue-600 rounded">
                    <span class="text-gray-700">Food</span>
                </label>
                <label class="flex items-center gap-2 cursor-pointer">
                    <input type="checkbox" name="amenities" value="laundry" class="w-4 h-4 text-blue-600 rounded">
                    <span class="text-gray-700">Laundry</span>
                </label>
                <label class="flex items-center gap-2 cursor-pointer">
                    <input type="checkbox" name="amenities" value="parking" class="w-4 h-4 text-blue-600 rounded">
                    <span class="text-gray-700">Parking</span>
                </label>
                <label class="flex items-center gap-2 cursor-pointer">
                    <input type="checkbox" name="amenities" value="power_backup" class="w-4 h-4 text-blue-600 rounded">
                    <span class="text-gray-700">Power Backup</span>
                </label>
            </div>
        </div>

        <!-- Photos -->
        <div class="mb-8">
            <h3 class="text-xl font-bold text-gray-900 mb-6">Photos</h3>
            <div class="mb-4">
                <label class="block text-sm font-medium text-gray-700 mb-2">Upload Photos (Max 5 photos, 5MB each)</label>
                <input type="file" id="photoInput" name="photos" accept="image/*" multiple 
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                <p class="text-sm text-gray-500 mt-2">Supported formats: JPG, PNG, WEBP</p>
            </div>
            
            <!-- Photo Preview -->
            <div id="photoPreview" class="grid grid-cols-5 gap-4 mt-4"></div>
        </div>

        <!-- Submit Buttons -->
        <div class="flex gap-4">
            <button type="submit" id="submitBtn" class="px-8 py-3 rounded-lg font-semibold text-white transition-all shadow-md"
                    style="background-color: #3b82f6;">
                Submit for Approval
            </button>
            <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/owner/listings'" 
                    class="px-8 py-3 rounded-lg font-semibold border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                Cancel
            </button>
        </div>
    </form>
</div>

<script>
// Photo preview functionality
const photoInput = document.getElementById('photoInput');
const photoPreview = document.getElementById('photoPreview');
let selectedFiles = [];

if (photoInput) {
    photoInput.addEventListener('change', function(e) {
        const files = Array.from(e.target.files);
        
        if (files.length > 5) {
            alert('Maximum 5 photos allowed');
            photoInput.value = '';
            return;
        }
        
        selectedFiles = files;
        photoPreview.innerHTML = '';
        
        files.forEach((file, index) => {
            if (file.size > 5242880) { // 5MB
                alert('Each photo must be less than 5MB');
                photoInput.value = '';
                selectedFiles = [];
                photoPreview.innerHTML = '';
                return;
            }
            
            const reader = new FileReader();
            reader.onload = function(e) {
                const div = document.createElement('div');
                div.className = 'relative';
                div.innerHTML = `
                    <img src="${e.target.result}" class="w-full h-32 object-cover rounded-lg border border-gray-300">
                    <button type="button" onclick="removePhoto(${index})" 
                            class="absolute top-1 right-1 bg-red-500 text-white rounded-full w-6 h-6 flex items-center justify-center hover:bg-red-600">
                        <i class="fas fa-times text-xs"></i>
                    </button>
                    ${index == 0 ? '<span class="absolute bottom-1 left-1 bg-blue-500 text-white text-xs px-2 py-1 rounded">Primary</span>' : ''}
                `;
                photoPreview.appendChild(div);
            };
            reader.readAsDataURL(file);
        });
    });
}

function removePhoto(index) {
    selectedFiles.splice(index, 1);
    
    // Create new FileList
    const dt = new DataTransfer();
    selectedFiles.forEach(file => dt.items.add(file));
    photoInput.files = dt.files;
    
    // Trigger change event to update preview
    photoInput.dispatchEvent(new Event('change'));
}

function validateAddPGForm(event) {
    event.preventDefault();
    
    const form = event.target;
    const formData = new FormData(form);
    const submitBtn = document.getElementById('submitBtn');
    const originalText = submitBtn.innerHTML;
    
    // Basic validation
    const pgName = formData.get('pgName');
    const pgType = formData.get('pgType');
    const description = formData.get('description');
    const address = formData.get('address');
    const locality = formData.get('locality');
    const city = formData.get('city');
    const pincode = formData.get('pincode');
    const totalRooms = formData.get('totalRooms');
    const startingPrice = formData.get('startingPrice');
    
    if (!pgName || !pgType || !description || !address || !locality || !city || !pincode || !totalRooms || !startingPrice) {
        alert('Please fill all required fields marked with *');
        return false;
    }
    
    if (parseInt(totalRooms) < 1) {
        alert('Total rooms must be at least 1');
        return false;
    }
    
    if (parseInt(startingPrice) < 1000) {
        alert('Starting price must be at least ₹1,000');
        return false;
    }
    
    // Add photos to formData
    const photoFiles = photoInput.files;
    if (photoFiles.length > 0) {
        // Remove old photos entry
        formData.delete('photos');
        // Add each photo file
        for (let i = 0; i < photoFiles.length; i++) {
            formData.append('photos', photoFiles[i]);
        }
    }
    
    submitBtn.disabled = true;
    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Submitting...';
    
    fetch('${pageContext.request.contextPath}/owner/add-pg', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert(data.message || 'PG added successfully!');
            if (data.redirect) {
                window.location.href = data.redirect;
            } else {
                window.location.href = '${pageContext.request.contextPath}/owner/listings';
            }
        } else {
            alert(data.message || 'Failed to add PG. Please try again.');
            submitBtn.disabled = false;
            submitBtn.innerHTML = originalText;
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred while adding PG. Please check the form and try again.');
        submitBtn.disabled = false;
        submitBtn.innerHTML = originalText;
    });
    
    return false;
}
</script>

<script src="${pageContext.request.contextPath}/js/owner-validation.js"></script>
