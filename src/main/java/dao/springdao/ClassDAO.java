package dao.springdao;

import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import model.FacultyModel;
import model.QuestionModel;
import model.StudentModel;
import model.pollmodel.CreateNewPollModel;
import model.springmodel.Events;
import model.springmodel.PollQueDetails;
import model.springmodel.Question;
import model.springmodel.ClassDiscussion;
import model.springmodel.ClassDiscussionComment;
import model.springmodel.ClassDiscussionReply;
import model.springmodel.ClassPosts;
import model.springmodel.ClassRepresentative;
import model.springmodel.ClassSubjectFaculty;

public interface ClassDAO {

	List<StudentModel> showClassMembers(StudentModel sm);

	List<ClassRepresentative> showClassCR(StudentModel sm);

	List<FacultyModel> showClassCoordinator(StudentModel sm);

	Boolean checkCoordinator(String fid,String classId);

	void addClassPost(ClassPosts cp);

	Set<String> getClassDetails(String fid,boolean isCurrent);

	List<String> getCoordinatorDetails(String fid,int year);

	List<ClassSubjectFaculty> getSubjectClassDetails(String fid,int year);

	List<Object> showClassPosts(String classid,Boolean isPending,String userId);

	void acceptOrRejectPost(ClassPosts theClassPost);
	
}
