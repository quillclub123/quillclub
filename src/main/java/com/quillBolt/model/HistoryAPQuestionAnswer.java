package com.quillBolt.model;

import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

@Entity
public class HistoryAPQuestionAnswer {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int sno;
	private int apq_id;
	private String student_id;
	@Transient
	private List<HistoryPQA> hps;
	private String status;
	private Date createdAt;
	public int getSno() {
		return sno;
	}
	public void setSno(int sno) {
		this.sno = sno;
	}
	public int getApq_id() {
		return apq_id;
	}
	public void setApq_id(int apq_id) {
		this.apq_id = apq_id;
	}
	public String getStudent_id() {
		return student_id;
	}
	public void setStudent_id(String student_id) {
		this.student_id = student_id;
	}
	public List<HistoryPQA> getHps() {
		return hps;
	}
	public void setHps(List<HistoryPQA> hps) {
		this.hps = hps;
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
