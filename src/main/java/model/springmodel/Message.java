package model.springmodel;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import model.UserModel;

@Entity
@Table(name="messages")
public class Message 
{
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="mid" ,updatable = false, nullable = false)
	private int mid;

	@Column(name="timestamp")
	private Long timestamp;
	
	@Column(name="message")
	private String message;
	
	@OneToOne(cascade=CascadeType.ALL)
	@JoinColumn(name="senderid")
	private UserModel sender;
	
	@OneToOne
	@JoinColumn(name="receiverid")
	private UserModel receiver;

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getMid() {
		return mid;
	}

	public void setMid(int mid) {
		this.mid = mid;
	}

	

	

	public Long getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Long timestamp) {
		this.timestamp = timestamp;
	}

	public UserModel getSender() {
		return sender;
	}

	public void setSender(UserModel sender) {
		this.sender = sender;
	}

	public UserModel getReceiver() {
		return receiver;
	}

	public void setReceiver(UserModel receiver) {
		this.receiver = receiver;
	}

	@Override
	public String toString() {
		return "Message [mid=" + mid + ", timestamp=" + timestamp + ", message=" + message + ", sender=" + sender
				+ ", receiver=" + receiver + "]";
	}
	

	

	

	
		
	
	

}
