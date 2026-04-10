<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="mb-8">
    <h1 class="text-3xl font-bold text-gray-900">Verification Documents</h1>
    <p class="text-gray-600 mt-2">Upload your verification documents for account approval</p>
</div>

<!-- Upload Document Card -->
<div class="bg-white rounded-xl p-8 border border-gray-200 shadow-sm mb-8">
    <h3 class="text-xl font-bold text-gray-900 mb-6">Upload New Document</h3>
    
    <form id="uploadDocumentForm" onsubmit="return uploadDocument(event);">
        <div class="grid grid-cols-2 gap-6 mb-6">
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Document Type *</label>
                <select id="documentType" name="documentType"
                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <option value="">Select document type</option>
                    <option value="id_proof">ID Proof (Aadhar/PAN/Passport)</option>
                    <option value="address_proof">Address Proof</option>
                    <option value="property_proof">Property Ownership Proof</option>
                </select>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Document File *</label>
                <input type="file" id="documentFile" name="document" accept=".pdf,.jpg,.jpeg,.png"
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                <p class="text-xs text-gray-500 mt-1">PDF, JPG, PNG (Max 10MB)</p>
            </div>
        </div>
        
        <button type="submit" class="px-6 py-3 text-white rounded-lg font-semibold transition-colors" style="background-color: #3b82f6; display: inline-block;">
            <i class="fas fa-upload"></i> Upload Document
        </button>
    </form>
</div>

<!-- Uploaded Documents -->
<div class="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
    <div class="px-6 py-4 border-b border-gray-200">
        <h3 class="text-lg font-bold text-gray-900">Uploaded Documents</h3>
    </div>
    
    <c:choose>
        <c:when test="${not empty documents}">
            <table class="w-full">
                <thead class="bg-gray-50 border-b border-gray-200">
                    <tr>
                        <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Document Type</th>
                        <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Uploaded Date</th>
                        <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Status</th>
                        <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase">Actions</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-200">
                    <c:forEach var="doc" items="${documents}">
                        <tr class="hover:bg-gray-50 transition-colors">
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="flex items-center gap-2">
                                    <i class="fas fa-file-alt text-gray-400"></i>
                                    <span class="font-medium text-gray-900">
                                        <c:choose>
                                            <c:when test="${doc.documentType == 'id_proof'}">ID Proof</c:when>
                                            <c:when test="${doc.documentType == 'address_proof'}">Address Proof</c:when>
                                            <c:when test="${doc.documentType == 'property_proof'}">Property Proof</c:when>
                                            <c:otherwise>${doc.documentType}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-gray-600">
                                <fmt:formatDate value="${doc.uploadedAt}" pattern="dd MMM yyyy, HH:mm"/>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <c:choose>
                                    <c:when test="${doc.verificationStatus == 'pending'}">
                                        <span class="px-3 py-1 rounded-full text-xs font-semibold" style="background-color: #fef3c7; color: #92400e;">
                                            Pending Review
                                        </span>
                                    </c:when>
                                    <c:when test="${doc.verificationStatus == 'approved'}">
                                        <span class="px-3 py-1 rounded-full text-xs font-semibold" style="background-color: #dcfce7; color: #166534;">
                                            Approved
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="px-3 py-1 rounded-full text-xs font-semibold" style="background-color: #fee2e2; color: #991b1b;">
                                            Rejected
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="flex gap-2">
                                    <a href="${doc.documentUrl}" target="_blank" 
                                       class="px-3 py-1 text-white rounded-lg transition-colors text-sm" style="background-color: #3b82f6; display: inline-block; text-decoration: none;">
                                        <i class="fas fa-eye"></i> View
                                    </a>
                                    <button type="button" onclick="deleteDocument('${doc.documentId}')" 
                                            class="px-3 py-1 text-white rounded-lg transition-colors text-sm" style="background-color: #dc2626; display: inline-block;">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div class="p-12 text-center">
                <i class="fas fa-file-upload text-gray-300" style="font-size: 4rem; margin-bottom: 1rem;"></i>
                <h3 class="text-xl font-bold text-gray-900 mb-2">No Documents Uploaded</h3>
                <p class="text-gray-600">Upload your verification documents to get your account approved</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Info Card -->
<div class="mt-8 bg-blue-50 border border-blue-200 rounded-xl p-6">
    <div class="flex gap-4">
        <div class="flex-shrink-0">
            <i class="fas fa-info-circle text-blue-600" style="font-size: 1.5rem;"></i>
        </div>
        <div>
            <h4 class="font-bold text-blue-900 mb-2">Document Requirements</h4>
            <ul class="text-sm text-blue-800 space-y-1">
                <li>• <strong>ID Proof:</strong> Aadhar Card, PAN Card, Passport, or Driving License</li>
                <li>• <strong>Address Proof:</strong> Utility Bill, Bank Statement, or Rental Agreement</li>
                <li>• <strong>Property Proof:</strong> Property Tax Receipt, Sale Deed, or Ownership Documents</li>
                <li>• All documents must be clear and readable</li>
                <li>• Accepted formats: PDF, JPG, PNG (Max 10MB per file)</li>
                <li>• Documents will be reviewed by admin within 24-48 hours</li>
            </ul>
        </div>
    </div>
</div>

<script>
function uploadDocument(event) {
    event.preventDefault();
    
    const documentType = document.getElementById('documentType').value;
    const documentFile = document.getElementById('documentFile').files[0];
    
    // Validation
    if (!documentType) {
        alert('Please select document type');
        return false;
    }
    
    if (!documentFile) {
        alert('Please select a document file');
        return false;
    }
    
    // Check file size (10MB = 10485760 bytes)
    if (documentFile.size > 10485760) {
        alert('File size must be less than 10MB');
        return false;
    }
    
    // Check file type
    const allowedTypes = ['application/pdf', 'image/jpeg', 'image/jpg', 'image/png'];
    if (!allowedTypes.includes(documentFile.type)) {
        alert('Only PDF, JPG, and PNG files are allowed');
        return false;
    }
    
    const form = event.target;
    const formData = new FormData(form);
    formData.append('action', 'upload');
    
    const submitBtn = form.querySelector('button[type="submit"]');
    const originalText = submitBtn.innerHTML;
    
    submitBtn.disabled = true;
    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Uploading...';
    
    fetch('${pageContext.request.contextPath}/owner/documents', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        alert(data.message);
        if (data.success) {
            location.reload();
        } else {
            submitBtn.disabled = false;
            submitBtn.innerHTML = originalText;
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred while uploading document');
        submitBtn.disabled = false;
        submitBtn.innerHTML = originalText;
    });
    
    return false;
}

function deleteDocument(documentId) {
    if (!confirm('Are you sure you want to delete this document?')) {
        return;
    }
    
    const formData = new FormData();
    formData.append('action', 'delete');
    formData.append('documentId', documentId);
    
    fetch('${pageContext.request.contextPath}/owner/documents', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        alert(data.message);
        if (data.success) {
            location.reload();
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred while deleting document');
    });
}
</script>
