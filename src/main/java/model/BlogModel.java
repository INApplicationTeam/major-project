/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.ArrayList;

/**
 *
 * @author rohan
 */
public class BlogModel {
    private int blogId,upvotes,did;
    private String blogContent,uid,uname,dname,title;
    private ArrayList<BlogCommentModel> arbcm;
    private String timestamp;

    private Long timestamp1;

	public Long getTimestamp1() {
		return timestamp1;
	}

	public void setTimestamp1(Long timestamp1) {
		this.timestamp1 = timestamp1;
	}

	public String getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}

	public String getUname() {
        return uname;
    }

    public ArrayList<BlogCommentModel> getArbcm() {
		return arbcm;
	}

	public void setArbcm(ArrayList<BlogCommentModel> arbcm) {
		this.arbcm = arbcm;
	}

	public void setUname(String uname) {
        this.uname = uname;
    }

    public String getDname() {
        return dname;
    }

    public void setDname(String dname) {
        this.dname = dname;
    }
    
    
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getBlogId() {
        return blogId;
    }

    public void setBlogId(int blogId) {
        this.blogId = blogId;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public int getUpvotes() {
        return upvotes;
    }

    public void setUpvotes(int upvotes) {
        this.upvotes = upvotes;
    }

    public int getDid() {
        return did;
    }

    public void setDid(int did) {
        this.did = did;
    }

    public String getBlogContent() {
        return blogContent;
    }

    public void setBlogContent(String blogContent) {
        this.blogContent = blogContent;
    }

    
   
    
    
    
}
