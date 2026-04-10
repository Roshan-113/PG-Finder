<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 
  Button Component
  Usage: Set attributes before including:
    - variant: primary, secondary, outline, ghost (default: primary)
    - size: sm, md, lg (default: md)
    - text: Button text
    - onclick: JavaScript function
    - className: Additional CSS classes
--%>
<c:set var="variant" value="${param.variant != null ? param.variant : 'primary'}" />
<c:set var="size" value="${param.size != null ? param.size : 'md'}" />

<button 
    class="btn btn-${variant} btn-${size} ${param.className}"
    onclick="${param.onclick}"
    ${param.disabled ? 'disabled' : ''}>
    ${param.text}
</button>

<style>
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

.btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
}

.btn-primary {
    background-color: var(--color-primary-600);
    color: white;
    box-shadow: var(--shadow-sm);
}

.btn-primary:hover:not(:disabled) {
    background-color: var(--color-primary-700);
}

.btn-secondary {
    background-color: var(--color-secondary-600);
    color: white;
    box-shadow: var(--shadow-sm);
}

.btn-secondary:hover:not(:disabled) {
    background-color: var(--color-secondary-700);
}

.btn-outline {
    border: 2px solid var(--color-primary-600);
    color: var(--color-primary-600);
    background-color: transparent;
}

.btn-outline:hover:not(:disabled) {
    background-color: var(--color-primary-50);
}

.btn-ghost {
    color: var(--color-gray-700);
    background-color: transparent;
}

.btn-ghost:hover:not(:disabled) {
    background-color: var(--color-gray-100);
}

.btn-sm {
    padding: 0.375rem 0.75rem;
    font-size: 0.875rem;
}

.btn-md {
    padding: 0.5rem 1rem;
    font-size: 1rem;
}

.btn-lg {
    padding: 0.75rem 1.5rem;
    font-size: 1.125rem;
}
</style>
