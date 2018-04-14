package controller.springcontroller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sound.midi.Soundbank;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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

		UserModel um=new UserModel();
		Object object=session.getAttribute("userModel");
		String senderid=um.getUserId(object);
		
		UserModel receiver=new UserModel();
		String receiverid=request.getParameter("id");
		String receivername=request.getParameter("name");
		receiver.setUid(receiverid);
		receiver.setUname(receivername);
		
		Message themessage= new Message();
		themessage.setReceiver(receiver);
		theModel.addAttribute("message", themessage);
		
		List <Message> theConversation=dmservice.showConversation(receiverid,senderid);
		theModel.addAttribute("conversation", theConversation);
		
		return "DM";
	}
	
	
	@PostMapping("/sendDM")
	public String sendDM(@ModelAttribute ("message") Message themessage, HttpServletRequest request)
	{	
		System.out.println(themessage.getReceiver().getUid()+"0---------------------->>>>>>>>>>>");
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
	
	@RequestMapping(value = "/conversation", method = RequestMethod.GET)
    public String showConversation(HttpServletRequest request,Model theModel) 
	{
		HttpSession session=request.getSession();
		String id=request.getParameter("id");
		String name=request.getParameter("name");

		UserModel receiver= new UserModel();
		Object object=session.getAttribute("userModel");
		
		Message themessage= new Message();
		receiver.setUname(name);
		receiver.setUid(id);

		themessage.setReceiver(receiver);

		String userid=receiver.getUserId(object);
		List<Message> theConversation =dmservice.showConversation(id, userid);
		theModel.addAttribute("message", themessage);
		
		theModel.addAttribute("conversation", theConversation);

		return "DM";    }
}
