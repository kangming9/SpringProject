package kr.spring.notice.controller;

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

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.notice.service.NoticeService;
import kr.spring.notice.vo.NoticeVO;
import kr.spring.project.service.ProjectService;
import kr.spring.project.vo.ProjectVO;
import kr.spring.util.PagingUtil;

@Controller
public class NoticeController {
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	private int rowCount = 10;
	private int pageCount = 10;
	
	@Autowired
	private NoticeService noticeService;
	@Autowired
	private ProjectService projectService;
	@Autowired
	private MemberService memberService;
	
	//자바빈 초기화
	@ModelAttribute
	public NoticeVO initCommand() {
		return new NoticeVO();
	}
	
	//공지 폼 호출
	@GetMapping("/notice/register.do")
	public String form(@RequestParam(value="p_num",defaultValue="0") int p_num, HttpServletRequest request) {
		logger.debug("<<공지하기 p_num >> : " + p_num);
		
		request.setAttribute("p_num", p_num);
		
		return "noticeRegister";//타일스 식별자
	}
	
	//공지 등록 - 전송된 데이터 처리
	@PostMapping("/notice/register.do")
	public String submit(@Valid NoticeVO noticeVO, BindingResult result, HttpSession session, HttpServletRequest request) {
		
		logger.debug("<< 공지 등록 >> : " + noticeVO);
		logger.debug("<< 프로젝트 넘버 >> : " + noticeVO.getP_num());
		logger.debug("<< 제목 >> : " + noticeVO.getTitle());
		
		if(result.hasErrors()) {
			return form(noticeVO.getP_num(),request);
		}
		
		//회원번호 세팅
		noticeVO.setM_num((Integer)session.getAttribute("user_num"));
		noticeService.insertNotice(noticeVO);
		
		return "redirect:/notice/list.do?p_num="+noticeVO.getP_num();
	}
	
	//공지 목록
	@RequestMapping("/notice/list.do")
	public ModelAndView process(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
								@RequestParam(value="keyfield",defaultValue="") String keyfield,
								@RequestParam(value="keyword",defaultValue="") String keyword, 
								@RequestParam(value="p_num",defaultValue="0") int p_num) {
		
		logger.debug("<<공지목록>> : " + p_num);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("p_num", p_num);
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		int count = noticeService.selectRowCount(map);
		
		logger.debug("<<count>> : " + count);
		
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,rowCount,pageCount,"list.do","&p_num="+p_num);
		
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		
		List<NoticeVO> list = null;
		if(count > 0) {
			list = noticeService.selectList(map);
		}
		
		ProjectVO project = projectService.selectProject(p_num);
		MemberVO creator =  memberService.selectMember(project.getM_num());
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("noticeList"); // 타일스 식별자
		mav.addObject("p_num", p_num);
		mav.addObject("project", project);
		mav.addObject("creator", creator);
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("pagingHtml", page.getPagingHtml());
		
		return mav;
	}
	
	//notice 디테일
	@RequestMapping("/notice/detail.do")
	public ModelAndView process(@RequestParam int num) {
		
		NoticeVO notice = noticeService.selectNotice(num);
		MemberVO creator =  memberService.selectMember(notice.getM_num());
		
		logger.debug("<< 제목 >> : " + notice.getTitle());
		
		notice.setTitle(notice.getTitle());
		notice.setContent(notice.getContent());
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("noticeView");
		mav.addObject("notice", notice);
		mav.addObject("creator", creator);
		
		return mav;
	}
	
	//공지 수정 - 폼 호출
	@GetMapping("/notice/modify.do")
	public ModelAndView formUpdate(@RequestParam int num, Model model, HttpServletRequest request) {
		NoticeVO noticeVO = noticeService.selectNotice(num);
		
		logger.debug("<< 공지 수정 폼 호출 >> : " + noticeVO);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("noticeModify");
		mav.addObject("noticeVO", noticeVO);
		
		return mav;
	}
	
	//공지 수정 - 전송된 데이터 처리
	@PostMapping("/notice/modify.do")
	public String submitUpdate(@Valid NoticeVO noticeVO, BindingResult result,HttpServletRequest request,Model model) {
		
		logger.debug("<< 공지 수정 >> : " + noticeVO);
		
		if(result.hasErrors()) {
			return "noticeModify";
		}
		
		noticeService.modifyNotice(noticeVO);
		
		return "redirect:/notice/detail.do?num="+noticeVO.getNum();
	}
	
	//공지 삭제
	@RequestMapping("/notice/delete.do")
	public String submitDelete(@RequestParam int num) {
		NoticeVO noticeVO = noticeService.selectNotice(num);
		
		logger.debug("<<공지 삭제>> : " + num);
		
		noticeService.deleteNotice(num);
		
		
		return "redirect:/notice/list.do?p_num="+noticeVO.getP_num();
	}	
	
}
