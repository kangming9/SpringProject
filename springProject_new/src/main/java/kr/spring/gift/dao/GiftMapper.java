package kr.spring.gift.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.gift.vo.GiftVO;

public interface GiftMapper {
	public List<GiftVO> selectList(int p_num);
	@Select("SELECT count(*) FROM gift WHERE p_num=#{p_num}")
	public int selectRowCount(int p_num);
	@Select("select g.num, p_num, d.name gd_name, d.count gd_count from gift g join gift_detail d on g.num=d.g_num where g.p_num=#{num} order by d.num")
	public List<GiftVO> selectComList(int num);
	@Select("SELECT * FROM gift WHERE num=#{num}")
	public GiftVO selectGift(int num);
	
	@Select("SELECT gift_seq.nextval FROM dual")
	public int selectNum();
	@Select("SELECT gift_detail_seq.nextval FROM dual")
	public int selectDNum();
	@Insert("INSERT INTO gift (num, p_num, name, price, due_ship, num_component) VALUES (#{num}, #{p_num}, #{name}, #{price}, #{due_ship}, #{num_component})")
	public void addGift(GiftVO gift);
	@Select("SELECT num FROM gift WHERE name=#{name} AND p_num=#{p_num} ")
	public int selectGNum(@Param("name") String gname, @Param("p_num") int pnum); //parameter가 2개 이상이라 @param 추가
	@Insert("INSERT INTO gift_detail (num, g_num, name, count) VALUES (#{gd_num}, #{num}, #{gd_name}, #{gd_count})")
	public void addDetail(GiftVO gift);
}
