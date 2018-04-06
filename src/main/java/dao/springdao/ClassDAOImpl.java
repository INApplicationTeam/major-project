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
import model.springmodel.Coordinator;
import model.springmodel.Events;
import model.springmodel.PollQueDetails;
import model.springmodel.Question;

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
	public List<Object> showClassPosts(String classid,Boolean isPending) {
		
		Session currentSession=sessionFactory.getCurrentSession();
		Query<ClassPosts> qr=currentSession.createQuery("from ClassPosts where classid=:classid order by id desc",ClassPosts.class);
		qr.setParameter("classid",classid);
		List<ClassPosts> classPosts=(ArrayList<ClassPosts>)qr.getResultList();
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
				classPostsDetails.add(discussion);
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
	
	
				 
}


