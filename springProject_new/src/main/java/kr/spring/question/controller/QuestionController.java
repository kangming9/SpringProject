package kr.spring.question.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.question.service.QuestionService;
import kr.spring.question.vo.AnswerVO;
import kr.spring.question.vo.QuestionVO;
import kr.spring.util.PagingUtil;

@Controller
public class QuestionController {
	private static final Logger logger = LoggerFactory.getLogger(QuestionController.class);
	private int rowCount = 10;
	private int pageCount = 10;
	
	@Autowired
	private QuestionService questionService;
	
	//자바빈 초기화
	@ModelAttribute
	public QuestionVO initCommand() {
		return new QuestionVO();
	}
	
	//질문 폼 호출
	@GetMapping("/question/register.do")
	public String form() {
		
		
		return "questionRegister";//타일스 식별자
	}
	
	//질문 등록 - 전송된 데이터 처리
	@PostMapping("/question/register.do")
	public String submit(@Valid QuestionVO questionVO, BindingResult result,HttpSession session,HttpServletRequest request) {
		
		logger.debug("<< 질문 등록 >> : " + questionVO);
		logger.debug("<< 프로젝트 넘버 >> : " + questionVO.getP_num());
		logger.debug("<< 제목 >> : " + questionVO.getTitle());
		
		if(result.hasErrors()) {
			return form();
		}
		
		if(questionVO.getP_num() == 0) {
			questionVO.setP_num(-1);
		}
		
		
		//회원번호 세팅
		questionVO.setM_num((Integer)session.getAttribute("user_num"));
		questionService.insertQuestion(questionVO);
		
		return "redirect:/question/list.do";
	}
	
	
	//게시판 목록
	@RequestMapping("/question/list.do")
	public ModelAndView process(@RequestParam(value="pageNum",defaultValue="1") int currentPage,@RequestParam(value="keyfield",defaultValue="") String keyfield,@RequestParam(value="keyword",defaultValue="") String keyword ) {
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		int count = questionService.selectRowCount(map);
		
		logger.debug("<<count>> : " + count);
		
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,rowCount,pageCount,"list.do");
		
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		
		List<QuestionVO> list = null;
		if(count > 0) {
			list = questionService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("questionList"); // 타일스 식별자
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("pagingHtml", page.getPagingHtml());
		
		return mav;
	}
	
	//question 디테일
	@RequestMapping("/question/detail.do")
	public ModelAndView process(@RequestParam int num) {
		
		QuestionVO question = questionService.selectQuestion(num);
		
		logger.debug("<< 제목 >> : " + question.getTitle());
		
		question.setTitle(question.getTitle());
		question.setContent(question.getContent());
		
		if(question.getPassword()!=null) {
			
		}
		
		
		return new ModelAndView("questionView","question",question);
	}
	
	//글 수정 - 폼 호출
	@GetMapping("/question/modify.do")
	public String formUpdate(@RequestParam int num,Model model, HttpServletRequest request) {
		QuestionVO questionVO = questionService.selectQuestion(num);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("q_num", num);
		
		int count = questionService.selectRowCountAnswer(map);
		
		if(count > 0) {
			
			model.addAttribute("check", "question");
			model.addAttribute("message", "이미 댓글이 달린 글은 수정할 수 없습니다.");
			model.addAttribute("url", request.getContextPath()+"/question/list.do");
			
			return "common/resultView";
		}
		
		
		model.addAttribute("questionVO",questionVO);
		
		return "questionModify";
	}
	
	//질문 수정 - 전송된 데이터 처리
	@PostMapping("/question/modify.do")
	public String submitUpdate(@Valid QuestionVO questionVO, BindingResult result,HttpServletRequest request,Model model) {
		
		logger.debug("<< 질문 수정 >> : " + questionVO);
		
		if(result.hasErrors()) {
			return "questionModify";
		}
		
		questionService.modifyQuestion(questionVO);
		
		return "redirect:/question/list.do"; 
	}
	
	//질문 삭제
	@RequestMapping("/question/delete.do")
	public String submitDelete(@RequestParam int num) {
		
		logger.debug("<<질문 삭제>> : " + num);
		
		questionService.deleteQuestion(num);
		
		
		return "redirect:/question/list.do";
	}
	
	//댓글 등록(ajax)
	@RequestMapping("/question/writeAnswer.do")
	@ResponseBody
	public Map<String,String> writeAnswer (AnswerVO answerVO, HttpSession session, HttpServletRequest request){
		
		logger.debug("<<댓글 등록>> : " + answerVO);
		Map<String,String> map = new HashMap<String,String>();
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			map.put("result", "logout");
		}else {
			questionService.insertAnswer(answerVO);
			map.put("result", "success");
		}
		
		return map;
	}
		
		//댓글 목록(ajax)
		@RequestMapping("/question/listAnswer.do")
		@ResponseBody
		public Map<String,Object> getList(@RequestParam(value="pageNum",defaultValue="1") int currentPage,@RequestParam int q_num){
			
			logger.debug("<<currentPage>> : " + currentPage);
			logger.debug("<<q_num>> : " + q_num);
			
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("q_num", q_num);
			
			int count = questionService.selectRowCountAnswer(map);
			logger.debug("============ 댓글" + count);
			
			PagingUtil page = new PagingUtil(currentPage, count, rowCount, pageCount, null);
			
			map.put("start", page.getStartCount());
			map.put("end", page.getEndCount());
			
			List<AnswerVO> list = null;
			if(count > 0) {
				list = questionService.selectListAnswer(map);
			}else {
				list = Collections.emptyList();
			}
			
			logger.debug("============ 댓글" + list.toString());
			
			Map<String,Object> mapJson = new HashMap<String,Object>();
			mapJson.put("count", count);
			mapJson.put("rowCount", rowCount);
			mapJson.put("list", list);
			
			return mapJson;
		}
		

		//댓글 삭제
		@RequestMapping("/question/deleteAnswer.do")
		@ResponseBody
		public Map<String,String> deleteReply(@RequestParam int a_num,
				                              @RequestParam int m_num,
				                              HttpSession session){
			
			logger.debug("<<a_num>> : " + a_num);
			logger.debug("<<m_num>> : " + m_num);
			
			Map<String,String> map = new HashMap<String,String>();
			
			Integer user_num = (Integer)session.getAttribute("user_num");
			if(user_num == null) {
				//로그인이 되어있지 않음
				map.put("result", "logout");
			}else if(user_num != null && user_num==m_num) {
				//로그인이 되어 있고 로그인한 아이디와 작성자 아이디가 일치
				questionService.deleteAnswer(a_num);
				map.put("result", "success");
			}else {
				//로그인 아이디와 작성자 아이디 불일치
				map.put("result", "wrongAccess");
			}
			return map;
		}
		
		//댓글 수정
		@RequestMapping("/question/updateAnswer.do")
		@ResponseBody
		public Map<String,String> modifyReply(AnswerVO answerVO,
				                              HttpSession session,
				                              HttpServletRequest request){
			logger.debug("<<댓글 수정>> : " + answerVO);
			
			Map<String,String> map = new HashMap<String,String>();
			
			Integer user_num = (Integer)session.getAttribute("user_num");
			if(user_num==null) {
				//로그인이 안 된 경우
				map.put("result", "logout");
			}else if(user_num!=null && user_num == answerVO.getM_num()) {
				//로그인 회원 번호와 작성자 회원 번호 일치
				
				//댓글 수정
				questionService.updateAnswer(answerVO);
				map.put("result", "success");
			}else {
				//로그인 회원 번호와 작성자 회원 번호 불일치
				map.put("result", "wrongAccess");
			}
			
			return map;
		}
	
}