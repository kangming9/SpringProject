package kr.spring.question.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.spring.question.vo.QuestionVO;

public interface QuestionService {
	public List<QuestionVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertQuestion(QuestionVO question);
	public QuestionVO selectQuestion(Integer num);
	public void modifyQuestion(QuestionVO question);
	public void deleteQuestion(Integer num);
}
