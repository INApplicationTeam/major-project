package service.springservice;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.springdao.PollDAO;
import model.springmodel.PollQueDetails;

@Service
public class PollServiceImpl implements PollService {

	@Autowired
	private PollDAO pollDAO;
	
	@Override
	@Transactional
	public List<PollQueDetails> showPoll(String classid) {
		
		return pollDAO.showPoll(classid);
		
	}

}
