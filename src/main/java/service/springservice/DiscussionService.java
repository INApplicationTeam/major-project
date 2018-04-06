package service.springservice;

import java.util.List;

import model.springmodel.ClassDiscussion;
import model.springmodel.ClassDiscussionComment;
import model.springmodel.ClassDiscussionReply;

public interface DiscussionService {
	
	int addDiscussion(ClassDiscussion cd);

	List<ClassDiscussion> showDiscussions(String classId);

	void postComment(ClassDiscussionComment cdc);

	void postCommentReply(ClassDiscussionReply reply);

}
