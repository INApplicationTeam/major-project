package service.springservice;

import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.springdao.ClassDAO;
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

@Service
public class ClassServiceImpl implements ClassService {
	
	@Autowired
	private ClassDAO classdao;
	
	@Override
	@Transactional
	public List<StudentModel> showClassMembers(StudentModel sm) {
		return classdao.showClassMembers(sm);
		
	}

	@Override
	@Transactional
	public List<ClassRepresentative> showClassCR(StudentModel sm) {
		return classdao.showClassCR(sm);
	}

	@Override
	@Transactional
	public List<FacultyModel> showClassCoordinator(StudentModel sm) {
		
		return classdao.showClassCoordinator(sm);
	}

	@Override
	@Transactional
	public List<PollQueDetails> showPoll(String classid) {
		
		return classdao.showPoll(classid);
		
	}

	@Override
	@Transactional
	public Boolean checkCoordinator(String fid,String classId) {
		return classdao.checkCoordinator(fid,classId);
	}

	@Override
	@Transactional
	public int addDiscussion(ClassDiscussion cd) {
		return classdao.addDiscussion(cd);
		
	}

	@Override
	@Transactional
	public void addClassPost(ClassPosts cp) {
		classdao.addClassPost(cp);
		
	}

	@Override
	@Transactional
	public List<ClassDiscussion> showDiscussions(String classId) {
		return classdao.showDiscussions(classId);
	}

	
	@Override
	@Transactional
	public Set<String> getClassDetails(String fid,boolean isCurrent) {
		
		return classdao.getClassDetails(fid,isCurrent);
		 
	}
	
	@Override
	@Transactional
	public List<ClassSubjectFaculty> getSubjectClassDetails(String fid, int year) {
		return classdao.getSubjectClassDetails(fid,year);
	}


	@Override
	@Transactional
	public List<String> getCoordiatorDetails(String fid,int year) {
		return classdao.getCoordinatorDetails(fid,year);
	}

	@Override
	@Transactional
	public List<Events> showEvents(String classid) {
		return classdao.showEvents(classid);
    }
	
	@Override
	@Transactional
	public void postComment(ClassDiscussionComment cdc) {
		classdao.postComment(cdc);		
	}

	@Override
	@Transactional
	public List<Question> showClassQuestions(String classId) {
		return classdao.fetchClassQuestions(classId);
	}

	@Override
	@Transactional
	public void postCommentReply(ClassDiscussionReply reply) {
		classdao.postCommentReply(reply);
	}

	@Override
	@Transactional
	public List<Object> showClassPosts(String classid) {
		return classdao.showClassPosts(classid);
	}
	
	

	
	}

