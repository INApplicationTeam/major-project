package service.springservice;

import java.util.List;

import model.UserModel;
import model.springmodel.Notice;
import model.springmodel.NoticeViewers;

public interface NoticeService {

	int saveNotice(Notice notice);

	List<Notice> getClassNotices(String classId,String viewerId);

	Notice showNotice(Integer nid, String classId, String viewerId);

	void addViewer(NoticeViewers viewer);

	List<UserModel> showAllViewers(Integer noticeId);

}
