package com.quillBolt.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Banner {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int sno;
	private String bannerImg;
	private String status;
	private Date createdAt;
	private Date updatedAt;
	public int getSno() {
		return sno;
	}
	public void setSno(int sno) {
		this.sno = sno;
	}
	public String getBannerImg() {
		return bannerImg;
	}
	public void setBannerImg(String bannerImg) {
		this.bannerImg = bannerImg;
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
