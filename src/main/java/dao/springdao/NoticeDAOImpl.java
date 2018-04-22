package dao.springdao;

import java.util.List;

import javax.persistence.NoResultException;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.UserModel;
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
		
		Query<NoticeViewers> qr1=session.createQuery("from NoticeViewers where noticeId=:noticeId and viewer.uid=:viewerId",NoticeViewers.class);
		
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
	public Notice showNotice(Integer nid,String classId,String viewerId) {
		
		Session currentSession=sessionFactory.getCurrentSession();
		Notice notice=currentSession.get(Notice.class,nid);
		
		Query<NoticeViewers> qr1=currentSession.createQuery("from NoticeViewers where noticeId=:noticeId and viewer.uid=:viewerId",NoticeViewers.class);
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
		
		return notice;
	}

	@Override
	public void addViewer(NoticeViewers viewer) {
		
		Session currentSession=sessionFactory.getCurrentSession();
		
		Query qr=currentSession.createQuery("update Notice set viewers=viewers+1 where noticeId=:nid and noticeId not in (select noticeId from NoticeViewers where viewer.uid=:viewerId)");
		qr.setParameter("nid", viewer.getNoticeId());
		qr.setParameter("viewerId",viewer.getViewer().getUid());
		int result=qr.executeUpdate();
		
		if(result==1)
		{
			currentSession.save(viewer);
		}
		
	}

	@Override
	public List<UserModel> showAllViewers(Integer noticeId) {
		
		Session currentSession=sessionFactory.getCurrentSession();
		
		Query<UserModel> qr=currentSession.createQuery("select viewer from NoticeViewers where noticeId=:noticeId",UserModel.class);
		qr.setParameter("noticeId",noticeId);
		List<UserModel> viewers=qr.getResultList();
		
		return viewers;
	}
	
	
	
	
	

}
