package kr.spring.notice.service;

import java.util.List;
import java.util.Map;

import kr.spring.notice.vo.NoticeVO;

public interface NoticeService {
	public List<NoticeVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertNotice(NoticeVO notice);
	public NoticeVO selectNotice(Integer num);
	public void modifyNotice(NoticeVO notice);
	public void deleteNotice(Integer num);
	
}
