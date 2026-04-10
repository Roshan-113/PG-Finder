<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>Upload PG Photos</h2>

<select id="listingSelect" onchange="loadPhotos()">
    <option value="">Select Property</option>
    <c:forEach var="listing" items="${listings}">
        <option value="${listing.listingId}">${listing.title}</option>
    </c:forEach>
</select>

<br><br>

<div id="uploadSection" style="display:none;">
    <input type="file" id="photoUpload" multiple accept="image/*" onchange="handlePhotoUpload(event)">
    <br><br>

    <!-- IMPORTANT -->
    <button type="button" onclick="uploadPhotos()" id="uploadBtn" style="display:none;">
        Upload Photos
    </button>
</div>

<script>
let selectedFiles = [];
let currentListingId = null;

function loadPhotos() {
    currentListingId = document.getElementById('listingSelect').value;

    if (currentListingId) {
        document.getElementById('uploadSection').style.display = 'block';
    } else {
        document.getElementById('uploadSection').style.display = 'none';
    }
}

function handlePhotoUpload(event) {
    const files = Array.from(event.target.files);

    if (files.length < 1) {
        alert("Select at least 1 photo");
        return;
    }

    if (files.length > 5) {
        alert("Max 5 photos allowed");
        return;
    }

    const maxSize = 20 * 1024 * 1024;

    for (let file of files) {
        if (file.size > maxSize) {
            alert("Each photo must be under 20MB");
            return;
        }
    }

    selectedFiles = files;
    document.getElementById('uploadBtn').style.display = 'inline-block';
}

function uploadPhotos() {

    if (!currentListingId) {
        alert("Select property first");
        return;
    }

    if (selectedFiles.length === 0) {
        alert("Select photos first");
        return;
    }

    const formData = new FormData();
    formData.append("action", "upload");
    formData.append("listingId", currentListingId);

    selectedFiles.forEach(file => {
        formData.append("photos", file); // IMPORTANT NAME
    });

    fetch("${pageContext.request.contextPath}/owner/photos", {
        method: "POST",
        body: formData
    })
    .then(res => res.json())
    .then(data => {
        alert(data.message);
        location.reload();
    })
    .catch(err => {
        console.error(err);
        alert("Upload failed");
    });
}
</script>