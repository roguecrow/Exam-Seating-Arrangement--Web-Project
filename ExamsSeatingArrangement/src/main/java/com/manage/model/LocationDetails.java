package com.manage.model;

public class LocationDetails {
	private int allocatedSeat;
	private int locationId;
	private String city;
	private String venueName;
	private String hallName;
	private int totalCapacity;
	private String address;
	private String locationUrl;
	private int examId;
	private int filledCapacity;
	private String serialNo;

	public LocationDetails(int allocatedSeat, int locationId, String city, String venueName, String hallName,
			int totalCapacity, String address, String locationUrl, int examId, int filledCapacity, String serialNo) {
		this.allocatedSeat = allocatedSeat;
		this.locationId = locationId;
		this.city = city;
		this.venueName = venueName;
		this.hallName = hallName;
		this.totalCapacity = totalCapacity;
		this.address = address;
		this.locationUrl = locationUrl;
		this.examId = examId;
		this.filledCapacity = filledCapacity;
		this.serialNo = serialNo;
	}

	// Getters and toString() method

	public int getAllocatedSeat() {
		return allocatedSeat;
	}

	public int getLocationId() {
		return locationId;
	}

	public String getCity() {
		return city;
	}

	public String getVenueName() {
		return venueName;
	}

	public String getHallName() {
		return hallName;
	}

	public int getTotalCapacity() {
		return totalCapacity;
	}

	public String getAddress() {
		return address;
	}

	public String getLocationUrl() {
		return locationUrl;
	}

	public int getExamId() {
		return examId;
	}

	public int getFilledCapacity() {
		return filledCapacity;
	}

	@Override
	public String toString() {
		return "LocationDetails{" + "allocatedSeat=" + allocatedSeat + ", locationId=" + locationId + ", city='" + city
				+ '\'' + ", venueName='" + venueName + '\'' + ", hallName='" + hallName + '\'' + ", totalCapacity="
				+ totalCapacity + ", address='" + address + '\'' + ", locationUrl='" + locationUrl + '\'' + ", examId="
				+ examId + ", filledCapacity=" + filledCapacity + '}';
	}

	public String getSerialNo() {
		return serialNo;
	}

	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}
}
