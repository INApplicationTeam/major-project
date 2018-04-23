package dao.springdao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.persistence.NoResultException;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.springmodel.PollQueDetails;
import model.springmodel.PollVoteStatus;

@Repository
public class PollDAOImpl implements PollDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<PollQueDetails> showPoll(String classid, String uid) {

		Session currentSession = sessionFactory.getCurrentSession();
		List<PollQueDetails> polldata = new ArrayList<>();
		Query<Integer> qr = currentSession
				.createQuery("select postid from ClassPosts where classid =:id AND post_type='poll'", Integer.class);
		qr.setParameter("id", classid);

		List<Integer> queid = qr.list();
		Iterator<Integer> it = queid.iterator();

		while (it.hasNext()) {
			int pollqueid = (int) it.next();
			System.out.println("poll qid----->>>>"+pollqueid);
			PollQueDetails pqd = currentSession.get(PollQueDetails.class, pollqueid);
System.out.println(pqd);
			Query<Integer> qr1 = currentSession.createQuery("select votestatus from PollVoteStatus where ccode =:uid and queid =:pid", Integer.class);

			qr1.setParameter("uid", uid);
			qr1.setParameter("pid", pollqueid);
			try {

				int status = qr1.getSingleResult();
				pqd.setIsVoted(true);
			} catch (NoResultException e) {
				System.out.println("not voted poll");
				pqd.setIsVoted(false);

			} catch (Exception e) {
				System.out.println("not voted poll");
				pqd.setIsVoted(false);
			}

			System.out.println(pqd);
			polldata.add(pqd);
		}

		return polldata;
	}

}
