package dao.springdao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	public List<Events> showEvents(String classid) {
		
    Session currentSession= sessionFactory.getCurrentSession();
		Query<Events> qr= currentSession.createQuery("from Events where eid in(select postid from ClassPosts where classid=:classid and post_type='event' and pending=:pending) order by eid desc",Events.class);
		qr.setParameter("classid", classid);
		qr.setParameter("pending",true);
		return qr.getResultList();
	}


}
