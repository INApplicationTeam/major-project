package dao.springdao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.springmodel.Notice;

@Repository
public class NoticeDAOImpl implements NoticeDAO {
	
	@Autowired
	private SessionFactory sessionFactory ;

	@Override
	public int saveNotice(Notice notice) {
		
		Session currentSession=sessionFactory.getCurrentSession();
		int noticeId=(Integer)currentSession.save(notice);
		return noticeId;
	}

	@Override
	public List<Notice> getClassNotices(String classId) {
		
		Session session=sessionFactory.getCurrentSession();
		Query<Notice> qr=session.createQuery("from Notice where noticeId in (select postid from ClassPosts where post_type=:post_type and classid=:classid) and closed=:closed order by noticeId desc",Notice.class);
		qr.setParameter("post_type","notice");
		qr.setParameter("classid",classId);
		qr.setParameter("closed",false);
		List<Notice> classNotices=qr.getResultList();
		
		return classNotices;
	}

	@Override
	public Notice showNotice(Integer nid) {
		
		Session currentSession=sessionFactory.getCurrentSession();
		Notice notice=currentSession.get(Notice.class,nid);
		return notice;
	}
	
	
	
	

}
