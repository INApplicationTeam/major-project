package controller.springcontroller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import model.UserModel;
import model.springmodel.Message;
import service.springservice.DirectMessageService;

@Controller
@RequestMapping("/message")
public class DirectMessage 
{

	@Autowired
	private DirectMessageService dmservice;
	
	
	@GetMapping("/DMform")
	public String directMessageform(HttpServletRequest request, Model theModel)
	{
		HttpSession session=request.getSession();


		UserModel receiver=new UserModel();
		Object object=session.getAttribute("userModel");

		String senderid=receiver.getUserId(object);

		Message themessage= new Message();
		String receiverid=request.getParameter("id");
		String username=request.getParameter("name");
		System.out.println("name------"+username);
		receiver.setUid(receiverid);
		receiver.setUname(username);
		theModel.addAttribute("message", themessage);
		List <Message> theConversation=dmservice.showConversation(receiverid,senderid);
		theModel.addAttribute("conversation", theConversation);
		themessage.setReceiver(receiver);
		
		return "DM";
	}
	
	
	@PostMapping("/sendDM")
	public String sendDM(@ModelAttribute ("message") Message themessage, HttpServletRequest request)
	{	
		HttpSession session=request.getSession();

		UserModel sender= new UserModel();
		Object object=session.getAttribute("userModel");
		
		String senderid=sender.getUserId(object);
		sender.setUid(senderid);		
		themessage.setSender(sender);
		Long timestamp= System.currentTimeMillis();
		themessage.setTimestamp(timestamp);
		dmservice.sendDM(themessage);
		
		return "profilepage";
		
	}
	
	
	
	@GetMapping("/inbox")
	public String myMessages(HttpServletRequest request, Model theModel)
	{
		HttpSession session=request.getSession();


		UserModel um= new UserModel();
		Object object=session.getAttribute("userModel");
		
		String id=um.getUserId(object);
		
		HashMap<String, String> theThreads= dmservice.getMessageThreads(id);
		
		theModel.addAttribute("threads", theThreads);
		return "inbox";
		
	}
	

}
