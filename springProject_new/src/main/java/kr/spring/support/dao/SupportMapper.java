package kr.spring.support.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import kr.spring.support.vo.SupportVO;
import kr.spring.support.vo.SupporterVO;

public interface SupportMapper {
	@Select("SELECT count(*) FROM support WHERE g_num = #{gnum}")
	public int selectGiftSupport(int gnum);
	@Select("SELECT rownum as num, d.nickname, g.name, g.price, s.donation, s.support_amount, s.payment_date FROM support s JOIN gift g ON s.p_num = g.p_num and s.g_num = g.num JOIN member_detail d ON s.m_num = d.m_num WHERE s.p_num = #{pnum}")
	public List<SupporterVO> selectSupporterList(int pnum);
	@Insert("INSERT INTO support (num,m_num,p_num,g_num,support_amount,gift_option,donation) VALUES (support_seq.nextval,#{m_num},#{p_num},#{g_num},#{support_amount},#{gift_option},#{donation})")
	public void insertSupport(SupportVO supportVO);
	@Select("SELECT count(m_num) as m_num, sum(support_amount) as support_amount, sum(donation) as donation FROM support WHERE p_num = #{pnum}")
	public SupportVO selectSupportSum(int pnum);
	@Select("SELECT name, sum(support_amount) as support_amount FROM (SELECT * FROM SUPPORT s JOIN gift g ON s.g_num = g.num) GROUP BY name")
	public List<SupporterVO> selectGiftMoney();
}
