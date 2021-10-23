package kr.spring.guide.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class GuideController {

// return을 void로 설정하면 uri를 jsp forward할때 사용함

@RequestMapping("/guide/guide.do")
	public String guide() {
		return "guide";
	}

@RequestMapping("/guide/creatorGuide.do")
	public String creatorGuideView() {
		return "/guide/creatorGuideView";
	}
	
@RequestMapping("/guide/supporterGuide.do")
	public String supporterGuideView() {
		return "supporterGuideView";
	}

@RequestMapping("/guide/projectStandard.do")
	public String projectStandardView() {
		return "projectStandardView";
	}

@RequestMapping("/guide/termsOfUse.do")
	public String termsOfUseView() {
		return "termsOfUseView";
	}

@RequestMapping("/guide/privacyPolicy.do")
	public String privacyPolicyView() {
		return "privacyPolicyView";
	}
}