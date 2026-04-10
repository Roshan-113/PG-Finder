package com.pgfinder.model;

import java.sql.Timestamp;

public class Report {
    private int reportId;
    private int reporterId;
    private String reportedType; // listing, user, review, booking
    private int reportedId;
    private String reportReason;
    private String reportDescription;
    private String status; // pending, investigating, resolved, dismissed
    private String adminNotes;
    private Integer resolvedBy;
    private Timestamp createdAt;
    private Timestamp resolvedAt;
    
    // Additional fields for display
    private String reporterName;
    private String reporterEmail;
    private String reportedEntityDetails;
    private String resolvedByName;
    
    // Constructors
    public Report() {}
    
    public Report(int reporterId, String reportedType, int reportedId, String reportReason, String reportDescription) {
        this.reporterId = reporterId;
        this.reportedType = reportedType;
        this.reportedId = reportedId;
        this.reportReason = reportReason;
        this.reportDescription = reportDescription;
    }
    
    // Getters and Setters
    public int getReportId() { return reportId; }
    public void setReportId(int reportId) { this.reportId = reportId; }
    
    public int getReporterId() { return reporterId; }
    public void setReporterId(int reporterId) { this.reporterId = reporterId; }
    
    public String getReportedType() { return reportedType; }
    public void setReportedType(String reportedType) { this.reportedType = reportedType; }
    
    public int getReportedId() { return reportedId; }
    public void setReportedId(int reportedId) { this.reportedId = reportedId; }
    
    public String getReportReason() { return reportReason; }
    public void setReportReason(String reportReason) { this.reportReason = reportReason; }
    
    public String getReportDescription() { return reportDescription; }
    public void setReportDescription(String reportDescription) { this.reportDescription = reportDescription; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getAdminNotes() { return adminNotes; }
    public void setAdminNotes(String adminNotes) { this.adminNotes = adminNotes; }
    
    public Integer getResolvedBy() { return resolvedBy; }
    public void setResolvedBy(Integer resolvedBy) { this.resolvedBy = resolvedBy; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public Timestamp getResolvedAt() { return resolvedAt; }
    public void setResolvedAt(Timestamp resolvedAt) { this.resolvedAt = resolvedAt; }
    
    public String getReporterName() { return reporterName; }
    public void setReporterName(String reporterName) { this.reporterName = reporterName; }
    
    public String getReporterEmail() { return reporterEmail; }
    public void setReporterEmail(String reporterEmail) { this.reporterEmail = reporterEmail; }
    
    public String getReportedEntityDetails() { return reportedEntityDetails; }
    public void setReportedEntityDetails(String reportedEntityDetails) { this.reportedEntityDetails = reportedEntityDetails; }
    
    public String getResolvedByName() { return resolvedByName; }
    public void setResolvedByName(String resolvedByName) { this.resolvedByName = resolvedByName; }
}
