package service.springservice;

import java.util.List;

import model.springmodel.ClassDiscussion;
import model.springmodel.ClassDiscussionComment;
import model.springmodel.ClassDiscussionReply;
import model.springmodel.CommentLikers;

public interface DiscussionService {
	
	int addDiscussion(ClassDiscussion cd);

	List<ClassDiscussion> showDiscussions(String classId,String userId);

	void postComment(ClassDiscussionComment cdc);

	void postCommentReply(ClassDiscussionReply reply);

	int likeComment(CommentLikers commentLikers);

	int unLikeComment(CommentLikers commentLikers);

}
