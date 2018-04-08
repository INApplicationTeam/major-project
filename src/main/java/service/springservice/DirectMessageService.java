package service.springservice;


import java.util.HashMap;
import java.util.List;

import model.springmodel.Message;


public interface DirectMessageService {

	void sendDM(Message themessage);




	List<Message> showConversation(String receiverid, String senderid);




	HashMap<String, String> getMessageThreads(String id);

}
