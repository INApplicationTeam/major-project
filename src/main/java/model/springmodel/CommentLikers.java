package model.springmodel;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="commentlikers")
public class CommentLikers implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="uid")
	private String uid;
	
	@Id
	@Column(name="commentId")
	private int commentId;

	
	public CommentLikers() {
		
	}
	
	public CommentLikers(int commentId, String userId) {
		this.commentId=commentId;
		this.uid=userId;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public int getCommentId() {
		return commentId;
	}

	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}

	@Override
	public String toString() {
		return "CommentLikers [uid=" + uid + ", commentId=" + commentId + "]";
	}
	
	

}
