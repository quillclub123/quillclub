package com.quillBolt.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

@Entity
public class SampleQuestion {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer sno;
	private String question_image;
	private String question;
	private String questionImgType;
	private String status;
	private Date createdAt;
	private Date updatedAt;
	public Integer getSno() {
		return sno;
	}
	public void setSno(Integer sno) {
		this.sno = sno;
	}
	public String getQuestion_image() {
		return question_image;
	}
	public void setQuestion_image(String question_image) {
		this.question_image = question_image;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getQuestionImgType() {
		return questionImgType;
	}
	public void setQuestionImgType(String questionImgType) {
		this.questionImgType = questionImgType;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
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
