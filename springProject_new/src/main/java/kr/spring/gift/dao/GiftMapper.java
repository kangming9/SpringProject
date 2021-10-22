package kr.spring.gift.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
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
	@Select("SELECT d.num, g.name, d.name as gd_name, d.count as gd_count FROM gift_detail d JOIN gift g ON g.num=d.g_num WHERE g.num = #{num}")
	public List<GiftVO> selectGcomList(int num);
	@Select("SELECT * FROM gift WHERE num=#{num}")
	public GiftVO selectGift(int num);
	@Delete("DELETE FROM gift_detail WHERE gift_detail.g_num = (SELECT num FROM gift WHERE p_num = #{pnum} AND name = #{name})")
	public void deleteDetail(@Param("pnum") int pnum, @Param("name") String name);
	@Delete("DELETE FROM gift WHERE p_num = #{pnum}")
	public void deleteGift(int pnum);
	
	@Select("SELECT gift_seq.nextval FROM dual")
	public int selectNum();
	@Select("SELECT gift_detail_seq.nextval FROM dual")
	public int selectDNum();
	@Insert("INSERT INTO gift (num, p_num, name, price, due_ship, num_component, optional) VALUES (#{num}, #{p_num}, #{name}, #{price}, #{due_ship}, #{num_component}, #{optional})")
	public void addGift(GiftVO gift);
	@Select("SELECT num FROM gift WHERE name=#{name} AND p_num=#{p_num} ")
	public int selectGNum(@Param("name") String gname, @Param("p_num") int pnum); //parameter가 2개 이상이라 @param 추가
	@Insert("INSERT INTO gift_detail (num, g_num, name, count) VALUES (#{gd_num}, #{num}, #{gd_name}, #{gd_count})")
	public void addDetail(GiftVO gift);
	
	@Select("SELECT num, g_num as gd_num, name, count as gd_count FROM gift_detail WHERE g_num=#{gd_num}")
	public List<GiftVO> selectGiftDetail(Map<String, Object> map);
}
