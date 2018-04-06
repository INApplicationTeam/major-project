package dao.springdao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.springmodel.ClassDiscussion;
import model.springmodel.ClassDiscussionComment;
import model.springmodel.ClassDiscussionReply;

@Repository
public class DiscussionDAOImpl implements DiscussionDAO {
	
	@Autowired
	private SessionFactory sessionFactory ;
	
	@Override
	public int addDiscussion(ClassDiscussion cd) 
	{
		Session currentSession=sessionFactory.getCurrentSession();
		int id=(Integer)currentSession.save(cd);
		return id;
	}
	
	@Override
	public List<ClassDiscussion> showDiscussions(String classId) 
	{
		Session currentSession=sessionFactory.getCurrentSession();
		Query<ClassDiscussion> qr=currentSession.createQuery("from ClassDiscussion cd where cd.id in (select postid from ClassPosts where classid =:classid and post_type='discussion') and isReviewed=:isReviewed order by cd.id desc",ClassDiscussion.class);
		qr.setParameter("classid", classId);
		qr.setParameter("isReviewed",true);
		List<ClassDiscussion> discussionList=qr.getResultList();
	
		return discussionList;
	}

	@Override
	public void postComment(ClassDiscussionComment cdc) 
	{
		Session currentSession=sessionFactory.getCurrentSession();
		int commentId=(Integer)currentSession.save(cdc);
	}
	
	@Override
	public void postCommentReply(ClassDiscussionReply reply) {
		
		Session currentSession=sessionFactory.getCurrentSession();
		int replyId=(Integer)currentSession.save(reply);
	}



}
