<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="currentPage" value="settings" scope="request" />

<div class="max-w-4xl mx-auto px-6 py-8">
    <h1 class="text-3xl font-bold text-gray-900 mb-8">Settings</h1>

    <!-- Notifications Section -->
    <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm mb-6">
        <div class="flex items-center gap-2 mb-6">
            <i class="fas fa-bell text-gray-700"></i>
            <h2 class="text-xl font-bold text-gray-900">Notifications</h2>
        </div>
        
        <div class="space-y-4">
            <div class="flex items-center justify-between p-4 hover:bg-gray-50 rounded-lg">
                <div>
                    <div class="font-medium text-gray-900">Email notifications</div>
                    <div class="text-sm text-gray-600">Receive updates via email</div>
                </div>
                <label class="relative inline-flex items-center cursor-pointer">
                    <input type="checkbox" checked class="sr-only peer">
                    <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600"></div>
                </label>
            </div>

            <div class="flex items-center justify-between p-4 hover:bg-gray-50 rounded-lg">
                <div>
                    <div class="font-medium text-gray-900">SMS notifications</div>
                    <div class="text-sm text-gray-600">Receive updates via SMS</div>
                </div>
                <label class="relative inline-flex items-center cursor-pointer">
                    <input type="checkbox" checked class="sr-only peer">
                    <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600"></div>
                </label>
            </div>

            <div class="flex items-center justify-between p-4 hover:bg-gray-50 rounded-lg">
                <div>
                    <div class="font-medium text-gray-900">Push notifications</div>
                    <div class="text-sm text-gray-600">Receive push notifications</div>
                </div>
                <label class="relative inline-flex items-center cursor-pointer">
                    <input type="checkbox" checked class="sr-only peer">
                    <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600"></div>
                </label>
            </div>
        </div>
    </div>

    <!-- Security Section -->
    <div class="bg-white rounded-xl p-6 border border-gray-200 shadow-sm">
        <div class="flex items-center gap-2 mb-6">
            <i class="fas fa-lock text-gray-700"></i>
            <h2 class="text-xl font-bold text-gray-900">Security</h2>
        </div>
        
        <button class="w-full flex items-center justify-between p-4 rounded-lg text-white font-semibold hover:opacity-90 transition-opacity"
                style="background-color: #3b82f6;">
            <div class="flex items-center gap-3">
                <i class="fas fa-key"></i>
                <span>Change Password</span>
            </div>
            <i class="fas fa-chevron-right"></i>
        </button>
    </div>
</div>
