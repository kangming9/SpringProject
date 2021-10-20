package kr.spring.question.service;

import java.util.List;
import java.util.Map;


import kr.spring.question.vo.AnswerVO;
import kr.spring.question.vo.QuestionVO;

public interface QuestionService {
	public List<QuestionVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertQuestion(QuestionVO question);
	public QuestionVO selectQuestion(Integer num);
	public void modifyQuestion(QuestionVO question);
	public void deleteQuestion(Integer num);

	public String selectProjectTitle(Integer p_num);
	
	
	//answer
	public List<AnswerVO> selectListAnswer(Map<String,Object> map);
	public int selectRowCountAnswer(Map<String,Object> map);
	public void insertAnswer(AnswerVO answer);
	public void updateAnswer(AnswerVO answer);
	public void deleteAnswer(Integer num);
}
