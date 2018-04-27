package dao.springdao;

import java.util.List;

import javax.persistence.NoResultException;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.springmodel.Answer;
import model.springmodel.AnswerViewers;
import model.springmodel.Question;

@Repository
public class QuestionDAOImpl implements QuestionDAO {

	@Autowired
	private SessionFactory sessionFactory ;
	
	@Override
	public List<Question> fetchClassQuestions(String classId) {
		
		Session currentSession= sessionFactory.getCurrentSession();
		Query<Question> qr=currentSession.createQuery("from Question where qid in (select postid from ClassPosts where classid=:classid and post_type='question') order by qid desc",Question.class);
		qr.setParameter("classid",classId);
		List<Question> queList=(List<Question>)qr.getResultList();
		
		for(Question que: queList)
		{
			System.out.println(que.getMostUpvotedAnswer());
		}
		
		return queList;
	}

	@Override
	public Question fetchAllAnswers(Integer qid,String uid) {
		
		Session currentSession= sessionFactory.getCurrentSession();
		Query<Question> qr=currentSession.createQuery("from Question where qid=:qid",Question.class);
		qr.setParameter("qid",qid);
		
		try{
			Question question=qr.getSingleResult();
			System.out.println(question.getAnswers());
			
			Query<AnswerViewers> qr1=currentSession.createQuery("from AnswerViewers where qid=:qid and uid=:uid and viewerid=:viewerid",AnswerViewers.class);
			int i=0;
			
			for(Answer answer: question.getAnswers())
			{
				qr1.setParameter("qid",qid);
				qr1.setParameter("uid",answer.getUserModel().getUid());
				qr1.setParameter("viewerid",uid);
				
				try{
					qr1.getSingleResult();
					question.getAnswers().get(i).setViewed(true);
				}
				catch(NoResultException noResult)
				{
					question.getAnswers().get(i).setViewed(false);
					noResult.printStackTrace();
				}
			}
			
			return question;
		}
		catch(NoResultException noResult)
		{
			noResult.printStackTrace();
		}
		return null;
	}

	@Override
	public Answer isAnswered(Integer qid,String uid) {
		
		Session currentSession= sessionFactory.getCurrentSession();
		Query<Answer> qr=currentSession.createQuery("from Answer where qid=:qid and uid=:uid",Answer.class);
		qr.setParameter("qid",qid);
		qr.setParameter("uid", uid);
		try{
		Answer answer=qr.getSingleResult();
		return answer;
		}
		catch(NoResultException noResult)
		{
			noResult.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean isFollowed(Integer qid,String uid) {
		
		Session currentSession= sessionFactory.getCurrentSession();
		Query<Integer> qr=currentSession.createQuery("select qid from QuestionFollowers where qid=:qid and followerId=:uid",Integer.class);
		qr.setParameter("qid",qid);
		qr.setParameter("uid", uid);
		Boolean isFollowed=false;
		try{
			int q=(int) qr.getSingleResult();
			isFollowed=true;
		}
		catch(NoResultException noResult)
		{
			noResult.printStackTrace();
		}
		
		return isFollowed;
	}
	
	
}
