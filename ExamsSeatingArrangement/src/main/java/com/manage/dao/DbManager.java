package com.manage.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.manage.encrypt.PasswordEncryption;
import com.manage.model.ExamDetails;
import com.manage.model.ExamLocationDetails;
import com.manage.model.LocationDetails;
import com.manage.model.UserDetails;
import com.manage.util.ConnectionUtil;

public class DbManager {
	ConnectionUtil connection;
	Connection connect;

	public DbManager() throws ClassNotFoundException, SQLException {
		connection = new ConnectionUtil();
		connect = connection.getConnection();
	}

	public int userRegisteration(String fullName, String email, String password) throws SQLException {
		String addUser = "INSERT INTO user_credentials (full_name, email, password) VALUES (?, ?, ?)";
		try(PreparedStatement prepareStatement = connect.prepareStatement(addUser)) {
			prepareStatement.setString(1, fullName);
			prepareStatement.setString(2, email);
			prepareStatement.setString(3, password);

			int rows = prepareStatement.executeUpdate();
			System.out.println("affected row :" + rows);
			return rows;
		}
	}

	public int createExam(String examName, String description, Date examDate, Date applicationStartDate,
			Date applicationEndDate) throws SQLException {
		String addExam = "INSERT INTO exams (exam_name, description, exam_date, application_start_date, application_end_date) VALUES (?, ?, ?, ?, ?)";
		try(PreparedStatement prepareStatement = connect.prepareStatement(addExam, Statement.RETURN_GENERATED_KEYS)) {
			prepareStatement.setString(1, examName);
			prepareStatement.setString(2, description);
			prepareStatement.setDate(3, new java.sql.Date(examDate.getTime()));
			prepareStatement.setDate(4, new java.sql.Date(applicationStartDate.getTime()));
			prepareStatement.setDate(5, new java.sql.Date(applicationEndDate.getTime()));

			int rows = prepareStatement.executeUpdate();
			System.out.println("affected row :" + rows);
			
			int examId = -1;
			ResultSet generatedKeys = prepareStatement.getGeneratedKeys();
			if (generatedKeys.next()) {
				examId = generatedKeys.getInt(1);
				System.out.println("exam_id :" + examId);
			}
			return examId;
		}
	}

	public int addLocationToExam(String city, String venueName, String hallName, int capacity, String address,
			String locationUrl, int examId) throws SQLException {
		String addLocation = "INSERT INTO exam_locations (city, venue_name, hall_name, total_capacity, address, location_url, exam_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
		try(PreparedStatement prepareStatement = connect.prepareStatement(addLocation)) {
			prepareStatement.setString(1, city);
			prepareStatement.setString(2, venueName);
			prepareStatement.setString(3, hallName);
			prepareStatement.setInt(4, capacity);
			prepareStatement.setString(5, address);
			prepareStatement.setString(6, locationUrl);
			prepareStatement.setInt(7, examId);

			return prepareStatement.executeUpdate();
		}
	}

	public List<ExamDetails> getAllExams() throws SQLException {
		List<ExamDetails> exams = new ArrayList<>();
		String selectAllExams = "SELECT exam_id,exam_name,description,exam_date,application_start_date,application_end_date FROM exams";
		try (PreparedStatement preparedStatement = connect.prepareStatement(selectAllExams);
				ResultSet resultSet = preparedStatement.executeQuery()) {
			while (resultSet.next()) {
				int examId = resultSet.getInt("exam_id");
				String examName = resultSet.getString("exam_name");
				String description = resultSet.getString("description");
				Date examDate = resultSet.getDate("exam_date");
				Date applicationStartDate = resultSet.getDate("application_start_date");
				Date applicationEndDate = resultSet.getDate("application_end_date");
				exams.add(new ExamDetails(examId, examName, description, examDate, applicationStartDate,
						applicationEndDate));
			}
		}
		return exams;
	}

	public boolean findUser(String email, String password, UserDetails details, boolean isSignIn) throws Exception {
		// System.out.println(id);
		// System.out.println(connect);
		PasswordEncryption mask = new PasswordEncryption();
		String findUser = "SELECT roll_no,full_name,email, password,role_id FROM user_credentials WHERE email = ? AND is_active = ?";
		try(PreparedStatement prepareStatement = connect.prepareStatement(findUser)) {
			prepareStatement.setString(1, email);
			prepareStatement.setBoolean(2, true);
			ResultSet resultSet = prepareStatement.executeQuery();
			if (resultSet.next()) {
				int id = resultSet.getInt("roll_no");
				String username = resultSet.getString("full_name");
				String dbemail = resultSet.getString("email");
				String dbpassword = resultSet.getString("password");
				int roleId = resultSet.getInt("role_id");
				System.out.println("email = " + dbemail + "password = " + dbpassword);
				System.out.println("found record-id :" + id);
				details.setUsername(username);
				details.setRollNo(id);
				details.setRoleId(roleId);
				if (mask.decrypt(dbpassword).equals(password) && email.equals(dbemail) && isSignIn) {
					return true;
				} else if (email.equals(dbemail) && !isSignIn) {
					return true;
				} else {
					System.out.println(password + " " + email + " " + isSignIn);
					return false;
				}

			}
			return false;
		}
	}

	public ExamDetails getExamById(int examId) throws SQLException {
		ExamDetails exam = null; 

		String getExamQuery = "SELECT exam_id, exam_name, description, exam_date, application_start_date, application_end_date FROM exams WHERE exam_id = ?";
		try (PreparedStatement preparedStatement = connect.prepareStatement(getExamQuery)) {
			preparedStatement.setInt(1, examId);
			try (ResultSet resultSet = preparedStatement.executeQuery()) {
				if (resultSet.next()) {
					int id = resultSet.getInt("exam_id");
					String examName = resultSet.getString("exam_name");
					String description = resultSet.getString("description");
					Date examDate = resultSet.getDate("exam_date");
					Date applicationStartDate = resultSet.getDate("application_start_date");
					Date applicationEndDate = resultSet.getDate("application_end_date");
					exam = new ExamDetails(id, examName, description, examDate, applicationStartDate,
							applicationEndDate);
				}
			}
		}
		return exam;
	}
	
	public List<String> cityLocationsForExam(int examId) throws SQLException {
	    List<String> cities = new ArrayList<>();

	    String getCitiesQuery = "SELECT DISTINCT city FROM exam_locations WHERE exam_id = ?";

	    try (PreparedStatement citiesStatement = connect.prepareStatement(getCitiesQuery)) {
	        citiesStatement.setInt(1, examId);
	        
	        try (ResultSet citiesResultSet = citiesStatement.executeQuery()) {
	            while (citiesResultSet.next()) {
	                String city = citiesResultSet.getString("city");
	                cities.add(city);
	            }
	            System.out.println("cities - "+cities);
	        }
	    }
	    return cities;
	}


	public int deleteExam(int examId) throws SQLException {
		String deleteExam = "DELETE FROM exams WHERE exam_id = ?";
		try(PreparedStatement preparedStatement = connect.prepareStatement(deleteExam)) {
			preparedStatement.setInt(1, examId);
			int row = preparedStatement.executeUpdate();
			
			return row;
		}
	}
	
	public ArrayList<ExamDetails> findExam(String examName) throws SQLException {
	    ArrayList<ExamDetails> searchedExams = new ArrayList<>();
	    String searchQuery = "SELECT exam_id, exam_name, description, exam_date, application_start_date, application_end_date FROM exams WHERE exam_name LIKE ?";
	    try(PreparedStatement preparedStatement = connect.prepareStatement(searchQuery)) {
		    preparedStatement.setString(1, "%" + examName + "%"); 
		    ResultSet resultSet = preparedStatement.executeQuery();
		    while (resultSet.next()) {
		        int examId = resultSet.getInt("exam_id");
		        String name = resultSet.getString("exam_name");
		        String description = resultSet.getString("description");
		        Date examDate = resultSet.getDate("exam_date");
		        Timestamp applicationStartDate = resultSet.getTimestamp("application_start_date");
		        Timestamp applicationEndDate = resultSet.getTimestamp("application_end_date");
		        ExamDetails exam = new ExamDetails(examId, name, description, examDate, applicationStartDate, applicationEndDate);
		        searchedExams.add(exam);
		    }
		    return searchedExams;
	    }
	}
	
	public boolean updateExamDetails(int examId,Date examDate,Date applicationStart,Date applicationEnd) throws SQLException {
	    String updateExamQuery = "UPDATE exams SET exam_date = ?, application_start_date = ?, application_end_date = ? WHERE exam_id = ?";
	    boolean rowUpdated = false;
	    
	    try (PreparedStatement preparedStatement = connect.prepareStatement(updateExamQuery)) {
	        preparedStatement.setDate(1, new java.sql.Date(examDate.getTime()));
	        preparedStatement.setDate(2, new java.sql.Date(applicationStart.getTime()));
	        preparedStatement.setDate(3, new java.sql.Date(applicationEnd.getTime()));
	        preparedStatement.setInt(4,examId);
	        
	        System.out.println(rowUpdated);
	        rowUpdated = preparedStatement.executeUpdate() > 0;
	    }
	    
	    return rowUpdated;
	}
	
	
	public int addUserDetails(UserDetails details,String appId) throws SQLException {
		String addUserDetailsQuery = "INSERT INTO user_details (roll_no, name, dob, qualification, gender, city_preference_1, city_preference_2, city_preference_3, address, native_city, state, aadhar_number,application_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try(PreparedStatement preparedStatement = connect.prepareStatement(addUserDetailsQuery)) {
			preparedStatement.setInt(1, details.getRollNo());
			preparedStatement.setString(2, details.getName());
			preparedStatement.setDate(3, new java.sql.Date(details.getDob().getTime()));
			preparedStatement.setString(4, details.getQualification());
			preparedStatement.setString(5, String.valueOf(details.getGender()));
			preparedStatement.setString(6, details.getCityPreference1());
			preparedStatement.setString(7, details.getCityPreference2());
			preparedStatement.setString(8, details.getCityPreference3());
			preparedStatement.setString(9, details.getAddress());
			preparedStatement.setString(10, details.getNativeCity());
			preparedStatement.setString(11, details.getState());
			preparedStatement.setString(12, details.getAadharNumber());
			preparedStatement.setString(13, appId);

			int affectedRows = preparedStatement.executeUpdate();
			return affectedRows;
		}

	}
	
	public int addUserDocument(int rollNo, byte[] passportPhoto, byte[] digitalSignature, byte[] qualificationDocuments) throws SQLException {
		String addUserDocumentQuery = "INSERT INTO user_documents (roll_no, passport_size_photo, digital_signature, qualification_documents) VALUES (?, ?, ?, ?)";
		try(PreparedStatement preparedStatement = connect.prepareStatement(addUserDocumentQuery)) {
			preparedStatement.setInt(1, rollNo);
			preparedStatement.setBytes(2, passportPhoto);
			preparedStatement.setBytes(3, digitalSignature);
			preparedStatement.setBytes(4, qualificationDocuments);

			int affectedRows = preparedStatement.executeUpdate();
			return affectedRows;
		}
	}
	
	public List<ExamLocationDetails> findExamLocationById(int examId) throws SQLException {
		List<ExamLocationDetails> examLocationList = new ArrayList<>();
	    String getExamLocations = "SELECT location_id, city, venue_name, hall_name, total_capacity, address, location_url, filled_capacity FROM exam_locations WHERE exam_id = ?";
	    try(PreparedStatement preparedStatement = connect.prepareStatement(getExamLocations)) {
	        preparedStatement.setInt(1, examId);
	        ResultSet resultSet = preparedStatement.executeQuery();
	        while (resultSet.next()) {
	            ExamLocationDetails location = new ExamLocationDetails();
	            location.setLocationId(resultSet.getInt("location_id"));
	            location.setCity(resultSet.getString("city"));
	            location.setVenueName(resultSet.getString("venue_name"));
	            location.setHallName(resultSet.getString("hall_name"));
	            location.setCapacity(resultSet.getInt("total_capacity"));
	            location.setAddress(resultSet.getString("address"));
	            location.setLocationUrl(resultSet.getString("location_url"));
	            location.setFilledCapacity(resultSet.getInt("filled_capacity"));

	            examLocationList.add(location);
	        }
	        return examLocationList;	
	    }
	}
	
    public  int getLastAllocatedSeatId(int locationId)throws SQLException {
        int lastAllocatedSeatId = 0;
        String getSeatId = "SELECT MAX(allocated_seat) AS last_seat FROM exam_seating WHERE location_id = ?";
        try (PreparedStatement preparedStatement = connect.prepareStatement(getSeatId)) {
            preparedStatement.setInt(1, locationId);
            
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    lastAllocatedSeatId = resultSet.getInt("last_seat");
                    System.out.println("lastAllocatedSeatId - " + lastAllocatedSeatId);
                }
            }
        }
        return lastAllocatedSeatId;
    }
    
    public int addExamSeating(int rollNo, int examId, int locationId, String serialNo, int allocatedSeat) throws SQLException {
        String addExamSeatingQuery = "INSERT INTO exam_seating (roll_no, exam_id, location_id, allocated_seat, serial_no) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connect.prepareStatement(addExamSeatingQuery)) {
        	preparedStatement.setInt(1, rollNo);
            preparedStatement.setInt(2, examId);
            preparedStatement.setInt(3, locationId);
            preparedStatement.setInt(4, allocatedSeat);
            preparedStatement.setString(5, serialNo);
            
            return preparedStatement.executeUpdate();
        }
       
    }
    
    public int updateCapacity(int locationId, int newCapacity) throws SQLException {
    	System.out.println("newCapacity =" +newCapacity);
        String updateCapacityQuery = "UPDATE exam_locations SET filled_capacity = ? WHERE location_id = ?";
        try(PreparedStatement preparedStatement = connect.prepareStatement(updateCapacityQuery)) {
        	 preparedStatement.setInt(1, newCapacity);
             preparedStatement.setInt(2, locationId);

             return preparedStatement.executeUpdate();
        }
    }
    
    public List<Integer> getExamIdsForRollNo(int rollNo) throws SQLException {
        List<Integer> examIds = new ArrayList<>();
        String query = "SELECT exam_id FROM exam_seating WHERE roll_no = ?";
        
        try (PreparedStatement preparedStatement = connect.prepareStatement(query)) {
        	 preparedStatement.setInt(1, rollNo);
        	 
             ResultSet resultSet = preparedStatement.executeQuery();
             while (resultSet.next()) {
                 int examId = resultSet.getInt("exam_id");
                 examIds.add(examId);
                 System.out.println("examId - " + examId);
             } 
             return examIds;
        }
    }

    public LocationDetails getExamLocationDetails(int rollNo , int examId) throws SQLException {
    	 String query = "SELECT es.allocated_seat,es.serial_no, el.* " +
                 "FROM exam_seating es " +
                 "JOIN exam_locations el ON es.location_id = el.location_id " +
                 "WHERE es.roll_no = ? AND es.exam_id = ?";
        
        try(PreparedStatement preparedStatement = connect.prepareStatement(query)) {
            preparedStatement.setInt(1, rollNo);
            preparedStatement.setInt(2, examId);
            
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                int allocatedSeat = resultSet.getInt("allocated_seat");
                int locationId = resultSet.getInt("location_id");
                String city = resultSet.getString("city");
                String venueName = resultSet.getString("venue_name");
                String hallName = resultSet.getString("hall_name");
                int totalCapacity = resultSet.getInt("total_capacity");
                String address = resultSet.getString("address");
                String locationUrl = resultSet.getString("location_url");
                int filledCapacity = resultSet.getInt("filled_capacity");
                String serialNo = resultSet.getString("serial_no");
                System.out.println("serialNo :" +serialNo);

                return new LocationDetails(allocatedSeat, locationId, city, venueName, hallName, totalCapacity, address, locationUrl, examId, filledCapacity, serialNo);
            } else {
                return null; // or throw an exception if preferred
            }
        }
    }
    
    public boolean getExamDocById(UserDetails details) throws SQLException {
        String getExamQuery = "SELECT doc_id, passport_size_photo, digital_signature,qualification_documents FROM user_documents WHERE roll_no = ?";
        try (PreparedStatement preparedStatement = connect.prepareStatement(getExamQuery)) {
            preparedStatement.setInt(1, details.getRollNo());
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    int docId = resultSet.getInt("doc_id");
                    try (InputStream passportPhoto = resultSet.getBlob("passport_size_photo").getBinaryStream();
                         InputStream digitalSignature = resultSet.getBlob("digital_signature").getBinaryStream();
                         InputStream qualificationDocuments = resultSet.getBlob("qualification_documents").getBinaryStream()) {

                        details.setDigitalSignature(passportPhoto.readAllBytes());
                        details.setPassportSizePhoto(digitalSignature.readAllBytes());
                        details.setQualificationDocuments(qualificationDocuments.readAllBytes());
                    } catch (IOException e) {
                        throw new SQLException("Error reading BLOB data", e);
                    }
                    return true; 
                }
            }
        }
        return false; 
    }
    
    public boolean updateExamDoc(UserDetails details) throws SQLException {
        String updateQuery = "UPDATE user_documents SET passport_size_photo = ?, digital_signature = ?, qualification_documents = ? WHERE roll_no = ?";
        
        try (PreparedStatement preparedStatement = connect.prepareStatement(updateQuery)) {
            preparedStatement.setBytes(1, details.getPassportSizePhoto());
            preparedStatement.setBytes(2, details.getDigitalSignature());
            preparedStatement.setBytes(3, details.getQualificationDocuments());
            preparedStatement.setInt(4, details.getRollNo());

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            throw new SQLException("Error updating user documents", e);
        }
    }
    
    public String getExamDetails(String serialNo) throws SQLException {
        String query = "SELECT " +
                "exams.exam_id, " +
                "exams.exam_name, " +
                "exams.exam_date, " +
                "user_details.roll_no," +
                "user_details.application_id, " +
                "user_details.name, " +
                "user_details.dob, " +
                "user_details.address, " +
                "user_documents.digital_signature, " +
                "user_documents.passport_size_photo, " +
                "user_documents.qualification_documents, " +
                "exam_locations.location_id, " +
                "exam_locations.city, " +
                "exam_locations.venue_name, " +
                "exam_locations.hall_name, " +
                "exam_locations.address AS location_address, " +
                "exam_locations.location_url " +
                "FROM exam_seating " +
                "JOIN exams ON exam_seating.exam_id = exams.exam_id " +
                "JOIN user_details ON CONCAT(exam_seating.exam_id, exam_seating.roll_no) = user_details.application_id " +
                "JOIN exam_locations ON exam_seating.location_id = exam_locations.location_id " +
                "JOIN user_documents ON exam_seating.roll_no = user_documents.roll_no " +
                "WHERE exam_seating.serial_no = ?";

        try (PreparedStatement preparedStatement = connect.prepareStatement(query)) {
            preparedStatement.setString(1, serialNo);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    JsonObject examDetails = new JsonObject();
                    examDetails.addProperty("exam_id", resultSet.getInt("exam_id"));
                    examDetails.addProperty("exam_name", resultSet.getString("exam_name"));
                    examDetails.addProperty("exam_date", resultSet.getDate("exam_date").toString());
                    examDetails.addProperty("roll_no", resultSet.getString("roll_no"));
                    examDetails.addProperty("application_id", resultSet.getString("application_id"));
                    examDetails.addProperty("name", resultSet.getString("name"));
                    examDetails.addProperty("dob", resultSet.getDate("dob").toString());
                    examDetails.addProperty("address", resultSet.getString("address"));
                    
                    examDetails.addProperty("digital_signature", encodeToBase64(resultSet.getBytes("digital_signature")));
                    examDetails.addProperty("passport_size_photo", encodeToBase64(resultSet.getBytes("passport_size_photo")));
                    examDetails.addProperty("qualification_documents", encodeToBase64(resultSet.getBytes("qualification_documents")));

                    examDetails.addProperty("location_id", resultSet.getInt("location_id"));
                    examDetails.addProperty("city", resultSet.getString("city"));
                    examDetails.addProperty("venue_name", resultSet.getString("venue_name"));
                    examDetails.addProperty("hall_name", resultSet.getString("hall_name"));
                    examDetails.addProperty("location_address", resultSet.getString("location_address"));
                    examDetails.addProperty("location_url", resultSet.getString("location_url"));

                    Gson gson = new Gson();
                    return gson.toJson(examDetails);
                } else {
                    return null;
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Error retrieving exam details", e);
        }
    }

    private String encodeToBase64(byte[] data) {
        return java.util.Base64.getEncoder().encodeToString(data);
    }
}




