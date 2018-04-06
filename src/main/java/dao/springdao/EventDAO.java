package dao.springdao;

import java.util.List;

import model.springmodel.Events;

public interface EventDAO {

	int addEvent(Events theEvents);

	List<Events> showEvents(String classid);

}
