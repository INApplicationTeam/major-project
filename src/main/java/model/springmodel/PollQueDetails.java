package model.springmodel;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import model.UserModel;

@Entity
@Table(name="pollquedetails")
public class PollQueDetails {
	
	@Id
	@Column(name="queid")
	private int queid;
	
	@Column(name="question")
	private String question;
	
	@OneToOne
	@JoinColumn(name="creator_id")
	private	UserModel userModel;
	
	@Column(name="pollviewstatus")
	private int pollviewstatus;
	
	@OneToMany (fetch = FetchType.EAGER,mappedBy="pqd",cascade=CascadeType.ALL)
	private List<PollOptionDetails> options;
	
	@Column(name="deadline")
	private Long deadline;
	
	@Column(name="description")
	private String description;
	
	@Column(name="showResult")
	private String showResult;
	

	public Long getDeadline() {
		return deadline;
	}

	public void setDeadline(Long deadline) {
		this.deadline = deadline;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getShowResult() {
		return showResult;
	}

	public void setShowResult(String showResult) {
		this.showResult = showResult;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public int getQueid() {
		return queid;
	}

	public void setQueid(int queid) {
		this.queid = queid;
	}

	public UserModel getUserModel() {
		return userModel;
	}

	public void setUserModel(UserModel userModel) {
		this.userModel = userModel;
	}

	public int getPollviewstatus() {
		return pollviewstatus;
	}

	public void setPollviewstatus(int pollviewstatus) {
		this.pollviewstatus = pollviewstatus;
	}

	public List<PollOptionDetails> getOptions() {
		return options;
	}

	public void setOptions(List<PollOptionDetails> options) {
		this.options = options;
	}

	
	
@Override
	public String toString() {
		return "PollQueDetails [queid=" + queid + ", question=" + question + ", creatorid=" + userModel
				+ ", pollviewstatus=" + pollviewstatus + ", options=" + options + "]";
	}

public void add(PollOptionDetails option)	
{
	if(options==null)
	{
		options= new ArrayList<>();
	}
	
	options.add(option);
	option.setPqd(this);
}


}