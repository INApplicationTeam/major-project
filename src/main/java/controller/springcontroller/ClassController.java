package controller.springcontroller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import dao.NotificationDao;
import model.FacultyModel;
import model.NotificationModel;
import model.StudentModel;
import model.UserModel;
import model.springmodel.CalenderEvents;
import model.springmodel.ClassDiscussion;
import model.springmodel.ClassDiscussionComment;
import model.springmodel.ClassDiscussionReply;
import model.springmodel.ClassPosts;
import model.springmodel.ClassRepresentative;
import model.springmodel.ClassSubjectFaculty;
import model.springmodel.CommentLikers;
import model.springmodel.Events;
import model.springmodel.Notice;
import model.springmodel.NoticeViewers;
import model.springmodel.PollQueDetails;
import model.springmodel.Question;
import model.springmodel.SavedPosts;
import service.springservice.ClassService;
import service.springservice.DiscussionService;
import service.springservice.EventService;
import service.springservice.NoticeService;
import service.springservice.PollService;
import service.springservice.QuestionService;

@Controller
@RequestMapping("/class")
public class ClassController implements ServletContextAware {
	@Autowired
	private ClassService classservice;

	@Autowired
	private EventService eventservice;

	@Autowired
	private DiscussionService discussionservice;

	@Autowired
	private QuestionService questionservice;

	@Autowired
	private PollService pollservice;

	@Autowired
	private NoticeService noticeservice;

	@Autowired
	private ServletContext context;

	@Override
	public void setServletContext(ServletContext context) {
		this.context = context;

	}

	@GetMapping("/CDFhomestudent")
	public String CDFhome(HttpServletRequest request, Model theModel,
			@ModelAttribute("pinnedPostType") String pinnedPostType,
			@ModelAttribute("pinnedQuestion") Question pinnedQuestion,
			@ModelAttribute("pinnedDiscussion") ClassDiscussion pinnedDiscussion,
			@ModelAttribute("pinnedEvent") Events pinnedEvent, @ModelAttribute("pinnedPoll") PollQueDetails pinnedPoll,
			BindingResult bindingResult) {
		HttpSession session = request.getSession();
		Object object = session.getAttribute("userModel");
		StudentModel sm = null;

		if (object instanceof StudentModel) {
			sm = (StudentModel) object;
			String classid = sm.getBranch() + "-" + sm.getSemester() + "-" + sm.getSection() + "-" + sm.getBatch();
			session.setAttribute("classid", classid);

			List<StudentModel> theClassMembers = classservice.showClassMembers(sm);
			theModel.addAttribute("classmembers", theClassMembers);

			List<ClassRepresentative> theCR = classservice.showClassCR(sm);
			theModel.addAttribute("CR", theCR);

			List<ClassSubjectFaculty> theClassSubjectFaculty = classservice.showClassSubjectFaculty(sm);
			theModel.addAttribute("classSubjectFaculty", theClassSubjectFaculty);

			List<FacultyModel> theClassCoordinator = classservice.showClassCoordinator(sm);
			theModel.addAttribute("classCoordinator", theClassCoordinator);

			List<Object> allClassPosts = classservice.showClassPosts(classid, false, sm.getSid(), null);
			theModel.addAttribute("allClassPosts", allClassPosts);

			List<ClassPosts> allPinnedPosts = classservice.showPinnedPosts(classid, false, sm.getSid());
			theModel.addAttribute("allPinnedPosts", allPinnedPosts);

			String currentsem = new UserModel().getSem(object);
			String selectedsem = currentsem;
			theModel.addAttribute("currentsem", currentsem);
			theModel.addAttribute("selectedsem", selectedsem);

			ClassDiscussionComment cdc = new ClassDiscussionComment();
			theModel.addAttribute("ClassCommentModel", cdc);

			ClassDiscussionReply cdr = new ClassDiscussionReply();
			theModel.addAttribute("ClassReplyModel", cdr);

			if (pinnedPostType.equals("discussion")) {
				theModel.addAttribute("pinnedPostType", pinnedPostType);
				theModel.addAttribute("pinnedPost", pinnedDiscussion);
			} else if (pinnedPostType.equals("event")) {
				theModel.addAttribute("pinnedPostType", pinnedPostType);
				theModel.addAttribute("pinnedPost", pinnedEvent);
			} else if (pinnedPostType.equals("question")) {
				theModel.addAttribute("pinnedPostType", pinnedPostType);
				theModel.addAttribute("pinnedPost", pinnedQuestion);
			} else if (pinnedPostType.equals("poll")) {
				theModel.addAttribute("pinnedPostType", pinnedPostType);
				theModel.addAttribute("pinnedPost", pinnedPoll);
			}

			List<Notice> classNotices = noticeservice.getClassNotices(classid, sm.getSid());
			theModel.addAttribute("classNotices", classNotices);

			theModel.addAttribute("bindingNotice", new Notice());

			return "CDFhomestudent";
		}
		return null;

	}

	@GetMapping("/showSession")
	public String showSession(HttpServletRequest request, Model theModel,
			@ModelAttribute("pinnedPostType") String pinnedPostType,
			@ModelAttribute("pinnedQuestion") Question pinnedQuestion,
			@ModelAttribute("pinnedDiscussion") ClassDiscussion pinnedDiscussion,
			@ModelAttribute("pinnedEvent") Events pinnedEvent, @ModelAttribute("pinnedPoll") PollQueDetails pinnedPoll,
			BindingResult bindingResult) {
		String selectedsem = request.getParameter("sem");

		HttpSession session = request.getSession();
		Object object = session.getAttribute("userModel");
		StudentModel sm = null;
		StudentModel tempStudent = null;
		String classid = null;

		if (object instanceof StudentModel) {
			sm = (StudentModel) object;
			classid = sm.getBranch() + "-" + selectedsem + "-" + sm.getSection() + "-" + sm.getBatch();

			tempStudent = new StudentModel();
			tempStudent.setBranch(sm.getBranch());
			tempStudent.setSemester(selectedsem);
			tempStudent.setSection(sm.getSection());
			tempStudent.setBatch(sm.getBatch());

			session.setAttribute("classid", classid);
		}

		List<StudentModel> theClassMembers = classservice.showClassMembers(tempStudent);
		theModel.addAttribute("classmembers", theClassMembers);

		List<ClassRepresentative> theCR = classservice.showClassCR(tempStudent);
		theModel.addAttribute("CR", theCR);

		List<FacultyModel> theClassCoordinator = classservice.showClassCoordinator(tempStudent);
		theModel.addAttribute("classCoordinator", theClassCoordinator);

		List<ClassSubjectFaculty> theClassSubjectFaculty = classservice.showClassSubjectFaculty(tempStudent);
		theModel.addAttribute("classSubjectFaculty", theClassSubjectFaculty);

		List<Object> allClassPosts = classservice.showClassPosts(classid, false, sm.getSid(), null);
		theModel.addAttribute("allClassPosts", allClassPosts);

		List<ClassPosts> allPinnedPosts = classservice.showPinnedPosts(classid, false, sm.getSid());
		theModel.addAttribute("allPinnedPosts", allPinnedPosts);

		String currentsem = new UserModel().getSem(object);
		theModel.addAttribute("currentsem", currentsem);
		theModel.addAttribute("selectedsem", selectedsem);

		ClassDiscussionComment cdc = new ClassDiscussionComment();
		theModel.addAttribute("ClassCommentModel", cdc);

		ClassDiscussionReply cdr = new ClassDiscussionReply();
		theModel.addAttribute("ClassReplyModel", cdr);

		if (pinnedPostType.equals("discussion")) {
			theModel.addAttribute("pinnedPostType", pinnedPostType);
			theModel.addAttribute("pinnedPost", pinnedDiscussion);
		} else if (pinnedPostType.equals("event")) {
			theModel.addAttribute("pinnedPostType", pinnedPostType);
			theModel.addAttribute("pinnedPost", pinnedEvent);
		} else if (pinnedPostType.equals("question")) {
			theModel.addAttribute("pinnedPostType", pinnedPostType);
			theModel.addAttribute("pinnedPost", pinnedQuestion);
		} else if (pinnedPostType.equals("poll")) {
			theModel.addAttribute("pinnedPostType", pinnedPostType);
			theModel.addAttribute("pinnedPost", pinnedPoll);
		}

		List<Notice> classNotices = noticeservice.getClassNotices(classid, sm.getSid());
		theModel.addAttribute("classNotices", classNotices);

		theModel.addAttribute("bindingNotice", new Notice());

		return "CDFhomestudent";
	}

	@PostMapping("/classdiscussionfaculty")
	public String classdiscussionfaculty(HttpServletRequest request, Model theModel,
			@ModelAttribute("choosedClass") ClassSubjectFaculty choosedClass) {
		String classId = choosedClass.getClassid();
		int year = choosedClass.getYearOfTeaching();

		HttpSession session = request.getSession();
		session.setAttribute("classid", classId);
		session.setAttribute("year", year);
		Object object = session.getAttribute("userModel");
		FacultyModel fm = null;

		fm = (FacultyModel) object;
		String fid = fm.getFid();

		Boolean coordinatorflag = classservice.checkCoordinator(fid, classId);
		Boolean isCurrentYear = false;

		if (year == Calendar.getInstance().get(Calendar.YEAR)) {
			isCurrentYear = true;
		}

		if (coordinatorflag) {
			String utype = "coordinator";
			theModel.addAttribute("type", utype);
		} else {
			String utype = "faculty";
			theModel.addAttribute("type", utype);
		}

		StudentModel sm = new StudentModel();
		sm.setClassAttributes(classId);

	

		List<Boolean> checkPinned = new ArrayList<>();
		List<Object> allClassPosts = classservice.showClassPosts(classId, false, fid, checkPinned);
		theModel.addAttribute("allClassPosts", allClassPosts);
		theModel.addAttribute("checkPinned", checkPinned);

		List<ClassPosts> allPinnedPosts = classservice.showPinnedPosts(classId, false, sm.getSid());
		theModel.addAttribute("allPinnedPosts", allPinnedPosts);

		theModel.addAttribute("isCurrentYear", isCurrentYear);
		theModel.addAttribute("classid", classId);

		ClassDiscussionComment cdc = new ClassDiscussionComment();
		theModel.addAttribute("ClassCommentModel", cdc);

		ClassDiscussionReply cdr = new ClassDiscussionReply();
		theModel.addAttribute("ClassReplyModel", cdr);

		ClassPosts pinnedClassPost = new ClassPosts();
		theModel.addAttribute("pinnedClassPost", pinnedClassPost);

		List<Notice> classNotices = noticeservice.getClassNotices(classId, fid);
		theModel.addAttribute("classNotices", classNotices);

		theModel.addAttribute("bindingNotice", new Notice());
		
		ClassSubjectFaculty csf= new ClassSubjectFaculty();
		csf.setClassAttributes(classId);
		String branchsec=csf.getBranch()+" - "+ csf.getSec();
		int sem=csf.getSem();
		theModel.addAttribute("branchsec", branchsec);
		theModel.addAttribute("sem", sem);

		return "CDFhomefaculty";

	}

	@GetMapping("/CDFhomefaculty")
	public String showCDF(HttpServletRequest request, Model theModel,
			@RequestParam(value = "year", required = false) Integer year) {
		HttpSession session = request.getSession();
		Object object = session.getAttribute("userModel");
		FacultyModel fm = null;

		if (year == null)
			year = Calendar.getInstance().get(Calendar.YEAR);

		if (object instanceof FacultyModel) {
			fm = (FacultyModel) object;
			String fid = fm.getFid();

			List<String> coordinatorDetails = classservice.getCoordiatorDetails(fid, year);
			List<ClassSubjectFaculty> subjectClassList = classservice.getSubjectClassDetails(fid, year);
			List<ClassSubjectFaculty> coordinatorClassList = new ArrayList<>();

			ClassSubjectFaculty subjectFaculty = null;

			if (coordinatorDetails != null) {
				for (String classId : coordinatorDetails) {
					subjectFaculty = new ClassSubjectFaculty();
					subjectFaculty.setClassAttributes(classId);
					coordinatorClassList.add(subjectFaculty);
				}
			}

			theModel.addAttribute("subjectClassList", subjectClassList);
			theModel.addAttribute("coordinatorClassList", coordinatorClassList);
			theModel.addAttribute("currentYear", year);
			theModel.addAttribute("choosedClass", new ClassSubjectFaculty());
			
			

		}
		return "chooseclass";
	}

	@GetMapping("/addPoll")
	public String addPoll(@RequestParam("pollid") int pollid, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String utype = (String) session.getAttribute("utype");

		ClassPosts theclassposts = new ClassPosts();
		theclassposts.setClassid((String) session.getAttribute("classid"));
		theclassposts.setPost_type("poll");
		theclassposts.setPostid(pollid);

		classservice.addClassPost(theclassposts);

		if (utype.equals("student"))
			return "redirect:/major/class/CDFhomestudent";

		else if (utype.equals("faculty"))
			return "redirect:/major/class/redirectFacultyHome";

		else
			return null;
	}

	@GetMapping("/showPoll")
	public String showPoll(HttpServletRequest request, Model theModel)
	{	
		HttpSession session=request.getSession();
		String classid= (String) session.getAttribute("classid");
		Object obj	= session.getAttribute("userModel");
		
		UserModel um =new UserModel();
		String uid=um.getUserId(obj);
		
		List<PollQueDetails> theCreateNewPollModel =pollservice.showPoll(classid,uid);
		theModel.addAttribute("showpoll", theCreateNewPollModel);
		return "showpoll";
	}

	@GetMapping("/addEventForm")
	public String addEventForm(Model theModel, HttpServletRequest request,
			@RequestParam(name = "type", required = false) String type) {
		Events theEvents = new Events();

		if (type != null && type.equals("faculty")) {
			theEvents.setScope("global");
		} else {
			theEvents.setScope("class");
		}
		theModel.addAttribute("Events", theEvents);

		return "addevent";
	}

	@PostMapping("/addEvent")
	public String addClassEvent(@ModelAttribute("Events") Events theEvents, HttpServletRequest request) {
		HttpSession session = request.getSession();

		UserModel um = new UserModel();
		um.setUid(um.getUserId(session.getAttribute("userModel")));
		String utype = (String) session.getAttribute("utype");

		theEvents.setTimestamp(new Date().getTime());
		theEvents.setUserModel(um);

		if (utype.equals("faculty"))
			theEvents.setPending(true);

		else if (utype.equals("student"))
			theEvents.setPending(false);

		int id = eventservice.addEvent(theEvents);
		if (theEvents.getScope().equals("class")) {
			ClassPosts theclasspost = new ClassPosts();
			theclasspost.setClassid((String) session.getAttribute("classid"));
			theclasspost.setPost_type("event");
			theclasspost.setPostid(id);

			classservice.addClassPost(theclasspost);
		}
		if (theEvents.getScope().equals("global")) {
			return "redirect:/MyFeed";
		}

		if (utype.equals("student"))
			return "redirect:/major/class/CDFhomestudent";
		else if (utype.equals("faculty"))
			return "redirect:/major/class/redirectFacultyHome";
		else
			return null;

	}

	@PostMapping("/saveDiscussion")
	public String savePost(@ModelAttribute("ClassDiscussionModel") ClassDiscussion cd, HttpServletRequest request) {
		HttpSession session = request.getSession();

		UserModel um = new UserModel();
		String utype = (String) session.getAttribute("utype");
		String uid = um.getUserId(session.getAttribute("userModel"));
		um.setUid(uid);

		cd.setUserModel(um);
		cd.setTimeStamp(new Date().getTime());

		if (utype.equals("faculty"))
			cd.setReviewed(true);

		else if (utype.equals("student"))
			cd.setReviewed(false);

		int id = discussionservice.addDiscussion(cd);

		ClassPosts cp = new ClassPosts();
		cp.setClassid((String) session.getAttribute("classid"));
		cp.setPost_type("discussion");
		cp.setPostid(id);

		classservice.addClassPost(cp);

		if (utype.equals("student"))
			return "redirect:/major/class/CDFhomestudent";
		else if (utype.equals("faculty"))
			return "redirect:/major/class/redirectFacultyHome";
		else
			return null;

	}

	@GetMapping("/showDiscussions")
	public String showDiscussions(HttpServletRequest request, Model model) {
		ClassDiscussionComment cdc = new ClassDiscussionComment();
		model.addAttribute("ClassCommentModel", cdc);

		ClassDiscussionReply cdr = new ClassDiscussionReply();
		model.addAttribute("ClassReplyModel", cdr);

		HttpSession session = request.getSession();
		String classId = (String) session.getAttribute("classid");

		UserModel um = new UserModel();
		String userId = um.getUserId(session.getAttribute("userModel"));

		List<ClassDiscussion> discussionsList = discussionservice.showDiscussions(classId, userId);
		model.addAttribute("discussionsList", discussionsList);
		model.addAttribute("userId", userId);
		return "classDiscussions";
	}

	@GetMapping("/startClassDiscussion")
	public String startClassDiscussion(Model model) {
		ClassDiscussion cd = new ClassDiscussion();
		model.addAttribute("ClassDiscussionModel", cd);

		return "startClassDiscussion";

	}

	@GetMapping("/showEvents")
	public String showEvents(HttpServletRequest request, Model theModel) {

		HttpSession session = request.getSession();
		String classid = (String) session.getAttribute("classid");

		List<Events> eventlist = eventservice.showEvents(classid);
		theModel.addAttribute("eventlist", eventlist);

		return "classevents";

	}
	
	@GetMapping("/ShowEventOfDay")
	public String showEventOfDay(@RequestParam("id")String id,Model theModel,HttpServletRequest request)
	{
		StringTokenizer tokens=new StringTokenizer(id,",");
		ArrayList<Integer> idList=new ArrayList<>();
		
		HttpSession session =request.getSession();
		String classId= (String)session.getAttribute("classid");
		while(tokens.hasMoreTokens())
		{
			idList.add(Integer.parseInt(tokens.nextToken()));
		}	
		
		List<Events> eventlist = eventservice.showEventsOfDay(idList);
		theModel.addAttribute("eventlist", eventlist);
		
		ClassSubjectFaculty csf= new ClassSubjectFaculty();
		csf.setClassAttributes(classId);
		String branchsec=csf.getBranch()+" - "+ csf.getSec();
		int sem=csf.getSem();
		theModel.addAttribute("branchsec", branchsec);
		theModel.addAttribute("sem", sem);
		
		return "classevents";
	}

	@PostMapping("/postComment")
	public String postComment(@RequestParam("disId") int disId,
			@ModelAttribute("ClassCommentModel") ClassDiscussionComment comment, HttpServletRequest request) {
		HttpSession session = request.getSession();

		String utype = (String) session.getAttribute("utype");
		UserModel um = new UserModel();
		um.setUid(um.getUserId(session.getAttribute("userModel")));

		ClassDiscussion discussion = new ClassDiscussion();
		discussion.setId(disId);

		comment.setClassDiscussion(discussion);
		comment.setUserModel(um);
		comment.setTimestamp(new Date().getTime());

		discussionservice.postComment(comment);

		if (utype.equals("student"))
			return "redirect:/major/class/CDFhomestudent";
		else if (utype.equals("faculty"))
			return "redirect:/major/class/redirectFacultyHome";
		else
			return null;
	}

	@PostMapping("/postCommentReply")
	public String postCommentReply(@RequestParam("commentId") int commentId,
			@ModelAttribute("ClassReplyModel") ClassDiscussionReply reply, HttpServletRequest request) {
		HttpSession session = request.getSession();

		String utype = (String) session.getAttribute("utype");
		UserModel um = new UserModel();
		um.setUid(um.getUserId(session.getAttribute("userModel")));

		ClassDiscussionComment comment = new ClassDiscussionComment();
		comment.setCommentId(commentId);

		reply.setComment(comment);
		reply.setUserModel(um);
		reply.setTimestamp(new Date().getTime());

		discussionservice.postCommentReply(reply);

		if (utype.equals("student"))
			return "redirect:/major/class/CDFhomestudent";
		else if (utype.equals("faculty"))
			return "redirect:/major/class/redirectFacultyHome";
		else
			return null;
	}

	@GetMapping("/addClassQue")
	public String addClassQue(@RequestParam("qid") Integer qid, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String utype = (String) session.getAttribute("utype");

		ClassPosts theclassposts = new ClassPosts();
		theclassposts.setClassid((String) session.getAttribute("classid"));
		theclassposts.setPost_type("question");
		theclassposts.setPostid(qid);

		classservice.addClassPost(theclassposts);

		if (utype.equals("student"))
			return "redirect:/major/class/CDFhomestudent";
		else if (utype.equals("faculty"))
			return "redirect:/major/class/redirectFacultyHome";
		else
			return null;
	}

	@GetMapping("/showClassQuestions")
	public String showClassQuestions(HttpServletRequest request, Model theModel) {
		HttpSession session = request.getSession();
		String classId = (String) session.getAttribute("classid");

		List<Question> classQuestions = questionservice.showClassQuestions(classId);
		theModel.addAttribute("questionList", classQuestions);

		return "showClassQuestions";
	}

	@GetMapping("/showPendingPosts")
	public String showPendingPosts(HttpServletRequest request, Model theModel) {
		HttpSession session = request.getSession();
		String classId = (String) session.getAttribute("classid");

		UserModel um = new UserModel();
		String userId = um.getUserId(session.getAttribute("userModel"));

		List<Object> pendingPostsList = classservice.showClassPosts(classId, true, userId, null);
		theModel.addAttribute("pendingPosts", pendingPostsList);

		theModel.addAttribute("acceptOrReject", new ClassPosts());

		return "showPendingPosts";
	}

	@PostMapping("/acceptOrRejectPost")
	public String acceptOrRejectPost(@ModelAttribute("acceptOrReject") ClassPosts theClassPost,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		String classId = (String) session.getAttribute("classid");
		String userName = new UserModel().getUserName(session.getAttribute("userModel"));

		classservice.acceptOrRejectPost(theClassPost);

		if (theClassPost.isReviewed()) {
			NotificationModel nm = new NotificationModel();
			nm.setMessage(userName + " Approved Discussion :" + theClassPost.getTitle());
			nm.setTimestamp(new Date().getTime());
			nm.setViewed(false);

			NotificationDao notificationDao = new NotificationDao();
			notificationDao.addClassPostNotification(nm, classId, context);
		} else {
			System.out.println("not reviewed");
		}

		return "redirect:/major/class/showPendingPosts";
	}

	@PostMapping("/LikeComment")
	public void likeComment(@RequestParam("commentId") Integer commentId,
			@RequestParam("likesCount") Integer likesCount, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String userId = new UserModel().getUserId(session.getAttribute("userModel"));

		CommentLikers commentLikers = new CommentLikers();
		commentLikers.setCommentId(commentId);
		commentLikers.setUid(userId);

		int result = discussionservice.likeComment(commentLikers);

		try {
			response.getWriter().println(result);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	@PostMapping("/UnLikeComment")
	public void unLikeComment(@RequestParam("commentId") Integer commentId,
			@RequestParam("likesCount") Integer likesCount, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String userId = new UserModel().getUserId(session.getAttribute("userModel"));

		CommentLikers commentLikers = new CommentLikers();
		commentLikers.setCommentId(commentId);
		commentLikers.setUid(userId);

		int result = discussionservice.unLikeComment(commentLikers);

		try {
			response.getWriter().println(result);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	@PostMapping("/pinClassPost")
	public void pinClassPost(@RequestParam("postId") Integer postId, @RequestParam("postType") String postType,
			HttpServletResponse response) {
		ClassPosts pinnedClassPost = new ClassPosts();
		pinnedClassPost.setPostid(postId);
		pinnedClassPost.setPost_type(postType);

		int result = classservice.pinPost(pinnedClassPost);

		try {
			response.getWriter().println(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@PostMapping("/unPinClassPost")
	public void unPinClassPost(@RequestParam("postId") Integer postId, @RequestParam("postType") String postType,
			HttpServletResponse response) {
		ClassPosts pinnedClassPost = new ClassPosts();
		pinnedClassPost.setPostid(postId);
		pinnedClassPost.setPost_type(postType);

		int result = classservice.unPinPost(pinnedClassPost);

		try {
			response.getWriter().println(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@GetMapping("/redirectFacultyHome")
	public String facultyHome(HttpServletRequest request, Model theModel,
			@ModelAttribute("pinnedPostType") String pinnedPostType,
			@ModelAttribute("pinnedQuestion") Question pinnedQuestion,
			@ModelAttribute("pinnedDiscussion") ClassDiscussion pinnedDiscussion,
			@ModelAttribute("pinnedEvent") Events pinnedEvent, @ModelAttribute("pinnedPoll") PollQueDetails pinnedPoll,
			BindingResult bindingResult) {
		HttpSession session = request.getSession();
		String classId = (String) session.getAttribute("classid");
		Integer year = (Integer) session.getAttribute("year");
		Object object = session.getAttribute("userModel");
		FacultyModel fm = null;

		fm = (FacultyModel) object;
		String fid = fm.getFid();

		Boolean coordinatorflag = classservice.checkCoordinator(fid, classId);
		Boolean isCurrentYear = false;

		if (year == Calendar.getInstance().get(Calendar.YEAR)) {
			isCurrentYear = true;
		}

		if (coordinatorflag) {
			String utype = "coordinator";
			theModel.addAttribute("type", utype);
		} else {
			String utype = "faculty";
			theModel.addAttribute("type", utype);
		}

		StudentModel sm = new StudentModel();
		sm.setClassAttributes(classId);

		List<StudentModel> theClassMembers = classservice.showClassMembers(sm);
		theModel.addAttribute("classmembers", theClassMembers);

		List<ClassRepresentative> theCR = classservice.showClassCR(sm);
		theModel.addAttribute("CR", theCR);

		List<FacultyModel> theClassCoordinator = classservice.showClassCoordinator(sm);
		theModel.addAttribute("classCoordinator", theClassCoordinator);
		
		List<ClassSubjectFaculty> theClassSubjectFaculty = classservice.showClassSubjectFaculty(sm);
		theModel.addAttribute("classSubjectFaculty", theClassSubjectFaculty);

		List<Boolean> checkPinned = new ArrayList<>();
		List<Object> allClassPosts = classservice.showClassPosts(classId, false, fid, checkPinned);
		theModel.addAttribute("allClassPosts", allClassPosts);
		theModel.addAttribute("checkPinned", checkPinned);

		List<ClassPosts> allPinnedPosts = classservice.showPinnedPosts(classId, false, sm.getSid());
		theModel.addAttribute("allPinnedPosts", allPinnedPosts);

		theModel.addAttribute("isCurrentYear", isCurrentYear);
		theModel.addAttribute("classid", classId);

		ClassDiscussionComment cdc = new ClassDiscussionComment();
		theModel.addAttribute("ClassCommentModel", cdc);

		ClassDiscussionReply cdr = new ClassDiscussionReply();
		theModel.addAttribute("ClassReplyModel", cdr);

		ClassPosts pinnedClassPost = new ClassPosts();
		theModel.addAttribute("pinnedClassPost", pinnedClassPost);

		if (pinnedPostType.equals("discussion")) {
			theModel.addAttribute("pinnedPostType", pinnedPostType);
			theModel.addAttribute("pinnedPost", pinnedDiscussion);
		} else if (pinnedPostType.equals("event")) {
			theModel.addAttribute("pinnedPostType", pinnedPostType);
			theModel.addAttribute("pinnedPost", pinnedEvent);
		} else if (pinnedPostType.equals("question")) {
			theModel.addAttribute("pinnedPostType", pinnedPostType);
			theModel.addAttribute("pinnedPost", pinnedQuestion);
		} else if (pinnedPostType.equals("poll")) {
			theModel.addAttribute("pinnedPostType", pinnedPostType);
			theModel.addAttribute("pinnedPost", pinnedPoll);
		}

		List<Notice> classNotices = noticeservice.getClassNotices(classId, fid);
		theModel.addAttribute("classNotices", classNotices);

		theModel.addAttribute("bindingNotice", new Notice());
		
		ClassSubjectFaculty csf= new ClassSubjectFaculty();
		csf.setClassAttributes(classId);
		String branchsec=csf.getBranch()+" - "+ csf.getSec();
		int sem=csf.getSem();
		System.out.println("branch sec"+branchsec);
		theModel.addAttribute("branchsec", branchsec);
		theModel.addAttribute("sem", sem);

		return "CDFhomefaculty";

	}

	@GetMapping("/showPinnedPost")
	public String renderPinnedPost(@RequestParam("postId") Integer postId, @RequestParam("postType") String postType,
			RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response,
			Model theModel) {
		HttpSession session = request.getSession();
		UserModel userModel = new UserModel();
		String userId = userModel.getUserId(session.getAttribute("userModel"));
		String utype = (String) session.getAttribute("utype");

		Object pinnedPost = classservice.renderPinnedPost(postId, postType, userId);

		if (pinnedPost instanceof Question) {
			redirectAttributes.addFlashAttribute("pinnedQuestion", (Question) pinnedPost);
		} else if (pinnedPost instanceof Events) {
			redirectAttributes.addFlashAttribute("pinnedEvent", (Events) pinnedPost);
		} else if (pinnedPost instanceof ClassDiscussion) {
			redirectAttributes.addFlashAttribute("pinnedDiscussion", (ClassDiscussion) pinnedPost);
		} else if (pinnedPost instanceof PollQueDetails) {
			redirectAttributes.addFlashAttribute("pinnedPoll", (PollQueDetails) pinnedPost);
		}

		redirectAttributes.addFlashAttribute("pinnedPostType", postType);

		if (utype.equals("faculty"))
			return "redirect:/major/class/redirectFacultyHome";

		else if (utype.equals("student"))
			return "redirect:/major/class/CDFhomestudent";

		else
			return null;
	}

	@GetMapping("/issueNotice")
	public String issueNotice(Model theModel) {
		Notice notice = new Notice();
		theModel.addAttribute("notice", notice);

		return "noticeForm";
	}

	@PostMapping("/saveNotice")
	public String saveNotice(@ModelAttribute("notice") Notice notice, HttpServletRequest request) {
		HttpSession session = request.getSession();

		String utype = (String) session.getAttribute("utype");
		String classId = (String) session.getAttribute("classid");

		UserModel creator = new UserModel();
		creator.setUid(creator.getUserId(session.getAttribute("userModel")));

		notice.setCreator(creator);
		notice.setTimestamp(new Date().getTime());
		notice.setClosed(false);

		int noticeId = noticeservice.saveNotice(notice);

		ClassPosts classPost = new ClassPosts();
		classPost.setClassid(classId);
		classPost.setPost_type("notice");
		classPost.setPostid(noticeId);

		classservice.addClassPost(classPost);

		if (utype.equals("faculty"))
			return "redirect:/major/class/redirectFacultyHome";

		else if (utype.equals("student"))
			return "redirect:/major/class/CDFhomestudent";

		else
			return null;
	}

	@PostMapping("/showNotices")
	public String showNotices(@ModelAttribute("bindingNotice") Notice notice, HttpServletRequest request,
			Model theModel) {
		int nid = notice.getNoticeId();
		HttpSession session = request.getSession();
		String classId = (String) session.getAttribute("classid");
		String viewerId = new UserModel().getUserId(session.getAttribute("userModel"));
		

		Notice currentNotice = noticeservice.showNotice(nid,classId,viewerId);

		List<Notice> classNotices = new ArrayList<>();
		classNotices.add(currentNotice);
		ClassSubjectFaculty csf= new ClassSubjectFaculty();
		csf.setClassAttributes(classId);
		String branchsec=csf.getBranch()+" - "+ csf.getSec();
		int sem=csf.getSem();
		theModel.addAttribute("classNotices", classNotices);
		theModel.addAttribute("branchsec", branchsec);
		theModel.addAttribute("sem", sem);
		
		return "noticePage";
	}

	@GetMapping("/showNotices")
	public String showAllNotices(HttpServletRequest request, Model theModel) {
		HttpSession session = request.getSession();
		String classId = (String) session.getAttribute("classid");
		String viewerId = new UserModel().getUserId(session.getAttribute("userModel"));

		List<Notice> classNotices = noticeservice.getClassNotices(classId, viewerId);
		theModel.addAttribute("classNotices", classNotices);
		
		return "noticePage";
	}

	@GetMapping("/showMyDiscussions")
	public String showMyDiscussions(HttpServletRequest request, Model theModel) {
		HttpSession session = request.getSession();

		String userId = new UserModel().getUserId(session.getAttribute("userModel"));
		String classId = (String) session.getAttribute("classid");

		ClassDiscussionComment cdc = new ClassDiscussionComment();
		theModel.addAttribute("ClassCommentModel", cdc);

		ClassDiscussionReply cdr = new ClassDiscussionReply();
		theModel.addAttribute("ClassReplyModel", cdr);

		List<Object> myDiscussions = classservice.getMyPosts(classId, userId, "discussion");
		theModel.addAttribute("allMyPosts", myDiscussions);

		theModel.addAttribute("postType","discussion");
		
		return "myPosts";
	}
	
	@GetMapping("/showMyQuestions")
	public String showMyQuestions(HttpServletRequest request, Model theModel) {
		HttpSession session = request.getSession();

		String userId = new UserModel().getUserId(session.getAttribute("userModel"));
		String classId = (String) session.getAttribute("classid");

		List<Object> myQuestions = classservice.getMyPosts(classId, userId, "question");
		theModel.addAttribute("allMyPosts", myQuestions);

		theModel.addAttribute("postType","question");

		return "myPosts";
	}
	
	@GetMapping("/showMyPolls")
	public String showMyPolls(HttpServletRequest request, Model theModel) {
		HttpSession session = request.getSession();

		String userId = new UserModel().getUserId(session.getAttribute("userModel"));
		String classId = (String) session.getAttribute("classid");

		List<Object> myPolls = classservice.getMyPosts(classId, userId, "poll");
		theModel.addAttribute("allMyPosts", myPolls);
		
		theModel.addAttribute("postType","poll");

		return "myPosts";
	}
	
	@GetMapping("/showMyEvents")
	public String showMyEvents(HttpServletRequest request, Model theModel) {
		HttpSession session = request.getSession();

		String userId = new UserModel().getUserId(session.getAttribute("userModel"));
		String classId = (String) session.getAttribute("classid");

		List<Object> myEvents = classservice.getMyPosts(classId, userId, "event");
		theModel.addAttribute("allMyPosts", myEvents);
		
		theModel.addAttribute("postType","event");
		
		return "myPosts";
	}


	@PostMapping("/saveAsBookmark")
	public void saveAsBookmark(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("postId") Integer postId, @RequestParam("postType") String postType) {
		HttpSession session = request.getSession();
		String userId = new UserModel().getUserId(session.getAttribute("userModel"));

		SavedPosts savedPosts = new SavedPosts();
		savedPosts.setUid(userId);
		savedPosts.setTimestamp(new Date().getTime());

		int result = -1;
		if (classservice.getClassPostId(postId, postType) != -1) {
			savedPosts.setId(classservice.getClassPostId(postId, postType));
			result = classservice.saveAsBookMark(savedPosts);
		}

		try {
			response.getWriter().println(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@GetMapping("/showSavedPosts")
	public String showSavedPosts(HttpServletRequest request, Model theModel) {
		HttpSession session = request.getSession();

		String userId = new UserModel().getUserId(session.getAttribute("userModel"));
		String classId = (String) session.getAttribute("classid");

		List<Object> savedPosts = classservice.showSavedPosts(userId, classId);
		theModel.addAttribute("savedPosts", savedPosts);

		ClassDiscussionComment cdc = new ClassDiscussionComment();
		theModel.addAttribute("ClassCommentModel", cdc);

		ClassDiscussionReply cdr = new ClassDiscussionReply();
		theModel.addAttribute("ClassReplyModel", cdr);
		
		
		ClassSubjectFaculty csf= new ClassSubjectFaculty();
		csf.setClassAttributes(classId);
		String branchsec=csf.getBranch()+" - "+ csf.getSec();
		int sem=csf.getSem();
		System.out.println("branch sec"+branchsec);
		theModel.addAttribute("branchsec", branchsec);
		theModel.addAttribute("sem", sem);


		return "savedPosts";
	}

	@PostMapping("/unSavePost")
	public void unSavePost(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("postId") Integer postId, @RequestParam("postType") String postType) {
		HttpSession session = request.getSession();
		String userId = new UserModel().getUserId(session.getAttribute("userModel"));

		SavedPosts savedPosts = new SavedPosts();
		savedPosts.setUid(userId);

		int result = -1;
		if (classservice.getClassPostId(postId, postType) != -1) {
			savedPosts.setId(classservice.getClassPostId(postId, postType));
			result = classservice.unSavePost(savedPosts);
		}

		try {
			response.getWriter().println(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@PostMapping("/CountAsNoticeView")
	public void countAsNoticeView(@RequestParam("noticeId") Integer nid,@RequestParam("count")Integer count,HttpServletRequest request,HttpServletResponse response)
	{
		HttpSession session=request.getSession();
		UserModel viewer=new UserModel();
		viewer.setUid(viewer.getUserId(session.getAttribute("userModel"))); 
		
		NoticeViewers viewers=new NoticeViewers();
		viewers.setNoticeId(nid);
		viewers.setViewer(viewer);
		
		noticeservice.addViewer(viewers);
		
		try {
			response.getWriter().println(count);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
	}
	
	@PostMapping("/showAllViewers")
	public void showAllViewers(@RequestParam("noticeId") Integer noticeId,HttpServletResponse response)
	{
		List<UserModel> viewers=noticeservice.showAllViewers(noticeId);
		try {
			String viewerJSON=new Gson().toJson(viewers);
			System.out.println(viewerJSON);
			response.getWriter().println(viewerJSON);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@GetMapping("/getCD")
	public String showCD() {
		return "Notice_Page";
	}

	@GetMapping("/showEventOnCalender")
	public void show(@RequestParam("year") Integer year, @RequestParam("month") Integer month,
			HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String classId = (String) session.getAttribute("classid");

		ArrayList<CalenderEvents> events = eventservice.eventsForCalender(year, month, "class", classId);
		String eventJSON = new Gson().toJson(events);
		System.out.println(eventJSON);
		try {
			response.getWriter().println(eventJSON);
			;
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	@GetMapping("/aboutClass")
	public String aboutClass(HttpServletRequest request,Model theModel)
	{
		HttpSession session = request.getSession();
		Object object = session.getAttribute("userModel");
		StudentModel sm = null;

		if (object instanceof StudentModel) {
			sm = (StudentModel) object;
			String classid = sm.getBranch() + "-" + sm.getSemester() + "-" + sm.getSection() + "-" + sm.getBatch();
			session.setAttribute("classid", classid);

			List<StudentModel> theClassMembers = classservice.showClassMembers(sm);
			theModel.addAttribute("classmembers", theClassMembers);

			List<ClassRepresentative> theCR = classservice.showClassCR(sm);
			theModel.addAttribute("CR", theCR);

			List<ClassSubjectFaculty> theClassSubjectFaculty = classservice.showClassSubjectFaculty(sm);
			theModel.addAttribute("classSubjectFaculty", theClassSubjectFaculty);

			List<FacultyModel> theClassCoordinator = classservice.showClassCoordinator(sm);
			theModel.addAttribute("classCoordinator", theClassCoordinator);

		}
		String classId = (String) session.getAttribute("classid");
		if(object instanceof FacultyModel)
		{
			StudentModel sm1 = new StudentModel();
			sm1.setClassAttributes(classId);
			String classname= sm1.getBranch() +" - "+ sm1.getSection();
			List<StudentModel> theClassMembers = classservice.showClassMembers(sm1);
			theModel.addAttribute("classmembers", theClassMembers);

			List<ClassRepresentative> theCR = classservice.showClassCR(sm1);
			theModel.addAttribute("CR", theCR);

			List<FacultyModel> theClassCoordinator = classservice.showClassCoordinator(sm1);
			theModel.addAttribute("classCoordinator", theClassCoordinator);
			
			List<ClassSubjectFaculty> theClassSubjectFaculty = classservice.showClassSubjectFaculty(sm1);
			theModel.addAttribute("classSubjectFaculty", theClassSubjectFaculty);
			theModel.addAttribute("classname", classname);
			System.out.println("CR"+theCR);
			System.out.println("classCoordinator"+theClassCoordinator);
			System.out.println("classMembers"+theClassMembers);
			System.out.println("subject faculty"+theClassSubjectFaculty);
		}
		
		return "aboutclass";
	}

}
