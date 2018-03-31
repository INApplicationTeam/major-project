package model.springmodel;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="classposts")
public class ClassPosts implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="postid")
	private int postid;
	
	@Id
	@Column(name="post_type")
	private String post_type;

	@Column(name="classid")
	private String classid;
	
	@Transient
	private boolean reviewed;
	
	
	public boolean isReviewed() {
		return reviewed;
	}

	public void setReviewed(boolean reviewed) {
		this.reviewed = reviewed;
	}

	public String getClassid() {
		return classid;
	}

	public void setClassid(String classid) {
		this.classid = classid;
	}

	public int getPostid() {
		return postid;
	}

	public void setPostid(int postid) {
		this.postid = postid;
	}

	public String getPost_type() {
		return post_type;
	}

	public void setPost_type(String post_type) {
		this.post_type = post_type;
	}

	@Override
	public String toString() {
		return "ClassPosts [classid=" + classid + ", postid=" + postid + ", post_type=" + post_type +", isReviewed = "+reviewed+"]";
	}

	
	
}
