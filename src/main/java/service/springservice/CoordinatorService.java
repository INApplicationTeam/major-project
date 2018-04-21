package service.springservice;

import java.util.List;

import org.springframework.stereotype.Service;

import model.UserModel;
import model.springmodel.ClassRepresentative;
import model.springmodel.ClassSubjectFaculty;
import model.springmodel.Coordinator;
import model.springmodel.SubjectModel;

public interface CoordinatorService {

	void addCoordinator(Coordinator theCoordinator);

	List<Coordinator> getCoordinators();

	void addCR(ClassRepresentative theCR);

	List<ClassRepresentative> showCR(String classId);

	void addFaculty(ClassSubjectFaculty theFaculty);

	List<ClassSubjectFaculty> showFaculty(String classid);

	List<UserModel> searchName(String name);

	List<SubjectModel> getSubjects(String classId);

}
