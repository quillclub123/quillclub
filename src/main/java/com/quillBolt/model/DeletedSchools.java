package com.quillBolt.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

@Entity
public class DeletedSchools {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int sno;
	private int school_id;
	private int institution_group_id;
	private String school_name;
	@Transient
	private String institution_group;
	private String state;
	private String city;
	private String location;
	private String branch;
	private String status;
	private Date createdAt;
	private Date updatedAt;
	public int getSno() {
		return sno;
	}
	public void setSno(int sno) {
		this.sno = sno;
	}
	
	public int getSchool_id() {
		return school_id;
	}
	public void setSchool_id(int school_id) {
		this.school_id = school_id;
	}
	public int getInstitution_group_id() {
		return institution_group_id;
	}
	public void setInstitution_group_id(int institution_group_id) {
		this.institution_group_id = institution_group_id;
	}
	public String getSchool_name() {
		return school_name;
	}
	public void setSchool_name(String school_name) {
		this.school_name = school_name;
	}
	public String getInstitution_group() {
		return institution_group;
	}
	public void setInstitution_group(String institution_group) {
		this.institution_group = institution_group;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getBranch() {
		return branch;
	}
	public void setBranch(String branch) {
		this.branch = branch;
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
