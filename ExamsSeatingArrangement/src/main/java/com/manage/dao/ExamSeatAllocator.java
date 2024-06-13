package com.manage.dao;

import java.sql.SQLException;
import java.util.List;

import com.manage.model.ExamLocationDetails;
import com.manage.model.UserDetails;

public class ExamSeatAllocator {
	
    public void allocateSeats(UserDetails details, int examId) throws SQLException, ClassNotFoundException  {
    	DbManager manage = new DbManager();

        String cityPreference1 = details.getCityPreference1();
        String cityPreference2 = details.getCityPreference2();
        String cityPreference3 = details.getCityPreference3();
        
        System.out.println("from allocator  :" + cityPreference1 + " " + cityPreference2 + " " + cityPreference3);
        
        List<ExamLocationDetails> examLocations = manage.findExamLocationById(examId);
        
        boolean seatAllocated = allocateSeatByCityPreference(examLocations, cityPreference1, details, examId);
        if (!seatAllocated) {
            seatAllocated = allocateSeatByCityPreference(examLocations, cityPreference2, details, examId);
        }
        if (!seatAllocated) {
            seatAllocated = allocateSeatByCityPreference(examLocations, cityPreference3, details, examId);
        }
        
        // If no seat allocated in preferred cities, allocate in any available city
        if (!seatAllocated) {
            seatAllocated = allocateSeatInAnyAvailableCity(examLocations, details, examId);
        }

        if (seatAllocated) {
            System.out.println("Seat allocated successfully for user: " + details.getName());
        } else {
            System.out.println("Failed to allocate seat for user: " + details.getName());
        }
    }
    
    private boolean allocateSeatByCityPreference(List<ExamLocationDetails> examLocations, String cityPreference, UserDetails details, int examId) throws SQLException, ClassNotFoundException {
    	DbManager manage = new DbManager();

        for (ExamLocationDetails location : examLocations) {
            if (location.getCity().equalsIgnoreCase(cityPreference) && location.getCapacity() > location.getFilledCapacity()) {
            	
                location.setFilledCapacity(location.getFilledCapacity() + 1);
                
                int lastAllocatedSeat = manage.getLastAllocatedSeatId(location.getLocationId());
                System.out.println("lastAllocatedSeat: " + lastAllocatedSeat);
                
                int rowsAffected = manage.updateCapacity(location.getLocationId(), location.getFilledCapacity());
                System.out.println("Rows affected: " + rowsAffected);
                
                System.out.println("capacity after allocating :" + location.getCapacity());     
                
                int affectedExamSeating = manage.addExamSeating(details.getRollNo(), examId, location.getLocationId(),
                		seatNoGenerator(location.getLocationId(), location.getCity(), location.getVenueName(), location.getHallName(), lastAllocatedSeat + 1), lastAllocatedSeat + 1);
                System.out.println(affectedExamSeating);
                System.out.println("Seat allocated at " + location.getVenueName() + ", " + location.getHallName() + " in " + location.getCity());
                return true;
            }
        }
        return false;
    }
    
    private boolean allocateSeatInAnyAvailableCity(List<ExamLocationDetails> examLocations, UserDetails details, int examId) throws SQLException, ClassNotFoundException {
    	DbManager manage = new DbManager();

        for (ExamLocationDetails location : examLocations) {
            if (location.getCapacity() > location.getFilledCapacity()) {
                
                location.setFilledCapacity(location.getFilledCapacity() + 1);
                
                int lastAllocatedSeat = manage.getLastAllocatedSeatId(location.getLocationId());
                System.out.println("lastAllocatedSeat: " + lastAllocatedSeat);
                
                int rowsAffected = manage.updateCapacity(location.getLocationId(), location.getFilledCapacity());
                System.out.println("Rows affected: " + rowsAffected);
                
                System.out.println("capacity after allocating :" + location.getCapacity());
                
                int affectedExamSeating = manage.addExamSeating(details.getRollNo(), examId, location.getLocationId(),
                		seatNoGenerator(location.getLocationId(), location.getCity(), location.getVenueName(), location.getHallName(), lastAllocatedSeat + 1), lastAllocatedSeat + 1);
                System.out.println(affectedExamSeating);
                System.out.println("Seat allocated at " + location.getVenueName() + ", " + location.getHallName() + " in " + location.getCity());
                return true;
            }
        }
        return false;
    }
    
    public static String seatNoGenerator(int locationId, String city, String venue, String hall, int seatingId) {
        char cityFirstChar = city.charAt(0);
        char venueFirstChar = venue.charAt(0);
        char hallFirstChar = hall.charAt(0);

        String allocatedSeat = locationId + "" + cityFirstChar + "" + venueFirstChar + "" + hallFirstChar + String.format("%02d", seatingId);

        return allocatedSeat;
    }
}
