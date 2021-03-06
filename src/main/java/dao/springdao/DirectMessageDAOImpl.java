package dao.springdao;

import java.util.HashMap;
import java.util.List;
import java.util.TreeMap;

import javax.sound.midi.Soundbank;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.UserModel;
import model.springmodel.Coordinator;
import model.springmodel.Message;

@Repository
public class DirectMessageDAOImpl implements DirectMessageDAO {

	@Autowired
	private SessionFactory sessionFactory ;
	
	
	
	
	@Override
	public void sendDM(Message themessage) {
	Session currentSession=sessionFactory.getCurrentSession();
	currentSession.save(themessage);

	}




	



	@Override
	public List<Message> showConversation(String receiverid, String senderid) {
		Session currentSession= sessionFactory.getCurrentSession();
		Query<Message> qr= currentSession.createQuery("from Message where (receiverid =:r and senderid =:s ) or (receiverid =:s and senderid =:r ) order by timestamp ",Message.class);
		qr.setParameter("r", receiverid);
		qr.setParameter("s", senderid);
		
		List<Message> conversation  =qr.getResultList();

		return conversation;
	}







	@Override
	public TreeMap<String, String> getMessageThreads(String id) 
	{
		Session currentSession= sessionFactory.getCurrentSession();
		Query<Object[]> qr= currentSession.createQuery("select distinct sender.uid, sender.uname from Message where (receiverid =:id) order by timestamp ",Object[].class);
		Query<Object[]> qr1= currentSession.createQuery("select distinct receiver.uid, receiver.uname from Message where (senderid =:id) order by timestamp ",Object[].class);

		qr.setParameter("id", id);
		qr1.setParameter("id", id);
	
		List<Object[]> threads  =qr.getResultList();

		List<Object[]> threads1  =qr1.getResultList();
		threads.addAll(threads1);
		
		TreeMap<String, String> conversation = new TreeMap<>();	
		for(Object[] o: threads)
		{
			
				conversation.put(o[0].toString(),o[1].toString());
				
		}
		
			return conversation;
			
	}



	@Override
	public List<UserModel> searchThreadName(String name)
	{
		Session currentSession= sessionFactory.getCurrentSession();
		Query<UserModel> qr= currentSession.createQuery(" from UserModel where uname like :name",UserModel.class);
		
		qr.setParameter("name", name+"%");
		List<UserModel> threadNames  =qr.getResultList();
		
		
		
		return threadNames;
	}

}
