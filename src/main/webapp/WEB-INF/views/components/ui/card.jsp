<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 
  Card Component
  Usage: Wrap content with this component
    - hover: true/false (default: false)
    - className: Additional CSS classes
--%>
<c:set var="hover" value="${param.hover != null ? param.hover : 'false'}" />

<div class="card ${hover == 'true' ? 'card-hover' : ''} ${param.className}">
    <jsp:doBody/>
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
</style>
