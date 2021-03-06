package service.springservice;

import java.util.ArrayList;
import java.util.List;

import model.springmodel.CalenderEvents;
import model.springmodel.Events;

public interface EventService {

	int addEvent(Events theEvents);

	List<Events> showEvents(String classid);

	ArrayList<CalenderEvents> eventsForCalender(Integer year, Integer month,String scope,String classId);

	List<Events> showEventsOfDay(ArrayList<Integer> idList);

}
