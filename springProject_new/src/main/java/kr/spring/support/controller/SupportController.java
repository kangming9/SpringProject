package kr.spring.support.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.delivery.vo.DeliveryVO;
import kr.spring.gift.service.GiftService;
import kr.spring.gift.vo.GiftVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.mypage.service.MypageService;
import kr.spring.project.service.ProjectService;
import kr.spring.project.vo.ProjectVO;
import kr.spring.support.service.SupportService;
import kr.spring.support.vo.SupportVO;

@Controller
public class SupportController {
	private static final Logger logger = LoggerFactory.getLogger(SupportController.class);
	
	@Autowired
	private SupportService supportService;
	@Autowired
	private GiftService giftService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private MypageService mypageService;
	@Autowired
	private ProjectService projectService;
	
	//자바빈(VO) 초기화
	@ModelAttribute
	public SupportVO initCommand() {
		return new SupportVO();
	}
	
	//후원하기
	@RequestMapping("/support/support.do")
	public ModelAndView process(@RequestParam(value = "optional", defaultValue = "")String optional, SupportVO supportVO, HttpSession session) {
		Integer user_num = (Integer)session.getAttribute("user_num");
		MemberVO memberVO = null;
		List<DeliveryVO> deliveryList = null;
		int deliveryCnt = 0;
		
		if(user_num==null) {
			logger.debug("<<후원하기>> : 로그인 필요");
		}else {
			supportVO.setM_num(user_num);
			memberVO = memberService.selectMember(user_num);
			
			deliveryCnt = mypageService.getdelCount(user_num);
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("start", 1);
			map.put("end", deliveryCnt);
			map.put("m_num", user_num);
			deliveryList = mypageService.delSelectList(map);
		}
		
		GiftVO giftVO = giftService.selectGift(supportVO.getG_num());
		int p_num = giftVO.getP_num();
		
		supportVO.setNum(supportService.selectNum());
		supportVO.setP_num(p_num);
		supportVO.setSupport_amount(giftVO.getPrice()+supportVO.getDonation());
		supportVO.setGift_option(optional);
		
		List<GiftVO> giftList = giftService.selectList(p_num);
		List<GiftVO> comList = giftService.selectComList(p_num);
		
		logger.debug("<<후원하기-선택선물>> : " + giftVO);
		logger.debug("<<후원하기-후원정보>> : " + supportVO);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("member", memberVO);
		mav.addObject("deliveryCnt", deliveryCnt);
		mav.addObject("deliveryList", deliveryList);
		mav.addObject("gift", giftVO);
		mav.addObject("giftList", giftList);
		mav.addObject("comList", comList);
		mav.addObject("support", supportVO);
		mav.setViewName("supportView");
		
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/support/insertSupport.do")
	public Map<String, String> insertSupport(SupportVO supportVO, HttpSession session){
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		Map<String, String> map = new HashMap<String, String>();
		
		if(user_num==null) {
			logger.debug("<<후원 insert>> : 로그인 필요");
			
			map.put("result", "logout");
		}else {
			
			supportVO.setM_num(user_num);
			
			if(supportVO.getGift_option() == null) {
				supportVO.setGift_option("");
			}
			
			if(supportVO.getD_num() == 0) {
				supportVO.setD_num(-1);
			}
			
			supportService.insertSupport(supportVO);
			map.put("result", "success");
			
			logger.debug("<<후원완료>> :" + supportVO);
		}
		
		return map;
	}
	
	@RequestMapping("/support/result.do")
	public ModelAndView submit(SupportVO supportVO, HttpSession session) {
		Integer user_num = (Integer)session.getAttribute("user_num");
		ProjectVO project = null; 
		int supporter = 0;
		if(user_num==null) {
			logger.debug("<<후원완료>> : 로그인 필요");
		}else {
			project = projectService.selectProject(supportVO.getP_num());
			supporter = projectService.selectProjectSupporter(supportVO.getP_num());
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("project", project);
		mav.addObject("supporter", supporter);
		mav.setViewName("supportResult");
		
		return mav;
	}

}
