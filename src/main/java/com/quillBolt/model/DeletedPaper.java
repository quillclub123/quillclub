package com.quillBolt.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

@Entity
public class DeletedPaper {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int sno;
	private int paper_id;
	private int school_id;
	private int class_id;
	private String status;
	@Transient
	private String question;
	private Date createdAt;
	private Date updatedAt;
	public int getSno() {
		return sno;
	}
	public void setSno(int sno) {
		this.sno = sno;
	}
	
	public int getPaper_id() {
		return paper_id;
	}
	public void setPaper_id(int paper_id) {
		this.paper_id = paper_id;
	}
	public int getSchool_id() {
		return school_id;
	}
	public void setSchool_id(int school_id) {
		this.school_id = school_id;
	}
	public int getClass_id() {
		return class_id;
	}
	public void setClass_id(int class_id) {
		this.class_id = class_id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public Date getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	
	
}
