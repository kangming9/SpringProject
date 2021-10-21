package kr.spring.support.service;

import java.util.List;

import kr.spring.support.vo.SupporterVO;

public interface SupportService {
	public int selectGiftSupport(int gnum);
	public List<SupporterVO> selectSupporterList(int pnum);
}
