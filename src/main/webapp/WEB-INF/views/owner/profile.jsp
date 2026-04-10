<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="mb-8">
    <h1 class="text-3xl font-bold text-gray-900">My Profile</h1>
    <p class="text-gray-600 mt-2">Manage your personal information</p>
</div>

<div class="grid grid-cols-3 gap-8">
    <!-- Profile Card -->
    <div class="col-span-1">
        <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
            <div class="text-center mb-6">
                <div class="w-32 h-32 rounded-full mx-auto flex items-center justify-center text-white font-bold text-4xl shadow-lg mb-4"
                     style="background: linear-gradient(to bottom right, #3b82f6, #14b8a6);">
                    O
                </div>
                <h3 class="text-xl font-bold text-gray-900">${sessionScope.userName != null ? sessionScope.userName : 'Owner'}</h3>
                <p class="text-gray-600 text-sm">${sessionScope.userEmail != null ? sessionScope.userEmail : 'owner@pgfinder.com'}</p>
                <span class="inline-block px-3 py-1 rounded-full text-xs font-semibold mt-3" 
                      style="background-color: #dbeafe; color: #1e40af;">Property Owner</span>
            </div>
            <div class="border-t border-gray-200 pt-4 space-y-3">
                <div class="flex items-center gap-3 text-sm">
                    <i class="fas fa-phone text-gray-400"></i>
                    <span class="text-gray-600">+91 98765 43210</span>
                </div>
                <div class="flex items-center gap-3 text-sm">
                    <i class="fas fa-map-marker-alt text-gray-400"></i>
                    <span class="text-gray-600">Bangalore, Karnataka</span>
                </div>
                <div class="flex items-center gap-3 text-sm">
                    <i class="fas fa-calendar text-gray-400"></i>
                    <span class="text-gray-600">Joined Jan 2024</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Profile Form -->
    <div class="col-span-2">
        <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
            <h3 class="text-lg font-bold text-gray-900 mb-6">Personal Information</h3>
            <form id="profileForm" onsubmit="validateProfileForm(event)" class="space-y-6">
                <div class="grid grid-cols-2 gap-6">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">First Name</label>
                        <input type="text" id="firstName" name="firstName" value="Owner" 
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Last Name</label>
                        <input type="text" id="lastName" name="lastName" value="User" 
                               class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                    </div>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Email Address</label>
                    <input type="email" id="email" name="email" value="owner@pgfinder.com" 
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Phone Number</label>
                    <input type="tel" id="phone" name="phone" value="+91 98765 43210" 
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Address</label>
                    <textarea id="address" name="address" rows="3" 
                              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">Bangalore, Karnataka, India</textarea>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">About</label>
                    <textarea id="about" name="about" rows="4" 
                              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent">Experienced property owner managing multiple PG accommodations in Bangalore.</textarea>
                </div>
                <div class="flex gap-3">
                    <button type="submit" 
                            class="px-6 py-3 rounded-lg font-semibold text-white transition-all shadow-md"
                            style="background-color: #3b82f6;">
                        Save Changes
                    </button>
                    <button type="button" onclick="window.location.reload()"
                            class="px-6 py-3 rounded-lg font-semibold border border-gray-300 text-gray-700 hover:bg-gray-50 transition-colors">
                        Cancel
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/owner-validation.js"></script>
