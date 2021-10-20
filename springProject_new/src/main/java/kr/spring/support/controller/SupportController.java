package kr.spring.support.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.support.service.SupportService;
import kr.spring.support.vo.SupportVO;

@Controller
public class SupportController {
	private static final Logger logger = LoggerFactory.getLogger(SupportController.class);
	
	@Autowired
	private SupportService supportService;
	
	//자바빈(VO) 초기화
	@ModelAttribute
	public SupportVO initCommand() {
		return new SupportVO();
	}
	
	//후원하기
	@RequestMapping("/support/support.do")
	public ModelAndView process() {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("supportView");
		
		return mav;
	}
	
}
