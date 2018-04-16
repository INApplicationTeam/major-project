package model.springmodel;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import model.UserModel;

@Entity
@Table(name="class_subject_faculty")
public class ClassSubjectFaculty implements Serializable
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@OneToOne
	@JoinColumn(name="uid")
	private UserModel userModel;
	
	@Transient
	private String branch;

	@Transient
	private int sem;

	@Transient
	private char sec;

	@Transient
	private int batch;

	@Id
	@Column(name="classid")
	private String classid;

	@Id
	@OneToOne
	@JoinColumn(name="subcode")
	private SubjectModel subject;
	
	@Column(name="year_of_teaching")
	private int yearOfTeaching;

	public int getYearOfTeaching() {
		return yearOfTeaching;
	}

	public void setYearOfTeaching(int yearOfTeaching) {
		this.yearOfTeaching = yearOfTeaching;
	}

	public void setClassid(String classid) {
		this.classid = classid;
		setClassAttributes(this.classid);
	}
	
	public SubjectModel getSubject() {
		return subject;
	}

	public void setSubject(SubjectModel subject) {
		this.subject = subject;
	}

	public String getClassid() {
		return classid;
	}

	public void setClassid() {
		classid=branch+"-"+sem+"-"+sec+"-"+batch;
	}

	public void setClassAttributes(String classid)
	{
		this.classid=classid;
		String temp[]=classid.split("-");
		this.branch=temp[0];
		this.sem=Integer.parseInt(temp[1]);
		this.sec=temp[2].charAt(0);
		this.batch=Integer.parseInt(temp[3]);
		
	}

	public int getBatch() {
		return batch;
	}

	public void setBatch(int batch) {
		this.batch = batch;
	}

	

	public UserModel getUserModel() {
		return userModel;
	}

	public void setUserModel(UserModel userModel) {
		this.userModel = userModel;
	}

	public String getBranch() {
		return branch;
	}

	public void setBranch(String branch) {
		this.branch = branch;
	}

	public int getSem() {
		return sem;
	}

	public void setSem(int sem) {
		this.sem = sem;
	}

	public char getSec() {
		return sec;
	}

	public void setSec(char sec) {
		this.sec = sec;
	}

	@Override
	public String toString() {
		return "ClassSubjectFaculty [userModel=" + userModel + ", branch=" + branch + ", sem=" + sem + ", sec=" + sec
				+ ", batch=" + batch + ", classid=" + classid + ", subject=" + subject + ", yearOfTeaching="
				+ yearOfTeaching + "]";
	}

	

}
