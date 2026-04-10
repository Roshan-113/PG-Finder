<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 
  PG Card Component
  Expected attributes: pg (object with name, location, image, rating, reviews, rent)
--%>

<div class="card card-hover" onclick="window.location.href='${pageContext.request.contextPath}/pg-details?id=${pg.id}'">
    <img src="${pg.image}" alt="${pg.name}" 
         style="width: 100%; height: 200px; object-fit: cover; border-radius: 0.75rem 0.75rem 0 0;" />
    <div style="padding: 1rem;">
        <h3 style="margin-bottom: 0.5rem; font-size: 1.125rem; font-weight: 600;">${pg.name}</h3>
        <div style="display: flex; align-items: center; gap: 0.5rem; margin-bottom: 0.5rem; color: var(--color-gray-600);">
            <i class="fas fa-map-marker-alt" style="font-size: 16px;"></i>
            <span style="font-size: 0.875rem;">${pg.location}</span>
        </div>
        <div style="display: flex; align-items: center; gap: 0.5rem; margin-bottom: 1rem;">
            <i class="fas fa-star" style="color: var(--color-amber-500); font-size: 16px;"></i>
            <span style="font-weight: 500;">${pg.rating}</span>
            <span style="color: var(--color-gray-600); font-size: 0.875rem;">(${pg.reviews} reviews)</span>
        </div>
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <div>
                <div style="font-size: 1.5rem; font-weight: 700; color: var(--color-gray-900);">₹${pg.rent}</div>
                <div style="font-size: 0.875rem; color: var(--color-gray-600);">per month</div>
            </div>
            <button class="btn btn-primary btn-sm" onclick="event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/pg-details?id=${pg.id}'">
                View Details
            </button>
        </div>
    </div>
</div>

<style>
.card {
    background-color: white;
    border-radius: var(--radius-xl);
    box-shadow: var(--shadow-sm);
    border: 1px solid var(--color-gray-100);
}

.card-hover {
    cursor: pointer;
    transition: box-shadow 0.2s;
}

.card-hover:hover {
    box-shadow: var(--shadow-md);
}

.btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    border-radius: 0.5rem;
    font-weight: 500;
    transition: all 0.2s;
    border: none;
    cursor: pointer;
}

.btn-primary {
    background-color: var(--color-primary-600);
    color: white;
    box-shadow: var(--shadow-sm);
}

.btn-primary:hover {
    background-color: var(--color-primary-700);
}

.btn-sm {
    padding: 0.375rem 0.75rem;
    font-size: 0.875rem;
}
</style>
