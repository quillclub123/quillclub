package com.quillBolt.model;

import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

@Entity
public class Structure {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int sno;
	private int group_id;
	private int school_id;
	private int total_words;
	private String student_id;
	@Transient
	List<StructureDescription> sd;
	private String status;
	private Date createdAt;
	public int getSno() {
		return sno;
	}
	public void setSno(int sno) {
		this.sno = sno;
	}
	public int getGroup_id() {
		return group_id;
	}
	public void setGroup_id(int group_id) {
		this.group_id = group_id;
	}
	public int getSchool_id() {
		return school_id;
	}
	public void setSchool_id(int school_id) {
		this.school_id = school_id;
	}
	public int getTotal_words() {
		return total_words;
	}
	public void setTotal_words(int total_words) {
		this.total_words = total_words;
	}
	public List<StructureDescription> getSd() {
		return sd;
	}
	public void setSd(List<StructureDescription> sd) {
		this.sd = sd;
	}
	public String getStudent_id() {
		return student_id;
	}
	public void setStudent_id(String student_id) {
		this.student_id = student_id;
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
}
