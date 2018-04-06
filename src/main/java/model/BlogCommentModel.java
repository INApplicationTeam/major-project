package model;

import java.util.ArrayList;

public class BlogCommentModel {

	private int bid;
	
	private int cid;
	
	private String uid,uname;
	
	private String comment;
	
	private long timestamp;

	private int likes;
	
	private int flags;
	
	private ArrayList<BlogReplyModel> arbrm;
	
	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public ArrayList<BlogReplyModel> getArbrm() {
		return arbrm;
	}

	public void setArbrm(ArrayList<BlogReplyModel> arbrm) {
		this.arbrm = arbrm;
	}

	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public long getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(long timestamp) {
		this.timestamp = timestamp;
	}

	public int getLikes() {
		return likes;
	}

	public void setLikes(int likes) {
		this.likes = likes;
	}

	public int getFlags() {
		return flags;
	}

	public void setFlags(int flags) {
		this.flags = flags;
	}
}
