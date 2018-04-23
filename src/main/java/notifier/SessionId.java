package notifier;
import javax.websocket.Session;

public class SessionId
{
	private Session session;
	private String userId;
	
	public SessionId()
	{
		
	}
	
	public SessionId(Session session,String userId)
	{
		this.session=session;
		this.userId=userId;
	}
	
	public Session getSession() {
		return session;
	}
	public void setSession(Session session) {
		this.session = session;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	@Override
	public boolean equals(Object obj) 
	{
		if(obj instanceof SessionId)
		{
			SessionId sessionId=(SessionId)obj;
			if(sessionId.getUserId().equalsIgnoreCase(this.getUserId()))
				return true;
			else
				return false;
		}
		else
			return false;
	}

	
	
	
}
