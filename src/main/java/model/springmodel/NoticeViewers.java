package model.springmodel;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import model.UserModel;

@Entity
@Table(name="noticeviewers")
public class NoticeViewers implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="noticeId")
	private int noticeId;

	@Id
	@OneToOne
	@JoinColumn(name="viewedId")
	private UserModel viewer;

	public int getNoticeId() {
		return noticeId;
	}

	public void setNoticeId(int noticeId) {
		this.noticeId = noticeId;
	}

	public UserModel getViewer() {
		return viewer;
	}

	public void setViewer(UserModel viewer) {
		this.viewer = viewer;
	}

		
	
}