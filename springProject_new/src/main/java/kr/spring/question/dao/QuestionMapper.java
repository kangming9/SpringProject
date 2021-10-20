package kr.spring.question.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.question.vo.QuestionVO;

public interface QuestionMapper {
	public List<QuestionVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	@Insert("INSERT INTO question (num,m_num,title,content,password,question_date) VALUES (question_seq.nextval,#{m_num},#{title},#{content},#{password, jdbcType=VARCHAR},SYSDATE)")
	public void insertQuestion(QuestionVO question);
	@Select("SELECT * FROM question q JOIN member m ON q.m_num=m.num WHERE q.num=#{num}")
	public QuestionVO selectQuestion(Integer num);
	@Update("UPDATE question q SET title=#{title},content=#{content} WHERE q.num=#{num} ")
	public void modifyQuestion(QuestionVO question);
	@Delete("DELETE FROM question WHERE num=#{num}")
	public void deleteQuestion(Integer num);
}
