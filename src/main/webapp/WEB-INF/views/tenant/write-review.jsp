<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div style="max-width: 800px; margin: 0 auto; padding: 2rem 1.5rem;">
    <h1 style="margin: 0 0 0.5rem 0; font-size: 2rem; font-weight: bold; color: #111827;">Write a Review</h1>
    <p style="margin: 0 0 2rem 0; color: #6b7280;">Share your experience to help others make better decisions</p>

    <div style="background: white; border-radius: 1rem; padding: 2rem; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
        <form method="post" action="${pageContext.request.contextPath}/write-review" id="reviewForm">
            <input type="hidden" name="pgId" value="${pgId}">
            <input type="hidden" name="bookingId" value="${bookingId}">
            
            <!-- Rating -->
            <div style="margin-bottom: 2rem;">
                <label style="display: block; font-size: 1rem; font-weight: 600; color: #111827; margin-bottom: 1rem;">
                    Overall Rating *
                </label>
                <div style="display: flex; gap: 0.5rem; font-size: 2rem;">
                    <i class="far fa-star rating-star" data-rating="1" style="color: #d1d5db; cursor: pointer; transition: color 0.2s;"></i>
                    <i class="far fa-star rating-star" data-rating="2" style="color: #d1d5db; cursor: pointer; transition: color 0.2s;"></i>
                    <i class="far fa-star rating-star" data-rating="3" style="color: #d1d5db; cursor: pointer; transition: color 0.2s;"></i>
                    <i class="far fa-star rating-star" data-rating="4" style="color: #d1d5db; cursor: pointer; transition: color 0.2s;"></i>
                    <i class="far fa-star rating-star" data-rating="5" style="color: #d1d5db; cursor: pointer; transition: color 0.2s;"></i>
                </div>
                <input type="hidden" name="rating" id="ratingValue">
                <div id="ratingError" style="color: #ef4444; font-size: 0.875rem; margin-top: 0.5rem; display: none;">Please select a rating</div>
            </div>

            <!-- Review Text -->
            <div style="margin-bottom: 2rem;">
                <label style="display: block; font-size: 1rem; font-weight: 600; color: #111827; margin-bottom: 0.5rem;">
                    Your Review *
                </label>
                <textarea name="reviewText" id="reviewText" rows="6"
                          placeholder="Share your experience about the PG, facilities, cleanliness, food quality, owner behavior, etc."
                          style="width: 100%; padding: 0.75rem; border: 1px solid #d1d5db; border-radius: 0.5rem; font-size: 0.9375rem; resize: vertical;"></textarea>
                <div style="color: #6b7280; font-size: 0.875rem; margin-top: 0.5rem;">Minimum 20 characters</div>
            </div>

            <!-- Submit Buttons -->
            <div style="display: flex; gap: 1rem;">
                <button type="submit" style="flex: 1; padding: 0.875rem; background: #2563eb; color: white; font-weight: 600; border: none; border-radius: 0.5rem; cursor: pointer; font-size: 1rem; transition: background 0.2s;"
                        onmouseover="this.style.background='#1d4ed8'" onmouseout="this.style.background='#2563eb'">
                    <i class="fas fa-paper-plane"></i> Submit Review
                </button>
                <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/tenant/bookings'" 
                        style="flex: 1; padding: 0.875rem; background: white; color: #374151; font-weight: 600; border: 1px solid #d1d5db; border-radius: 0.5rem; cursor: pointer; font-size: 1rem; transition: all 0.2s;"
                        onmouseover="this.style.background='#f9fafb'" onmouseout="this.style.background='white'">
                    Cancel
                </button>
            </div>
        </form>
    </div>
</div>

<script>
// Rating stars functionality
const stars = document.querySelectorAll('.rating-star');
const ratingValue = document.getElementById('ratingValue');
let selectedRating = 0;

stars.forEach(star => {
    star.addEventListener('click', function() {
        selectedRating = parseInt(this.getAttribute('data-rating'));
        ratingValue.value = selectedRating;
        updateStars(selectedRating);
        document.getElementById('ratingError').style.display = 'none';
    });
    
    star.addEventListener('mouseenter', function() {
        const rating = parseInt(this.getAttribute('data-rating'));
        updateStars(rating);
    });
});

document.querySelector('.rating-star').parentElement.addEventListener('mouseleave', function() {
    updateStars(selectedRating);
});

function updateStars(rating) {
    stars.forEach((star, index) => {
        if (index < rating) {
            star.classList.remove('far');
            star.classList.add('fas');
            star.style.color = '#f59e0b';
        } else {
            star.classList.remove('fas');
            star.classList.add('far');
            star.style.color = '#d1d5db';
        }
    });
}

// Form validation
document.getElementById('reviewForm').addEventListener('submit', function(e) {
    let isValid = true;
    
    // Check rating
    if (!ratingValue.value) {
        document.getElementById('ratingError').style.display = 'block';
        isValid = false;
    }
    
    // Check review text
    const reviewText = document.getElementById('reviewText').value.trim();
    if (reviewText.length < 20) {
        alert('Please write at least 20 characters in your review');
        isValid = false;
    }
    
    if (!isValid) {
        e.preventDefault();
    }
});
</script>
