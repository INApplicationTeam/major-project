package dao.springdao;

import java.util.List;

import model.springmodel.Notice;

public interface NoticeDAO {

	int saveNotice(Notice notice);

	List<Notice> getClassNotices(String classId);

	Notice showNotice(Integer nid);

}