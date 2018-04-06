package dao.springdao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.springmodel.PollQueDetails;

@Repository
public class PollDAOImpl implements PollDAO {
	
	@Autowired
	private SessionFactory sessionFactory ;
		
	@Override
	public List<PollQueDetails> showPoll(String classid) {
		
		Session currentSession= sessionFactory.getCurrentSession();
		List <PollQueDetails> polldata= new ArrayList<>();	
		Query<Integer> qr= currentSession.createQuery("select postid from ClassPosts where classid =:id AND post_type='poll'",Integer.class);
		qr.setParameter("id", classid);
	
		List<Integer> queid= qr.list();
	  Iterator<Integer> it = queid.iterator();
	    
	  while(it.hasNext())
	  {
	    int pollqueid=(int) it.next();
	    PollQueDetails pqd= currentSession.get(PollQueDetails.class,pollqueid);
	    System.out.println(pqd);
	    polldata.add(pqd);
	  }

		return polldata;			
	}


}
