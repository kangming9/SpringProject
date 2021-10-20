package kr.spring.question.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.question.dao.QuestionMapper;
import kr.spring.question.vo.QuestionVO;

@Service
@Transactional
public class QuestionServiceImpl implements QuestionService{

	@Autowired
	private QuestionMapper questionMapper;
	
	@Override
	public List<QuestionVO> selectList(Map<String, Object> map) {
		return questionMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return questionMapper.selectRowCount(map);
	}

	@Override
	public void insertQuestion(QuestionVO question) {
		questionMapper.insertQuestion(question);
	}

	@Override
	public QuestionVO selectQuestion(Integer num) {
		return questionMapper.selectQuestion(num);
	}

	@Override
	public void modifyQuestion(QuestionVO question) {
		questionMapper.modifyQuestion(question);
		
	}

	@Override
	public void deleteQuestion(Integer num) {
		questionMapper.deleteQuestion(num);
		
	}

}
