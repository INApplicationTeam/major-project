package dao.springdao;

import java.util.List;

import model.springmodel.PollQueDetails;

public interface PollDAO {

	List<PollQueDetails> showPoll(String classid, String uid);

}
