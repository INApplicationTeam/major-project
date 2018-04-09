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

}
