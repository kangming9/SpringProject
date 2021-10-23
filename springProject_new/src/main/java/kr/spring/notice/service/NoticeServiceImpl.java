package kr.spring.notice.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.notice.dao.NoticeMapper;
import kr.spring.notice.vo.NoticeVO;

@Service
@Transactional
public class NoticeServiceImpl implements NoticeService{

	@Autowired
	private NoticeMapper noticeMapper;

	@Override
	public List<NoticeVO> selectList(Map<String, Object> map) {
		return noticeMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return noticeMapper.selectRowCount(map);
	}

	@Override
	public void insertNotice(NoticeVO notice) {
		noticeMapper.insertNotice(notice);
		
	}

	@Override
	public NoticeVO selectNotice(Integer num) {
		return noticeMapper.selectNotice(num);
	}

	@Override
	public void modifyNotice(NoticeVO notice) {
		noticeMapper.modifyNotice(notice);
		
	}

	@Override
	public void deleteNotice(Integer num) {
		noticeMapper.deleteNotice(num);;
		
	}
}
