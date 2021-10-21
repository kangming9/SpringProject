package kr.spring.support.dao;

import org.apache.ibatis.annotations.Select;

public interface SupportMapper {
	@Select("SELECT count(*) FROM support WHERE g_num = #{gnum}")
	public int selectGiftSupport(int gnum);
}
