package com.manage.model;

public class ExamLocationDetails {

    private int locationId;
    private String city;
    private String venueName;
    private String hallName;
    private int capacity;
    private String address;
    private String locationUrl;
    private int examId;
    private int filledCapacity;

    public ExamLocationDetails() {
    }

    public ExamLocationDetails(int locationId, String city, String venueName, String hallName, int capacity, String address, String locationUrl,int filledCapacity) {
        this.locationId = locationId;
        this.city = city;
        this.venueName = venueName;
        this.hallName = hallName;
        this.capacity = capacity;
        this.address = address;
        this.locationUrl = locationUrl;
        this.filledCapacity = filledCapacity;
    }

    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getVenueName() {
        return venueName;
    }

    public void setVenueName(String venueName) {
        this.venueName = venueName;
    }

    public String getHallName() {
        return hallName;
    }

    public void setHallName(String hallName) {
        this.hallName = hallName;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getLocationUrl() {
        return locationUrl;
    }

    public void setLocationUrl(String locationUrl) {
        this.locationUrl = locationUrl;
    }
    
	public int getExamId() {
		return examId;
	}

	public void setExamId(int examId) {
		this.examId = examId;
	}

    @Override
    public String toString() {
        return "ExamLocationDetails{" +
                "locationId=" + locationId +
                ", city='" + city + '\'' +
                ", venueName='" + venueName + '\'' +
                ", hallName='" + hallName + '\'' +
                ", capacity=" + capacity +
                ", address='" + address + '\'' +
                ", locationUrl='" + locationUrl + '\'' +
                '}';
    }

	public int getFilledCapacity() {
		return filledCapacity;
	}

	public void setFilledCapacity(int filledCapacity) {
		this.filledCapacity = filledCapacity;
	}

}
