package service.springservice;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.springdao.CoordinatorDAO;
import model.FacultyModel;
import model.StudentModel;
import model.UserModel;
import model.springmodel.ClassRepresentative;
import model.springmodel.ClassSubjectFaculty;
import model.springmodel.Coordinator;
import model.springmodel.SubjectModel;

@Service
public class CoordinatorServiceImpl implements CoordinatorService {
	
	@Autowired
	private CoordinatorDAO coordinatorDAO;
	
	@Override
	@Transactional
	public void addCoordinator(Coordinator theCoordinator) 
	{	
		coordinatorDAO.addCoordinator(theCoordinator);
	}

	@Override
	@Transactional
	public List<Coordinator> getCoordinators() 
	{		
		return coordinatorDAO.getCoordinators();
	}

	@Override
	@Transactional
	public void addCR(ClassRepresentative theCR) {
		coordinatorDAO.addCR(theCR);
	}

	@Override
	@Transactional
	public List<ClassRepresentative> showCR(String classId) {

		return coordinatorDAO.showCR(classId);
	}

	@Override
	@Transactional
	public void addFaculty(ClassSubjectFaculty theFaculty) {
		
		coordinatorDAO.addFaculty(theFaculty);
	}

	@Override
	@Transactional
	public List<ClassSubjectFaculty> showFaculty(String classid) {
		return coordinatorDAO.showFaculty(classid);
	}

	@Override
	@Transactional
	public List<StudentModel> searchName(String name) {
		return coordinatorDAO.searchName(name);
	}

	@Override
	@Transactional
	public List<SubjectModel> getSubjects(int sem,String branch) {
		return coordinatorDAO.getSubjects(sem,branch);
	}

	@Override
	@Transactional
	public List<FacultyModel> searchFName(String term) {
		 		return coordinatorDAO.searchFName(term);
	}

}
