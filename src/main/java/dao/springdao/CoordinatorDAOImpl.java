package dao.springdao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.FacultyModel;
import model.StudentModel;
import model.UserModel;
import model.springmodel.ClassRepresentative;
import model.springmodel.ClassSubjectFaculty;
import model.springmodel.Coordinator;
import model.springmodel.SubjectModel;

@Repository
public class CoordinatorDAOImpl implements CoordinatorDAO {
	
	
	@Autowired
	private SessionFactory sessionFactory ;
	
	@Override
	public void addCoordinator(Coordinator theCoordinator) 
	{
		Session currentSession=sessionFactory.getCurrentSession();
		currentSession.save(theCoordinator);
	}

	@Override
	public List<Coordinator> getCoordinators()
	{
		Session currentSession= sessionFactory.getCurrentSession();
		Query<Coordinator> qr= currentSession.createQuery("from Coordinator ",Coordinator.class);
		List<Coordinator> coordinators  =qr.getResultList();
		
		return coordinators;	
	}

	@Override
	public void addCR(ClassRepresentative theCR) 
	{	
		Session currentSession=sessionFactory.getCurrentSession();
		currentSession.save(theCR);
	}

	@Override
	public List<ClassRepresentative> showCR(String classId) 
	{
		Session currentSession= sessionFactory.getCurrentSession();
		Query<ClassRepresentative> qr= currentSession.createQuery("from ClassRepresentative where classid=:classId",ClassRepresentative.class);	
		qr.setParameter("classId",classId);
		List<ClassRepresentative> CR=qr.getResultList();
		
		return CR;
		
		
	}

	@Override
	public void addFaculty(ClassSubjectFaculty theFaculty) 
	{
		Session currentSession=sessionFactory.getCurrentSession();
		currentSession.save(theFaculty);
	}

	@Override
	public List<ClassSubjectFaculty> showFaculty(String classid) 
	{
		Session currentSession= sessionFactory.getCurrentSession();
		Query<ClassSubjectFaculty> qr= currentSession.createQuery("from ClassSubjectFaculty where classid=:classid",ClassSubjectFaculty.class);
		qr.setParameter("classid", classid);
		List<ClassSubjectFaculty> faculty= qr.getResultList();
		
		return faculty;
	}

	@Override
	public List<StudentModel> searchName(String name) 
	{
		Session currentSession= sessionFactory.getCurrentSession();
		Query<StudentModel> qr= currentSession.createQuery(" from StudentModel where name like :name",StudentModel.class);
		
		qr.setParameter("name", name+"%");
		List<StudentModel> names  =qr.getResultList();
		
		return names;
		
	}

	@Override
	public List<SubjectModel> getSubjects(int sem,String branch) {
		Session currentSession= sessionFactory.getCurrentSession();
		Query<SubjectModel> qr= currentSession.createQuery("from SubjectModel where sem=:sem and branch=:branch",SubjectModel.class);
		qr.setParameter("sem", sem);
		qr.setParameter("branch", branch);
		List<SubjectModel> subjects= qr.getResultList();
		System.out.println("subjects------->"+subjects);
		return subjects;
	}

	@Override
	public List<FacultyModel> searchFName(String name) {
		Session currentSession= sessionFactory.getCurrentSession();
		Query<FacultyModel> qr= currentSession.createQuery(" from FacultyModel where name like :name",FacultyModel.class);
		
		qr.setParameter("name", name+"%");
		List<FacultyModel> names  =qr.getResultList();
		
		return names;
	}

}
