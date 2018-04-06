package service.springservice;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.springdao.QuestionDAO;
import model.springmodel.Answer;
import model.springmodel.Question;

@Service
public class QuestionServiceImpl implements QuestionService {

	@Autowired
	private QuestionDAO questionDAO;
	
	@Override
	@Transactional
	public List<Question> showClassQuestions(String classId) {
		return questionDAO.fetchClassQuestions(classId);
	}

	@Override
	@Transactional
	public Question showAllAnswers(Integer qid,String uid) {
		return questionDAO.fetchAllAnswers(qid,uid);
	}

	@Override
	@Transactional
	public Answer isAnswered(Integer qid,String uid) {
		return questionDAO.isAnswered(qid,uid);
	}

	@Override
	@Transactional
	public boolean isFollowed(Integer qid,String uid) {
		return questionDAO.isFollowed(qid,uid);
	}
	
	
	

}
