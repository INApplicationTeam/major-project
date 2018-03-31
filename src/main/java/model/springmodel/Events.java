package model.springmodel;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import model.UserModel;

@Entity
@Table(name="event")
public class Events {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="eid" ,updatable = false, nullable = false)
	private int eid;
	
	@Column(name="title")
	private String title;
	
	@Column(name="description")
	private String description;
	
	@Column(name="startdate")
	private Long startdate;
	
	@Column(name="enddate")
	private Long enddate;
	
	@Column(name="pending")
	private Boolean pending;
	
	@OneToOne
	@JoinColumn(name="creatorid")
	private UserModel userModel;

	
	
	public Boolean getPending() {
		return pending;
	}

	public void setPending(Boolean pending) {
		this.pending = pending;
	}

	public int getEid() {
		return eid;
	}

	public void setEid(int eid) {
		this.eid = eid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Long getStartdate() {
		return startdate;
	}

	public void setStartdate(Long startdate) {
		this.startdate = startdate;
	}

	public Long getEnddate() {
		return enddate;
	}

	public void setEnddate(Long enddate) {
		this.enddate = enddate;
	}
	
	public UserModel getUserModel() {
		return userModel;
	}

	public void setUserModel(UserModel userModel) {
		this.userModel = userModel;
	}

	@Override
	public String toString() {
		return "Events [eid=" + eid + ", title=" + title + ", description=" + description + ", startdate=" + startdate
				+ ", enddate=" + enddate + ", pending=" + pending + ", creator=" + userModel + "]";
	}

	
	}
	
	
	
	
	

