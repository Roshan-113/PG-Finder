package com.pgfinder.filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.io.IOException;

import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("TenantAuthFilter Tests")
class TenantAuthFilterTest {
    
    @Mock
    private HttpServletRequest request;
    
    @Mock
    private HttpServletResponse response;
    
    @Mock
    private FilterChain filterChain;
    
    @Mock
    private HttpSession session;
    
    private TenantAuthFilter filter;
    
    @BeforeEach
    void setUp() {
        filter = new TenantAuthFilter();
    }
    
    @Test
    @DisplayName("Should allow access when tenant is logged in")
    void testTenantLoggedIn() throws IOException, ServletException {
        // Arrange
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("userEmail")).thenReturn("tenant@test.com");
        when(session.getAttribute("userRole")).thenReturn("tenant");
        
        // Act
        filter.doFilter(request, response, filterChain);
        
        // Assert
        verify(filterChain).doFilter(request, response);
        verify(response, never()).sendRedirect(anyString());
    }
    
    @Test
    @DisplayName("Should redirect when tenant is not logged in")
    void testTenantNotLoggedIn() throws IOException, ServletException {
        // Arrange
        when(request.getSession(false)).thenReturn(null);
        when(request.getSession(true)).thenReturn(session);
        when(request.getRequestURI()).thenReturn("/pg-finder/tenant/bookings");
        when(request.getQueryString()).thenReturn(null);
        when(request.getContextPath()).thenReturn("/pg-finder");
        
        // Act
        filter.doFilter(request, response, filterChain);
        
        // Assert
        verify(session).setAttribute("redirectAfterLogin", "/pg-finder/tenant/bookings");
        verify(response).sendRedirect("/pg-finder/login");
        verify(filterChain, never()).doFilter(request, response);
    }
    
    @Test
    @DisplayName("Should redirect when session exists but no email")
    void testSessionExistsButNoEmail() throws IOException, ServletException {
        // Arrange
        when(request.getSession(false)).thenReturn(session);
        when(request.getSession(true)).thenReturn(session);
        when(session.getAttribute("userEmail")).thenReturn(null);
        when(session.getAttribute("userRole")).thenReturn("tenant");
        when(request.getRequestURI()).thenReturn("/pg-finder/tenant/bookings");
        when(request.getQueryString()).thenReturn(null);
        when(request.getContextPath()).thenReturn("/pg-finder");
        
        // Act
        filter.doFilter(request, response, filterChain);
        
        // Assert
        verify(response).sendRedirect("/pg-finder/login");
        verify(filterChain, never()).doFilter(request, response);
    }
    
    @Test
    @DisplayName("Should redirect when user role is not tenant")
    void testUserRoleIsNotTenant() throws IOException, ServletException {
        // Arrange
        when(request.getSession(false)).thenReturn(session);
        when(request.getSession(true)).thenReturn(session);
        when(session.getAttribute("userEmail")).thenReturn("owner@test.com");
        when(session.getAttribute("userRole")).thenReturn("owner");
        when(request.getRequestURI()).thenReturn("/pg-finder/tenant/bookings");
        when(request.getQueryString()).thenReturn(null);
        when(request.getContextPath()).thenReturn("/pg-finder");
        
        // Act
        filter.doFilter(request, response, filterChain);
        
        // Assert
        verify(response).sendRedirect("/pg-finder/login");
        verify(filterChain, never()).doFilter(request, response);
    }
    
    @Test
    @DisplayName("Should store redirect URL with query string")
    void testStoreRedirectUrlWithQueryString() throws IOException, ServletException {
        // Arrange
        when(request.getSession(false)).thenReturn(null);
        when(request.getSession(true)).thenReturn(session);
        when(request.getRequestURI()).thenReturn("/pg-finder/tenant/bookings");
        when(request.getQueryString()).thenReturn("id=123");
        when(request.getContextPath()).thenReturn("/pg-finder");
        
        // Act
        filter.doFilter(request, response, filterChain);
        
        // Assert
        verify(session).setAttribute("redirectAfterLogin", "/pg-finder/tenant/bookings?id=123");
        verify(response).sendRedirect("/pg-finder/login");
        verify(filterChain, never()).doFilter(request, response);
    }
}
