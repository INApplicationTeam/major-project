package controller.springcontroller;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sound.midi.Soundbank;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.HttpServerErrorException;

import com.google.gson.Gson;

import model.FacultyModel;
import model.StudentModel;
import model.UserModel;
import model.springmodel.ClassRepresentative;
import model.springmodel.ClassSubjectFaculty;
import model.springmodel.Coordinator;
import model.springmodel.SubjectModel;
import service.springservice.CoordinatorService;


@Controller
@RequestMapping("/admin")
public class AdminController {
		
	@Autowired
	private CoordinatorService coordinatorService;
	
	@GetMapping("/home")
	public String adminHome(Model theModel)
	{	
		return "adminhome";
	}
	
	@GetMapping("/addformCoordinators")
	public String addformCoordinators(Model theModel)
	{	
		Coordinator theCoordinator= new Coordinator();
		theModel.addAttribute("coordinator",theCoordinator);
		return "addcoordinators";
	}
	
	@PostMapping("/addCoordinators")
	public String addCoordinators(@ModelAttribute ("coordinator") Coordinator theCoordinator)
	{
		theCoordinator.setClassid();
		coordinatorService.addCoordinator(theCoordinator);
		
		return "adminhome";
	}
	
	@GetMapping("/showCoordinators")
	public String showCoordinators(Model theModel)
	{	
		List<Coordinator> theCoordinators= coordinatorService.getCoordinators();
		theModel.addAttribute("coordinators",theCoordinators);

		return "showcoordinators";
	}
	
	@GetMapping("/addCRForm")
	public String addCRForm(Model theModel,HttpServletRequest request)
	{	
		HttpSession session=request.getSession();
		String classId=(String)session.getAttribute("classid");
		
		ClassRepresentative theCR = new ClassRepresentative();
		theCR.setClassAttributes(classId);
		
		
		theModel.addAttribute("CR",theCR);
		return "addCR";
	}
	
	@PostMapping("/addCR")
	public String addCR(@ModelAttribute ("CR") ClassRepresentative theCR,HttpServletRequest request)
	{	
		HttpSession session=request.getSession();
		String classId=(String)session.getAttribute("classid");
		Integer year=(Integer)session.getAttribute("year");
		UserModel um=theCR.getUserModel();
		String studDetails[]=um.getUid().split("-");
		String uid=studDetails[1];
		theCR.setClassid();
		um.setUid(uid);
		theCR.setUserModel(um);
		coordinatorService.addCR(theCR);
		
		return "redirect:/major/class/redirectFacultyHome";
	}
	
	@GetMapping("/showCR")
	public String showCR(Model theModel,HttpServletRequest request)
	{	
		HttpSession session=request.getSession();
		String classId=(String)session.getAttribute("classid");
		List<ClassRepresentative> theCR= coordinatorService.showCR(classId);
		
		theModel.addAttribute("CR",theCR);
		
		return "showCR";
	}
	
	@GetMapping("/addformFaculty")
	public String addformFaculty(Model theModel,HttpServletRequest request)
	{	
		HttpSession session=request.getSession();
		String classId=(String)session.getAttribute("classid");
		
		ClassSubjectFaculty thefaculty= new ClassSubjectFaculty();
		thefaculty.setClassAttributes(classId);
		int sem=thefaculty.getSem();
		String branch=thefaculty.getBranch();
		List<SubjectModel> theSubjects=coordinatorService.getSubjects(sem,branch);
		List<String> theSubjectName=new ArrayList<String>();
		List<Integer> theSubjectCode=new ArrayList<Integer>();
		for(SubjectModel sm: theSubjects)
		{
			theSubjectName.add(sm.getSubject());
			theSubjectCode.add(sm.getSubcode());
		}
		theModel.addAttribute("subjectCode", theSubjectCode);
		theModel.addAttribute("subjectname", theSubjectName);
		theModel.addAttribute("faculty",thefaculty);
		return "addsubjectfaculty";
	}
	
	@PostMapping("/addFaculty")
	public String addCR(@ModelAttribute ("faculty") ClassSubjectFaculty theFaculty)
	{			
		int year=Calendar.getInstance().get(Calendar.YEAR);
		theFaculty.setYearOfTeaching(year);
		theFaculty.setClassid();
		UserModel um=theFaculty.getUserModel();
		String id[]= um.getUid().split("-");
		um.setUid(id[1]);
		theFaculty.setUserModel(um);
		coordinatorService.addFaculty(theFaculty);
		return "redirect:/major/class/redirectFacultyHome";
		
	}
	
	@GetMapping("/showFaculty")
	public String showFaculty(Model theModel,HttpServletRequest request)
	{	
		HttpSession session= request.getSession();
		String classid=(String)session.getAttribute("classid");
		List<ClassSubjectFaculty> theFaculty= coordinatorService.showFaculty(classid);
		theModel.addAttribute("Faculty",theFaculty);
		
		return "showfaculty";
	}
	
	@GetMapping("/searchName")
	public void searchName(HttpServletRequest request,HttpServletResponse response)
	{
        String term=request.getParameter("term");
		List <StudentModel> names=coordinatorService.searchName(term);
		List <String> searchname=new ArrayList<>();
		
		try {
			for(StudentModel um : names)
			{searchname.add(um.getName()+"-"+um.getSid());
			}
            String searchList = new Gson().toJson(searchname);
            response.getWriter().write(searchList);
			
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	@GetMapping("/searchFName")
	public void searchFName(HttpServletRequest request,HttpServletResponse response)
	{
        String term=request.getParameter("term");
		List <FacultyModel> names=coordinatorService.searchFName(term);
		List <String> searchname=new ArrayList<>();
		
		try {
			for(FacultyModel um : names)
			{searchname.add(um.getName()+"-"+um.getFid());
			}
            String searchList = new Gson().toJson(searchname);
            response.getWriter().write(searchList);
			
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	

	
	
}
