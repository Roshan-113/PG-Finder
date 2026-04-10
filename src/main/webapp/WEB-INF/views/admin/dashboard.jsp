<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.google.gson.Gson" %>
<%
    // Convert registration stats to JSON
    Gson gson = new Gson();
    String registrationStatsJson = gson.toJson(request.getAttribute("registrationStats"));
    request.setAttribute("registrationStatsJson", registrationStatsJson);
    
    // Convert revenue stats to JSON
    String revenueStatsJson = gson.toJson(request.getAttribute("revenueStats"));
    request.setAttribute("revenueStatsJson", revenueStatsJson);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - PG Finder</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/globals.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50">
    <div class="flex">
        <jsp:include page="../includes/sidebar-admin.jsp">
            <jsp:param name="currentPage" value="dashboard" />
        </jsp:include>

        <main class="flex-1 min-h-screen" style="margin-left: 240px;">
            <jsp:include page="../includes/header-admin.jsp" />

            <div class="p-8">
                <h1 class="text-3xl font-bold text-gray-900 mb-2">Admin Dashboard</h1>
                <p class="text-gray-600 mb-8">Welcome back! Here's your platform overview</p>

                <!-- Stats Grid -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                    <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-100">
                        <div class="flex items-center gap-4">
                            <div class="w-14 h-14 rounded-lg flex items-center justify-center" style="background: #eff6ff;">
                                <i class="fas fa-users" style="font-size: 24px; color: #2563eb;"></i>
                            </div>
                            <div>
                                <div class="text-3xl font-bold text-gray-900">${stats.tenant_count + stats.owner_count}</div>
                                <div class="text-sm text-gray-600">Total Users</div>
                            </div>
                        </div>
                    </div>

                    <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-100">
                        <div class="flex items-center gap-4">
                            <div class="w-14 h-14 rounded-lg flex items-center justify-center" style="background: #f0fdf4;">
                                <i class="fas fa-home" style="font-size: 24px; color: #10b981;"></i>
                            </div>
                            <div>
                                <div class="text-3xl font-bold text-gray-900">${stats.total_listings}</div>
                                <div class="text-sm text-gray-600">Total Listings</div>
                            </div>
                        </div>
                    </div>

                    <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-100">
                        <div class="flex items-center gap-4">
                            <div class="w-14 h-14 rounded-lg flex items-center justify-center" style="background: #fef3c7;">
                                <i class="fas fa-calendar-check" style="font-size: 24px; color: #f59e0b;"></i>
                            </div>
                            <div>
                                <div class="text-3xl font-bold text-gray-900">${stats.total_bookings}</div>
                                <div class="text-sm text-gray-600">Total Bookings</div>
                            </div>
                        </div>
                    </div>

                    <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-100">
                        <div class="flex items-center gap-4">
                            <div class="w-14 h-14 rounded-lg flex items-center justify-center" style="background: #fce7f3;">
                                <i class="fas fa-rupee-sign" style="font-size: 24px; color: #ec4899;"></i>
                            </div>
                            <div>
                                <div class="text-3xl font-bold text-gray-900">₹<fmt:formatNumber value="${stats.total_revenue}" pattern="#,##0"/></div>
                                <div class="text-sm text-gray-600">Total Revenue</div>
                            </div>
                        </div>
                    </div>

                    <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-100">
                        <div class="flex items-center gap-4">
                            <div class="w-14 h-14 rounded-lg flex items-center justify-center" style="background: #ede9fe;">
                                <i class="fas fa-clock" style="font-size: 24px; color: #8b5cf6;"></i>
                            </div>
                            <div>
                                <div class="text-3xl font-bold text-gray-900">${stats.pending_documents}</div>
                                <div class="text-sm text-gray-600">Pending Approvals</div>
                            </div>
                        </div>
                    </div>

                    <div class="bg-white rounded-xl p-6 shadow-sm border border-gray-100">
                        <div class="flex items-center gap-4">
                            <div class="w-14 h-14 rounded-lg flex items-center justify-center" style="background: #fef9c3;">
                                <i class="fas fa-flag" style="font-size: 24px; color: #eab308;"></i>
                            </div>
                            <div>
                                <div class="text-3xl font-bold text-gray-900">${stats.pending_reports}</div>
                                <div class="text-sm text-gray-600">Pending Reports</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Graphs Section -->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
                    <!-- User Registration Graph -->
                    <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
                        <h2 class="text-xl font-bold text-gray-900 mb-4">User Registrations (Last 12 Months)</h2>
                        <div id="registrationChartContainer">
                            <canvas id="registrationChart" style="max-height: 300px;"></canvas>
                        </div>
                    </div>

                    <!-- Revenue Line Graph -->
                    <div class="bg-white rounded-xl shadow-sm border border-gray-100 p-6">
                        <h2 class="text-xl font-bold text-gray-900 mb-4">Revenue Trend (Last 12 Months)</h2>
                        <div id="revenueChartContainer">
                            <canvas id="revenueChart" style="max-height: 300px;"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Recent Activities -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-100 mb-8">
                    <div class="px-6 py-4 border-b border-gray-100 flex items-center justify-between">
                        <h2 class="text-xl font-bold text-gray-900">Recent Activities</h2>
                        <a href="${pageContext.request.contextPath}/admin/settings?tab=logs" class="text-sm text-blue-600 hover:text-blue-700 font-medium">View All</a>
                    </div>
                    <div class="p-6">
                        <c:choose>
                            <c:when test="${not empty recentActivities}">
                                <table class="w-full">
                                    <thead>
                                        <tr class="border-b border-gray-100">
                                            <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">User</th>
                                            <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Action</th>
                                            <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Description</th>
                                            <th class="text-left py-3 px-4 text-sm font-semibold text-gray-700">Time</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="activity" items="${recentActivities}">
                                            <tr class="border-b border-gray-50 hover:bg-gray-50">
                                                <td class="py-3 px-4 text-sm text-gray-900">${activity.user_name}</td>
                                                <td class="py-3 px-4 text-sm"><span class="px-2 py-1 bg-gray-100 text-gray-700 rounded text-xs font-medium">${activity.action_type}</span></td>
                                                <td class="py-3 px-4 text-sm text-gray-600">${activity.action_description}</td>
                                                <td class="py-3 px-4 text-sm text-gray-500"><fmt:formatDate value="${activity.created_at}" pattern="dd MMM yyyy HH:mm"/></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-12">
                                    <i class="fas fa-history text-gray-300 text-5xl mb-4"></i>
                                    <p class="text-gray-500">No recent activities</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div>
                    <h2 class="text-xl font-bold text-gray-900 mb-4">Quick Actions</h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                        <a href="${pageContext.request.contextPath}/admin/users" class="bg-white rounded-xl p-6 shadow-sm border border-gray-100 hover:shadow-md transition-shadow text-center">
                            <i class="fas fa-users text-blue-600 text-3xl mb-3"></i>
                            <div class="text-sm font-semibold text-gray-900">Manage Users</div>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/listings" class="bg-white rounded-xl p-6 shadow-sm border border-gray-100 hover:shadow-md transition-shadow text-center">
                            <i class="fas fa-building text-green-600 text-3xl mb-3"></i>
                            <div class="text-sm font-semibold text-gray-900">View Listings</div>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/approvals" class="bg-white rounded-xl p-6 shadow-sm border border-gray-100 hover:shadow-md transition-shadow text-center">
                            <i class="fas fa-shield-alt text-purple-600 text-3xl mb-3"></i>
                            <div class="text-sm font-semibold text-gray-900">Verify Owners</div>
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/reports" class="bg-white rounded-xl p-6 shadow-sm border border-gray-100 hover:shadow-md transition-shadow text-center">
                            <i class="fas fa-flag text-yellow-600 text-3xl mb-3"></i>
                            <div class="text-sm font-semibold text-gray-900">Review Reports</div>
                        </a>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- Chart.js Library -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    
    <script>
        // Check if we have data
        const registrationData = ${registrationStatsJson};
        const revenueData = ${revenueStatsJson};
        
        console.log('Registration Data:', registrationData);
        console.log('Revenue Data:', revenueData);
        
        // Only render charts if we have data
        if (registrationData && registrationData.length > 0) {
            // Process registration data for chart
            const months = [...new Set(registrationData.map(d => d.month))].sort();
            const tenantData = months.map(month => {
                const entry = registrationData.find(d => d.month === month && d.user_type === 'tenant');
                return entry ? entry.count : 0;
            });
            const ownerData = months.map(month => {
                const entry = registrationData.find(d => d.month === month && d.user_type === 'owner');
                return entry ? entry.count : 0;
            });
            const totalData = months.map((month, i) => tenantData[i] + ownerData[i]);
            
            // Format month labels
            const monthLabels = months.map(m => {
                const [year, month] = m.split('-');
                const date = new Date(year, month - 1);
                return date.toLocaleDateString('en-US', { month: 'short', year: 'numeric' });
            });
            
            // Registration Chart (Bar Chart with hover percentages)
            const registrationCtx = document.getElementById('registrationChart').getContext('2d');
            const registrationChart = new Chart(registrationCtx, {
                type: 'bar',
                data: {
                    labels: monthLabels,
                    datasets: [
                        {
                            label: 'Tenants',
                            data: tenantData,
                            backgroundColor: 'rgba(59, 130, 246, 0.8)',
                            borderColor: 'rgba(59, 130, 246, 1)',
                            borderWidth: 2,
                            hoverBackgroundColor: 'rgba(37, 99, 235, 1)',
                            hoverBorderColor: 'rgba(29, 78, 216, 1)',
                            hoverBorderWidth: 3
                        },
                        {
                            label: 'Owners',
                            data: ownerData,
                            backgroundColor: 'rgba(96, 165, 250, 0.8)',
                            borderColor: 'rgba(96, 165, 250, 1)',
                            borderWidth: 2,
                            hoverBackgroundColor: 'rgba(59, 130, 246, 1)',
                            hoverBorderColor: 'rgba(37, 99, 235, 1)',
                            hoverBorderWidth: 3
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: true,
                    interaction: {
                        mode: 'index',
                        intersect: false
                    },
                    plugins: {
                        legend: {
                            display: true,
                            position: 'top',
                            labels: {
                                usePointStyle: true,
                                padding: 15,
                                font: {
                                    size: 13,
                                    weight: '500'
                                }
                            }
                        },
                        tooltip: {
                            backgroundColor: 'rgba(0, 0, 0, 0.8)',
                            titleColor: '#fff',
                            bodyColor: '#fff',
                            borderColor: 'rgba(59, 130, 246, 1)',
                            borderWidth: 2,
                            padding: 12,
                            displayColors: true,
                            callbacks: {
                                label: function(context) {
                                    const label = context.dataset.label || '';
                                    const value = context.parsed.y;
                                    const total = totalData[context.dataIndex];
                                    const percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0;
                                    return label + ': ' + value + ' (' + percentage + '%)';
                                },
                                footer: function(tooltipItems) {
                                    const index = tooltipItems[0].dataIndex;
                                    const total = totalData[index];
                                    return 'Total: ' + total;
                                }
                            }
                        }
                    },
                    scales: {
                        x: {
                            stacked: false,
                            grid: {
                                display: false
                            },
                            ticks: {
                                font: {
                                    size: 11
                                }
                            }
                        },
                        y: {
                            stacked: false,
                            beginAtZero: true,
                            ticks: {
                                stepSize: 1,
                                font: {
                                    size: 11
                                }
                            },
                            grid: {
                                color: 'rgba(59, 130, 246, 0.1)',
                                drawBorder: false
                            }
                        }
                    }
                }
            });
        } else {
            // Show no data message for registration chart
            document.getElementById('registrationChart').parentElement.innerHTML = 
                '<div class="text-center py-12"><i class="fas fa-chart-bar text-gray-300" style="font-size: 3rem; margin-bottom: 1rem;"></i><p class="text-gray-500">No registration data available for the last 12 months</p></div>';
        }
        
        // Revenue Chart
        if (revenueData && revenueData.length > 0) {
            try {
                // Process revenue data for chart
                const revenueMonths = revenueData.map(d => {
                    const [year, month] = d.month.split('-');
                    const date = new Date(year, month - 1);
                    return date.toLocaleDateString('en-US', { month: 'short', year: 'numeric' });
                });
                const revenueValues = revenueData.map(d => parseFloat(d.revenue) || 0);
                const bookingCounts = revenueData.map(d => parseInt(d.booking_count) || 0);
                
                console.log('Revenue Months:', revenueMonths);
                console.log('Revenue Values:', revenueValues);
                console.log('Booking Counts:', bookingCounts);
                
                // Revenue Chart (Line Chart)
                const revenueCanvas = document.getElementById('revenueChart');
                if (revenueCanvas) {
                    const revenueCtx = revenueCanvas.getContext('2d');
                    const revenueChart = new Chart(revenueCtx, {
                        type: 'line',
                        data: {
                            labels: revenueMonths,
                            datasets: [{
                                label: 'Revenue (₹)',
                                data: revenueValues,
                                borderColor: 'rgba(59, 130, 246, 1)',
                                backgroundColor: 'rgba(59, 130, 246, 0.1)',
                                borderWidth: 3,
                                fill: true,
                                tension: 0.4,
                                pointRadius: 6,
                                pointHoverRadius: 10,
                                pointBackgroundColor: 'rgba(59, 130, 246, 1)',
                                pointBorderColor: '#fff',
                                pointBorderWidth: 3,
                                pointHoverBackgroundColor: 'rgba(37, 99, 235, 1)',
                                pointHoverBorderColor: '#fff',
                                pointHoverBorderWidth: 4
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: true,
                            interaction: {
                                mode: 'index',
                                intersect: false
                            },
                            plugins: {
                                legend: {
                                    display: true,
                                    position: 'top',
                                    labels: {
                                        usePointStyle: true,
                                        padding: 15,
                                        font: {
                                            size: 13,
                                            weight: '500'
                                        }
                                    }
                                },
                                tooltip: {
                                    backgroundColor: 'rgba(0, 0, 0, 0.8)',
                                    titleColor: '#fff',
                                    bodyColor: '#fff',
                                    borderColor: 'rgba(59, 130, 246, 1)',
                                    borderWidth: 2,
                                    padding: 12,
                                    displayColors: true,
                                    callbacks: {
                                        label: function(context) {
                                            const value = context.parsed.y;
                                            const bookings = bookingCounts[context.dataIndex];
                                            return [
                                                'Revenue: ₹' + value.toLocaleString('en-IN'),
                                                'Bookings: ' + bookings
                                            ];
                                        }
                                    }
                                }
                            },
                            scales: {
                                x: {
                                    grid: {
                                        display: true,
                                        color: 'rgba(59, 130, 246, 0.1)',
                                        drawBorder: false
                                    },
                                    ticks: {
                                        font: {
                                            size: 11
                                        }
                                    }
                                },
                                y: {
                                    beginAtZero: true,
                                    ticks: {
                                        callback: function(value) {
                                            return '₹' + value.toLocaleString('en-IN');
                                        },
                                        font: {
                                            size: 11
                                        }
                                    },
                                    grid: {
                                        color: 'rgba(59, 130, 246, 0.1)',
                                        drawBorder: false
                                    }
                                }
                            },
                            onHover: (event, activeElements) => {
                                event.native.target.style.cursor = activeElements.length > 0 ? 'pointer' : 'default';
                            }
                        }
                    });
                    console.log('Revenue chart created successfully');
                } else {
                    console.error('Revenue chart canvas element not found');
                }
            } catch (error) {
                console.error('Error creating revenue chart:', error);
                document.getElementById('revenueChartContainer').innerHTML = 
                    '<div class="text-center py-12"><i class="fas fa-exclamation-triangle text-red-300" style="font-size: 3rem; margin-bottom: 1rem;"></i><p class="text-red-500">Error loading revenue chart: ' + error.message + '</p></div>';
            }
        } else {
            // Show no data message for revenue chart
            document.getElementById('revenueChartContainer').innerHTML = 
                '<div class="text-center py-12"><i class="fas fa-chart-line text-gray-300" style="font-size: 3rem; margin-bottom: 1rem;"></i><p class="text-gray-500">No revenue data available for the last 12 months</p></div>';
        }
    </script>
</body>
</html>
