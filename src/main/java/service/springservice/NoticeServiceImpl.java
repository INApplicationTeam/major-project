package service.springservice;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.springdao.NoticeDAO;
import model.springmodel.Notice;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDAO noticeDAO;

	@Override
	@Transactional
	public int saveNotice(Notice notice) {
		return noticeDAO.saveNotice(notice);
	}

	@Override
	@Transactional
	public List<Notice> getClassNotices(String classId) {
		return noticeDAO.getClassNotices(classId);
	}

	@Override
	@Transactional
	public Notice showNotice(Integer nid) {
		return noticeDAO.showNotice(nid);
	}
	
	
	
}
