package controller.springcontroller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

import model.springmodel.CalenderEvents;
import model.springmodel.Events;
import service.springservice.EventService;

@Controller
@RequestMapping("/event")
public class EventController {

	@Autowired
	private EventService eventservice;
	
	@GetMapping("/ShowGlobalEventOfDay")
	public String showGlobalEventOfDay(@RequestParam("id")String id,Model theModel)
	{
		StringTokenizer tokens=new StringTokenizer(id,",");
		ArrayList<Integer> idList=new ArrayList<>();
		
		while(tokens.hasMoreTokens())
		{
			idList.add(Integer.parseInt(tokens.nextToken()));
		}	
		
		List<Events> eventlist = eventservice.showEventsOfDay(idList);
		theModel.addAttribute("eventlist", eventlist);
		
		return "globalevents";
	}
	
	@GetMapping("/showGlobalEventOnCalender")
	public void show(@RequestParam("year") Integer year, @RequestParam("month") Integer month,
			HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();

		ArrayList<CalenderEvents> events = eventservice.eventsForCalender(year, month, "global",null);
		String eventJSON = new Gson().toJson(events);
		System.out.println(eventJSON);
		try {
			response.getWriter().println(eventJSON);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
}
