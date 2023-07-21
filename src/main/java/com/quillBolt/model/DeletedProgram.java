package com.quillBolt.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

@Entity
public class DeletedProgram {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int sno;
	private int program_id;
	private int institution_group_id;
	private String school_id;
	@Transient
	private String institution_group;
	@Transient
	private String school_name;
	private String title;
	private String studentOf;
	private String bgColor;
	private String subTitle;
	private String logo;
	private String description;
	private String termsCondition;
	private String extra;
	private String status;
	private Date createdAt;
	public int getSno() {
		return sno;
	}
	public void setSno(int sno) {
		this.sno = sno;
	}
	public int getProgram_id() {
		return program_id;
	}
	public void setProgram_id(int program_id) {
		this.program_id = program_id;
	}
	public int getInstitution_group_id() {
		return institution_group_id;
	}
	public void setInstitution_group_id(int institution_group_id) {
		this.institution_group_id = institution_group_id;
	}
	public String getSchool_id() {
		return school_id;
	}
	public void setSchool_id(String school_id) {
		this.school_id = school_id;
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
	public String getStudentOf() {
		return studentOf;
	}
	public void setStudentOf(String studentOf) {
		this.studentOf = studentOf;
	}
	public String getBgColor() {
		return bgColor;
	}
	public void setBgColor(String bgColor) {
		this.bgColor = bgColor;
	}
	public void setSchool_name(String school_name) {
		this.school_name = school_name;
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

	
	
}
