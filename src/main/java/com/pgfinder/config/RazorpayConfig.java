package com.pgfinder.config;

import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;

public class RazorpayConfig {
    // Replace with your actual Razorpay credentials
    private static final String KEY_ID = "rzp_test_SVIqxh9e1lGkPp";
    private static final String KEY_SECRET = "d79dG0NPUuTIdOGxoS4f32VS";
    
    private static RazorpayClient razorpayClient;
    
    public static RazorpayClient getClient() throws RazorpayException {
        if (razorpayClient == null) {
            synchronized (RazorpayConfig.class) {
                if (razorpayClient == null) {
                    razorpayClient = new RazorpayClient(KEY_ID, KEY_SECRET);
                }
            }
        }
        return razorpayClient;
    }
    
    public static String getKeyId() {
        return KEY_ID;
    }
    
    public static String getKeySecret() {
        return KEY_SECRET;
    }
}
