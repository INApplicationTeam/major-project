package dao.springdao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.number.money.CurrencyUnitFormatter;
import org.springframework.stereotype.Repository;

import model.springmodel.ClassDiscussion;
import model.springmodel.ClassDiscussionComment;
import model.springmodel.ClassDiscussionReply;
import model.springmodel.CommentLikers;

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
	public List<ClassDiscussion> showDiscussions(String classId,String userId) 
	{
		Session currentSession=sessionFactory.getCurrentSession();
		Query<ClassDiscussion> qr=currentSession.createQuery("from ClassDiscussion cd where cd.id in (select postid from ClassPosts where classid =:classid and post_type='discussion') and isReviewed=:isReviewed order by cd.id desc",ClassDiscussion.class);
		qr.setParameter("classid", classId);
		qr.setParameter("isReviewed",true);
		List<ClassDiscussion> discussionList=qr.getResultList();
		
		CommentLikers commentLikers=null;
		for(ClassDiscussion discussion:discussionList)
		{
			for(ClassDiscussionComment comment:discussion.getClassCommentList())
			{
				commentLikers=currentSession.get(CommentLikers.class,new CommentLikers(comment.getCommentId(),userId));
				
				if(commentLikers!=null)
				{
					comment.setLiked(true);
				}
				else
				{
					comment.setLiked(false);
				}
			}
		}
		
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

	@Override
	public int likeComment(CommentLikers commentLikers) {
		
		Session currentSession=sessionFactory.getCurrentSession();
		
		Query qr=currentSession.createQuery("update ClassDiscussionComment set likes=likes+1 where commentId=:commentId1 and commentId not in (select commentId from CommentLikers where commentId=:commentId2 and uid=:uid)");
		qr.setParameter("commentId1", commentLikers.getCommentId());
		qr.setParameter("commentId2", commentLikers.getCommentId());
		qr.setParameter("uid", commentLikers.getUid());
		int result=qr.executeUpdate();
		
		if(result==1)
			currentSession.save(commentLikers);
		
		return result;
		
	}

	@Override
	public int unLikeComment(CommentLikers commentLikers) {
		
		Session currentSession=sessionFactory.getCurrentSession();
		
		Query qr=currentSession.createQuery("update ClassDiscussionComment set likes=likes-1 where commentId=:commentId1 and commentId in (select commentId from CommentLikers where commentId=:commentId2 and uid=:uid)");
		qr.setParameter("commentId1", commentLikers.getCommentId());
		qr.setParameter("commentId2", commentLikers.getCommentId());
		qr.setParameter("uid", commentLikers.getUid());
		int result=qr.executeUpdate();
		
		if(result==1)
			currentSession.remove(commentLikers);
		
		return result;
	}

	


}
