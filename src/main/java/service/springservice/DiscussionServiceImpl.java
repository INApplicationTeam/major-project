package service.springservice;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.springdao.DiscussionDAO;
import model.springmodel.ClassDiscussion;
import model.springmodel.ClassDiscussionComment;
import model.springmodel.ClassDiscussionReply;

@Service
public class DiscussionServiceImpl implements DiscussionService{

	@Autowired
	private DiscussionDAO discussionDAO;
	
	@Override
	@Transactional
	public int addDiscussion(ClassDiscussion cd) {
		return discussionDAO.addDiscussion(cd);
		
	}
	
	@Override
	@Transactional
	public List<ClassDiscussion> showDiscussions(String classId) {
		return discussionDAO.showDiscussions(classId);
	}
	
	@Override
	@Transactional
	public void postComment(ClassDiscussionComment cdc) {
		discussionDAO.postComment(cdc);		
	}
	
	@Override
	@Transactional
	public void postCommentReply(ClassDiscussionReply reply) {
		discussionDAO.postCommentReply(reply);
	}



}
