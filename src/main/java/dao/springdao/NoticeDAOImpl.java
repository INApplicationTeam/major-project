package dao.springdao;

import java.util.List;

import javax.persistence.NoResultException;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.springmodel.Notice;
import model.springmodel.NoticeViewers;

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
	public List<Notice> getClassNotices(String classId,String viewerId) {
		
		Session session=sessionFactory.getCurrentSession();
		Query<Notice> qr=session.createQuery("from Notice where noticeId in (select postid from ClassPosts where post_type=:post_type and classid=:classid) and closed=:closed order by noticeId desc",Notice.class);
		qr.setParameter("post_type","notice");
		qr.setParameter("classid",classId);
		qr.setParameter("closed",false);
		List<Notice> classNotices=qr.getResultList();
		
		Query<NoticeViewers> qr1=session.createQuery("from NoticeViewers where noticeId=:noticeId and viewerId=:viewerId",NoticeViewers.class);
		
		for(Notice notice:classNotices)
		{
			qr1.setParameter("noticeId",notice.getNoticeId());
			qr1.setParameter("viewerId",viewerId);
			
			try{
				qr1.getSingleResult();
				notice.setViewed(true);	
			}
			catch(NoResultException noResult)
			{
				notice.setViewed(false);
				System.out.println("Not-Viewed");
			}
		}
		return classNotices;
	}

	@Override
	public Notice showNotice(Integer nid) {
		
		Session currentSession=sessionFactory.getCurrentSession();
		Notice notice=currentSession.get(Notice.class,nid);
		return notice;
	}
	
	
	
	

}
