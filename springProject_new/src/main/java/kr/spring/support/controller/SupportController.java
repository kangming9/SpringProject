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
import org.springframework.web.servlet.ModelAndView;

import kr.spring.delivery.vo.DeliveryVO;
import kr.spring.gift.service.GiftService;
import kr.spring.gift.vo.GiftVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.mypage.service.MypageService;
import kr.spring.support.service.SupportService;
import kr.spring.support.vo.SupportVO;
import kr.spring.util.PagingUtil;

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
	
	//자바빈(VO) 초기화
	@ModelAttribute
	public SupportVO initCommand() {
		return new SupportVO();
	}
	
	//후원하기
	@RequestMapping("/support/support.do")
	public ModelAndView process(SupportVO supportVO, HttpSession session) {
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
		supportVO.setP_num(giftVO.getP_num());
		supportVO.setSupport_amount(giftVO.getPrice()+supportVO.getDonation());
		
		logger.debug("<<후원하기-선택선물>> : " + giftVO);
		logger.debug("<<후원하기-후원정보>> : " + supportVO);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("member", memberVO);
		mav.addObject("deliveryCnt", deliveryCnt);
		mav.addObject("deliveryList", deliveryList);
		mav.addObject("gift", giftVO);
		mav.addObject("support", supportVO);
		mav.setViewName("supportView");
		
		return mav;
	}
	
}
