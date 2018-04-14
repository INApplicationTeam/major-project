package service.springservice;

import java.util.HashMap;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.springdao.DirectMessageDAO;
import model.UserModel;
import model.springmodel.Message;
@Service
public class DirectMessageServiceImpl implements DirectMessageService {

	@Autowired
	private DirectMessageDAO dmDAO;
	
	
	
	@Override
	@Transactional
	public void sendDM(Message themessage)
	{
	 dmDAO.sendDM(themessage);
		
	}



	@Override
	@Transactional
	public List<Message> showConversation(String receiverid, String senderid) {
		return dmDAO.showConversation(receiverid,senderid);
	}


	@Override
	@Transactional
	public HashMap<String, String> getMessageThreads(String id) {
		return dmDAO.getMessageThreads(id);
	}



	@Override
	@Transactional
	public List<UserModel> searchThreadName(String name) {
		return dmDAO.searchThreadName(name);
	}

}
