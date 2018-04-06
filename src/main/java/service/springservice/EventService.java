package service.springservice;

import java.util.List;

import model.springmodel.Events;

public interface EventService {

	int addEvent(Events theEvents);

	List<Events> showEvents(String classid);

}
