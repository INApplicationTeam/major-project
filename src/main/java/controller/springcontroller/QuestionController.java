package controller.springcontroller;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.ServletContextAware;

import dao.QuestionDao;
import model.QuestionModel;
import model.RelatedQuestionModel;
import model.UserModel;
import model.springmodel.Answer;
import model.springmodel.Question;
import service.springservice.QuestionService;

@Controller
@RequestMapping("/question")
public class QuestionController implements ServletContextAware {

	@Autowired
	private QuestionService questionservice;
	
	@Autowired
	private ServletContext context;
	
	@GetMapping("/allAnswers")
	public String allAnswers(@RequestParam("qid")Integer qid,Model theModel,HttpServletRequest request)
	{
		HttpSession session=request.getSession();
		UserModel user=new UserModel();
		
		String userId=user.getUserId(session.getAttribute("userModel"));
		user.setUid(userId);
		theModel.addAttribute("userId",userId);
		
		String utype=(String)session.getAttribute("utype");
		theModel.addAttribute("utype",utype);
		
		Question question=questionservice.showAllAnswers(qid,userId);
		theModel.addAttribute("question",question);
		
		Answer isAnswered=questionservice.isAnswered(qid,userId);
		theModel.addAttribute("isAnswered",isAnswered);
		
		boolean isFollowed=questionservice.isFollowed(qid,userId);
		theModel.addAttribute("isFollowed",isFollowed);
		
		Boolean flag=false;
		if(isAnswered!=null)
		{
			isAnswered=new Answer();
			isAnswered.setUserModel(user);
			flag=true;
		}
		theModel.addAttribute("flag",flag);
		
		QuestionDao qd=new QuestionDao();
		RelatedQuestionModel rqm=new RelatedQuestionModel();
		QuestionModel qm=new QuestionModel();
		qm.setQid(qid);
		qm.setQue(question.getQue());
		qd.getQuestionSuggestion(qm, rqm, context);
		theModel.addAttribute("RelatedQuestions",rqm.getRelatedque());
		
		return "allAnswer";
	}

	@Override
	public void setServletContext(ServletContext context) {
		this.context=context;
		
	}

	
}
