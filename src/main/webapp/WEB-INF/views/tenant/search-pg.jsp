<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search PG - PG Finder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50">
    <%@ include file="../layouts/tenant-layout.jsp" %>
    
    <div class="min-h-screen bg-gray-50 pt-16 p-8">
        <div class="max-w-7xl mx-auto space-y-6">
            <div>
                <h1 class="text-3xl font-bold text-gray-900">Search PG</h1>
                <p class="text-gray-600 mt-1">Find your perfect PG accommodation</p>
            </div>

            <!-- Search Bar -->
            <div class="bg-white rounded-lg p-6 border border-gray-200">
                <div class="flex gap-4">
                    <div class="flex-1 relative">
                        <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400" style="font-size: 20px;"></i>
                        <input type="text" placeholder="Search by location, PG name..." 
                               class="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"/>
                    </div>
                    <button class="px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 font-medium">Search</button>
                </div>
            </div>

            <!-- Filters -->
            <div class="bg-white rounded-lg p-6 border border-gray-200">
                <div class="flex items-center gap-2 mb-4">
                    <i class="fas fa-filter text-gray-600" style="font-size: 20px;"></i>
                    <h3 class="text-lg font-bold text-gray-900">Filters</h3>
                </div>
                <div class="grid grid-cols-4 gap-4">
                    <select class="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option>All Locations</option>
                        <option>Koramangala</option>
                        <option>HSR Layout</option>
                        <option>Indiranagar</option>
                    </select>
                    <select class="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option>Price Range</option>
                        <option>Under ₹10,000</option>
                        <option>₹10,000 - ₹15,000</option>
                        <option>Above ₹15,000</option>
                    </select>
                    <select class="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option>Room Type</option>
                        <option>Single</option>
                        <option>Double</option>
                        <option>Triple</option>
                    </select>
                    <select class="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option>Gender</option>
                        <option>Male</option>
                        <option>Female</option>
                        <option>Co-ed</option>
                    </select>
                </div>
            </div>

            <!-- Results -->
            <div class="space-y-4">
                <div class="bg-white rounded-lg p-6 border border-gray-200 hover:shadow-md transition-all">
                    <div class="flex items-start justify-between">
                        <div class="flex gap-4">
                            <div class="w-24 h-24 bg-gradient-to-br from-blue-500 to-blue-600 rounded-lg flex items-center justify-center text-white font-bold text-2xl">S</div>
                            <div>
                                <h3 class="text-xl font-bold text-gray-900 mb-2">Sunrise PG for Men</h3>
                                <div class="flex items-center gap-4 text-sm text-gray-600">
                                    <div class="flex items-center gap-1">
                                        <i class="fas fa-map-marker-alt" style="font-size: 16px;"></i>
                                        Koramangala
                                    </div>
                                    <div class="flex items-center gap-1">
                                        <i class="fas fa-users" style="font-size: 16px;"></i>
                                        Single Sharing
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="text-right">
                            <div class="text-2xl font-bold text-blue-600">₹12,000</div>
                            <div class="text-sm text-gray-500">per month</div>
                            <button class="mt-4 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 text-sm font-medium">View Details</button>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-lg p-6 border border-gray-200 hover:shadow-md transition-all">
                    <div class="flex items-start justify-between">
                        <div class="flex gap-4">
                            <div class="w-24 h-24 bg-gradient-to-br from-green-500 to-green-600 rounded-lg flex items-center justify-center text-white font-bold text-2xl">G</div>
                            <div>
                                <h3 class="text-xl font-bold text-gray-900 mb-2">Green Valley Girls Hostel</h3>
                                <div class="flex items-center gap-4 text-sm text-gray-600">
                                    <div class="flex items-center gap-1">
                                        <i class="fas fa-map-marker-alt" style="font-size: 16px;"></i>
                                        HSR Layout
                                    </div>
                                    <div class="flex items-center gap-1">
                                        <i class="fas fa-users" style="font-size: 16px;"></i>
                                        Double Sharing
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="text-right">
                            <div class="text-2xl font-bold text-blue-600">₹10,000</div>
                            <div class="text-sm text-gray-500">per month</div>
                            <button class="mt-4 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 text-sm font-medium">View Details</button>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-lg p-6 border border-gray-200 hover:shadow-md transition-all">
                    <div class="flex items-start justify-between">
                        <div class="flex gap-4">
                            <div class="w-24 h-24 bg-gradient-to-br from-purple-500 to-purple-600 rounded-lg flex items-center justify-center text-white font-bold text-2xl">U</div>
                            <div>
                                <h3 class="text-xl font-bold text-gray-900 mb-2">Urban Nest Co-living</h3>
                                <div class="flex items-center gap-4 text-sm text-gray-600">
                                    <div class="flex items-center gap-1">
                                        <i class="fas fa-map-marker-alt" style="font-size: 16px;"></i>
                                        Indiranagar
                                    </div>
                                    <div class="flex items-center gap-1">
                                        <i class="fas fa-users" style="font-size: 16px;"></i>
                                        Single Sharing
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="text-right">
                            <div class="text-2xl font-bold text-blue-600">₹15,000</div>
                            <div class="text-sm text-gray-500">per month</div>
                            <button class="mt-4 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 text-sm font-medium">View Details</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <style>
        .space-y-6 > * + * { margin-top: 1.5rem; }
        .space-y-4 > * + * { margin-top: 1rem; }
    </style>
</body>
</html>
