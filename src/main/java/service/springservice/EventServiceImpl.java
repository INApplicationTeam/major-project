package service.springservice;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder.In;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.springdao.EventDAO;
import model.springmodel.CalenderEvents;
import model.springmodel.Events;

@Service
public class EventServiceImpl implements EventService {
	
	@Autowired
	private EventDAO eventDAO;
	
	@Override
	@Transactional
	public int addEvent(Events theEvents) {
		
		return eventDAO.addEvent(theEvents);
	}
	
	@Override
	@Transactional
	public List<Events> showEvents(String classid) {
		return eventDAO.showEvents(classid);
    }

	@Override
	@Transactional
	public ArrayList<CalenderEvents> eventsForCalender(Integer year, Integer month,String scope, String classId) {
		return eventDAO.eventsForCalender(year,month,scope,classId);
	}

	@Override
	@Transactional
	public List<Events> showEventsOfDay(ArrayList<Integer> idList) {
		return eventDAO.showEventsOfDay(idList);
	}
	
	

	
}
