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
@DisplayName("OwnerAuthFilter Tests")
class OwnerAuthFilterTest {
    
    @Mock
    private HttpServletRequest request;
    
    @Mock
    private HttpServletResponse response;
    
    @Mock
    private FilterChain filterChain;
    
    @Mock
    private HttpSession session;
    
    private OwnerAuthFilter filter;
    
    @BeforeEach
    void setUp() {
        filter = new OwnerAuthFilter();
    }
    
    @Test
    @DisplayName("Should allow access when owner is logged in")
    void testOwnerLoggedIn() throws IOException, ServletException {
        // Arrange
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("userRole")).thenReturn("owner");
        when(session.getAttribute("userId")).thenReturn(1);
        when(request.getRequestURI()).thenReturn("/pg-finder/owner/dashboard");
        
        // Act
        filter.doFilter(request, response, filterChain);
        
        // Assert
        verify(filterChain).doFilter(request, response);
        verify(response, never()).sendRedirect(anyString());
    }
    
    @Test
    @DisplayName("Should redirect when owner is not logged in")
    void testOwnerNotLoggedIn() throws IOException, ServletException {
        // Arrange
        when(request.getSession(false)).thenReturn(null);
        when(request.getRequestURI()).thenReturn("/pg-finder/owner/dashboard");
        when(request.getContextPath()).thenReturn("/pg-finder");
        
        // Act
        filter.doFilter(request, response, filterChain);
        
        // Assert
        verify(response).sendRedirect("/pg-finder/login");
        verify(filterChain, never()).doFilter(request, response);
    }
    
    @Test
    @DisplayName("Should redirect when session exists but no owner role")
    void testSessionExistsButNoOwnerRole() throws IOException, ServletException {
        // Arrange
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("userRole")).thenReturn(null);
        when(session.getAttribute("userId")).thenReturn(1);
        when(request.getRequestURI()).thenReturn("/pg-finder/owner/dashboard");
        when(request.getContextPath()).thenReturn("/pg-finder");
        
        // Act
        filter.doFilter(request, response, filterChain);
        
        // Assert
        verify(response).sendRedirect("/pg-finder/login");
        verify(filterChain, never()).doFilter(request, response);
    }
    
    @Test
    @DisplayName("Should redirect when user role is tenant")
    void testUserRoleIsTenant() throws IOException, ServletException {
        // Arrange
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("userRole")).thenReturn("tenant");
        when(session.getAttribute("userId")).thenReturn(1);
        when(request.getRequestURI()).thenReturn("/pg-finder/owner/dashboard");
        when(request.getContextPath()).thenReturn("/pg-finder");
        
        // Act
        filter.doFilter(request, response, filterChain);
        
        // Assert
        verify(response).sendRedirect("/pg-finder/login");
        verify(filterChain, never()).doFilter(request, response);
    }
    
    @Test
    @DisplayName("Should redirect when user role is admin")
    void testUserRoleIsAdmin() throws IOException, ServletException {
        // Arrange
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("userRole")).thenReturn("admin");
        when(session.getAttribute("userId")).thenReturn(1);
        when(request.getRequestURI()).thenReturn("/pg-finder/owner/dashboard");
        when(request.getContextPath()).thenReturn("/pg-finder");
        
        // Act
        filter.doFilter(request, response, filterChain);
        
        // Assert
        verify(response).sendRedirect("/pg-finder/login");
        verify(filterChain, never()).doFilter(request, response);
    }
}
