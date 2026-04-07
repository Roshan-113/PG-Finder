package com.pgfinder.model;

import java.sql.Timestamp;

public class ActivityLog {
    private int logId;
    private Integer userId;
    private String actionType;
    private String actionDescription;
    private String entityType;
    private Integer entityId;
    private String ipAddress;
    private String userAgent;
    private Timestamp createdAt;
    
    // Additional field for display
    private String userName;
    private String userEmail;
    
    // Constructors
    public ActivityLog() {}
    
    public ActivityLog(Integer userId, String actionType, String actionDescription) {
        this.userId = userId;
        this.actionType = actionType;
        this.actionDescription = actionDescription;
    }
    
    // Getters and Setters
    public int getLogId() { return logId; }
    public void setLogId(int logId) { this.logId = logId; }
    
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    
    public String getActionType() { return actionType; }
    public void setActionType(String actionType) { this.actionType = actionType; }
    
    public String getActionDescription() { return actionDescription; }
    public void setActionDescription(String actionDescription) { this.actionDescription = actionDescription; }
    
    public String getEntityType() { return entityType; }
    public void setEntityType(String entityType) { this.entityType = entityType; }
    
    public Integer getEntityId() { return entityId; }
    public void setEntityId(Integer entityId) { this.entityId = entityId; }
    
    public String getIpAddress() { return ipAddress; }
    public void setIpAddress(String ipAddress) { this.ipAddress = ipAddress; }
    
    public String getUserAgent() { return userAgent; }
    public void setUserAgent(String userAgent) { this.userAgent = userAgent; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    
    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }
}
