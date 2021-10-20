package kr.spring.question.controller;

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
import org.springframework.web.servlet.ModelAndView;

import kr.spring.question.service.QuestionService;
import kr.spring.question.vo.QuestionVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;

@Controller
public class QuestionController {
	private static final Logger logger = LoggerFactory.getLogger(QuestionController.class);
	private int rowCount = 20;
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
		
		if(result.hasErrors()) {
			return form();
		}
		
		//회원번호 세팅
		questionVO.setNum((Integer)session.getAttribute("user_num"));
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
		
		//HTML 태그 불허
		question.setTitle(StringUtil.useNoHtml(question.getTitle()));
		//html 태그 불허 줄바꿈 허용
		//question.setContent(StringUtil.useBrNoHtml(question.getContent()));
		
		
		return new ModelAndView("questionView","question",question);
	}
	
	//글 수정 - 폼 호출
	@GetMapping("/question/modify.do")
	public String formUpdate(@RequestParam int num,Model model) {
		QuestionVO questionVO = questionService.selectQuestion(num);
		
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
		
		return "questionList"; 
	}
	
	//질문 삭제
	@RequestMapping("/question/delete.do")
	public String submitDelete(@RequestParam int num) {
		
		logger.debug("<<질문 삭제>> : " + num);
		
		questionService.deleteQuestion(num);
		
		
		return "redirect:/question/list.do";
	}
}