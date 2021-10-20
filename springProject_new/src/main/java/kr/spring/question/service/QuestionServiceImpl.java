package kr.spring.question.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.question.dao.QuestionMapper;
import kr.spring.question.vo.AnswerVO;
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
		questionMapper.deleteAnswerByQuestionNum(num);
		questionMapper.deleteQuestion(num);
		
	}

	@Override
	public List<AnswerVO> selectListAnswer(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return questionMapper.selectListAnswer(map);
	}

	@Override
	public int selectRowCountAnswer(Map<String, Object> map) {
		return questionMapper.selectRowCountAnswer(map);
	}

	@Override
	public void insertAnswer(AnswerVO answer) {
		questionMapper.insertAnswer(answer);
	}

	@Override
	public void updateAnswer(AnswerVO answer) {
		questionMapper.updateAnswer(answer);
	}

	@Override
	public void deleteAnswer(Integer num) {
		questionMapper.deleteAnswer(num);
		
	}

	@Override
	public String selectProjectTitle(Integer p_num) {
		// TODO Auto-generated method stub
		return questionMapper.selectProjectTitle(p_num);
	}

}
