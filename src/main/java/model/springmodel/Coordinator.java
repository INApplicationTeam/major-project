package model.springmodel;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="class_coordinators")
public class Coordinator {
	
	@Id
	@Column(name="classid")
	private String classid;

	@Column(name="uid")
	private String id;
	
	@Column(name="IsCurrent")
	boolean isCurrent;
	
	@Transient
	private String branch;
	
	@Transient
	private int sem;
	
	@Transient
	private char sec;
	
	@Transient
	private int batch;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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
	
	
	
	public String getClassid() {
		return classid;
	}

	public void setClassid() {
		classid=branch+"-"+sem+"-"+sec+"-"+batch;
	}



	public int getBatch() {
		return batch;
	}

	public void setBatch(int batch) {
		this.batch = batch;
	}
	

	public boolean isCurrent() {
		return isCurrent;
	}

	public void setCurrent(boolean isCurrent) {
		this.isCurrent = isCurrent;
	}

	public void setClassid(String classid) {
		this.classid = classid;
	}

	@Override
	public String toString() {
		return "Coordinator [id=" + id + ", branch=" + branch + ", sem=" + sem + ", sec=" + sec + ", batch=" + batch
				+ ", classid=" + classid + "]";
	}
	
	

	

}
