package model.springmodel;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="answerviewers")
public class AnswerViewers implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="qid")
	private int qid;
	
	@Id
	@Column(name="uid")
	private String uid;
	
	@Id
	@Column(name="viewerid")
	private String viewerid;

	public int getQid() {
		return qid;
	}

	public void setQid(int qid) {
		this.qid = qid;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getViewerid() {
		return viewerid;
	}

	public void setViewerid(String viewerid) {
		this.viewerid = viewerid;
	}
	
	

}
