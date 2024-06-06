package com.manage.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.manage.encrypt.PasswordEncryption;
import com.manage.model.ExamDetails;
import com.manage.model.UserDetails;

public class DbManager {
	ConnectionUtil connection;
	Connection connect;

	public DbManager() throws ClassNotFoundException, SQLException {
		connection = new ConnectionUtil();
		connect = connection.getConnection();
	}

	public int userRegisteration(String fullName, String email, String password) throws SQLException {
		String addUser = "INSERT INTO user_credentials (full_name, email, password) VALUES (?, ?, ?)";
		PreparedStatement prepareStatement = connect.prepareStatement(addUser);
		prepareStatement.setString(1, fullName);
		prepareStatement.setString(2, email);
		prepareStatement.setString(3, password);

		int rows = prepareStatement.executeUpdate();
		System.out.println("affected row :" + rows);
		return rows;
	}

	public int createExam(String examName, String description, Date examDate, Date applicationStartDate,
			Date applicationEndDate) throws SQLException {
		String addExam = "INSERT INTO exams (exam_name, description, exam_date, application_start_date, application_end_date) VALUES (?, ?, ?, ?, ?)";
		PreparedStatement prepareStatement = connect.prepareStatement(addExam, Statement.RETURN_GENERATED_KEYS);
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

	public int addLocationToExam(String city, String venueName, String hallName, int capacity, String address,
			String locationUrl, int examId) throws SQLException {
		String addLocation = "INSERT INTO exam_locations (city, venue_name, hall_name, capacity, address, location_url, exam_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement prepareStatement = connect.prepareStatement(addLocation);
		prepareStatement.setString(1, city);
		prepareStatement.setString(2, venueName);
		prepareStatement.setString(3, hallName);
		prepareStatement.setInt(4, capacity);
		prepareStatement.setString(5, address);
		prepareStatement.setString(6, locationUrl);
		prepareStatement.setInt(7, examId);

		int affectedRows = prepareStatement.executeUpdate();
		return affectedRows;
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
				Timestamp applicationStartDate = resultSet.getTimestamp("application_start_date");
				Timestamp applicationEndDate = resultSet.getTimestamp("application_end_date");
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
		PreparedStatement prepareStatement = connect.prepareStatement(findUser);
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

	public ExamDetails getExamById(int examId) throws SQLException {
		ExamDetails exam = null; 

		String getExamQuery = "SELECT * FROM exams WHERE exam_id = ?";
		try (PreparedStatement preparedStatement = connect.prepareStatement(getExamQuery)) {
			preparedStatement.setInt(1, examId);
			try (ResultSet resultSet = preparedStatement.executeQuery()) {
				if (resultSet.next()) {
					int id = resultSet.getInt("exam_id");
					String examName = resultSet.getString("exam_name");
					String description = resultSet.getString("description");
					Date examDate = resultSet.getDate("exam_date");
					Timestamp applicationStartDate = resultSet.getTimestamp("application_start_date");
					Timestamp applicationEndDate = resultSet.getTimestamp("application_end_date");
					exam = new ExamDetails(id, examName, description, examDate, applicationStartDate,
							applicationEndDate);
				}
			}
		}
		return exam;
	}

	public int deleteExam(int examId) throws SQLException {
		String deleteExam = "DELETE FROM exams WHERE exam_id = ?";
		PreparedStatement preparedStatement = connect.prepareStatement(deleteExam);
		preparedStatement.setInt(1, examId);
		int row = preparedStatement.executeUpdate();
		
		return row;
	}
}
