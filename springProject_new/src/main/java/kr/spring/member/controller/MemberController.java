package kr.spring.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.AuthCheckException;

@Controller
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;

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
		// 로그아웃
		session.invalidate();

		return "redirect:/main/main.do";
	}

	//구글아이디로 로그인
	 @ResponseBody 
	 @PostMapping("/member/googleLogin") 
	 public String googleLogin(MemberVO memberVO, HttpSession session, MemberVO vo) throws Exception{ 
		 MemberVO returnVO = memberService.loginByGoogle(memberVO);
		 
		 System.out.println("구글아이디 포스트 db에서 가져온 vo "+ memberVO); 
		 
		 String vo_ajaxid = vo.getId();
		 if(returnVO == null) { //아이디가 DB에 존재하지 않는 경우 //구글 회원가입
		 memberService.registerByGoogle(memberVO);
	 
		 //구글 로그인 
		 returnVO = memberService.loginByGoogle(memberVO);
		 session.setAttribute("id", returnVO.getId()); session.setAttribute("pass",returnVO); }
	  
		 if(vo_ajaxid.equals(returnVO.getId())){ //아이디가 DB에 존재하는 경우 
			 //구글 로그인
			 memberService.loginByGoogle(memberVO); 
			 session.setAttribute("id", returnVO.getId()); 
		 }else {//아이디가 DB에 존재하지 않는 경우 
			 //구글 회원가입
			 memberService.registerByGoogle(memberVO);
			 //구글 로그인 
			 returnVO = memberService.loginByGoogle(memberVO);
			 session.setAttribute("id", returnVO.getId()); 
		}
		 
 		return "redirect:/main/main.do"; 
		 		
	 }
}