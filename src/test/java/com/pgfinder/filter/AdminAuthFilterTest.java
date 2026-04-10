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
@DisplayName("AdminAuthFilter Tests")
class AdminAuthFilterTest {
    
    @Mock
    private HttpServletRequest request;
    
    @Mock
    private HttpServletResponse response;
    
    @Mock
    private FilterChain filterChain;
    
    @Mock
    private HttpSession session;
    
    private AdminAuthFilter filter;
    
    @BeforeEach
    void setUp() {
        filter = new AdminAuthFilter();
    }
    
    @Test
    @DisplayName("Should allow access when admin is logged in")
    void testAdminLoggedIn() throws IOException, ServletException {
        // Arrange
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("userRole")).thenReturn("admin");
        
        // Act
        filter.doFilter(request, response, filterChain);
        
        // Assert
        verify(filterChain).doFilter(request, response);
        verify(response, never()).sendRedirect(anyString());
    }
    
    @Test
    @DisplayName("Should redirect when admin is not logged in")
    void testAdminNotLoggedIn() throws IOException, ServletException {
        // Arrange
        when(request.getSession(false)).thenReturn(null);
        when(request.getContextPath()).thenReturn("/pg-finder");
        
        // Act
        filter.doFilter(request, response, filterChain);
        
        // Assert
        verify(response).sendRedirect("/pg-finder/admin-login");
        verify(filterChain, never()).doFilter(request, response);
    }
    
    @Test
    @DisplayName("Should redirect when session exists but no admin role")
    void testSessionExistsButNoAdminRole() throws IOException, ServletException {
        // Arrange
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("userRole")).thenReturn(null);
        when(request.getContextPath()).thenReturn("/pg-finder");
        
        // Act
        filter.doFilter(request, response, filterChain);
        
        // Assert
        verify(response).sendRedirect("/pg-finder/admin-login");
        verify(filterChain, never()).doFilter(request, response);
    }
    
    @Test
    @DisplayName("Should redirect when user role is not admin")
    void testUserRoleIsNotAdmin() throws IOException, ServletException {
        // Arrange
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("userRole")).thenReturn("tenant");
        when(request.getContextPath()).thenReturn("/pg-finder");
        
        // Act
        filter.doFilter(request, response, filterChain);
        
        // Assert
        verify(response).sendRedirect("/pg-finder/admin-login");
        verify(filterChain, never()).doFilter(request, response);
    }
    
    @Test
    @DisplayName("Should redirect when user role is owner")
    void testUserRoleIsOwner() throws IOException, ServletException {
        // Arrange
        when(request.getSession(false)).thenReturn(session);
        when(session.getAttribute("userRole")).thenReturn("owner");
        when(request.getContextPath()).thenReturn("/pg-finder");
        
        // Act
        filter.doFilter(request, response, filterChain);
        
        // Assert
        verify(response).sendRedirect("/pg-finder/admin-login");
        verify(filterChain, never()).doFilter(request, response);
    }
}

