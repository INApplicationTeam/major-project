package dao.springdao;

import java.util.HashMap;
import java.util.List;
import java.util.TreeMap;

import model.UserModel;
import model.springmodel.Message;

public interface DirectMessageDAO {

	void sendDM(Message themessage);


	List<Message> showConversation(String receiverid, String senderid);


	TreeMap<String, String> getMessageThreads(String id);


	List<UserModel> searchThreadName(String name);

}
