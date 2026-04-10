package com.pgfinder.model;

import java.sql.Timestamp;

public class Inquiry {
    private int inquiryId;
    private int listingId;
    private int tenantId;
    private int ownerId;
    private String inquiryText;
    private String responseText;
    private String status;
    private Timestamp createdAt;
    private Timestamp respondedAt;
    
    // Additional fields
    private String tenantName;
    private String tenantEmail;
    private String tenantPhone;
    private String listingTitle;
    
    public Inquiry() {}
    
    // Getters and Setters
    public int getInquiryId() { return inquiryId; }
    public void setInquiryId(int inquiryId) { this.inquiryId = inquiryId; }
    
    public int getListingId() { return listingId; }
    public void setListingId(int listingId) { this.listingId = listingId; }
    
    public int getTenantId() { return tenantId; }
    public void setTenantId(int tenantId) { this.tenantId = tenantId; }
    
    public int getOwnerId() { return ownerId; }
    public void setOwnerId(int ownerId) { this.ownerId = ownerId; }
    
    public String getInquiryText() { return inquiryText; }
    public void setInquiryText(String inquiryText) { this.inquiryText = inquiryText; }
    
    public String getResponseText() { return responseText; }
    public void setResponseText(String responseText) { this.responseText = responseText; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public Timestamp getRespondedAt() { return respondedAt; }
    public void setRespondedAt(Timestamp respondedAt) { this.respondedAt = respondedAt; }
    
    public String getTenantName() { return tenantName; }
    public void setTenantName(String tenantName) { this.tenantName = tenantName; }
    
    public String getTenantEmail() { return tenantEmail; }
    public void setTenantEmail(String tenantEmail) { this.tenantEmail = tenantEmail; }
    
    public String getTenantPhone() { return tenantPhone; }
    public void setTenantPhone(String tenantPhone) { this.tenantPhone = tenantPhone; }
    
    public String getListingTitle() { return listingTitle; }
    public void setListingTitle(String listingTitle) { this.listingTitle = listingTitle; }
}
