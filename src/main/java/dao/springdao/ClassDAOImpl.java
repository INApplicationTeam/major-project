package dao.springdao;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.persistence.NoResultException;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.exception.ConstraintViolationException;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.FacultyModel;
import model.StudentModel;
import model.springmodel.ClassDiscussion;
import model.springmodel.ClassDiscussionComment;
import model.springmodel.ClassDiscussionReply;
import model.springmodel.ClassPosts;
import model.springmodel.ClassRepresentative;
import model.springmodel.ClassSubjectFaculty;
import model.springmodel.CommentLikers;
import model.springmodel.Coordinator;
import model.springmodel.Events;
import model.springmodel.PollQueDetails;
import model.springmodel.Question;
import model.springmodel.SavedPosts;

@Repository
public class ClassDAOImpl implements ClassDAO {
	
	@Autowired
	private SessionFactory sessionFactory ;
	
	@Override
	public List<StudentModel> showClassMembers(StudentModel sm) 
	{
		Session currentSession= sessionFactory.getCurrentSession();
		Query<StudentModel> qr= currentSession.createQuery("from StudentModel where branch =:branch AND batch =:batch"
														 + " AND section =:section",StudentModel.class);
		
		qr.setParameter("branch", sm.getBranch());
		qr.setParameter("batch", sm.getBatch());
		qr.setParameter("section", sm.getSection());
		
		List<StudentModel> classmembers =qr.getResultList();

		return classmembers;
	}

	@Override
	public List<ClassRepresentative> showClassCR(StudentModel sm) 
	{	
		Session currentSession= sessionFactory.getCurrentSession();
		String id=sm.getBranch()+"-"+sm.getSemester()+"-"+sm.getSection()+"-"+sm.getBatch();
		
		Query<ClassRepresentative> qr2= currentSession.createQuery("from ClassRepresentative where classid =:classid",ClassRepresentative.class);
		qr2.setParameter("classid", id);
		List<ClassRepresentative> classCR =qr2.getResultList();
		 
		return classCR;
	}

	@Override
	public List<FacultyModel> showClassCoordinator(StudentModel sm) 
	{	
		Session currentSession= sessionFactory.getCurrentSession();
		String id=sm.getBranch()+"-"+sm.getSemester()+"-"+sm.getSection()+"-"+sm.getBatch();
		Query<FacultyModel> qr2= currentSession.createQuery("from FacultyModel  where id IN("+
		"select id from Coordinator where classid =:classid"+")",FacultyModel.class);
		
		qr2.setParameter("classid", id);
	    List<FacultyModel> classCoordinator =qr2.getResultList();
	    
		return classCoordinator;
	}

	
	@Override
	public Boolean checkCoordinator(String fid,String classId)
	{	
		Session currentSession=sessionFactory.getCurrentSession();
		Query<Coordinator> qr= currentSession.createQuery("from Coordinator where id=:id and classid=:classid",Coordinator.class);
		qr.setParameter("id", fid);
		qr.setParameter("classid", classId);
		
		List<Coordinator> coordinator=qr.getResultList();
		
		if(coordinator.isEmpty()) 
		{
			return false;
		}
		else
		{
			return true;
		}
		
	}

	

	@Override
	public void addClassPost(ClassPosts cp) 
	{
		Session currentSession=sessionFactory.getCurrentSession();
		currentSession.save(cp);
	}

	
	@Override
	public Set<String> getClassDetails(String fid,boolean isCurrent) {
		
		Session currentSession= sessionFactory.getCurrentSession();
		Query<String> qr=currentSession.createQuery("select classid from Coordinator where id=:id and isCurrent=:isCurrent",String.class);
		qr.setParameter("id", fid);
		qr.setParameter("isCurrent",isCurrent);
		
		Set<String> set = new HashSet<String>(qr.getResultList());

		Query<String> qr2=currentSession.createQuery("select classid from ClassSubjectFaculty where id=:id and isCurrent=:isCurrent",String.class);
		qr2.setParameter("id", fid);
		qr2.setParameter("isCurrent",isCurrent);
		Set<String> set2 = new HashSet<String>(qr2.getResultList());

		set.addAll(set2);
		return set;
	}
	
	

	@Override
	public List<String> getCoordinatorDetails(String fid, int year) {
		
		Session currentSession= sessionFactory.getCurrentSession();
		Query<String> qr=currentSession.createQuery("select classid from Coordinator where id=:id and yearOfTeaching=:year",String.class);
		qr.setParameter("id", fid);
		qr.setParameter("year",year);
		List<String> coordinatorDetails=qr.getResultList();
		
		return coordinatorDetails;

	}
	
	

	@Override
	public List<ClassSubjectFaculty> getSubjectClassDetails(String fid,int year) {
		
		Session currentSession= sessionFactory.getCurrentSession();
		Query<ClassSubjectFaculty> qr2=currentSession.createQuery("from ClassSubjectFaculty where uid=:fid and yearOfTeaching=:year",ClassSubjectFaculty.class);
		qr2.setParameter("fid", fid);
		qr2.setParameter("year",year);
		List<ClassSubjectFaculty> subjectClassDetails=(List<ClassSubjectFaculty>)qr2.getResultList();
	
		for(ClassSubjectFaculty csf:subjectClassDetails)
		{
			csf.setClassAttributes(csf.getClassid());
		}
		return subjectClassDetails;

	}

	
	
	
	@Override
	public List<Object> showClassPosts(String classid,Boolean isPending,String userId,List<Boolean> isPinned) {
		
		Session currentSession=sessionFactory.getCurrentSession();
		Query<ClassPosts> qr=currentSession.createQuery("from ClassPosts where classid=:classid order by id desc",ClassPosts.class);
		qr.setParameter("classid",classid);
		List<ClassPosts> classPosts=(ArrayList<ClassPosts>)qr.getResultList();
		
		return fetchAllPosts(currentSession,classPosts,isPending,userId,isPinned);
	}
	
	@Override
	public List<ClassPosts> showPinnedPosts(String classid, boolean isPending, String userId) {
		
		Session currentSession=sessionFactory.getCurrentSession();
		Query<ClassPosts> qr=currentSession.createQuery("from ClassPosts where classid=:classid and pinned=:pinned order by id desc",ClassPosts.class);
		qr.setParameter("classid",classid);
		qr.setParameter("pinned",true);
		List<ClassPosts> classPosts=(ArrayList<ClassPosts>)qr.getResultList();
		
		Query<String> qrForDiscussion=currentSession.createQuery("select title from ClassDiscussion where id=:postId and isReviewed=:isReviewed",String.class);
		Query<String> qrForEvent=currentSession.createQuery("select title from Events where eid=:postId and pending=:isPending",String.class);
		Query<String> qrForPoll=currentSession.createQuery("select question from PollQueDetails where queid=:postId",String.class);
		Query<String> qrForQuestion=currentSession.createQuery("select que from Question where qid=:postId",String.class);

		String title=null;
		
		for(ClassPosts classPost : classPosts)
		{
			if(classPost.getPost_type().equals("discussion"))
			{
				qrForDiscussion.setParameter("postId",classPost.getPostid());
				qrForDiscussion.setParameter("isReviewed",!isPending);
				
				try{
					title=qrForDiscussion.getSingleResult();	
					classPost.setTitle(title);
				}
				catch(NoResultException noResultException)
				{
					noResultException.printStackTrace();
				}
			}
			else if(classPost.getPost_type().equals("event"))
			{
				qrForEvent.setParameter("postId",classPost.getPostid());
				qrForEvent.setParameter("isPending",!isPending);
				
				try{
					title=qrForEvent.getSingleResult();
					classPost.setTitle(title);
				}
				catch(NoResultException noResultException)
				{
					noResultException.printStackTrace();
				}
			}
			else if(classPost.getPost_type().equals("poll") && !isPending)
			{
				qrForPoll.setParameter("postId",classPost.getPostid());
				
				try{
					title=qrForPoll.getSingleResult();
					classPost.setTitle(title);
				}
				catch(NoResultException noResultException)
				{
					noResultException.printStackTrace();
				}
			}
			else if(classPost.getPost_type().equals("question") && !isPending)
			{
				qrForQuestion.setParameter("postId",classPost.getPostid());
				
				try{
					title=qrForQuestion.getSingleResult();
					classPost.setTitle(title);
				}
				catch(NoResultException noResultException)
				{
					noResultException.printStackTrace();
				}
			}
		
		}
		
		return classPosts;

		
	}
	
	
	public List<Object> fetchAllPosts(Session currentSession,List<ClassPosts> classPosts,Boolean isPending,String userId,List<Boolean> isPinned)
	{
		List<Object> classPostsDetails=new LinkedList<>();
		Query<ClassDiscussion> qrForDiscussion=currentSession.createQuery("from ClassDiscussion where id=:postId and isReviewed=:isReviewed",ClassDiscussion.class);
		Query<Events> qrForEvent=currentSession.createQuery("from Events where eid=:postId and pending=:isPending",Events.class);
		Query<PollQueDetails> qrForPoll=currentSession.createQuery("from PollQueDetails where queid=:postId",PollQueDetails.class);
		Query<Question> qrForQuestion=currentSession.createQuery("from Question where qid=:postId",Question.class);

		ClassDiscussion discussion=null;
		Events event=null;
		PollQueDetails poll=null;
		Question question=null;
		
		
		for(ClassPosts classPost : classPosts)
		{
			if(classPost.getPost_type().equals("discussion"))
			{
				qrForDiscussion.setParameter("postId",classPost.getPostid());
				qrForDiscussion.setParameter("isReviewed",!isPending);
				
				try{
				discussion=qrForDiscussion.getSingleResult();
				
				CommentLikers commentLikers=null;
					
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
				
				classPostsDetails.add(discussion);
				
					if(isPinned!=null && !isPending && (userId.startsWith("F") || userId.startsWith("f")))
					{
						isPinned.add(classPost.isPinned());
					}
				}
				catch(NoResultException noResultException)
				{
					noResultException.printStackTrace();
				}
			}
			else if(classPost.getPost_type().equals("event"))
			{
				qrForEvent.setParameter("postId",classPost.getPostid());
				qrForEvent.setParameter("isPending",!isPending);
				
				try{
				event=qrForEvent.getSingleResult();
				classPostsDetails.add(event);
				
					if(isPinned!=null && !isPending && (userId.startsWith("F") || userId.startsWith("f")))
					{
						isPinned.add(classPost.isPinned());
					}
				}
				catch(NoResultException noResultException)
				{
					noResultException.printStackTrace();
				}
			}
			else if(classPost.getPost_type().equals("poll") && !isPending)
			{
				qrForPoll.setParameter("postId",classPost.getPostid());
				
				try{
				poll=qrForPoll.getSingleResult();
				classPostsDetails.add(poll);
				
					if(isPinned!=null && !isPending && (userId.startsWith("F") || userId.startsWith("f")))
					{
						isPinned.add(classPost.isPinned());
					}
				}
				catch(NoResultException noResultException)
				{
					noResultException.printStackTrace();
				}
			}
			else if(classPost.getPost_type().equals("question") && !isPending)
			{
				qrForQuestion.setParameter("postId",classPost.getPostid());
				
				try{
				question=qrForQuestion.getSingleResult();
				System.out.println(question.getMostUpvotedAnswer());
				classPostsDetails.add(question);
					
					if(isPinned!=null && !isPending && (userId.startsWith("F") || userId.startsWith("f")))
					{
						isPinned.add(classPost.isPinned());
					}
				
				}
				catch(NoResultException noResultException)
				{
					noResultException.printStackTrace();
				}
			}		
		}
	
		return classPostsDetails;

	}

	@Override
	public void acceptOrRejectPost(ClassPosts theClassPost) {
		
		Session currentSession=sessionFactory.getCurrentSession();	
		
		if(theClassPost.getPost_type().equals("event"))
		{
			Events event=currentSession.get(Events.class,theClassPost.getPostid());
			event.setPending(theClassPost.isReviewed());
			currentSession.update(event);
		}
		else if(theClassPost.getPost_type().equals("discussion"))
		{
			Query qr=currentSession.createQuery("update ClassDiscussion set isReviewed=:result where id=:id");
			qr.setParameter("result",theClassPost.isReviewed());
			qr.setParameter("id",theClassPost.getPostid());
			qr.executeUpdate();
		}
	}

	@Override
	public int pinPost(ClassPosts pinnedClassPost) {
		
		Session currentSession=sessionFactory.getCurrentSession();	
		Query qr=currentSession.createQuery("update ClassPosts set pinned=:pinned where postid=:postid and post_type=:post_type");
		qr.setParameter("pinned",true);
		qr.setParameter("postid",pinnedClassPost.getPostid());
		qr.setParameter("post_type",pinnedClassPost.getPost_type());
		int result=qr.executeUpdate();
		return result;
	}
	
	@Override
	public int unPinPost(ClassPosts pinnedClassPost) {
		
		Session currentSession=sessionFactory.getCurrentSession();	
		Query qr=currentSession.createQuery("update ClassPosts set pinned=:pinned where postid=:postid and post_type=:post_type");
		qr.setParameter("pinned",false);
		qr.setParameter("postid",pinnedClassPost.getPostid());
		qr.setParameter("post_type",pinnedClassPost.getPost_type());
		int result=qr.executeUpdate();
		return result;
	}

	@Override
	public Object renderPinnedPost(Integer postId, String postType,String userId) {
		
		Session currentSession=sessionFactory.getCurrentSession();	
		Query<ClassDiscussion> qrForDiscussion=currentSession.createQuery("from ClassDiscussion where id=:postId",ClassDiscussion.class);
		Query<Events> qrForEvent=currentSession.createQuery("from Events where eid=:postId",Events.class);
		Query<PollQueDetails> qrForPoll=currentSession.createQuery("from PollQueDetails where queid=:postId",PollQueDetails.class);
		Query<Question> qrForQuestion=currentSession.createQuery("from Question where qid=:postId",Question.class);

		ClassDiscussion discussion=null;
		Events event=null;
		PollQueDetails poll=null;
		Question question=null;
		
		if(postType.equals("discussion"))
		{
			qrForDiscussion.setParameter("postId",postId);
			
			try{
				discussion=qrForDiscussion.getSingleResult();
				CommentLikers commentLikers=null;
				
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
				return discussion;
				
			}
			catch(NoResultException noResultException)
			{
				noResultException.printStackTrace();
			}
		}
		else if(postType.equals("event"))
		{
			qrForEvent.setParameter("postId",postId);
			
			try{
				event=qrForEvent.getSingleResult();
				return event;
			}
			catch(NoResultException noResultException)
			{
				noResultException.printStackTrace();
			}
		}
		else if(postType.equals("poll"))
		{
			qrForPoll.setParameter("postId",postId);
			
			try{
				poll=qrForPoll.getSingleResult();
				return poll;
			}
			catch(NoResultException noResultException)
			{
				noResultException.printStackTrace();
			}
		}
		else if(postType.equals("question"))
		{
			qrForQuestion.setParameter("postId",postId);
			
			try{
				question=qrForQuestion.getSingleResult();
				System.out.println(question.getMostUpvotedAnswer());
				return question;
			}
			catch(NoResultException noResultException)
			{
				noResultException.printStackTrace();
			}
			
		}
	
		return null;
	}

	@Override
	public List<Object> getMyPosts(String classId, String userId, String postType) {
		
		Session currentSession=sessionFactory.getCurrentSession();
		Query<Object>qr=null;
		
		List<Object> myPosts=null;
		
		if(postType.equals("question"))
			qr=currentSession.createQuery("from Question where qid in (select postid from ClassPosts where post_type=:post_type and classid=:classid) and userModel.uid=:uid",Object.class);
			
		else if(postType.equals("poll"))
			qr=currentSession.createQuery("from PollQueDetails where queid in (select postid from ClassPosts where post_type=:post_type and classid=:classid) and userModel.uid=:uid",Object.class);
		
		else if(postType.equals("event"))
			qr=currentSession.createQuery("from Events where eid in (select postid from ClassPosts where post_type=:post_type and classid=:classid) and userModel.uid=:uid",Object.class);

		else if(postType.equals("discussion"))
			qr=currentSession.createQuery("from ClassDiscussion where id in (select postid from ClassPosts where post_type=:post_type and classid=:classid) and userModel.uid=:uid",Object.class);
		
		qr.setParameter("post_type",postType);
		qr.setParameter("classid",classId);
		qr.setParameter("uid",userId);
		
		try{
			myPosts=qr.getResultList();
		}
		catch(NoResultException noResultException)
		{
			System.out.println("No Post Found...!!!");
		}
		
		System.out.println(myPosts.size());
		return myPosts;
	}

	@Override
	public int getClassPostId(Integer postId, String postType) {
		
		Session currentSession=sessionFactory.getCurrentSession();
		Query<Integer> qr=currentSession.createQuery("select id from ClassPosts where postid=:postid and post_type=:post_type",Integer.class);
		qr.setParameter("postid",postId);
		qr.setParameter("post_type",postType);
		
		try{
			return qr.getSingleResult();
		}
		catch(NoResultException noResult)
		{
			System.out.println("No Post Found...!!!");
		}
		return -1;
	}

	@Override
	public int saveAsBookmark(SavedPosts savedPosts) {

		Session currentSession=sessionFactory.getCurrentSession();
		SavedPosts isSaved=currentSession.get(SavedPosts.class,savedPosts);
		
		if(isSaved!=null)
			return -1;
		else
		{
			currentSession.save(savedPosts);
			return 0;
		}
	}

	@Override
	public List<Object> showSavedPosts(String userId, String classId) {
		
		Session currentSession=sessionFactory.getCurrentSession();
		List<Object[]> savedPostsId=null;
		List<Object>savedPosts=new ArrayList<>();
		
		Query<Object[]> qr=currentSession.createQuery("select cp.postid,cp.post_type from SavedPosts sp inner join ClassPosts cp on cp.id=sp.id where uid=:uid and sp.id in (select id from ClassPosts where classid=:classid) order by timestamp desc",Object[].class);
		qr.setParameter("uid",userId);
		qr.setParameter("classid",classId);
		
		Query<ClassDiscussion> qrForDiscussion=currentSession.createQuery("from ClassDiscussion where id=:postId",ClassDiscussion.class);
		Query<Events> qrForEvent=currentSession.createQuery("from Events where eid=:postId",Events.class);
		Query<PollQueDetails> qrForPoll=currentSession.createQuery("from PollQueDetails where queid=:postId",PollQueDetails.class);
		Query<Question> qrForQuestion=currentSession.createQuery("from Question where qid=:postId",Question.class);

		ClassDiscussion discussion=null;
		Events event=null;
		PollQueDetails poll=null;
		Question question=null;
		
		int postId;
		String postType;
		
		try{
			savedPostsId=qr.getResultList();
			
			for(Object o[]:savedPostsId)
			{
				postId=(Integer)o[0];
				postType=(String)o[1];
				
				if(postType.equals("discussion"))
				{
					qrForDiscussion.setParameter("postId",postId);
					
					try{
						discussion=qrForDiscussion.getSingleResult();
						CommentLikers commentLikers=null;
						
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
						
						savedPosts.add(discussion);
						
					}
					catch(NoResultException noResultException)
					{
						noResultException.printStackTrace();
					}
				}
				else if(postType.equals("event"))
				{
					qrForEvent.setParameter("postId",postId);
					
					try{
						event=qrForEvent.getSingleResult();
						savedPosts.add(event);
					}
					catch(NoResultException noResultException)
					{
						noResultException.printStackTrace();
					}
				}
				else if(postType.equals("poll"))
				{
					qrForPoll.setParameter("postId",postId);
					
					try{
						poll=qrForPoll.getSingleResult();
						savedPosts.add(poll);
					}
					catch(NoResultException noResultException)
					{
						noResultException.printStackTrace();
					}
				}
				else if(postType.equals("question"))
				{
					qrForQuestion.setParameter("postId",postId);
					
					try{
						question=qrForQuestion.getSingleResult();
						System.out.println(question.getMostUpvotedAnswer());
						savedPosts.add(question);
					}
					catch(NoResultException noResultException)
					{
						noResultException.printStackTrace();
					}
					
				}

			}
			
			return savedPosts;
		}
		catch(NoResultException noResult)
		{
			System.out.println("No Saved Posts Found");
		}
		return null;
	}

	@Override
	public int unSavePost(SavedPosts savedPosts) {
		
		Session currentSession=sessionFactory.getCurrentSession();
		currentSession.delete(savedPosts);
		return 0;
	}
	
  @Override
	public List<ClassSubjectFaculty> showClassSubjectFaculty(StudentModel sm) {
		Session currentSession= sessionFactory.getCurrentSession();
		String id=sm.getBranch()+"-"+sm.getSemester()+"-"+sm.getSection()+"-"+sm.getBatch();
		
		Query<ClassSubjectFaculty> qr2= currentSession.createQuery("from ClassSubjectFaculty where classid =:classid",ClassSubjectFaculty.class);
		qr2.setParameter("classid", id);
		List<ClassSubjectFaculty> classSubjectFaculty =qr2.getResultList();	
		System.out.println(classSubjectFaculty);
		return classSubjectFaculty;
	}
	
}


