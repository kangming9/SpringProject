package kr.spring.support.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.support.dao.SupportMapper;
import kr.spring.support.vo.SupporterVO;

@Service
@Transactional
public class SupportServiceImpl implements SupportService{

	@Autowired
	private SupportMapper supportMapper;

	@Override
	public int selectGiftSupport(int gnum) {
		return supportMapper.selectGiftSupport(gnum);
	}

	@Override
	public List<SupporterVO> selectSupporterList(int pnum) {
		return supportMapper.selectSupporterList(pnum);
	}
	
	

}
