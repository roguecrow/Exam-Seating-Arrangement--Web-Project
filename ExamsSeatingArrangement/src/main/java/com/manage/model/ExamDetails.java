package com.manage.model;

import java.sql.Timestamp;
import java.util.Date;

public class ExamDetails {
	private int examId;
    private String examName;
    private String description;
    private Date examDate;
    private Date applicationStartDate;
    private Date applicationEndDate;	
	
	
    public int getExamId() {
		return examId;
	}

	public void setExamId(int examId) {
		this.examId = examId;
	}

	public String getExamName() {
		return examName;
	}

	public void setExamName(String examName) {
		this.examName = examName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getExamDate() {
		return examDate;
	}

	public void setExamDate(Date examDate) {
		this.examDate = examDate;
	}

	public Date getApplicationStartDate() {
		return applicationStartDate;
	}

	public void setApplicationStartDate(Timestamp applicationStartDate) {
		this.applicationStartDate = applicationStartDate;
	}

	public Date getApplicationEndDate() {
		return applicationEndDate;
	}

	public void setApplicationEndDate(Timestamp applicationEndDate) {
		this.applicationEndDate = applicationEndDate;
	}

    public ExamDetails(int examId, String examName, String description, Date examDate, Timestamp applicationStartDate, Timestamp applicationEndDate) {
        this.examId = examId;
        this.examName = examName;
        this.description = description;
        this.examDate = examDate;
        this.applicationStartDate = applicationStartDate;
        this.applicationEndDate = applicationEndDate;
    }
}

