/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.pollmodel;

import java.util.Arrays;

/**
 *
 * @author rohan
 */
public class CreateNewPollModel {
    
   private String que,pollviewer,branch,sem,sec;
   private String option[],creatorId,creatorName;
   private int pollqueid ,optid,count[], pollviewstatus;
   private long deadline;
   private String description;
   private String status;
   private String showresult;
   private String opid[];
   
   

    public String[] getOpid() {
	return opid;
}

public void setOpid(String[] opid) {
	this.opid = opid;
}

	public String getShowresult() {
	return showresult;
}

public void setShowresult(String showresult) {
	this.showresult = showresult;
}

	public String getStatus() {
	return status;
}

public void setStatus(String status) {
	this.status = status;
}

	public long getDeadline() {
	return deadline;
}

public void setDeadline(long deadline) {
	this.deadline = deadline;
}

public String getDescription() {
	return description;
}

public void setDescription(String description) {
	this.description = description;
}

	public String getCreatorId() {
	return creatorId;
}

public void setCreatorId(String creatorId) {
	this.creatorId = creatorId;
}

public String getCreatorName() {
	return creatorName;
}

public void setCreatorName(String creatorName) {
	this.creatorName = creatorName;
}

	public int getPollviewstatus() {
        return pollviewstatus;
    }

    public void setPollviewstatus(int pollviewstatus) {
        this.pollviewstatus = pollviewstatus;
    }

    public int getOptid() {
        return optid;
    }

    public void setOptid(int optid) {
        this.optid = optid;
    }

    public int[] getCount() {
        return count;
    }

    public void setCount(int[] count) {
        this.count = count;
    }
   
   
    public int getPollqueid() {
        return pollqueid;
    }

    public void setPollqueid(int pollqueid) {
        this.pollqueid = pollqueid;
    }
   
    

   

    public String getPollviewer() {
        return pollviewer;
    }

    public void setPollviewer(String pollviewer) {
        this.pollviewer = pollviewer;
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch;
    }

    public String getSem() {
        return sem;
    }

    public void setSem(String sem) {
        this.sem = sem;
    }

    public String getSec() {
        return sec;
    }

    public void setSec(String sec) {
        this.sec = sec;
    }
   
   

    public String getQue() {
        return que;
    }

    public void setQue(String que) {
        this.que = que;
    }

    public String[] getOption() {
        return option;
    }

    public void setOption(String[] option) {
        this.option = option;
    }

	@Override
	public String toString() {
		return "CreateNewPollModel [que=" + que + ", pollviewer=" + pollviewer + ", branch=" + branch + ", sem=" + sem
				+ ", sec=" + sec + ", option=" + Arrays.toString(option) + ", creatorId=" + creatorId + ", creatorName="
				+ creatorName + ", pollqueid=" + pollqueid + ", optid=" + optid + ", count=" + Arrays.toString(count)
				+ ", pollviewstatus=" + pollviewstatus + ", deadline=" + deadline + ", description=" + description
				+ ", status=" + status + "]";
	}

    
    
}
