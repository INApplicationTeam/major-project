package service.springservice;

import java.util.List;

import model.springmodel.Answer;
import model.springmodel.Question;

public interface QuestionService {

	List<Question> showClassQuestions(String classId);

	Question showAllAnswers(Integer qid,String uid);

	Answer isAnswered(Integer qid,String uid);

	boolean isFollowed(Integer qid,String uid);


}
