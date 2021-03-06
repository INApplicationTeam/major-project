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
import model.springmodel.SavedPosts;
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
	public Boolean checkCoordinator(String fid,String classId) {
		return classdao.checkCoordinator(fid,classId);
	}

	

	@Override
	@Transactional
	public void addClassPost(ClassPosts cp) {
		classdao.addClassPost(cp);
		
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
	public List<Object> showClassPosts(String classid,Boolean isPending,String userId, List<Boolean> checkPinned) {
		return classdao.showClassPosts(classid,isPending,userId,checkPinned);
	}

	@Override
	@Transactional
	public void acceptOrRejectPost(ClassPosts theClassPost) {
		classdao.acceptOrRejectPost(theClassPost);
	}

	@Override
	@Transactional
	public int pinPost(ClassPosts pinnedClassPost) {
		return classdao.pinPost(pinnedClassPost);
		
	}

	@Override
	@Transactional
	public int unPinPost(ClassPosts pinnedClassPost) {
		return classdao.unPinPost(pinnedClassPost);
		
	}

	@Override
	@Transactional
	public List<ClassPosts> showPinnedPosts(String classid, boolean isPending, String userId) {
		return classdao.showPinnedPosts(classid,isPending,userId);
	}

	@Override
	@Transactional
	public Object renderPinnedPost(Integer postId, String postType,String userId) {
		return classdao.renderPinnedPost(postId,postType,userId);
	}

	@Override
	@Transactional
	public List<Object> getMyPosts(String classId, String userId, String postType) {
		return classdao.getMyPosts(classId,userId,postType);
	}

	@Override
	@Transactional
	public int getClassPostId(Integer postId, String postType) {
		return classdao.getClassPostId(postId,postType);
	}

	@Override
	@Transactional
	public int saveAsBookMark(SavedPosts savedPosts) {
		return classdao.saveAsBookmark(savedPosts);
	}

	@Override
	@Transactional
	public List<Object> showSavedPosts(String userId, String classId) {
		return classdao.showSavedPosts(userId,classId);
	}

	@Override
	@Transactional
	public int unSavePost(SavedPosts savedPosts) {
		return classdao.unSavePost(savedPosts);
  }
  
  @Override
  @Transactional
	public List<ClassSubjectFaculty> showClassSubjectFaculty(StudentModel sm) {
				return classdao.showClassSubjectFaculty(sm);
	}

	
	
	
	
}

