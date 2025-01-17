package kr.spring.gift.service;

import java.util.List;
import java.util.Map;

import kr.spring.gift.vo.GiftVO;

public interface GiftService {
	public List<GiftVO> selectList(Integer p_num);
	public int selectRowCount(int p_num);
	public List<GiftVO> selectComList(int num);
	public List<GiftVO> selectGcomList(int num);
	public GiftVO selectGift(int num);
	
	public int selectNum();
	public int selectDNum();
	public void addGift(GiftVO gift);
	public int selectGNum(String gname, int pnum);
	public void addDetail(GiftVO gift);
	
	public void deleteDetail(int pnum, String name);
	public void deleteGift(int pnum);
	
	public List<GiftVO> selectGiftDetail(Map<String, Object> map);
}
