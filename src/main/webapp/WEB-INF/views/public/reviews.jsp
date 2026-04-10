<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div style="background: #f9fafb; min-height: 100vh;">
    <!-- Page Header -->
    <div style="background: white; border-bottom: 1px solid #e5e7eb; padding: 2rem 0;">
        <div style="max-width: 80rem; margin: 0 auto; padding: 0 1rem;">
            <h1 style="margin: 0 0 0.5rem 0; font-size: 1.875rem; font-weight: bold; color: #1f2937;">Verified PG Reviews</h1>
            <p style="margin: 0; color: #6b7280; font-size: 0.875rem;">Honest reviews from real tenants to help you make informed decisions</p>
        </div>
    </div>

    <div style="max-width: 80rem; margin: 0 auto; padding: 2rem 1rem;">
        <div style="display: grid; grid-template-columns: 280px 1fr; gap: 2rem;">
            <!-- Sidebar -->
            <div>
                <div style="background: white; border: 1px solid #e5e7eb; border-radius: 0.5rem; padding: 1.5rem; position: sticky; top: 1rem;">
                    <h3 style="margin: 0 0 1.5rem 0; font-size: 1.125rem; font-weight: 600; color: #1f2937;">Overall Rating</h3>
                    
                    <div style="text-align: center; margin-bottom: 1.5rem;">
                        <div style="font-size: 3.5rem; font-weight: bold; color: #1f2937; margin-bottom: 0.5rem;">4.6</div>
                        <div style="display: flex; justify-content: center; gap: 0.25rem; margin-bottom: 0.5rem;">
                            <i class="fas fa-star" style="color: #f59e0b; font-size: 1.125rem;"></i>
                            <i class="fas fa-star" style="color: #f59e0b; font-size: 1.125rem;"></i>
                            <i class="fas fa-star" style="color: #f59e0b; font-size: 1.125rem;"></i>
                            <i class="fas fa-star" style="color: #f59e0b; font-size: 1.125rem;"></i>
                            <i class="fas fa-star-half-alt" style="color: #f59e0b; font-size: 1.125rem;"></i>
                        </div>
                        <p style="margin: 0; font-size: 0.875rem; color: #6b7280;">5 verified reviews</p>
                    </div>

                    <div style="display: flex; flex-direction: column; gap: 0.75rem; margin-bottom: 1.5rem;">
                        <div style="display: flex; align-items: center; gap: 0.5rem; font-size: 0.875rem;">
                            <span style="color: #374151; width: 2rem;">5 ★</span>
                            <div style="flex: 1; height: 0.5rem; background: #e5e7eb; border-radius: 0.25rem; overflow: hidden;">
                                <div style="height: 100%; background: #f59e0b; width: 60%;"></div>
                            </div>
                            <span style="color: #6b7280; width: 1.5rem; text-align: right;">3</span>
                        </div>
                        <div style="display: flex; align-items: center; gap: 0.5rem; font-size: 0.875rem;">
                            <span style="color: #374151; width: 2rem;">4 ★</span>
                            <div style="flex: 1; height: 0.5rem; background: #e5e7eb; border-radius: 0.25rem; overflow: hidden;">
                                <div style="height: 100%; background: #f59e0b; width: 40%;"></div>
                            </div>
                            <span style="color: #6b7280; width: 1.5rem; text-align: right;">2</span>
                        </div>
                        <div style="display: flex; align-items: center; gap: 0.5rem; font-size: 0.875rem;">
                            <span style="color: #374151; width: 2rem;">3 ★</span>
                            <div style="flex: 1; height: 0.5rem; background: #e5e7eb; border-radius: 0.25rem; overflow: hidden;">
                                <div style="height: 100%; background: #f59e0b; width: 0%;"></div>
                            </div>
                            <span style="color: #6b7280; width: 1.5rem; text-align: right;">0</span>
                        </div>
                        <div style="display: flex; align-items: center; gap: 0.5rem; font-size: 0.875rem;">
                            <span style="color: #374151; width: 2rem;">2 ★</span>
                            <div style="flex: 1; height: 0.5rem; background: #e5e7eb; border-radius: 0.25rem; overflow: hidden;">
                                <div style="height: 100%; background: #f59e0b; width: 0%;"></div>
                            </div>
                            <span style="color: #6b7280; width: 1.5rem; text-align: right;">0</span>
                        </div>
                        <div style="display: flex; align-items: center; gap: 0.5rem; font-size: 0.875rem;">
                            <span style="color: #374151; width: 2rem;">1 ★</span>
                            <div style="flex: 1; height: 0.5rem; background: #e5e7eb; border-radius: 0.25rem; overflow: hidden;">
                                <div style="height: 100%; background: #f59e0b; width: 0%;"></div>
                            </div>
                            <span style="color: #6b7280; width: 1.5rem; text-align: right;">0</span>
                        </div>
                    </div>

                    <div style="border-top: 1px solid #e5e7eb; padding-top: 1.5rem;">
                        <h4 style="margin: 0 0 1rem 0; font-size: 0.875rem; font-weight: 600; color: #1f2937;">Filters</h4>
                        <div style="margin-bottom: 1rem;">
                            <label style="display: block; font-size: 0.75rem; font-weight: 500; color: #6b7280; margin-bottom: 0.5rem;">Rating</label>
                            <select style="width: 100%; padding: 0.5rem; border: 1px solid #d1d5db; border-radius: 0.375rem; font-size: 0.875rem; color: #374151; outline: none;">
                                <option>All Ratings</option>
                                <option>5 Stars</option>
                                <option>4 Stars</option>
                                <option>3 Stars</option>
                                <option>2 Stars</option>
                                <option>1 Star</option>
                            </select>
                        </div>
                        <button style="width: 100%; padding: 0.5rem; border: 1px solid #2563eb; background: white; color: #2563eb; border-radius: 0.375rem; font-size: 0.875rem; font-weight: 500; cursor: pointer; transition: all 0.2s;"
                                onmouseover="this.style.background='#eff6ff'" onmouseout="this.style.background='white'">
                            Clear Filters
                        </button>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div>
                <!-- Search and Write Review -->
                <div style="background: white; border: 1px solid #e5e7eb; border-radius: 0.5rem; padding: 1.5rem; margin-bottom: 1.5rem;">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                        <h3 style="margin: 0; font-size: 1.125rem; font-weight: 600; color: #1f2937;">Share Your Experience</h3>
                        <button style="padding: 0.625rem 1.25rem; background: #2563eb; color: white; border: none; border-radius: 0.375rem; font-size: 0.875rem; font-weight: 500; cursor: pointer; transition: background 0.2s;"
                                onmouseover="this.style.background='#1d4ed8'" onmouseout="this.style.background='#2563eb'">
                            Write a Review
                        </button>
                    </div>
                    <p style="margin: 0; font-size: 0.875rem; color: #6b7280;">Help others by writing an honest review of your PG</p>
                </div>

                <!-- Review Cards -->
                <div style="display: flex; flex-direction: column; gap: 1.5rem;">
                    <!-- Review 1 -->
                    <div style="background: white; border: 1px solid #e5e7eb; border-radius: 0.5rem; padding: 1.5rem;">
                        <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 1rem;">
                            <div style="display: flex; gap: 1rem;">
                                <div style="width: 3rem; height: 3rem; border-radius: 50%; background: linear-gradient(135deg, #3b82f6, #2563eb); display: flex; align-items: center; justify-content: center; color: white; font-weight: bold; font-size: 1.125rem; flex-shrink: 0;">
                                    RK
                                </div>
                                <div>
                                    <h4 style="margin: 0 0 0.25rem 0; font-size: 1rem; font-weight: 600; color: #1f2937;">Rahul Kumar</h4>
                                    <p style="margin: 0 0 0.5rem 0; font-size: 0.875rem; color: #6b7280;">Jan 15, 2026</p>
                                    <div style="display: flex; gap: 0.5rem;">
                                        <span style="padding: 0.125rem 0.5rem; background: #dbeafe; color: #1e40af; font-size: 0.75rem; font-weight: 500; border-radius: 0.25rem;">
                                            <i class="fas fa-check-circle" style="font-size: 0.625rem;"></i> Verified Tenant
                                        </span>
                                        <span style="padding: 0.125rem 0.5rem; background: #e0e7ff; color: #3730a3; font-size: 0.75rem; font-weight: 500; border-radius: 0.25rem;">
                                            Sunrise PG for Men
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div style="display: flex; align-items: center; gap: 0.25rem;">
                                <i class="fas fa-star" style="color: #f59e0b; font-size: 1rem;"></i>
                                <span style="font-weight: 600; font-size: 1.125rem; color: #1f2937;">4.5</span>
                            </div>
                        </div>
                        
                        <p style="margin: 0 0 1rem 0; color: #374151; line-height: 1.6; font-size: 0.875rem;">
                            Great place with excellent facilities. The rooms are spacious and well-maintained. Owner is very cooperative and responsive to any issues. The location is convenient with easy access to public transport.
                        </p>
                        
                        <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 1rem; padding: 1rem; background: #f9fafb; border-radius: 0.375rem;">
                            <div>
                                <div style="font-size: 0.75rem; color: #6b7280; margin-bottom: 0.25rem;">Cleanliness</div>
                                <div style="display: flex; align-items: center; gap: 0.25rem;">
                                    <i class="fas fa-star" style="color: #f59e0b; font-size: 0.875rem;"></i>
                                    <span style="font-weight: 600; font-size: 0.875rem; color: #1f2937;">5</span>
                                </div>
                            </div>
                            <div>
                                <div style="font-size: 0.75rem; color: #6b7280; margin-bottom: 0.25rem;">Food</div>
                                <div style="display: flex; align-items: center; gap: 0.25rem;">
                                    <i class="fas fa-star" style="color: #f59e0b; font-size: 0.875rem;"></i>
                                    <span style="font-weight: 600; font-size: 0.875rem; color: #1f2937;">4</span>
                                </div>
                            </div>
                            <div>
                                <div style="font-size: 0.75rem; color: #6b7280; margin-bottom: 0.25rem;">Safety</div>
                                <div style="display: flex; align-items: center; gap: 0.25rem;">
                                    <i class="fas fa-star" style="color: #f59e0b; font-size: 0.875rem;"></i>
                                    <span style="font-weight: 600; font-size: 0.875rem; color: #1f2937;">5</span>
                                </div>
                            </div>
                            <div>
                                <div style="font-size: 0.75rem; color: #6b7280; margin-bottom: 0.25rem;">Value for Money</div>
                                <div style="display: flex; align-items: center; gap: 0.25rem;">
                                    <i class="fas fa-star" style="color: #f59e0b; font-size: 0.875rem;"></i>
                                    <span style="font-weight: 600; font-size: 0.875rem; color: #1f2937;">4</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Review 2 -->
                    <div style="background: white; border: 1px solid #e5e7eb; border-radius: 0.5rem; padding: 1.5rem;">
                        <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 1rem;">
                            <div style="display: flex; gap: 1rem;">
                                <div style="width: 3rem; height: 3rem; border-radius: 50%; background: linear-gradient(135deg, #ec4899, #db2777); display: flex; align-items: center; justify-content: center; color: white; font-weight: bold; font-size: 1.125rem; flex-shrink: 0;">
                                    PS
                                </div>
                                <div>
                                    <h4 style="margin: 0 0 0.25rem 0; font-size: 1rem; font-weight: 600; color: #1f2937;">Priya Singh</h4>
                                    <p style="margin: 0 0 0.5rem 0; font-size: 0.875rem; color: #6b7280;">Jan 20, 2026</p>
                                    <div style="display: flex; gap: 0.5rem;">
                                        <span style="padding: 0.125rem 0.5rem; background: #dbeafe; color: #1e40af; font-size: 0.75rem; font-weight: 500; border-radius: 0.25rem;">
                                            <i class="fas fa-check-circle" style="font-size: 0.625rem;"></i> Verified Tenant
                                        </span>
                                        <span style="padding: 0.125rem 0.5rem; background: #e0e7ff; color: #3730a3; font-size: 0.75rem; font-weight: 500; border-radius: 0.25rem;">
                                            Green Valley Girls Hostel
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div style="display: flex; align-items: center; gap: 0.25rem;">
                                <i class="fas fa-star" style="color: #f59e0b; font-size: 1rem;"></i>
                                <span style="font-weight: 600; font-size: 1.125rem; color: #1f2937;">5</span>
                            </div>
                        </div>
                        
                        <p style="margin: 0 0 1rem 0; color: #374151; line-height: 1.6; font-size: 0.875rem;">
                            Very safe and clean environment. Perfect for working women. The security measures are excellent and the staff is very helpful. Highly recommend!
                        </p>
                        
                        <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 1rem; padding: 1rem; background: #f9fafb; border-radius: 0.375rem;">
                            <div>
                                <div style="font-size: 0.75rem; color: #6b7280; margin-bottom: 0.25rem;">Cleanliness</div>
                                <div style="display: flex; align-items: center; gap: 0.25rem;">
                                    <i class="fas fa-star" style="color: #f59e0b; font-size: 0.875rem;"></i>
                                    <span style="font-weight: 600; font-size: 0.875rem; color: #1f2937;">5</span>
                                </div>
                            </div>
                            <div>
                                <div style="font-size: 0.75rem; color: #6b7280; margin-bottom: 0.25rem;">Food</div>
                                <div style="display: flex; align-items: center; gap: 0.25rem;">
                                    <i class="fas fa-star" style="color: #f59e0b; font-size: 0.875rem;"></i>
                                    <span style="font-weight: 600; font-size: 0.875rem; color: #1f2937;">4</span>
                                </div>
                            </div>
                            <div>
                                <div style="font-size: 0.75rem; color: #6b7280; margin-bottom: 0.25rem;">Safety</div>
                                <div style="display: flex; align-items: center; gap: 0.25rem;">
                                    <i class="fas fa-star" style="color: #f59e0b; font-size: 0.875rem;"></i>
                                    <span style="font-weight: 600; font-size: 0.875rem; color: #1f2937;">5</span>
                                </div>
                            </div>
                            <div>
                                <div style="font-size: 0.75rem; color: #6b7280; margin-bottom: 0.25rem;">Value for Money</div>
                                <div style="display: flex; align-items: center; gap: 0.25rem;">
                                    <i class="fas fa-star" style="color: #f59e0b; font-size: 0.875rem;"></i>
                                    <span style="font-weight: 600; font-size: 0.875rem; color: #1f2937;">5</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Review 3 -->
                    <div style="background: white; border: 1px solid #e5e7eb; border-radius: 0.5rem; padding: 1.5rem;">
                        <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 1rem;">
                            <div style="display: flex; gap: 1rem;">
                                <div style="width: 3rem; height: 3rem; border-radius: 50%; background: linear-gradient(135deg, #10b981, #059669); display: flex; align-items: center; justify-content: center; color: white; font-weight: bold; font-size: 1.125rem; flex-shrink: 0;">
                                    AV
                                </div>
                                <div>
                                    <h4 style="margin: 0 0 0.25rem 0; font-size: 1rem; font-weight: 600; color: #1f2937;">Amit Verma</h4>
                                    <p style="margin: 0 0 0.5rem 0; font-size: 0.875rem; color: #6b7280;">Jan 18, 2026</p>
                                    <div style="display: flex; gap: 0.5rem;">
                                        <span style="padding: 0.125rem 0.5rem; background: #dbeafe; color: #1e40af; font-size: 0.75rem; font-weight: 500; border-radius: 0.25rem;">
                                            <i class="fas fa-check-circle" style="font-size: 0.625rem;"></i> Verified Tenant
                                        </span>
                                        <span style="padding: 0.125rem 0.5rem; background: #e0e7ff; color: #3730a3; font-size: 0.75rem; font-weight: 500; border-radius: 0.25rem;">
                                            Tech Park Residency
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div style="display: flex; align-items: center; gap: 0.25rem;">
                                <i class="fas fa-star" style="color: #f59e0b; font-size: 1rem;"></i>
                                <span style="font-weight: 600; font-size: 1.125rem; color: #1f2937;">4</span>
                            </div>
                        </div>
                        
                        <p style="margin: 0 0 1rem 0; color: #374151; line-height: 1.6; font-size: 0.875rem;">
                            Good PG near IT parks. Rooms are decent and amenities are as promised. WiFi speed could be better but overall a good place to stay.
                        </p>
                        
                        <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 1rem; padding: 1rem; background: #f9fafb; border-radius: 0.375rem;">
                            <div>
                                <div style="font-size: 0.75rem; color: #6b7280; margin-bottom: 0.25rem;">Cleanliness</div>
                                <div style="display: flex; align-items: center; gap: 0.25rem;">
                                    <i class="fas fa-star" style="color: #f59e0b; font-size: 0.875rem;"></i>
                                    <span style="font-weight: 600; font-size: 0.875rem; color: #1f2937;">4</span>
                                </div>
                            </div>
                            <div>
                                <div style="font-size: 0.75rem; color: #6b7280; margin-bottom: 0.25rem;">Food</div>
                                <div style="display: flex; align-items: center; gap: 0.25rem;">
                                    <i class="fas fa-star" style="color: #f59e0b; font-size: 0.875rem;"></i>
                                    <span style="font-weight: 600; font-size: 0.875rem; color: #1f2937;">4</span>
                                </div>
                            </div>
                            <div>
                                <div style="font-size: 0.75rem; color: #6b7280; margin-bottom: 0.25rem;">Safety</div>
                                <div style="display: flex; align-items: center; gap: 0.25rem;">
                                    <i class="fas fa-star" style="color: #f59e0b; font-size: 0.875rem;"></i>
                                    <span style="font-weight: 600; font-size: 0.875rem; color: #1f2937;">4</span>
                                </div>
                            </div>
                            <div>
                                <div style="font-size: 0.75rem; color: #6b7280; margin-bottom: 0.25rem;">Value for Money</div>
                                <div style="display: flex; align-items: center; gap: 0.25rem;">
                                    <i class="fas fa-star" style="color: #f59e0b; font-size: 0.875rem;"></i>
                                    <span style="font-weight: 600; font-size: 0.875rem; color: #1f2937;">4</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
