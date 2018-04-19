package model.springmodel;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import model.UserModel;

@Entity
@Table(name="notice")
public class Notice {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="noticeId" ,updatable = false, nullable = false)
	private int noticeId;
	
	@Column(name="noticeText")
	private String noticeText;
	
	@OneToOne
	@JoinColumn(name="creatorId")
	private UserModel creator;
	
	@Column(name="title")
	private String title;
	
	@Column(name="timestamp")
	private Long timestamp;
	
	@Column(name="isClosed")
	private Boolean closed;
	
	@Transient
	private boolean viewed;

	public boolean isViewed() {
		return viewed;
	}

	public void setViewed(boolean viewed) {
		this.viewed = viewed;
	}

	public int getNoticeId() {
		return noticeId;
	}

	public void setNoticeId(int noticeId) {
		this.noticeId = noticeId;
	}

	public String getNoticeText() {
		return noticeText;
	}

	public void setNoticeText(String noticeText) {
		this.noticeText = noticeText;
	}

	public UserModel getCreator() {
		return creator;
	}

	public void setCreator(UserModel creator) {
		this.creator = creator;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Long getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Long timestamp) {
		this.timestamp = timestamp;
	}

	public Boolean getClosed() {
		return closed;
	}

	public void setClosed(Boolean closed) {
		this.closed = closed;
	}

	@Override
	public String toString() {
		return "Notice [noticeId=" + noticeId + ", noticeText=" + noticeText + ", creator=" + creator + ", title="
				+ title + ", timestamp=" + timestamp + ", closed=" + closed + "]";
	}
	
}
