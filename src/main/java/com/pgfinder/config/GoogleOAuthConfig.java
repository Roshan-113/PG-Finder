package com.pgfinder.config;

/**
 * Google OAuth 2.0 Configuration
 * 
 * SETUP INSTRUCTIONS:
 * 1. Go to Google Cloud Console: https://console.cloud.google.com/
 * 2. Create a new project or select an existing one
 * 3. Enable Google+ API:
 *    - Go to "APIs & Services" > "Library"
 *    - Search for "Google+ API" and enable it
 * 4. Create OAuth 2.0 Credentials:
 *    - Go to "APIs & Services" > "Credentials"
 *    - Click "Create Credentials" > "OAuth client ID"
 *    - Choose "Web application"
 *    - Add authorized redirect URI: http://localhost:8082/pg-finder/auth/google/callback
 *    - Copy the Client ID and Client Secret
 * 5. Replace CLIENT_ID and CLIENT_SECRET below with your actual values
 * 
 * IMPORTANT: For production, update REDIRECT_URI to your production domain
 */
public class GoogleOAuthConfig {
    // TODO: Replace with your actual Google OAuth credentials
    // Get these from: https://console.cloud.google.com/apis/credentials
    public static final String CLIENT_ID = "YOUR_GOOGLE_CLIENT_ID.apps.googleusercontent.com";
    public static final String CLIENT_SECRET = "YOUR_GOOGLE_CLIENT_SECRET";
    public static final String REDIRECT_URI = "http://localhost:8082/pg-finder/auth/google/callback";
    
    // OAuth 2.0 endpoints
    public static final String AUTH_URI = "https://accounts.google.com/o/oauth2/v2/auth";
    public static final String TOKEN_URI = "https://oauth2.googleapis.com/token";
    public static final String USER_INFO_URI = "https://www.googleapis.com/oauth2/v2/userinfo";
    
    // Scopes
    public static final String SCOPE = "openid email profile";
}
