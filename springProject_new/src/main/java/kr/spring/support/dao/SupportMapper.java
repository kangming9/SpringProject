package kr.spring.support.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import kr.spring.support.vo.SupporterVO;

public interface SupportMapper {
	@Select("SELECT count(*) FROM support WHERE g_num = #{gnum}")
	public int selectGiftSupport(int gnum);
	@Select("SELECT rownum as num, d.nickname, g.name, g.price, s.donation, s.support_amount, s.payment_date FROM support s JOIN gift g ON s.p_num = g.p_num and s.g_num = g.num JOIN member_detail d ON s.m_num = d.m_num WHERE s.p_num = #{pnum}")
	public List<SupporterVO> selectSupporterList(int pnum);
}
