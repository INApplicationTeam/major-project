package model.springmodel;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="pollvotestatus")
public class PollVoteStatus implements Serializable

{
	@Id
	@Column(name="ccode")
	private String ccode;
	
	@Id
	@Column(name="queid")
	private int queid;
	
	@Column(name="votestatus")
	private int votestatus;

	public String getCcode() {
		return ccode;
	}

	public void setCcode(String ccode) {
		this.ccode = ccode;
	}

	public int getQueid() {
		return queid;
	}

	public void setQueid(int queid) {
		this.queid = queid;
	}

	public int getVotestatus() {
		return votestatus;
	}

	public void setVotestatus(int votestatus) {
		this.votestatus = votestatus;
	}

	@Override
	public String toString() {
		return "PollVoteStatus [ccode=" + ccode + ", queid=" + queid + ", votestatus=" + votestatus + "]";
	}
	
	
	

}
