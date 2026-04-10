package com.pgfinder.model;

import java.sql.Timestamp;

public class SystemSettings {
    private int settingId;
    private String settingKey;
    private String settingValue;
    private String settingType; // text, number, boolean, json
    private String description;
    private Integer updatedBy;
    private Timestamp updatedAt;
    
    // Additional field for display
    private String updatedByName;
    
    // Constructors
    public SystemSettings() {}
    
    public SystemSettings(String settingKey, String settingValue, String settingType, String description) {
        this.settingKey = settingKey;
        this.settingValue = settingValue;
        this.settingType = settingType;
        this.description = description;
    }
    
    // Getters and Setters
    public int getSettingId() { return settingId; }
    public void setSettingId(int settingId) { this.settingId = settingId; }
    
    public String getSettingKey() { return settingKey; }
    public void setSettingKey(String settingKey) { this.settingKey = settingKey; }
    
    public String getSettingValue() { return settingValue; }
    public void setSettingValue(String settingValue) { this.settingValue = settingValue; }
    
    public String getSettingType() { return settingType; }
    public void setSettingType(String settingType) { this.settingType = settingType; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public Integer getUpdatedBy() { return updatedBy; }
    public void setUpdatedBy(Integer updatedBy) { this.updatedBy = updatedBy; }
    
    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
    
    public String getUpdatedByName() { return updatedByName; }
    public void setUpdatedByName(String updatedByName) { this.updatedByName = updatedByName; }
}
