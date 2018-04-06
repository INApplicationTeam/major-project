package dao.springdao;

import java.util.List;

import model.springmodel.Answer;
import model.springmodel.Question;

public interface QuestionDAO {

	List<Question> fetchClassQuestions(String classId);

	Question fetchAllAnswers(Integer qid,String uid);

	Answer isAnswered(Integer qid,String uid);

	boolean isFollowed(Integer qid,String uid);

}
