package kr.spring.member.controller;

import java.util.ArrayList;
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

import kr.spring.member.service.KakaoAPI;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.AuthCheckException;

@Controller
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;
	
	
	 @Autowired 
	 private KakaoAPI kakaoAPI;
	 

	// 자바빈(VO)초기화
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}

	// 로그인 - 로그인 폼 호출
	@GetMapping("/member/login.do")
	public String formLogin() {
		return "login";// 타일스 식별자
	}

	// 로그인 - 로그인 데이터 처리
	@PostMapping("/member/login.do")
	public String submitLogin(@Valid MemberVO memberVO, BindingResult result, HttpSession session) {

		logger.debug("<<회원 로그인>> : " + memberVO);

		// 유효성 체크 결과 오류가 있으면 폼 호출
		if (result.hasFieldErrors("pass")) {
			return formLogin();
		}

		// 로그인 체크(id,비밀번호 일치 여부 체크)
		try {

			MemberVO member = memberService.selectCheckMember(memberVO.getId());

			boolean check = false;

			if (member != null) {// 아이디 일치 //비밀번호 일치 여부 체크 사용자가 입력한 비밀번호
				check = member.isCheckedPassword(memberVO.getPass());
			}

			if (check) { // 인증 성공, 로그인 처리
				session.setAttribute("user_num", member.getNum());
				session.setAttribute("user_id", member.getId());
				session.setAttribute("user_grade", member.getGrade());
				session.setAttribute("user_photo", member.getPhoto());
				session.setAttribute("user_nickname", member.getNickname());
				
				if(member.getNickname()==null) { //닉네임 널값이면 닉네임 익명으로 업데이트
					memberService.updateNickname(member.getNum());
					session.setAttribute("user_nickname", member.getNickname());
				}
				
				return "redirect:/main/main.do";

			} else { // 인증 실패
				throw new AuthCheckException();
			}

		} catch (AuthCheckException e) {
			result.reject("invalidIdOrPassword");
			return formLogin();
		}
	}

	// 아이디 중복 체크
	@RequestMapping("/member/confirmId.do")
	@ResponseBody
	public Map<String, String> process(@RequestParam String id) {

		logger.debug("<<id>> : " + id);

		Map<String, String> map = new HashMap<String, String>();
		MemberVO member = memberService.selectCheckMember(id);
		
		if(member != null){
			// 아이디 중복
			map.put("result", "idDuplicated");

		}else{
			// 아이디 미중복
			map.put("result", "idNotFound");
		}
		
		return map;
	}
	
	// 회원가입 - 가입 방법 채택
	@RequestMapping("/member/selectRegister.do")
	public String form() {

		logger.debug("<<회원가입 선택 폼 호출>>");

		return "selectRegister";
	}

	// 회원가입 - 회원가입 폼 호출
	@GetMapping("/member/register.do")
	public String nomalForm() {

		logger.debug("<<회원가입 폼 호출>>");

		return "register";
	}

	// 회원가입 - 회원가입 처리
	@PostMapping("/member/register.do")
	public String submit(@Valid MemberVO memberVO, BindingResult result) {

		logger.debug("<<회원 정보>> : " + memberVO);

		if (result.hasErrors()) {
			return nomalForm();
		}

		memberService.insertMember(memberVO);

		return "redirect:/main/main.do";
	}

	// 로그아웃
	@RequestMapping("/member/logout.do")
	public String processLogout(HttpSession session) {
		
		logger.debug("<<로그 찍히는지 확읹>>");
		
		// 로그아웃
		session.invalidate();

		return "redirect:/main/main.do";
	}

	 
	//카카오 로그인
	 @GetMapping("/member/snsLogin.do")
		public String snsLoginforKakao(@RequestParam("code") String code,HttpSession session,Model model) {
	
			logger.debug("----------카카오 로그인 진입 --------");
			
			String access_Token = kakaoAPI.getAccessToken(code);
		    HashMap<String, Object> userInfo = kakaoAPI.getUserInfo(access_Token);
		    System.out.println("login Controller : " + userInfo);
		    
		    //    클라이언트의 이메일이 존재할 때 세션에 해당 이메일과 토큰 등록
		    if (userInfo.get("email") != null) {
		        session.setAttribute("access_Token", access_Token);
		        String email = (String) userInfo.get("email");

		        MemberVO member = memberService.loginBySocial(email);
		        
    			if (member != null) {
    				session.setAttribute("user_num", member.getNum());
    				session.setAttribute("user_id", member.getId());
    				session.setAttribute("user_grade", member.getGrade());
    				session.setAttribute("user_photo", member.getPhoto());
    				session.setAttribute("user_nickname", member.getNickname());
    				
					if(member.getNickname()==null) { //닉네임 널값이면 닉네임 익명으로 업데이트
						memberService.updateNickname(member.getNum());
						session.setAttribute("user_nickname", member.getNickname());
					}
				
    			}else if(member == null) {
    				int idx = email.indexOf("@"); 
    		        String mailPass = email.substring(0, idx);

    				model.addAttribute("s_email", email);
    				model.addAttribute("s_emailPass", mailPass);
    				
    		        
    		        return "snsRegister";
    			}
		    }
			
			return "redirect:/main/main.do";
	}
	 
	 
	// 회원가입 - 회원가입 처리
	@PostMapping("/member/snsRegister.do")
	public String submitSNSRegister(@Valid MemberVO memberVO, BindingResult result) {

		logger.debug("<<회원 정보>> : " + memberVO);

		if (result.hasErrors()) {
			return "snsRegister";
		}

		memberService.insertMember(memberVO);

		return "redirect:/main/main.do";
	}
	 
	 
	 
	//아이디 찾기 (이름, 메일, 폰번호) - 폼 호출
	 @GetMapping("/member/searchID.do")
		public String searchId() {
	
			logger.debug("<<아이디 찾기 폼 호출>>");
	
			return "searchID";
	}
		 
	 //아이디 찾기 - 데이터 처리
	 @PostMapping("/member/searchID.do")
	 public String userIdSearch(@Valid MemberVO memberVO, BindingResult result,
			 HttpServletRequest request, Model model) {
			
		 
		logger.debug("<<user_name>> : "  + memberVO.getName());
		logger.debug("<<user_email>> : "  + memberVO.getEmail());
		logger.debug("<<user_phone>> : "  + memberVO.getPhone());
		
		
		String id = memberService.searchId(memberVO.getName(), memberVO.getEmail(), memberVO.getPhone());
		logger.debug("===========" + id);
		
		if(id == null) {
			model.addAttribute("check", "id");
			model.addAttribute("message", "회원님의 정보를 찾을 수 없습니다. 회원 가입을 해주세요.");
			model.addAttribute("url", request.getContextPath()+"/member/selectRegister.do");
			
			return "common/resultView";
		}else {

			model.addAttribute("check", "id");
			model.addAttribute("message", "귀하의 아이디는 " + id + " 입니다.");
			model.addAttribute("url", request.getContextPath()+"/member/login.do");
			
			return "common/resultView";
		}
	}
	 
	 
	//비밀번호 재설정 (아이디, 메일, 폰번호) - 폼 호출
	 @GetMapping("/member/searchPass.do")
		public String searchPass() {
	
			logger.debug("<<비밀번호 찾기 폼 호출>>");
	
			return "searchPass";
	}
	 
	 //비밀번호 재설정 - 정보 확인
	 @PostMapping("/member/searchPass.do")
	public String searchPassProcess(@RequestParam String id, 
			@RequestParam String email, @RequestParam String phone,
			HttpServletRequest request,Model model) {

		logger.debug("<<id>> : " + id);

		Map<String, String> map = new HashMap<String, String>();
		String pass = memberService.searchPass(id, email, phone);
		
		logger.debug("비밀번호 일치하는지 확인중");
		
		if(pass == null) {
			model.addAttribute("check", "notUser");
			model.addAttribute("message", "회원님의 정보를 찾을 수 없습니다. 회원 가입을 해주세요.");
			model.addAttribute("url", request.getContextPath()+"/member/selectRegister.do");
		}else {
			model.addAttribute("email",email);
			return "changePass";
		}
		
		return "common/result";
	}
	 
	 
	 //비밀번호 재설정 - 비밀번호 변경
	 @PostMapping("/member/changePass.do")
	 public String changePassProcess(@RequestParam String pass, @RequestParam String email,
			 HttpServletRequest request, Model model) {
			
		 
		logger.debug("<<user_pass>> : "  + pass);
		logger.debug("<<user_email>> : "  + email);
		
		/*
		 * if(result.hasErrors()) {
		 * return "searchID"; }
		 */
		
		memberService.changePass(pass,email);
		logger.debug("=========== 비밀번호 변경 완료");
	
		model.addAttribute("check", "pass");
		model.addAttribute("message", "비밀번호가 재설정 되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/member/login.do");
			
		return "common/resultView";
		}
	
	//회원관리 페이지
		 @RequestMapping("/member/memberList.do")
		 public String memberList(HttpSession session, Model model) {
			 
			//Integer user_num = (Integer)session.getAttribute("user_num");
			//MemberVO member = memberService.selectMember(user_num);
			
			List<MemberVO> list = new ArrayList<MemberVO>();
			if(memberService.countMember() > 0) {
				int roop;
				for(roop = 1; roop<=memberService.getMaxMemNum(); roop++) {
				MemberVO member = memberService.selectMember(roop);
				logger.debug(String.valueOf(roop));
				if(member==null)
					continue;
				list.add(member);
				}
				
				
				
			}
			
			session.setAttribute("mem_count", memberService.countMember());
			session.setAttribute("list", list);
			//session.setAttribute("member", member);
			return "memberList";
		 
		 }
	} 
	 
