package service.springservice;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.springdao.DiscussionDAO;
import model.springmodel.ClassDiscussion;
import model.springmodel.ClassDiscussionComment;
import model.springmodel.ClassDiscussionReply;
import model.springmodel.CommentLikers;

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
	public List<ClassDiscussion> showDiscussions(String classId,String userId) {
		return discussionDAO.showDiscussions(classId,userId);
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

	@Override
	@Transactional
	public int likeComment(CommentLikers commentLikers) {
		return discussionDAO.likeComment(commentLikers);
	}

	@Override
	@Transactional
	public int unLikeComment(CommentLikers commentLikers) {
		return discussionDAO.unLikeComment(commentLikers);
	}



}
