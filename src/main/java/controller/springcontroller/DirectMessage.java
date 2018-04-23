package controller.springcontroller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sound.midi.Soundbank;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import model.UserModel;
import model.springmodel.Message;
import model.springmodel.Question;
import notifier.ServerEndPoint;
import notifier.SessionId;
import service.springservice.DirectMessageService;

@Controller
@RequestMapping("/message")
public class DirectMessage 
{

	@Autowired
	private DirectMessageService dmservice;
		
	
	@PostMapping("/sendDM")
	public String sendDM(@ModelAttribute ("message") Message themessage, HttpServletRequest request,Model theModel,@RequestParam (name="id",required=false) String receiverid,@RequestParam (name="name",required=false) String receivername,RedirectAttributes redirectAttributes)
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
		
		System.out.println("rec=="+receivername);
		
        return "redirect:/major/message/inbox?id="+receiverid+"&name="+receivername 	;	
	}
	
	
	
	@GetMapping("/inbox")
	public String myMessages(HttpServletRequest request, Model theModel, @RequestParam (name="id",required=false) String receiverid,@RequestParam (name="name",required=false) String threadname)
	{
		HttpSession session=request.getSession();


		UserModel um= new UserModel();
		Object object=session.getAttribute("userModel");
		String senderid=um.getUserId(object);
		
		TreeMap<String, String> theThreads= dmservice.getMessageThreads(senderid);
		List<SessionId> allUsers=ServerEndPoint.users;
		SessionId isUser=null;
		ArrayList<Boolean> onlineUsers=new ArrayList<>();
		
		for(Map.Entry<String, String> entries : theThreads.entrySet())
		{
			isUser=new SessionId(null,entries.getKey());
			
			if(allUsers.contains(isUser))
			{
				onlineUsers.add(true);
				
			}
			
			else
			{
				onlineUsers.add(false);
			}
		}
		theModel.addAttribute("threads", theThreads);
		theModel.addAttribute("onlineUsers",onlineUsers);	
		//conversation
				
		if(receiverid!=null)
		{
			theModel.addAttribute("flag", true);
		}
		else
		{
			theModel.addAttribute("flag", false);

		}
		Message themessage= new Message(); 
		
		UserModel receiver= new UserModel();
		receiver.setUid(receiverid);
		receiver.setUname(threadname);
		themessage.setReceiver(receiver);
		List<Message> theConversation =dmservice.showConversation(receiverid, senderid);
		System.out.println(theConversation.toString());
		theModel.addAttribute("conversation", theConversation);
		theModel.addAttribute("message", themessage);
		theModel.addAttribute("userID", senderid);
		theModel.addAttribute("threadName", threadname);
		
		return "inbox";
		
	}
	
	@PostMapping("/searchThreadName")
	public void searchThreadName(@RequestParam("searchedname")String name,HttpServletResponse response)
	{
		System.out.println("name--------.-.-"+name);
		List<UserModel> theThreads= dmservice.searchThreadName(name);
		try {
			PrintWriter out= response.getWriter();
			for(UserModel um : theThreads)
//			out.println("<tr><td><a href='inbox?id="+um.getUid()+"'>"+um.getUname()+"</a></td></tr>");
			out.println("<a class='list-group-item list-group-item-action' id='list-home-list' data-toggle='list' href='inbox?id="+um.getUid()+"&name="+um.getUname()+"' role='tab' aria-controls='home' style='border-top: none;'> <img src='https://mdbootstrap.com/img/Photos/Avatars/img(31).jpg' class='img-fluid z-depth-1 rounded-circle avatar mr-2' alt='Responsive image'>"+um.getUname()+"</a>");

			/*String returnJson= new Gson().toJson(theThreads);
			response.getWriter().println(returnJson);*/
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
}
