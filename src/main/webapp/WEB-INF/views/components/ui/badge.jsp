<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 
  Badge Component
  Usage: Set attributes before including:
    - variant: primary, secondary, success, warning, danger (default: primary)
    - text: Badge text
--%>
<c:set var="variant" value="${param.variant != null ? param.variant : 'primary'}" />

<span class="badge badge-${variant}">
    ${param.text}
</span>

<style>
.badge {
    display: inline-flex;
    align-items: center;
    padding: 0.25rem 0.75rem;
    border-radius: 9999px;
    font-size: 0.75rem;
    font-weight: 500;
}

.badge-primary {
    background-color: var(--color-primary-100);
    color: var(--color-primary-700);
}

.badge-secondary {
    background-color: var(--color-secondary-100);
    color: var(--color-secondary-700);
}

.badge-success {
    background-color: #dcfce7;
    color: var(--color-green-600);
}

.badge-warning {
    background-color: var(--color-amber-100);
    color: var(--color-amber-700);
}

.badge-danger {
    background-color: #fee2e2;
    color: var(--color-red-600);
}
</style>
