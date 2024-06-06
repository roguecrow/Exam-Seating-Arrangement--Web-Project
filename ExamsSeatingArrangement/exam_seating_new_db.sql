CREATE DATABASE exam_management;

USE exam_management;

CREATE TABLE user_credentials (
    roll_no INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(50) NOT NULL, 
    email VARCHAR(50) NOT NULL UNIQUE,  
    password VARCHAR(255) NOT NULL 
);

select * from user_credentials;
alter table user_credentials add column is_active boolean ; 
ALTER TABLE user_credentials ADD COLUMN role_id INT DEFAULT 1;
alter table user_credentials modify column is_active boolean default true; 
INSERT INTO user_credentials (full_name, email, password,role_id) VALUES ('admin', 'admin@gmail.com', 'UL0F8wpeZeWX2de6wJSdgswkS4L5wSZf9bpoa9Iza6UZpax0ShRXgYbB9l19ZdrF+NBEuUJd/R0imU2aZu9Vd3rGO6bkDKrenWlZMgKDdBjSBOBSdWPBV0BkfQAUoNJs1Gi6JEGZcoh7yYb8rNO2JwU/hTGrhu8mabxSRT+GEU8=',0);

CREATE TABLE user_details (
    roll_no INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    qualification VARCHAR(100) NOT NULL,
    gender CHAR(1) NOT NULL,
    city_preference_1 VARCHAR(100) NOT NULL,
    city_preference_2 VARCHAR(100) NOT NULL,
    city_preference_3 VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    native_city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    aadhar_number VARCHAR(12) NOT NULL UNIQUE,
    FOREIGN KEY (roll_no) REFERENCES user_credentials(roll_no)
);

CREATE TABLE user_documents (
    doc_id INT PRIMARY KEY AUTO_INCREMENT,
    roll_no INT NOT NULL,
    passport_size_photo BLOB NOT NULL,
    digital_signature BLOB NOT NULL,
    qualification_documents BLOB NOT NULL,
    FOREIGN KEY (roll_no) REFERENCES user_credentials(roll_no)
);

CREATE TABLE exam_locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(100) NOT NULL,
    venue_name VARCHAR(255) NOT NULL,
    hall_name VARCHAR(255) NOT NULL,
    capacity INT NOT NULL,
    address VARCHAR(255) NOT NULL,
    location_url VARCHAR(255) NOT NULL,
    UNIQUE KEY (city, venue_name, hall_name)  
);

ALTER TABLE exam_locations
ADD COLUMN exam_id INT,
ADD FOREIGN KEY (exam_id) REFERENCES exams(exam_id);

DELETE FROM exam_locations WHERE exam_id = 9;

select * from exam_locations;

CREATE TABLE exams (
    exam_id INT PRIMARY KEY AUTO_INCREMENT,
    exam_name VARCHAR(100) NOT NULL,
    description TEXT,
    exam_date DATE NOT NULL,
    application_start_date DATETIME NOT NULL,  
    application_end_date DATETIME NOT NULL    
);


ALTER TABLE exams
ADD CONSTRAINT unique_exam_name UNIQUE (exam_name);


ALTER TABLE exams
MODIFY COLUMN application_start_date DATE NOT NULL,
MODIFY COLUMN application_end_date DATE NOT NULL;


ALTER TABLE exams
ADD CONSTRAINT chk_application_dates CHECK (application_start_date <> application_end_date);

DELETE FROM exams
WHERE exam_id = 9;


select * from exams;

CREATE TABLE exam_seating (
    seating_id INT PRIMARY KEY AUTO_INCREMENT,
    roll_no INT NOT NULL,
    exam_id INT NOT NULL,
    location_id INT NOT NULL,
    allocated_seat VARCHAR(20) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    FOREIGN KEY (roll_no) REFERENCES user_credentials(roll_no),
    FOREIGN KEY (exam_id) REFERENCES exams(exam_id),
    FOREIGN KEY (location_id) REFERENCES exam_locations(location_id)
);
