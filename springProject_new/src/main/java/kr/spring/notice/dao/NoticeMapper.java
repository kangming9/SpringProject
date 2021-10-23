package kr.spring.notice.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.notice.vo.NoticeVO;

public interface NoticeMapper {
	public List<NoticeVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	@Insert("INSERT INTO notice (num,m_num,p_num,title,content) VALUES (notice_seq.nextval,#{m_num},#{p_num},#{title},#{content})")
	public void insertNotice(NoticeVO notice);
	@Select("SELECT * FROM notice n JOIN member_detail d ON n.m_num=d.m_num WHERE n.num=#{num}")
	public NoticeVO selectNotice(Integer num);
	@Update("UPDATE notice SET title=#{title},content=#{content},mod_date=sysdate WHERE num=#{num} ")
	public void modifyNotice(NoticeVO notice);
	@Delete("DELETE FROM notice WHERE num=#{num}")
	public void deleteNotice(Integer num);
}
