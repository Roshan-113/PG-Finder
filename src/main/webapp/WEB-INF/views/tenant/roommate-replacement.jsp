<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layouts/tenant-layout.jsp" %>

<div class="min-h-screen bg-gray-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Back Button -->
        <button onclick="window.location.href='${pageContext.request.contextPath}/tenant/roommate-finder'" 
                class="flex items-center gap-2 text-gray-600 hover:text-gray-900 mb-6 font-medium">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
            </svg>
            Back to Roommate Finder
        </button>

        <!-- Header -->
        <div class="mb-8">
            <div class="flex items-center gap-3 mb-4">
                <div class="w-12 h-12 bg-gradient-to-br from-purple-500 to-purple-600 rounded-xl flex items-center justify-center">
                    <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
                    </svg>
                </div>
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Replace Roommate</h1>
                    <p class="text-gray-600">Find a new roommate without shifting PG</p>
                </div>
            </div>

            <!-- Info Banner -->
            <div class="bg-purple-50 border border-purple-200 rounded-xl p-4">
                <div class="flex items-start gap-3">
                    <div class="w-10 h-10 bg-purple-100 rounded-lg flex items-center justify-center flex-shrink-0">
                        <svg class="w-5 h-5 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
                        </svg>
                    </div>
                    <div>
                        <h3 class="font-semibold text-purple-900 mb-1">Unique Roommate Replacement Feature</h3>
                        <p class="text-sm text-purple-700">
                            Our smart matching system finds compatible replacements while you stay in your current PG. 
                            Both parties and the PG owner approve the transition for a seamless experience.
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Progress Steps -->
        <div class="mb-8">
            <div class="flex items-center justify-center">
                <div class="flex items-center gap-4">
                    <!-- Step 1 -->
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-full flex items-center justify-center font-semibold bg-indigo-600 text-white">1</div>
                        <span class="hidden sm:inline text-gray-900 font-medium">Current Details</span>
                    </div>
                    <div class="w-16 h-0.5 bg-gray-300"></div>
                    <!-- Step 2 -->
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-full flex items-center justify-center font-semibold bg-gray-200 text-gray-500">2</div>
                        <span class="hidden sm:inline text-gray-500">Find Match</span>
                    </div>
                    <div class="w-16 h-0.5 bg-gray-300"></div>
                    <!-- Step 3 -->
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-full flex items-center justify-center font-semibold bg-gray-200 text-gray-500">3</div>
                        <span class="hidden sm:inline text-gray-500">Confirm</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Step 1: Current Room Details -->
        <div class="max-w-3xl mx-auto space-y-6">
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                <h2 class="text-xl font-semibold text-gray-900 mb-6">Current Room Details</h2>
                
                <div class="bg-gray-50 rounded-xl p-6 mb-6">
                    <div class="flex items-start gap-4">
                        <div class="w-12 h-12 bg-indigo-100 rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-indigo-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                            </svg>
                        </div>
                        <div class="flex-1">
                            <h3 class="font-semibold text-gray-900 mb-2">Green Valley PG</h3>
                            <div class="space-y-1 text-sm text-gray-600">
                                <p>📍 Koramangala, Bangalore</p>
                                <p>🏠 Double Sharing</p>
                                <p>💰 ₹12,000/month</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="bg-amber-50 border border-amber-200 rounded-xl p-6 mb-6">
                    <div class="flex items-start gap-4">
                        <div class="w-12 h-12 bg-amber-100 rounded-lg flex items-center justify-center">
                            <svg class="w-6 h-6 text-amber-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                            </svg>
                        </div>
                        <div class="flex-1">
                            <h3 class="font-semibold text-gray-900 mb-2">Current Roommate</h3>
                            <div class="space-y-1 text-sm text-gray-600">
                                <p>Name: Rahul Kumar</p>
                                <p>Occupation: Software Engineer</p>
                                <p>Living together for: 6 months</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">
                        Reason for Replacement <span class="text-red-500">*</span>
                    </label>
                    <select class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 mb-3">
                        <option value="">Select a reason</option>
                        <option value="lifestyle">Lifestyle mismatch</option>
                        <option value="relocation">Roommate relocating</option>
                        <option value="schedule">Different work schedules</option>
                        <option value="personal">Personal reasons</option>
                        <option value="other">Other</option>
                    </select>
                    
                    <textarea rows="3" placeholder="Additional details (optional)" 
                              class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"></textarea>
                </div>

                <div class="flex gap-4 mt-6">
                    <button class="flex-1 px-6 py-3 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 font-medium transition-colors">
                        Find Compatible Roommates
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
