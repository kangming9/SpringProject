package kr.spring.gift.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.gift.dao.GiftMapper;
import kr.spring.gift.vo.GiftVO;

@Service
@Transactional
public class GiftServiceImpl implements GiftService{

	@Autowired
	private GiftMapper giftMapper;

	@Override
	public List<GiftVO> selectList(Integer p_num) {
		return giftMapper.selectList(p_num);
	}

	@Override
	public int selectRowCount(int p_num) {
		return giftMapper.selectRowCount(p_num);
	}

	@Override
	public List<GiftVO> selectComList(int num) {
		return giftMapper.selectComList(num);
	}

	@Override
	public int selectNum() {
		return giftMapper.selectNum();
	}
	@Override
	public int selectDNum() {
		return giftMapper.selectDNum();
	}
	
	@Override
	public void addGift(GiftVO gift) {
		giftMapper.addGift(gift);
	}

	@Override
	public int selectGNum(String gname, int pnum) {
		return giftMapper.selectGNum(gname, pnum);
	}

	@Override
	public void addDetail(GiftVO gift) {
		giftMapper.addDetail(gift);
	}
	
	

}
