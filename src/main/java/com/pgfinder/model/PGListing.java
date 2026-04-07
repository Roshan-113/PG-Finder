package com.pgfinder.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public class PGListing {
    private int listingId;
    private int ownerId;
    private String title;
    private String description;
    private String address;
    private String city;
    private String state;
    private String pincode;
    private Double latitude;
    private Double longitude;
    private String pgType;
    private String genderPreference;
    private int totalRooms;
    private int availableRooms;
    private BigDecimal rentPerMonth;
    private BigDecimal securityDeposit;
    private String amenities;
    private String rules;
    private boolean foodIncluded;
    private boolean wifiAvailable;
    private boolean acAvailable;
    private boolean laundryAvailable;
    private boolean parkingAvailable;
    private boolean isVerified;
    private boolean isActive;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Additional fields for display
    private String ownerName;
    private String ownerPhone;
    private List<String> photos;
    private double averageRating;
    private int reviewCount;
    private boolean isSaved;
    
    // Constructors
    public PGListing() {}
    
    // Getters and Setters
    public int getListingId() { return listingId; }
    public void setListingId(int listingId) { this.listingId = listingId; }
    
    public int getOwnerId() { return ownerId; }
    public void setOwnerId(int ownerId) { this.ownerId = ownerId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
    
    public String getState() { return state; }
    public void setState(String state) { this.state = state; }
    
    public String getPincode() { return pincode; }
    public void setPincode(String pincode) { this.pincode = pincode; }
    
    public Double getLatitude() { return latitude; }
    public void setLatitude(Double latitude) { this.latitude = latitude; }
    
    public Double getLongitude() { return longitude; }
    public void setLongitude(Double longitude) { this.longitude = longitude; }
    
    public String getPgType() { return pgType; }
    public void setPgType(String pgType) { this.pgType = pgType; }
    
    public String getGenderPreference() { return genderPreference; }
    public void setGenderPreference(String genderPreference) { this.genderPreference = genderPreference; }
    
    public int getTotalRooms() { return totalRooms; }
    public void setTotalRooms(int totalRooms) { this.totalRooms = totalRooms; }
    
    public int getAvailableRooms() { return availableRooms; }
    public void setAvailableRooms(int availableRooms) { this.availableRooms = availableRooms; }
    
    public BigDecimal getRentPerMonth() { return rentPerMonth; }
    public void setRentPerMonth(BigDecimal rentPerMonth) { this.rentPerMonth = rentPerMonth; }
    
    public BigDecimal getSecurityDeposit() { return securityDeposit; }
    public void setSecurityDeposit(BigDecimal securityDeposit) { this.securityDeposit = securityDeposit; }
    
    public String getAmenities() { return amenities; }
    public void setAmenities(String amenities) { this.amenities = amenities; }
    
    public String getRules() { return rules; }
    public void setRules(String rules) { this.rules = rules; }
    
    public boolean isFoodIncluded() { return foodIncluded; }
    public void setFoodIncluded(boolean foodIncluded) { this.foodIncluded = foodIncluded; }
    
    public boolean isWifiAvailable() { return wifiAvailable; }
    public void setWifiAvailable(boolean wifiAvailable) { this.wifiAvailable = wifiAvailable; }
    
    public boolean isAcAvailable() { return acAvailable; }
    public void setAcAvailable(boolean acAvailable) { this.acAvailable = acAvailable; }
    
    public boolean isLaundryAvailable() { return laundryAvailable; }
    public void setLaundryAvailable(boolean laundryAvailable) { this.laundryAvailable = laundryAvailable; }
    
    public boolean isParkingAvailable() { return parkingAvailable; }
    public void setParkingAvailable(boolean parkingAvailable) { this.parkingAvailable = parkingAvailable; }
    
    public boolean isVerified() { return isVerified; }
    public void setVerified(boolean isVerified) { this.isVerified = isVerified; }
    
    public boolean isActive() { return isActive; }
    public void setActive(boolean isActive) { this.isActive = isActive; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
    
    public String getOwnerName() { return ownerName; }
    public void setOwnerName(String ownerName) { this.ownerName = ownerName; }
    
    public String getOwnerPhone() { return ownerPhone; }
    public void setOwnerPhone(String ownerPhone) { this.ownerPhone = ownerPhone; }
    
    public List<String> getPhotos() { return photos; }
    public void setPhotos(List<String> photos) { this.photos = photos; }
    
    public double getAverageRating() { return averageRating; }
    public void setAverageRating(double averageRating) { this.averageRating = averageRating; }
    
    public int getReviewCount() { return reviewCount; }
    public void setReviewCount(int reviewCount) { this.reviewCount = reviewCount; }
    
    public boolean isSaved() { return isSaved; }
    public void setSaved(boolean isSaved) { this.isSaved = isSaved; }
}
