package com.quillBolt.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

@Entity
public class Questions {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer sno;
	private String title;
	private String question_image;
	@Transient
	private String commonQuestion;
	@Transient
	private String class_name;
	private String question;
	private String quotes;
	private String instructionHeadingA;
	private String instructionA;
	private String instructionHeadingQ;
	private String instructionQ;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getQuotes() {
		return quotes;
	}
	public void setQuotes(String quotes) {
		this.quotes = quotes;
	}
	public String getQuestionImgType() {
		return questionImgType;
	}
	public void setQuestionImgType(String questionImgType) {
		this.questionImgType = questionImgType;
	}
	public String getQuestion_image() {
		return question_image;
	}
	public void setQuestion_image(String question_image) {
		this.question_image = question_image;
	}
	
	public String getInstructionQ() {
		return instructionQ;
	}
	public void setInstructionQ(String instructionQ) {
		this.instructionQ = instructionQ;
	}
	public String getInstructionHeadingQ() {
		return instructionHeadingQ;
	}
	public void setInstructionHeadingQ(String instructionHeadingQ) {
		this.instructionHeadingQ = instructionHeadingQ;
	}
	
	public String getInstructionHeadingA() {
		return instructionHeadingA;
	}
	public void setInstructionHeadingA(String instructionHeadingA) {
		this.instructionHeadingA = instructionHeadingA;
	}
	public String getInstructionA() {
		return instructionA;
	}
	public void setInstructionA(String instructionA) {
		this.instructionA = instructionA;
	}
	public String getClass_name() {
		return class_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	
	public String getCommonQuestion() {
		return commonQuestion;
	}
	public void setCommonQuestion(String commonQuestion) {
		this.commonQuestion = commonQuestion;
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
