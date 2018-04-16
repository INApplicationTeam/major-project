package service.springservice;

import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import model.FacultyModel;
import model.StudentModel;
import model.springmodel.ClassPosts;
import model.springmodel.ClassRepresentative;
import model.springmodel.ClassSubjectFaculty;
import model.springmodel.Question;
import model.springmodel.SavedPosts;

public interface ClassService {

	List<StudentModel> showClassMembers(StudentModel sm);

	List<ClassRepresentative> showClassCR(StudentModel sm);

	List<FacultyModel> showClassCoordinator(StudentModel sm);

	Boolean checkCoordinator(String fid,String classId);

	void addClassPost(ClassPosts cp);

	Set<String> getClassDetails(String fid,boolean isCurrent);

	List<String> getCoordiatorDetails(String fid,int year);

	List<ClassSubjectFaculty> getSubjectClassDetails(String fid,int year);

	List<Object> showClassPosts(String classid,Boolean isPending,String userId, List<Boolean> checkPinned);

	void acceptOrRejectPost(ClassPosts theClassPost);

	int pinPost(ClassPosts pinnedClassPost);

	int unPinPost(ClassPosts pinnedClassPost);

	List<ClassPosts> showPinnedPosts(String classid, boolean isPending, String userId);

	Object renderPinnedPost(Integer postId, String postType, String userId);

	List<Object> getMyPosts(String classId, String userId, String postType);

	int getClassPostId(Integer postId, String postType);

	int saveAsBookMark(SavedPosts savedPosts);

	List<Object> showSavedPosts(String userId, String classId);

	int unSavePost(SavedPosts savedPosts);

}
