package com.quillBolt.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

@Entity
public class Schools {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int sno;
	private int institution_group_id;
	private String school_name;
	@Transient
	private String institution_group;
	@Transient
	private String[] select_classes;
	@Transient
	private String[] imgClasses;
	private String title;
	private String subTitle;
	private String logo;
	private String description;
	private String termsCondition;
	private String state;
	private String city;
	private String branch;
	private String location;
	private String extra;
	private String status;
	private Date createdAt;
	private Date updatedAt;
	
	public int getSno() {
		return sno;
	}
	public void setSno(int sno) {
		this.sno = sno;
	}
	public int getInstitution_group_id() {
		return institution_group_id;
	}
	public void setInstitution_group_id(int institution_group_id) {
		this.institution_group_id = institution_group_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSubTitle() {
		return subTitle;
	}
	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getTermsCondition() {
		return termsCondition;
	}
	public void setTermsCondition(String termsCondition) {
		this.termsCondition = termsCondition;
	}
	public String getInstitution_group() {
		return institution_group;
	}
	public void setInstitution_group(String institution_group) {
		this.institution_group = institution_group;
	}
	public String getSchool_name() {
		return school_name;
	}
	public void setSchool_name(String school_name) {
		this.school_name = school_name;
	}
	
	public String getBranch() {
		return branch;
	}
	public void setBranch(String branch) {
		this.branch = branch;
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
	
	public String[] getSelect_classes() {
		return select_classes;
	}
	public void setSelect_classes(String[] select_classes) {
		this.select_classes = select_classes;
	}
	public String[] getImgClasses() {
		return imgClasses;
	}
	public void setImgClasses(String[] imgClasses) {
		this.imgClasses = imgClasses;
	}
	public String getExtra() {
		return extra;
	}
	public void setExtra(String extra) {
		this.extra = extra;
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
