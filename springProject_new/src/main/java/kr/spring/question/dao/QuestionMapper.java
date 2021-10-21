package kr.spring.question.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.question.vo.AnswerVO;
import kr.spring.question.vo.QuestionVO;

public interface QuestionMapper {
	public List<QuestionVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	
	@Insert("INSERT INTO question (num,m_num,p_num,title,content,password,question_date) VALUES (question_seq.nextval,#{m_num},#{p_num},#{title},#{content},#{password, jdbcType=VARCHAR},SYSDATE)")
	public void insertQuestion(QuestionVO question);
	
	@Select("SELECT * FROM question q JOIN member m ON q.m_num=m.num WHERE q.num=#{num}")
	public QuestionVO selectQuestion(Integer num);
	
	@Update("UPDATE question q SET title=#{title},content=#{content} WHERE q.num=#{num} ")
	public void modifyQuestion(QuestionVO question);
	
	@Delete("DELETE FROM question WHERE num=#{num}")
	public void deleteQuestion(Integer num);
	
	@Select("SELECT name FROM project WHERE p_num=#{p_num}")
	public String selectProjectTitle(Integer p_num);
	
	
	//answer
	public List<AnswerVO> selectListAnswer(Map<String,Object> map);
	public int selectRowCountAnswer(Map<String,Object> map);
	@Insert("INSERT INTO answer (num,content,q_num,m_num) VALUES (answer_seq.nextval,#{content},#{q_num},#{m_num})")
	public void insertAnswer(AnswerVO answer);
	@Update("UPDATE answer SET content=#{content} WHERE num=#{num}")
	public void updateAnswer(AnswerVO answer);
	@Delete("DELETE FROM answer WHERE num=#{num}")
	public void deleteAnswer(Integer a_num);
	@Delete("DELETE FROM answer WHERE q_num=#{q_num}")
	public void deleteAnswerByQuestionNum(Integer q_num);

	
}
