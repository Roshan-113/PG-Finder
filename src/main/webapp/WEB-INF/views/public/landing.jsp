<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="currentPage" value="home" scope="request" />

<!-- Hero Section with Image Slider -->
<section class="relative overflow-hidden" style="background: linear-gradient(135deg, #111827 0%, #1e3a8a 50%, #1e40af 100%); color: white;">
    <!-- Background Images Slider -->
    <div class="absolute inset-0" id="imageSlider">
        <div class="slider-image active" style="opacity: 0.15;">
            <img src="https://images.unsplash.com/photo-1661258412259-fe5a585c1450?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080" 
                 alt="Modern Private Rooms" style="width: 100%; height: 100%; object-fit: cover;">
            <div style="position: absolute; inset: 0; background: linear-gradient(135deg, rgba(30, 58, 138, 0.9) 0%, rgba(30, 64, 175, 0.85) 50%, rgba(17, 24, 39, 0.9) 100%);"></div>
        </div>
        <div class="slider-image" style="opacity: 0;">
            <img src="https://images.unsplash.com/photo-1709805619372-40de3f158e83?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080" 
                 alt="Comfortable Shared Spaces" style="width: 100%; height: 100%; object-fit: cover;">
            <div style="position: absolute; inset: 0; background: linear-gradient(135deg, rgba(30, 58, 138, 0.9) 0%, rgba(30, 64, 175, 0.85) 50%, rgba(17, 24, 39, 0.9) 100%);"></div>
        </div>
        <div class="slider-image" style="opacity: 0;">
            <img src="https://images.unsplash.com/photo-1758523669073-edfbea249144?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080" 
                 alt="Premium Living Areas" style="width: 100%; height: 100%; object-fit: cover;">
            <div style="position: absolute; inset: 0; background: linear-gradient(135deg, rgba(30, 58, 138, 0.9) 0%, rgba(30, 64, 175, 0.85) 50%, rgba(17, 24, 39, 0.9) 100%);"></div>
        </div>
    </div>
    
    <!-- Animated Background Blobs -->
    <div class="absolute inset-0" style="opacity: 0.1;">
        <div style="position: absolute; top: 5rem; left: 2.5rem; width: 18rem; height: 18rem; background: white; border-radius: 9999px; filter: blur(64px); animation: pulse 2s infinite;"></div>
        <div style="position: absolute; bottom: 5rem; right: 2.5rem; width: 24rem; height: 24rem; background: #93c5fd; border-radius: 9999px; filter: blur(64px); animation: pulse 2s infinite;"></div>
    </div>
    
    <div class="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16 lg:py-24">
        <div class="grid lg:grid-cols-2 gap-12 items-center">
            <!-- Left Content -->
            <div>
                <!-- Badge -->
                <div class="inline-flex items-center gap-2 px-4 py-2 rounded-full mb-6" style="background: rgba(255, 255, 255, 0.1); backdrop-filter: blur(8px);">
                    <i class="fas fa-clock" style="font-size: 16px;"></i>
                    <span class="text-sm">Available 24/7 Support</span>
                </div>
                
                <!-- Heading -->
                <h1 class="mb-6 font-bold" style="font-size: 2.25rem; line-height: 1.2;">
                    Find Your Perfect
                    <span class="block" style="background: linear-gradient(to right, #93c5fd, #86efac); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">
                        PG & Roommate
                    </span>
                </h1>
                
                <!-- Description -->
                <p class="text-lg mb-8" style="color: #dbeafe; line-height: 1.625;">
                    Discover verified PG accommodations, connect with compatible roommates, and make your stay comfortable with PG Finder.
                </p>
                
                <!-- Stats Grid -->
                <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
                    <div class="text-center">
                        <i class="fas fa-home mx-auto mb-2" style="font-size: 20px; color: #4ade80;"></i>
                        <div class="font-bold text-xl">1000+</div>
                        <div class="text-xs" style="color: #bfdbfe;">Verified PGs</div>
                    </div>
                    <div class="text-center">
                        <i class="fas fa-users mx-auto mb-2" style="font-size: 20px; color: #4ade80;"></i>
                        <div class="font-bold text-xl">5000+</div>
                        <div class="text-xs" style="color: #bfdbfe;">Happy Tenants</div>
                    </div>
                    <div class="text-center">
                        <i class="fas fa-shield-alt mx-auto mb-2" style="font-size: 20px; color: #4ade80;"></i>
                        <div class="font-bold text-xl">100%</div>
                        <div class="text-xs" style="color: #bfdbfe;">Safe & Secure</div>
                    </div>
                    <div class="text-center">
                        <i class="fas fa-chart-line mx-auto mb-2" style="font-size: 20px; color: #4ade80;"></i>
                        <div class="font-bold text-xl">95%</div>
                        <div class="text-xs" style="color: #bfdbfe;">Success Rate</div>
                    </div>
                </div>
                
                <!-- CTA Buttons -->
                <div class="flex flex-col sm:flex-row gap-4">
                    <button class="flex-1 btn btn-lg" style="background: #0ea5e9; color: white;" 
                        onclick="window.location.href='${pageContext.request.contextPath}/find-pg'">
                        <i class="fas fa-search mr-2"></i>
                        Browse PG Listings
                    </button>
                    <button class="flex-1 btn btn-lg" style="border: 2px solid white; color: white; background: transparent;" 
                            onclick="window.location.href='${pageContext.request.contextPath}/find-roommate'">
                        <i class="fas fa-users mr-2"></i>
                        Find Roommates
                    </button>
                </div>
            </div>
            
            <!-- Right Side - Image Slider -->
            <div class="relative">
                <div class="relative rounded-2xl overflow-hidden shadow-2xl">
                    <div style="aspect-ratio: 4/3; position: relative;">
                        <div class="hero-slider-image active">
                            <img src="https://images.unsplash.com/photo-1661258412259-fe5a585c1450?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080" 
                                 alt="Modern Private Rooms" style="width: 100%; height: 100%; object-fit: cover;">
                            <div style="position: absolute; inset: 0; background: linear-gradient(to top, rgba(0,0,0,0.6), transparent);"></div>
                            <div style="position: absolute; bottom: 1.5rem; left: 1.5rem; right: 1.5rem;">
                                <h3 class="text-white text-2xl font-bold">Modern Private Rooms</h3>
                            </div>
                        </div>
                        <div class="hero-slider-image">
                            <img src="https://images.unsplash.com/photo-1709805619372-40de3f158e83?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080" 
                                 alt="Comfortable Shared Spaces" style="width: 100%; height: 100%; object-fit: cover;">
                            <div style="position: absolute; inset: 0; background: linear-gradient(to top, rgba(0,0,0,0.6), transparent);"></div>
                            <div style="position: absolute; bottom: 1.5rem; left: 1.5rem; right: 1.5rem;">
                                <h3 class="text-white text-2xl font-bold">Comfortable Shared Spaces</h3>
                            </div>
                        </div>
                        <div class="hero-slider-image">
                            <img src="https://images.unsplash.com/photo-1758523669073-edfbea249144?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=1080" 
                                 alt="Premium Living Areas" style="width: 100%; height: 100%; object-fit: cover;">
                            <div style="position: absolute; inset: 0; background: linear-gradient(to top, rgba(0,0,0,0.6), transparent);"></div>
                            <div style="position: absolute; bottom: 1.5rem; left: 1.5rem; right: 1.5rem;">
                                <h3 class="text-white text-2xl font-bold">Premium Living Areas</h3>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Slider Dots -->
                    <div style="position: absolute; bottom: 0.75rem; left: 50%; transform: translateX(-50%); display: flex; gap: 0.5rem; z-index: 10;">
                        <button class="slider-dot active" onclick="goToSlide(0)" style="height: 0.375rem; border-radius: 9999px; transition: all 0.3s; background: white; width: 2rem;"></button>
                        <button class="slider-dot" onclick="goToSlide(1)" style="height: 0.375rem; border-radius: 9999px; transition: all 0.3s; background: rgba(255,255,255,0.5); width: 0.375rem;"></button>
                        <button class="slider-dot" onclick="goToSlide(2)" style="height: 0.375rem; border-radius: 9999px; transition: all 0.3s; background: rgba(255,255,255,0.5); width: 0.375rem;"></button>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Search Form -->
        <div class="p-6 max-w-5xl mx-auto mt-12 mb-16 rounded-2xl shadow-2xl" style="background: rgba(255, 255, 255, 0.1); backdrop-filter: blur(12px); border: 1px solid rgba(255, 255, 255, 0.2);">
            <form action="${pageContext.request.contextPath}/pg-listing" method="GET" id="searchForm">
                <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                    <div class="md:col-span-2">
                        <div class="relative">
                            <i class="fas fa-map-marker-alt" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: #374151; font-size: 18px; z-index: 1; pointer-events: none;"></i>
                            <select name="city" id="citySelect" style="width: 100%; padding: 0.75rem 2.5rem 0.75rem 2.5rem; border-radius: 0.5rem; border: 1px solid rgba(255,255,255,0.3); background: rgba(255,255,255,0.9); color: #111827; appearance: none; background-image: url('data:image/svg+xml;charset=UTF-8,%3csvg xmlns=%27http://www.w3.org/2000/svg%27 viewBox=%270 0 24 24%27 fill=%27none%27 stroke=%27currentColor%27 stroke-width=%272%27 stroke-linecap=%27round%27 stroke-linejoin=%27round%27%3e%3cpolyline points=%276 9 12 15 18 9%27%3e%3c/polyline%3e%3c/svg%3e'); background-repeat: no-repeat; background-position: right 0.75rem center; background-size: 1.25rem;">
                                <option value="">Select City</option>
                                <c:choose>
                                    <c:when test="${not empty popularCities}">
                                        <c:forEach var="city" items="${popularCities}">
                                            <option value="${city.city}">${city.city}, ${city.state}</option>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="Bangalore">Bangalore, Karnataka</option>
                                        <option value="Mumbai">Mumbai, Maharashtra</option>
                                        <option value="Delhi">Delhi, Delhi</option>
                                        <option value="Pune">Pune, Maharashtra</option>
                                        <option value="Hyderabad">Hyderabad, Telangana</option>
                                        <option value="Chennai">Chennai, Tamil Nadu</option>
                                        <option value="Kolkata">Kolkata, West Bengal</option>
                                        <option value="Ahmedabad">Ahmedabad, Gujarat</option>
                                    </c:otherwise>
                                </c:choose>
                            </select>
                        </div>
                    </div>
                    <div>
                        <div class="relative">
                            <i class="fas fa-rupee-sign" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: #374151; font-size: 18px;"></i>
                            <input type="number" name="maxRent" placeholder="Max budget" 
                                   style="width: 100%; padding: 0.75rem 1rem 0.75rem 2.5rem; border-radius: 0.5rem; border: 1px solid rgba(255,255,255,0.3); background: rgba(255,255,255,0.9); color: #111827;">
                        </div>
                    </div>
                    <div>
                        <select name="pgType" style="width: 100%; padding: 0.75rem 2rem 0.75rem 1rem; border-radius: 0.5rem; border: 1px solid rgba(255,255,255,0.3); background: rgba(255,255,255,0.9); color: #111827; appearance: none; background-image: url('data:image/svg+xml;charset=UTF-8,%3csvg xmlns=%27http://www.w3.org/2000/svg%27 viewBox=%270 0 24 24%27 fill=%27none%27 stroke=%27currentColor%27 stroke-width=%272%27 stroke-linecap=%27round%27 stroke-linejoin=%27round%27%3e%3cpolyline points=%276 9 12 15 18 9%27%3e%3c/polyline%3e%3c/svg%3e'); background-repeat: no-repeat; background-position: right 0.75rem center; background-size: 1.25rem;">
                            <option value="">Select Gender</option>
                            <option value="boys">Male</option>
                            <option value="girls">Female</option>
                        </select>
                    </div>
                </div>
                <div class="flex flex-col sm:flex-row gap-3 mt-6">
                    <button type="submit" class="flex-1 btn btn-lg" style="background: #0ea5e9; color: white;">
                        <i class="fas fa-search mr-2"></i>
                        Search PG
                    </button>
                    <button type="button" class="flex-1 btn btn-lg" style="border: 2px solid white; color: white; background: transparent;" 
                            onclick="window.location.href='${pageContext.request.contextPath}/register'">
                        <i class="fas fa-home mr-2"></i>
                        Post Your Room
                    </button>
                </div>
            </form>
        </div>
    </div>
</section>


<!-- Features Section -->
<section class="py-20 bg-white">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-16">
            <h2 class="mb-4 text-3xl font-bold">Why Choose PG Finder?</h2>
            <p class="text-lg text-gray-600 max-w-2xl mx-auto">
                We make finding your perfect stay simple, safe, and stress-free with our unique features.
            </p>
        </div>
        
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            <!-- Feature 1 -->
            <div class="card p-6 hover:shadow-xl transition-all hover:-translate-y-1" style="height: 100%;">
                <div class="w-14 h-14 rounded-xl flex items-center justify-center mb-4 shadow-lg" 
                     style="background: linear-gradient(135deg, #3b82f6, #2563eb);">
                    <i class="fas fa-search text-white" style="font-size: 26px;"></i>
                </div>
                <h4 class="mb-3 font-semibold text-lg">Smart PG Search</h4>
                <p class="text-gray-600 text-sm leading-relaxed">
                    Find verified PG accommodations with advanced filters and real-time availability.
                </p>
            </div>
            
            <!-- Feature 2 -->
            <div class="card p-6 hover:shadow-xl transition-all hover:-translate-y-1" style="height: 100%;">
                <div class="w-14 h-14 rounded-xl flex items-center justify-center mb-4 shadow-lg" 
                     style="background: linear-gradient(135deg, #a855f7, #9333ea);">
                    <i class="fas fa-users text-white" style="font-size: 26px;"></i>
                </div>
                <h4 class="mb-3 font-semibold text-lg">Roommate Matching</h4>
                <p class="text-gray-600 text-sm leading-relaxed">
                    Discover compatible roommates based on lifestyle, habits, and preferences.
                </p>
            </div>
            
            <!-- Feature 3 -->
            <div class="card p-6 hover:shadow-xl transition-all hover:-translate-y-1" style="height: 100%;">
                <div class="w-14 h-14 rounded-xl flex items-center justify-center mb-4 shadow-lg" 
                     style="background: linear-gradient(135deg, #22c55e, #16a34a);">
                    <i class="fas fa-sync-alt text-white" style="font-size: 26px;"></i>
                </div>
                <h4 class="mb-3 font-semibold text-lg">Easy Roommate Replacement</h4>
                <p class="text-gray-600 text-sm leading-relaxed">
                    Replace roommates without shifting PG. Unique mutual approval system.
                </p>
            </div>
            
            <!-- Feature 4 -->
            <div class="card p-6 hover:shadow-xl transition-all hover:-translate-y-1" style="height: 100%;">
                <div class="w-14 h-14 rounded-xl flex items-center justify-center mb-4 shadow-lg" 
                     style="background: linear-gradient(135deg, #f59e0b, #d97706);">
                    <i class="fas fa-star text-white" style="font-size: 26px;"></i>
                </div>
                <h4 class="mb-3 font-semibold text-lg">Verified Reviews</h4>
                <p class="text-gray-600 text-sm leading-relaxed">
                    Read honest reviews from real tenants about PG facilities and owners.
                </p>
            </div>
        </div>
    </div>
</section>


<!-- How It Works Section -->
<section class="py-20 relative overflow-hidden" style="background: linear-gradient(135deg, #111827 0%, #1e3a8a 50%, #1e40af 100%); color: white;">
    <!-- Animated Background -->
    <div class="absolute inset-0" style="opacity: 0.1;">
        <div style="position: absolute; top: 5rem; left: 2.5rem; width: 18rem; height: 18rem; background: white; border-radius: 9999px; filter: blur(64px); animation: pulse 2s infinite;"></div>
        <div style="position: absolute; bottom: 5rem; right: 2.5rem; width: 24rem; height: 24rem; background: #93c5fd; border-radius: 9999px; filter: blur(64px); animation: pulse 2s infinite;"></div>
    </div>
    
    <div class="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-16">
            <h2 class="mb-4 text-white text-3xl font-bold">How It Works</h2>
            <p class="text-lg" style="color: #dbeafe;">
                Get started in three simple steps
            </p>
        </div>
        
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 max-w-6xl mx-auto">
            <!-- Step 1 -->
            <div class="rounded-2xl p-8 transition-all hover:-translate-y-2" 
                 style="background: rgba(255, 255, 255, 0.1); backdrop-filter: blur(8px); height: 100%; border: 1px solid rgba(255, 255, 255, 0.2);">
                <div class="flex flex-col items-center text-center">
                    <div class="w-20 h-20 rounded-2xl flex items-center justify-center text-3xl font-bold mb-6 shadow-xl text-white" 
                         style="background: rgba(255, 255, 255, 0.2); backdrop-filter: blur(8px);">
                        1
                    </div>
                    <i class="fas fa-search mb-4 text-white" style="font-size: 40px;"></i>
                    <h4 class="mb-3 text-white text-xl font-semibold">Search</h4>
                    <p style="color: #dbeafe; line-height: 1.625;">
                        Browse PGs and roommates in your preferred location
                    </p>
                </div>
            </div>
            
            <!-- Step 2 -->
            <div class="rounded-2xl p-8 transition-all hover:-translate-y-2" 
                 style="background: rgba(255, 255, 255, 0.1); backdrop-filter: blur(8px); height: 100%; border: 1px solid rgba(255, 255, 255, 0.2);">
                <div class="flex flex-col items-center text-center">
                    <div class="w-20 h-20 rounded-2xl flex items-center justify-center text-3xl font-bold mb-6 shadow-xl text-white" 
                         style="background: rgba(255, 255, 255, 0.2); backdrop-filter: blur(8px);">
                        2
                    </div>
                    <i class="fas fa-users mb-4 text-white" style="font-size: 40px;"></i>
                    <h4 class="mb-3 text-white text-xl font-semibold">Connect</h4>
                    <p style="color: #dbeafe; line-height: 1.625;">
                        Chat with owners and potential roommates
                    </p>
                </div>
            </div>
            
            <!-- Step 3 -->
            <div class="rounded-2xl p-8 transition-all hover:-translate-y-2" 
                 style="background: rgba(255, 255, 255, 0.1); backdrop-filter: blur(8px); height: 100%; border: 1px solid rgba(255, 255, 255, 0.2);">
                <div class="flex flex-col items-center text-center">
                    <div class="w-20 h-20 rounded-2xl flex items-center justify-center text-3xl font-bold mb-6 shadow-xl text-white" 
                         style="background: rgba(255, 255, 255, 0.2); backdrop-filter: blur(8px);">
                        3
                    </div>
                    <i class="fas fa-star mb-4 text-white" style="font-size: 40px;"></i>
                    <h4 class="mb-3 text-white text-xl font-semibold">Stay & Review</h4>
                    <p style="color: #dbeafe; line-height: 1.625;">
                        Move in and share your experience with others
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>


<!-- Reviews Section -->
<section class="py-20" style="background: linear-gradient(135deg, #f9fafb 0%, #eff6ff 100%);">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-16">
            <h2 class="mb-4 text-3xl font-bold">What Our Users Say</h2>
            <p class="text-lg text-gray-600">
                Real experiences from real tenants
            </p>
        </div>
        
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <!-- Review 1 -->
            <div class="card p-6 hover:shadow-xl transition-shadow" style="height: 100%;">
                <div class="flex items-center gap-4 mb-4">
                    <img src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&h=150&fit=crop" 
                         alt="Priya Sharma" class="w-16 h-16 rounded-full" style="object-fit: cover;">
                    <div>
                        <h4 class="font-semibold text-gray-900">Priya Sharma</h4>
                        <p class="text-sm text-gray-600">Software Engineer</p>
                    </div>
                </div>
                <div class="flex gap-1 mb-4">
                    <i class="fas fa-star" style="font-size: 18px; color: #f59e0b;"></i>
                    <i class="fas fa-star" style="font-size: 18px; color: #f59e0b;"></i>
                    <i class="fas fa-star" style="font-size: 18px; color: #f59e0b;"></i>
                    <i class="fas fa-star" style="font-size: 18px; color: #f59e0b;"></i>
                    <i class="fas fa-star" style="font-size: 18px; color: #f59e0b;"></i>
                </div>
                <p class="text-gray-700 leading-relaxed">"Found my perfect PG in just 2 days! The roommate matching feature is amazing. Highly recommended!"</p>
            </div>
            
            <!-- Review 2 -->
            <div class="card p-6 hover:shadow-xl transition-shadow" style="height: 100%;">
                <div class="flex items-center gap-4 mb-4">
                    <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop" 
                         alt="Rahul Kumar" class="w-16 h-16 rounded-full" style="object-fit: cover;">
                    <div>
                        <h4 class="font-semibold text-gray-900">Rahul Kumar</h4>
                        <p class="text-sm text-gray-600">MBA Student</p>
                    </div>
                </div>
                <div class="flex gap-1 mb-4">
                    <i class="fas fa-star" style="font-size: 18px; color: #f59e0b;"></i>
                    <i class="fas fa-star" style="font-size: 18px; color: #f59e0b;"></i>
                    <i class="fas fa-star" style="font-size: 18px; color: #f59e0b;"></i>
                    <i class="fas fa-star" style="font-size: 18px; color: #f59e0b;"></i>
                    <i class="fas fa-star" style="font-size: 18px; color: #f59e0b;"></i>
                </div>
                <p class="text-gray-700 leading-relaxed">"Best platform for finding PG accommodations. All listings are verified and the owners are very responsive."</p>
            </div>
            
            <!-- Review 3 -->
            <div class="card p-6 hover:shadow-xl transition-shadow" style="height: 100%;">
                <div class="flex items-center gap-4 mb-4">
                    <img src="https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop" 
                         alt="Anjali Desai" class="w-16 h-16 rounded-full" style="object-fit: cover;">
                    <div>
                        <h4 class="font-semibold text-gray-900">Anjali Desai</h4>
                        <p class="text-sm text-gray-600">Marketing Manager</p>
                    </div>
                </div>
                <div class="flex gap-1 mb-4">
                    <i class="fas fa-star" style="font-size: 18px; color: #f59e0b;"></i>
                    <i class="fas fa-star" style="font-size: 18px; color: #f59e0b;"></i>
                    <i class="fas fa-star" style="font-size: 18px; color: #f59e0b;"></i>
                    <i class="fas fa-star" style="font-size: 18px; color: #f59e0b;"></i>
                    <i class="fas fa-star" style="font-size: 18px; color: #f59e0b;"></i>
                </div>
                <p class="text-gray-700 leading-relaxed">"The roommate replacement feature saved me so much hassle. No need to shift PG, just found a new compatible roommate!"</p>
            </div>
        </div>
    </div>
</section>


<style>
/* Slider Styles */
.slider-image {
    position: absolute;
    inset: 0;
    transition: opacity 1s ease-in-out;
}

.slider-image.active {
    opacity: 0.15;
}

.hero-slider-image {
    position: absolute;
    inset: 0;
    opacity: 0;
    transition: opacity 800ms ease-in-out;
}

.hero-slider-image.active {
    opacity: 1;
}

.slider-dot.active {
    background: white !important;
    width: 2rem !important;
}

.slider-dot:hover {
    background: rgba(255, 255, 255, 0.8) !important;
}

/* Button Styles */
.btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    border-radius: 0.5rem;
    font-weight: 500;
    transition: all 0.2s;
    border: none;
    cursor: pointer;
    font-family: inherit;
}

.btn-lg {
    padding: 0.75rem 1.5rem;
    font-size: 1.125rem;
}

.btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
}

/* Animation */
@keyframes pulse {
    0%, 100% {
        opacity: 0.1;
    }
    50% {
        opacity: 0.15;
    }
}

/* Responsive */
@media (min-width: 1024px) {
    .lg\:text-5xl {
        font-size: 3rem;
    }
    .lg\:text-6xl {
        font-size: 3.75rem;
    }
}
</style>

<script>
// Background Image Slider
let currentBgSlide = 0;
const bgSlides = document.querySelectorAll('.slider-image');

function nextBgSlide() {
    bgSlides[currentBgSlide].classList.remove('active');
    currentBgSlide = (currentBgSlide + 1) % bgSlides.length;
    bgSlides[currentBgSlide].classList.add('active');
}

setInterval(nextBgSlide, 4000);

// Hero Image Slider
let currentHeroSlide = 0;
const heroSlides = document.querySelectorAll('.hero-slider-image');
const sliderDots = document.querySelectorAll('.slider-dot');

function updateHeroSlider() {
    heroSlides.forEach((slide, index) => {
        slide.classList.toggle('active', index === currentHeroSlide);
    });
    sliderDots.forEach((dot, index) => {
        dot.classList.toggle('active', index === currentHeroSlide);
        if (index === currentHeroSlide) {
            dot.style.background = 'white';
            dot.style.width = '2rem';
        } else {
            dot.style.background = 'rgba(255, 255, 255, 0.5)';
            dot.style.width = '0.375rem';
        }
    });
}

function nextHeroSlide() {
    currentHeroSlide = (currentHeroSlide + 1) % heroSlides.length;
    updateHeroSlider();
}

function goToSlide(index) {
    currentHeroSlide = index;
    updateHeroSlider();
}

setInterval(nextHeroSlide, 4000);
</script>
