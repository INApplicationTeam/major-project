package service.springservice;

import java.util.List;

import model.springmodel.Notice;

public interface NoticeService {

	int saveNotice(Notice notice);

	List<Notice> getClassNotices(String classId,String viewerId);

	Notice showNotice(Integer nid);

}
