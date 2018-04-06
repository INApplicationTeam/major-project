package service.springservice;

import java.util.List;

import model.springmodel.PollQueDetails;

public interface PollService {

	List<PollQueDetails> showPoll(String classid);

}
