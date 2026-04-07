package com.pgfinder.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class Earning {
    private int earningId;
    private int ownerId;
    private int bookingId;
    private BigDecimal amount;
    private String transactionType;
    private Date transactionDate;
    private String paymentMethod;
    private String status;
    private Timestamp createdAt;
    
    // Additional fields
    private String tenantName;
    private String listingTitle;
    
    public Earning() {}
    
    // Getters and Setters
    public int getEarningId() { return earningId; }
    public void setEarningId(int earningId) { this.earningId = earningId; }
    
    public int getOwnerId() { return ownerId; }
    public void setOwnerId(int ownerId) { this.ownerId = ownerId; }
    
    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }
    
    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }
    
    public String getTransactionType() { return transactionType; }
    public void setTransactionType(String transactionType) { this.transactionType = transactionType; }
    
    public Date getTransactionDate() { return transactionDate; }
    public void setTransactionDate(Date transactionDate) { this.transactionDate = transactionDate; }
    
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public String getTenantName() { return tenantName; }
    public void setTenantName(String tenantName) { this.tenantName = tenantName; }
    
    public String getListingTitle() { return listingTitle; }
    public void setListingTitle(String listingTitle) { this.listingTitle = listingTitle; }
}
