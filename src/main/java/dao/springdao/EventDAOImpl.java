package dao.springdao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.springmodel.CalenderEvents;
import model.springmodel.Events;

@Repository
public class EventDAOImpl implements EventDAO {
	
	@Autowired
	private SessionFactory sessionFactory ;
	

	@Override
	public int addEvent(Events theEvents) {
		
		Session currentSession= sessionFactory.getCurrentSession();
		int id= (Integer)currentSession.save(theEvents);
		return id;
	}
	
	@Override
	public ArrayList<CalenderEvents> eventsForCalender(Integer year, Integer month, String scope, String classId) {
	
		Session currentSession= sessionFactory.getCurrentSession();
		Query<Object[]> qr=currentSession.createQuery("select eid,title,DATE_FORMAT(FROM_UNIXTIME(startdate/1000),'%Y-%m-%d') from Events where eid in (select postid from ClassPosts where post_type=:post_type and classid=:classid) and EXTRACT(MONTH from FROM_UNIXTIME(startdate/1000))=:month and EXTRACT(YEAR from FROM_UNIXTIME(startdate/1000))=:year order by startdate",Object[].class);
		qr.setParameter("post_type","event");
		qr.setParameter("classid",classId);
		qr.setParameter("month",month);
		qr.setParameter("year",year);
		
		List<Object[]> events=qr.getResultList();
		ArrayList<CalenderEvents> calenderEventList=new ArrayList<>();
		CalenderEvents calenderEvent=null;
		
		for(Object[] obj:events)
		{
			if(calenderEvent!=null && calenderEvent.getDate().equals((String)obj[2]))
			{
				calenderEvent.setTitle(calenderEvent.getTitle()+"\n"+obj[1]);
				calenderEvent.setBody(calenderEvent.getBody()+","+obj[0]);
			}
			else
			{ 
				calenderEvent=new CalenderEvents();
				calenderEvent.setTitle((String)obj[1]);
				calenderEvent.setDate((String)obj[2]);
				calenderEvent.setBody(obj[0]+"");
				
				calenderEventList.add(calenderEvent);
			}
		}
		
		
		return calenderEventList;
	}

	@Override
	public List<Events> showEvents(String classid) {
		
		Session currentSession= sessionFactory.getCurrentSession();
		Query<Events> qr= currentSession.createQuery("from Events where eid in(select postid from ClassPosts where classid=:classid and post_type='event' and pending=:pending) order by eid desc",Events.class);
		qr.setParameter("classid", classid);
		qr.setParameter("pending",true);
		return qr.getResultList();
	}


}
