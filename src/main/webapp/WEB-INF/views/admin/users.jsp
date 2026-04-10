<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - PG Finder Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Modal Styles */
        .modal-overlay {
            position: fixed;
            inset: 0;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
            backdrop-filter: blur(4px);
        }
        
        .modal-content {
            background: white;
            border-radius: 1rem;
            padding: 2rem;
            max-width: 500px;
            width: 90%;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            animation: modalSlideIn 0.3s ease-out;
        }
        
        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .modal-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1rem;
        }
        
        .modal-icon {
            width: 48px;
            height: 48px;
            border-radius: 0.75rem;
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }
        
        .modal-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1a202c;
            margin: 0;
        }
        
        .modal-description {
            color: #6b7280;
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }
        
        .form-group {
            margin-bottom: 1.25rem;
        }
        
        .form-label {
            display: block;
            font-size: 0.875rem;
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.5rem;
        }
        
        .form-select, .form-textarea {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid #e5e7eb;
            border-radius: 0.5rem;
            font-size: 0.875rem;
            transition: all 0.2s;
            font-family: inherit;
        }
        
        .form-select:focus, .form-textarea:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }
        
        .form-textarea {
            resize: vertical;
            min-height: 100px;
        }
        
        .modal-actions {
            display: flex;
            gap: 0.75rem;
            justify-content: flex-end;
            margin-top: 1.5rem;
        }
        
        .btn-modal {
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-size: 0.875rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            border: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .btn-cancel {
            background: #f3f4f6;
            color: #374151;
        }
        
        .btn-cancel:hover {
            background: #e5e7eb;
        }
        
        .btn-deactivate {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            color: white;
        }
        
        .btn-deactivate:hover {
            background: linear-gradient(135deg, #d97706 0%, #b45309 100%);
        }
        
        .hidden {
            display: none !important;
        }
        
        /* Table improvements */
        .reason-cell {
            max-width: 250px;
        }
        
        .reason-text {
            display: block;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        
        .reason-tooltip {
            position: relative;
            cursor: help;
        }
    </style>
</head>
<body class="bg-gray-50">
    <div class="admin-container">
        <jsp:include page="../includes/sidebar-admin.jsp">
            <jsp:param name="currentPage" value="users" />
        </jsp:include>

        <main class="admin-main">
            <jsp:include page="../includes/header-admin.jsp" />

            <div class="dashboard-content">
                <div class="page-title-section">
                    <div>
                        <h1 class="page-title">User Management</h1>
                        <p class="page-subtitle">Manage all platform users and their roles</p>
                    </div>
                </div>

                <c:if test="${not empty sessionScope.success}">
                    <div style="background: #d1fae5; border: 2px solid #10b981; color: #065f46; padding: 1rem 1.5rem; border-radius: 0.75rem; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.75rem;">
                        <i class="fas fa-check-circle" style="font-size: 1.25rem;"></i>
                        <span style="font-weight: 500;">${sessionScope.success}</span>
                    </div>
                    <c:remove var="success" scope="session"/>
                </c:if>

                <c:if test="${not empty sessionScope.error}">
                    <div style="background: #fee2e2; border: 2px solid #ef4444; color: #991b1b; padding: 1rem 1.5rem; border-radius: 0.75rem; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.75rem;">
                        <i class="fas fa-exclamation-circle" style="font-size: 1.25rem;"></i>
                        <span style="font-weight: 500;">${sessionScope.error}</span>
                    </div>
                    <c:remove var="error" scope="session"/>
                </c:if>

                <!-- Filters -->
                <div style="background: white; border-radius: 1rem; padding: 1.25rem; box-shadow: 0 1px 3px rgba(0,0,0,0.1); margin-bottom: 1.5rem;">
                    <form method="get" style="display: flex; gap: 1rem; align-items: center; flex-wrap: wrap;">
                        <div style="flex: 1; min-width: 200px;">
                            <select name="type" onchange="this.form.submit()" class="form-select" style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e5e7eb; border-radius: 0.5rem; font-size: 0.875rem;">
                                <option value="all" ${selectedType == 'all' ? 'selected' : ''}>All User Types</option>
                                <option value="tenant" ${selectedType == 'tenant' ? 'selected' : ''}>Tenants</option>
                                <option value="owner" ${selectedType == 'owner' ? 'selected' : ''}>Owners</option>
                            </select>
                        </div>
                        <div style="flex: 1; min-width: 200px;">
                            <select name="status" onchange="this.form.submit()" class="form-select" style="width: 100%; padding: 0.75rem 1rem; border: 2px solid #e5e7eb; border-radius: 0.5rem; font-size: 0.875rem;">
                                <option value="all" ${selectedStatus == 'all' ? 'selected' : ''}>All Status</option>
                                <option value="active" ${selectedStatus == 'active' ? 'selected' : ''}>Active</option>
                                <option value="inactive" ${selectedStatus == 'inactive' ? 'selected' : ''}>Inactive</option>
                            </select>
                        </div>
                        <div style="margin-left: auto; font-size: 0.875rem; color: #6b7280; font-weight: 500;">
                            Total Users: <strong style="color: #1a202c; font-size: 1.125rem;">${totalUsers}</strong>
                        </div>
                    </form>
                </div>

                <!-- Users Table -->
                <div class="table-card-modern">
                    <table class="modern-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>User</th>
                                <th>Contact</th>
                                <th>Type</th>
                                <th>Status</th>
                                <th>Deactivation Reason</th>
                                <th>Verified</th>
                                <th>Joined</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${users}" var="user">
                                <tr>
                                    <td><span style="font-weight: 600; color: #3b82f6;">#${user.userId}</span></td>
                                    <td>
                                        <div class="user-cell">
                                            <div class="user-avatar-small">${user.name.substring(0,1).toUpperCase()}</div>
                                            <div>
                                                <div style="font-weight: 600; color: #1a202c;">${user.name}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div style="font-size: 0.875rem;">
                                            <div style="color: #4b5563; margin-bottom: 0.125rem;">
                                                <i class="fas fa-envelope" style="color: #9ca3af; width: 16px;"></i> ${user.email}
                                            </div>
                                            <div style="color: #6b7280;">
                                                <i class="fas fa-phone" style="color: #9ca3af; width: 16px;"></i> ${user.phone}
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="badge-pill ${user.userType == 'tenant' ? 'badge-tenant' : 'badge-owner'}">
                                            <i class="fas ${user.userType == 'tenant' ? 'fa-user' : 'fa-building'}"></i>
                                            ${user.userType}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge-pill ${user.active ? 'badge-active' : 'badge-inactive'}">
                                            <i class="fas ${user.active ? 'fa-check-circle' : 'fa-ban'}"></i>
                                            ${user.active ? 'Active' : 'Inactive'}
                                        </span>
                                    </td>
                                    <td class="reason-cell">
                                        <c:choose>
                                            <c:when test="${!user.active && not empty user.deactivationReason}">
                                                <span class="reason-text reason-tooltip" title="${user.deactivationReason}" style="color: #ef4444; font-size: 0.8125rem;">
                                                    <i class="fas fa-info-circle"></i>
                                                    ${user.deactivationReason.length() > 35 ? user.deactivationReason.substring(0, 35).concat('...') : user.deactivationReason}
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: #d1d5db;">—</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.verified}">
                                                <i class="fas fa-check-circle" style="color: #10b981; font-size: 1.125rem;"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-times-circle" style="color: #ef4444; font-size: 1.125rem;"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="color: #6b7280; font-size: 0.875rem;">
                                        <fmt:formatDate value="${user.createdAt}" pattern="dd MMM yyyy"/>
                                    </td>
                                    <td>
                                        <div class="action-buttons-modern">
                                            <c:if test="${user.active}">
                                                <button type="button" class="btn-icon-modern" style="background: #fef3c7; color: #92400e;" onclick="showDeactivateModal(${user.userId}, '${user.name}')" title="Deactivate User">
                                                    <i class="fas fa-ban"></i>
                                                </button>
                                            </c:if>
                                            <c:if test="${!user.active}">
                                                <form method="post" style="display:inline;">
                                                    <input type="hidden" name="action" value="activate">
                                                    <input type="hidden" name="userId" value="${user.userId}">
                                                    <button type="submit" class="btn-icon-modern" style="background: #d1fae5; color: #065f46;" onclick="return confirm('Activate this user?')" title="Activate User">
                                                        <i class="fas fa-check"></i>
                                                    </button>
                                                </form>
                                            </c:if>
                                            <form method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="userId" value="${user.userId}">
                                                <button type="submit" class="btn-icon-modern btn-delete" onclick="return confirm('Delete this user permanently? This action cannot be undone.')" title="Delete User">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty users}">
                                <tr>
                                    <td colspan="9" class="empty-state-row">
                                        <div class="empty-state-modern">
                                            <i class="fas fa-users"></i>
                                            <p>No users found</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

    <!-- Deactivation Modal -->
    <div id="deactivateModal" class="modal-overlay hidden">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-icon">
                    <i class="fas fa-user-slash"></i>
                </div>
                <h3 class="modal-title">Deactivate User</h3>
            </div>
            
            <p class="modal-description">
                You are about to deactivate <strong id="userName"></strong>. Please provide a reason for this action. This will be logged for audit purposes.
            </p>
            
            <form method="post" id="deactivateForm">
                <input type="hidden" name="action" value="deactivate">
                <input type="hidden" name="userId" id="deactivateUserId">
                
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-clipboard-list"></i> Reason for Deactivation
                    </label>
                    <select name="reason" id="reasonSelect" class="form-select" onchange="toggleCustomReason()" required>
                        <option value="">— Select a reason —</option>
                        <option value="Violation of terms and conditions">Violation of terms and conditions</option>
                        <option value="Fraudulent activity detected">Fraudulent activity detected</option>
                        <option value="Multiple complaints received">Multiple complaints received</option>
                        <option value="Suspicious account behavior">Suspicious account behavior</option>
                        <option value="Non-payment of dues">Non-payment of dues</option>
                        <option value="Requested by user">Requested by user</option>
                        <option value="Duplicate account">Duplicate account</option>
                        <option value="Spam or abusive content">Spam or abusive content</option>
                        <option value="custom">✏️ Other (specify custom reason)</option>
                    </select>
                </div>
                
                <div id="customReasonDiv" class="form-group hidden">
                    <label class="form-label">
                        <i class="fas fa-pen"></i> Custom Reason
                    </label>
                    <textarea name="customReason" id="customReason" class="form-textarea" placeholder="Please provide a detailed reason for deactivating this user..."></textarea>
                </div>
                
                <div class="modal-actions">
                    <button type="button" onclick="closeDeactivateModal()" class="btn-modal btn-cancel">
                        <i class="fas fa-times"></i>
                        Cancel
                    </button>
                    <button type="submit" class="btn-modal btn-deactivate">
                        <i class="fas fa-ban"></i>
                        Deactivate User
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function showDeactivateModal(userId, userName) {
            document.getElementById('deactivateUserId').value = userId;
            document.getElementById('userName').textContent = userName;
            document.getElementById('deactivateModal').classList.remove('hidden');
            document.getElementById('reasonSelect').value = '';
            document.getElementById('customReasonDiv').classList.add('hidden');
            document.getElementById('customReason').value = '';
        }

        function closeDeactivateModal() {
            document.getElementById('deactivateModal').classList.add('hidden');
        }

        function toggleCustomReason() {
            const select = document.getElementById('reasonSelect');
            const customDiv = document.getElementById('customReasonDiv');
            
            if (select.value === 'custom') {
                customDiv.classList.remove('hidden');
                document.getElementById('customReason').required = true;
            } else {
                customDiv.classList.add('hidden');
                document.getElementById('customReason').required = false;
            }
        }

        document.getElementById('deactivateForm').addEventListener('submit', function(e) {
            const reasonSelect = document.getElementById('reasonSelect');
            const customReason = document.getElementById('customReason');
            
            if (reasonSelect.value === 'custom') {
                if (!customReason.value.trim()) {
                    e.preventDefault();
                    alert('Please enter a custom reason');
                    return false;
                }
                // Replace the reason value with custom reason
                const hiddenInput = document.createElement('input');
                hiddenInput.type = 'hidden';
                hiddenInput.name = 'reason';
                hiddenInput.value = customReason.value.trim();
                this.appendChild(hiddenInput);
                reasonSelect.disabled = true;
            }
        });

        // Close modal on outside click
        document.getElementById('deactivateModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeDeactivateModal();
            }
        });
    </script>
</body>
</html>
