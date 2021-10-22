package kr.spring.mypage.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.ibatis.annotations.Delete;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.spring.delivery.vo.DeliveryVO;
import kr.spring.gift.service.GiftService;
import kr.spring.gift.vo.GiftVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.mypage.dao.MypageMapper;
import kr.spring.mypage.service.MypageService;
import kr.spring.project.service.ProjectService;
import kr.spring.project.vo.ProjectVO;
import kr.spring.support.service.SupportService;
import kr.spring.support.vo.SupportVO;
import kr.spring.support.vo.SupporterVO;
import kr.spring.util.PagingUtil;
import net.sf.json.JSONArray;

@Controller
public class MypageController {

	private static final Logger logger = LoggerFactory.getLogger(MypageController.class);
	private int rowCount = 6;
	private int pageCount = 10;


	@Autowired
	private MypageService mypageService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private ProjectService projectService;
	@Autowired
	private GiftService giftService;
	@Autowired
	private SupportService supportService;

	//자바빈 초기화
	@ModelAttribute
	public MemberVO initCommand2() {
		return new MemberVO();
	}
	
	//마이페이지 호출
	@RequestMapping("/mypage/myPage.do")
	public String view(HttpSession session, Model model) {
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		MemberVO member = memberService.selectMember(user_num); //레코드 하나 읽어옴
		
		logger.debug("<<마이페이지 호출>>");
		
		model.addAttribute("member", member);
		
		return "mypageView";
	}
	//후원프로젝트 호출
	@RequestMapping("/mypage/mySupport.do")
	public ModelAndView mySupportView(HttpSession session,
								@RequestParam(value="pageNum", defaultValue="1") int currentPage,
								@RequestParam(value="keyword", defaultValue="") String keyword) {
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		
		int count = mypageService.getSupportCount(user_num);
		logger.debug("<<후원프로젝트 호출>> map : " + map.toString() + "user_num" + count);
		
		PagingUtil page = new PagingUtil(currentPage, count, rowCount, pageCount, "mySupport.do");
		
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		
		List<SupportVO> list = null;
		
		if(count > 0) {
			map.put("m_num", user_num);
			logger.debug("map:"+map);
			list = mypageService.supportSelectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		//뷰 이름 설정
		mav.setViewName("mySupportView");
		//데이터 저장
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("pagingHtml", page.getPagingHtml());
		
		return mav;
	}
	//후원프로젝트 디테일
		@RequestMapping("/mypage/mysupportdetail.do")
		public ModelAndView mySupportView(HttpSession session,
										 @RequestParam(value="p_num") int p_num,
										 @RequestParam(value="g_num") int g_num,
										 @RequestParam(value="num") int num) {
			
			Integer user_num = (Integer)session.getAttribute("user_num");
			

			logger.debug("<<후원프로젝트 상세페이지 호출>>");
			
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("m_num", user_num);
			map.put("p_num", p_num);
			map.put("g_num", g_num);
			map.put("num", num);
			logger.debug("회원번호 : " + user_num + "프로젝트번호 : " + p_num + "선물번호 : " + g_num + "서포트번호 : " + num);
			
			SupportVO support = mypageService.selectmySupport(map);
			support.setP_num(p_num);
			logger.debug("<<supportVO>> : " + support);
			
			Map<String,Object> map2 = new HashMap<String,Object>();
			map2.put("gd_name", support.getname_1());
			map2.put("gd_num", g_num);
			
			List<GiftVO> gift = null;
			
			gift = giftService.selectGiftDetail(map2);
			logger.debug("<<GiftVO>> : " + gift);
			
			ModelAndView mav = new ModelAndView();
			mav.setViewName("mySupportDetailView");
			mav.addObject("support", support);
			mav.addObject("gift", gift);
			
			return mav;
		}
	//나의프로젝트 호출
	@RequestMapping("/mypage/myProject.do")
	public ModelAndView myProjectView(HttpSession session,
									  @RequestParam(value="pageNum", defaultValue="1") int currentPage,
									  @RequestParam(value="keyword", defaultValue="") String keyword) {
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		
		int count = mypageService.getProCount(user_num);

		PagingUtil page = new PagingUtil(currentPage, count, rowCount, pageCount, "myProject.do");
		logger.debug("<<나의 프로젝트>>");
		
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		
		List<ProjectVO> list = null;
		if(count > 0) {
			map.put("m_num", user_num);
			list = mypageService.proSelectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		//뷰 이름 설정
		mav.setViewName("myProjectView");
		//데이터 저장
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("pagingHtml", page.getPagingHtml());
		
		return mav;
	}
	@RequestMapping("/mypage/myProjectDetail.do")
	public ModelAndView myProjectDetail(HttpSession session, ProjectVO projectVO) {
		
		logger.debug("<<나의 프로젝트 - 상세 페이지 호출 : >> : " + projectVO.getName());
		
		projectVO = projectService.selectCheckProject(projectVO.getName());
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("num", projectVO.getNum());
		mav.addObject("name", projectVO.getName());
		mav.addObject("category", projectVO.getCategory() + "");
		mav.addObject("start_date", projectVO.getStart_date());
		mav.addObject("finish_date", projectVO.getFinish_date());
		mav.addObject("goal_amount", projectVO.getGoal_amount());
		mav.addObject("approval", projectVO.getApproval());
		mav.addObject("reason", projectVO.getReason());
		mav.addObject("summary", projectVO.getSummary());
		mav.addObject("photo", projectVO.getPhoto());
		mav.addObject("ship", projectVO.getShip() + "");
		mav.addObject("intro", projectVO.getIntro());
		mav.addObject("policy", projectVO.getPolicy());
		
		if(projectVO.getApproval() == -1 || projectVO.getApproval() == 2) mav.setViewName("myProjectDetailView");
		else mav.setViewName("myProjectDetailLock");
		
		int giftCnt = giftService.selectRowCount(projectVO.getNum());
		List<GiftVO> giftList = giftService.selectList(projectVO.getNum());
		List<GiftVO> comList = giftService.selectComList(projectVO.getNum());
		
		mav.addObject("giftCnt", giftCnt);
		mav.addObject("giftList", giftList);
		mav.addObject("comList", comList);
		
		return mav;
	}
	@RequestMapping("/mypage/projectInfo.do")
	public ModelAndView projectInfo(HttpSession session, ProjectVO projectVO) {
		
		String info = projectVO.getGoal_amount_str();
		
		projectVO = projectService.selectCheckProject(projectVO.getName());
		
		logger.debug("<<projectInfo 호출>> : " + projectVO.getName());
		
		int giftCnt = giftService.selectRowCount(projectVO.getNum());
		List<GiftVO> giftList = giftService.selectList(projectVO.getNum());
		List<GiftVO> comList = giftService.selectComList(projectVO.getNum());
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("num", projectVO.getNum());
		mav.addObject("name", projectVO.getName());
		mav.addObject("category", projectVO.getCategory() + "");
		mav.addObject("start_date", projectVO.getStart_date());
		mav.addObject("finish_date", projectVO.getFinish_date());
		mav.addObject("goal_amount", projectVO.getGoal_amount());
		mav.addObject("approval", projectVO.getApproval());
		mav.addObject("reason", projectVO.getReason());
		mav.addObject("summary", projectVO.getSummary());
		mav.addObject("photo", projectVO.getPhoto());
		mav.addObject("ship", projectVO.getShip() + "");
		mav.addObject("intro", projectVO.getIntro());
		mav.addObject("policy", projectVO.getPolicy());
		
		mav.addObject("project", projectVO);
		mav.addObject("giftCnt", giftCnt);
		mav.addObject("giftList", giftList);
		mav.addObject("comList", comList);

		if("project".equals(info)) {
			mav.setViewName("myProjectDetailLock");
		}else if("support".equals(info)) {
			List<SupporterVO> supporterList = null;
			supporterList = supportService.selectSupporterList(projectVO.getNum());
			for(SupporterVO i : supporterList) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				i.setPayment_date_str(sdf.format(i.getPayment_date()));
			}
			mav.addObject("supporterList", supporterList);
			mav.setViewName("supportInfo");
		}else if("state".equals(info)) {
			List<Integer> supportList = new ArrayList<Integer>(); //선물별 후원자 리스트
			
			for(GiftVO i : giftList) {
				supportList.add(supportService.selectGiftSupport(i.getNum()));
			}
			
			List<SupporterVO> giftSupport = supportService.selectGiftMoney();
			
			mav.addObject("giftSupport", giftSupport);
			mav.addObject("supportList", supportList);
			mav.setViewName("stateInfo");
		}else if("money".equals(info)) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			Date finish_date = projectService.selectFinish(projectVO.getNum());
			SupportVO supportSum = supportService.selectSupportSum(projectVO.getNum());
			MemberVO member = memberService.selectMember((Integer)session.getAttribute("user_num"));
			
			mav.addObject("nickname", member.getNickname());
			
			mav.addObject("finish", sdf.format(finish_date));
			mav.addObject("supportSum", supportSum);
			
			mav.setViewName("moneyInfo");
		}
		
		return mav;
	}
	
	//내문의게시판 호출
	@RequestMapping("/mypage/myQuestion.do")
	public String myQuestionView() {
			
		logger.debug("<<문의페이지 호출>>");
			
		return "myQuestionView";
	} 
	//설정 호출
	@RequestMapping("/mypage/mySettings.do")
	public String mySettingView() {
		
		logger.debug("<<설정페이지 호출>>");
		
		return "mySettingsView";
	}
	//설정 - 기본정보 호출
	@RequestMapping("/mypage/myInformation.do")
	public String myInformationView(HttpSession session, Model model) {
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		MemberVO member = memberService.selectMember(user_num); //레코드 하나 읽어옴
		//memberService.updateNickname(user_num);
		
		model.addAttribute("member", member);
		logger.debug("<<설정-기본정보 호출>>");
		
		return "myInformationView";
	}
	//기본정보 - 닉네임 변경
	@RequestMapping("/mypage/nicknameUpdate.do")
	@ResponseBody
	public Map<String, String> nicknameUpdate(HttpSession session, @RequestParam String nickname) {
		
		logger.debug("<<닉넴>> : " + nickname);
		
		Map<String, String> map = new HashMap<String, String>();
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num==null) {//로그인 안된 상태
			map.put("result", "logout");
		}else {//로그인 상태
			
			int check = mypageService.checkNickname(nickname); //null이 안나옴 ㅠ~ㅠ~ㅠ
	
			if(check > 0) {//닉네임 중복
				map.put("result", "nicknameDuplicated");
			}else {
				MemberVO member = new MemberVO();
				member.setNum(user_num);
				member.setNickname(nickname);
				logger.debug("<<엘스>>" + member);
				mypageService.updateNickname(member);
				
				logger.debug("<<닉네임>> : " + member.getNickname());
				session.setAttribute("user_nickname", member.getNickname());
				
				map.put("result", "success");
			}
		}
		
		return map;
		
	}
	//기본정보 - 회원 프로필 사진 업데이트
	@RequestMapping("/mypage/updateMyphoto.do")
	@ResponseBody
	public Map<String,String> processProfile(MemberVO memberVO, HttpSession session){
		Map<String,String> map = new HashMap<String,String>();
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) {//로그인 안된 상태
			map.put("result", "logout");
		}else {//로그인 상태
			memberVO.setNum(user_num);
			mypageService.updateProfile(memberVO);
			
			//이미지를 업로드한 후 세션에 저장된 회원 프로필 사진 정보 갱신
			session.setAttribute("user_photo", memberVO.getPhoto());
			
			map.put("result", "success");
		}
		
		return map;
	}
	//기본정보 - 프로필 사진 출력
	@RequestMapping("/mypage/photoView.do")
	public ModelAndView viewImage(HttpSession session) {
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		MemberVO memberVO = memberService.selectMember(user_num);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("imageView");
		mav.addObject("imageFile", memberVO.getPhoto());
		mav.addObject("filename", memberVO.getPhoto_name()); //파일명 가지고 확장자 체크 함
		
		return mav;
	}
	
	//기본정보 - 프로필 사진 출력
	@GetMapping("/mypage/mphotoView.do")
	public ModelAndView memberImage(int num) {
		MemberVO memberVO = memberService.selectMember(num);
	      
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName("imageView");
	    mav.addObject("imageFile", memberVO.getPhoto());
	    mav.addObject("filename", memberVO.getPhoto_name());
	      
	    return mav;
	}
	//기본정보 - 연락처 변경
	@RequestMapping("/mypage/updateMyPhone.do")
	@ResponseBody
	public Map<String,String> updatePhone(MemberVO memberVO, HttpSession session){
		Map<String,String> map = new HashMap<String,String>();
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) {//로그인 안된 상태
			map.put("result", "logout");
		}else {//로그인 상태
			memberVO.setNum(user_num);
			mypageService.updatePhone(memberVO);
	
			map.put("result", "success");
		}
		
		return map;
	}
	//기본정보 - 비밀번호 변경
	@RequestMapping("/mypage/updatePassword.do")
	@ResponseBody
	public Map<String,String> updatePass(MemberVO memberVO, HttpSession session){
		Map<String,String> map = new HashMap<String,String>();
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		MemberVO originVO = memberService.selectMember(user_num); //비번 일치비교하기 위해 값가져옴
		
		if(user_num==null) {//로그인 안된 상태
			map.put("result", "logout");
		}else if(user_num != memberVO.getNum()){
			map.put("result", "differentUser");
		}else if(!originVO.getPass().equals(memberVO.getPass())) {
			logger.debug("<<기존비번 >> " + originVO.getPass() + " <<비교하는비번>> : " + memberVO.getPass());
			map.put("result", "passNotFound");
		}else{//로그인 상태
			logger.debug("<<변경한다>>");
			memberVO.setNum(user_num);
			mypageService.updatePass(memberVO);
	
			map.put("result", "success");
		}
		
		return map;
	}
	//기본정보 - 탈퇴 폼 호출
	@GetMapping("/mypage/deleteform.do")
	public String deleteformView(HttpSession session, Model model) {
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		MemberVO member = memberService.selectMember(user_num);
		model.addAttribute("member", member);
		
		logger.debug("<<회원탈퇴 호출>> : " + member);
		
		return "mydeleteView";
	}
	//기본정보 - 탈퇴 처리
	@PostMapping("/mypage/deleteform.do")
	@ResponseBody
	public Map<String,String> deleteMember(MemberVO member, HttpSession session) {
		Map<String,String> map = new HashMap<String,String>();
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		MemberVO originVO = memberService.selectMember(user_num); //비번 일치비교하기 위해 값가져옴
		
		if(user_num==null) {//로그인 안된 상태
			map.put("result", "logout");
		}else if(user_num != member.getNum()){//회원번호 일치여부 확인
			map.put("result", "differentUser");
		}else if(!originVO.getPass().equals(member.getPass())) { //비번 일치여부 확인
			logger.debug("<<기존비번 >> " + originVO.getPass() + " <<비교하는비번>> : " + member.getPass());
			map.put("result", "passNotFound");
		}else{//탈퇴
			logger.debug("<<회원 탈퇴>>");
			member.setNum(user_num);
			mypageService.deleteMember(member);
			
			map.put("result", "success");
			
			//로그 아웃
			session.invalidate();
		}
		return map;
	}

	//설정 - 배송지 호출 및 리스트
	@RequestMapping("/mypage/myDelivery.do")
	public ModelAndView myDeliveryView(
						HttpSession session,
						DeliveryVO deliveryVO,
						@RequestParam(value="pageNum", defaultValue="1") int currentPage) {
					
		Integer user_num = (Integer)session.getAttribute("user_num");
		deliveryVO.setM_num(user_num);
		
		logger.debug("<<배송지호출 - deliveryVO 값>> : " + deliveryVO);
		
		int count = mypageService.getdelCount(user_num); //배송지 총 개수 가져옴
		
		logger.debug("<<배송지호출 - 총 배송목록 수>> : " + count);
		
		PagingUtil page = new PagingUtil(currentPage, count, rowCount, pageCount, 
										"myDelivery.do");
		
		logger.debug("<<배송지호출 - 페이지 정보>> : " + page);
		
		//목록 호출
		List<DeliveryVO> list = null;
		if(count > 0) {
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("start", page.getStartCount());
			map.put("end", page.getEndCount());
			map.put("m_num", deliveryVO.getM_num());
			
			list = mypageService.delSelectList(map);
		}
		ModelAndView mav = new ModelAndView();
		//뷰 이름 설정
		mav.setViewName("myDeliveryView");
		//데이터 저장
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("pagingHtml", page.getPagingHtml());
		
		return mav;
	}
	
	//설정 - 배송지 추가
	@RequestMapping("/mypage/myDeliverysubmit.do")
	public String myDelivery(HttpSession session, DeliveryVO deliveryVO) {
	
		Integer user_num = (Integer)session.getAttribute("user_num");
		deliveryVO.setM_num(user_num);
		
		logger.debug("<<배송지 추가>> : " + deliveryVO);
		
		if(deliveryVO.getAddress_check()==1) {//기본배송지로 변경하는 값 들어있는 경우
			mypageService.updateDelCheck(deliveryVO);
			mypageService.insertDelivery(deliveryVO);
		}else {//기본배송지 변경아니고 그냥 추가만 하는경우
			mypageService.insertDelivery(deliveryVO);
		}

		return "redirect:/mypage/myDelivery.do";
	}
	//설정 - 배송지 수정 폼 호출
	@RequestMapping("/mypage/myDeliveryUpdateForm.do")
	public String updateDeliveryForm(@RequestParam(value="num") int num,
									 @RequestParam(value="m_num") int m_num,
									 Model model) {
		
		DeliveryVO deliveryVO = mypageService.selectDelivery(num);
		
		logger.debug("<<배송지 수정 폼 호출>>");
		
		model.addAttribute("deliveryVO", deliveryVO);
		model.addAttribute("num", num);
		model.addAttribute("m_num", m_num);

		return "myDeliveryUpdateForm";
	}
	//설정 - 배송지 수정
	@RequestMapping("/mypage/myDeliveryUpdate.do")
	public String updateDelivery(DeliveryVO deliveryVO, HttpSession session) {
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		logger.debug("<<배송지수정>> : " + deliveryVO);
		
		int check = deliveryVO.getAddress_check();
		if(check==1) {//기본배송지 설정 체크할 시 기존에 있던 1 찾아서 0으로 바꿈
			mypageService.updateDelCheck(deliveryVO);
			mypageService.updateDelivery(deliveryVO);
		}else {//기본배송지 설정 안할 시
			mypageService.updateDelivery(deliveryVO);
		}

		return "redirect:/mypage/myDelivery.do";
	}
	//설정 - 배송지 삭제
	@RequestMapping("/mypage/myDeliveryDelete.do")
	public String deleteDelivery(Integer num) {
		System.out.println("목록호출삭제1");
		DeliveryVO deliveryVO = mypageService.selectDelivery(num);
		logger.debug("<<배송지삭제>> : " + deliveryVO);
		
		mypageService.deleteDelivery(deliveryVO.getNum());
		
		return "redirect:/mypage/myDelivery.do";
	}
	
	//설정 - 결제수단 호출
	@RequestMapping("/mypage/myPayment.do")
	public String myPaymentView() {
				
		logger.debug("<<설정-결제수단 호출>>");
				
		return "myPaymentView";
	}
	
	//프로젝트 수정
	@RequestMapping("mypage/updateProject.do")
	public ModelAndView myProjectUpdate(ProjectVO projectVO, BindingResult result, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		ModelAndView mav = new ModelAndView();

		logger.debug("<<프로젝트 업데이트 폼 전송>>");
		Integer user_num = (Integer) session.getAttribute("user_num");
		if (user_num == null) {// 로그인이 되지 않은 상태
			PrintWriter out = response.getWriter();
			out.println("<script>alert('로그인을 한 후에 가능합니다.');</script>");

			logger.debug("<<에러>> : 로그인되지 않은 상태");
			mav.setViewName("myProjectView");
		} else {
			// 유효성 검사 결과 오류가 있으면 폼 호출
			if (result.hasErrors()) {
				List<ObjectError> list = result.getAllErrors();

				for (ObjectError error : list) {
					logger.debug("<<에러>> : " + error.getDefaultMessage());
				}
				mav.setViewName("create");
				return mav;
			}

			logger.debug("<<프로젝트 정보>> : " + projectVO);

			// 프로젝트 전송
			projectService.updateAllProject(projectVO);

			mav.addObject("project", projectVO);
			mav.setViewName("updatePhoto");

			logger.debug("<<이동 경로>> : " + mav.getViewName());
		}
		return mav;
	}
	
	@RequestMapping("mypage/updatePhoto.do")
	public Map<String, String> uploadTeamImage(MultipartFile upload, HttpSession session, ProjectVO projectVO) throws Exception{

		logger.debug("<<updatePhoto 호출>>");

		Map<String, String> map = new HashMap<String, String>();

		Integer user_num = (Integer) session.getAttribute("user_num");
		if (user_num == null) {// 로그인이 되지 않은 상태
			map.put("result", "logout");
		} else {

			// 업로드할 폴더의 절대경로
			String realFolder = session.getServletContext().getRealPath("/upload");
			// 업로드한 파일 이름
			String org_filename = upload.getOriginalFilename();
			String str_filename = System.currentTimeMillis() + org_filename;
			String filepath = realFolder + "\\" + str_filename;
			logger.debug("<<파일 경로>> : " + filepath);
			File f = new File(filepath);
			if (!f.exists()) // 폴더가 존재하지 않으면
				f.mkdirs(); // 폴더 생성

			upload.transferTo(f); // 파일을 경로로 전송

			projectVO.setPhoto(str_filename);
			projectService.updatePhoto(projectVO);

			logger.debug("<<대표 이미지 업데이트 완료>>");

			map.put("result", "success");
		}
		return map;
		
	}
	@RequestMapping("mypage/deletePhoto.do")
	@ResponseBody
	public Map<String, String> deleteImage(HttpSession session, ProjectVO projectVO) throws Exception {

		logger.debug("<<deleteTeamPhoto 호출>>");

		Map<String, String> map = new HashMap<String, String>();

		Integer user_num = (Integer) session.getAttribute("user_num");
		if (user_num == null) {// 로그인이 되지 않은 상태
			map.put("result", "logout");
		} else {
			projectService.deletePhoto(projectVO);

			logger.debug("<<대표 이미지 삭제 완료>>");

			map.put("result", "success");
		}
		return map;
	}
	
	@RequestMapping("mypage/updateProjectAdd.do")
	public ModelAndView submitCreateAdd(@ModelAttribute GiftVO giftVO, ProjectVO projectVO,
		HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {
			
			ModelAndView mav = new ModelAndView();

			logger.debug("<<프로젝트 수정 폼 - updateProjectAdd>>");

			Integer user_num = (Integer) session.getAttribute("user_num");

			if (user_num == null) {// 로그인이 되지 않은 상태
				PrintWriter out = response.getWriter();
				out.println("<script>alert('로그인을 한 후에 가능합니다.');</script>");

				logger.debug("<<에러>> : 로그인되지 않은 상태");
				mav.setViewName("myPage");
			} else {

				logger.debug("<<프로젝트 정보>> : " + projectVO);

				mav.addObject("num", projectVO.getNum());
				mav.addObject("name", projectVO.getName());
				
				List<GiftVO> giftList = giftService.selectList(projectVO.getNum());
				List<List<GiftVO>> comList = new ArrayList<List<GiftVO>>();
				for(GiftVO i : giftList) {
					comList.add(giftService.selectGcomList(i.getNum()));
				}
				
				mav.addObject("giftList", giftList);
				mav.addObject("comList", comList);
				mav.setViewName("updateGift"); // 선물 구성 작성 폼으로 이동

				logger.debug("<<이동 경로>> : " + mav.getViewName());
			}
			return mav;
		}
	
	@RequestMapping("/mypage/updateGiftDetail.do")
	@ResponseBody
	public Map<String, String> updateGiftArr(HttpSession session, GiftVO giftVO, HttpServletRequest request) throws Exception{
		
		logger.debug("<<updateGift 호출>> : " + giftVO.getP_num());
		
		int pnum = giftVO.getP_num();
		Map<String,String> map = new HashMap<String,String>();
		
		List<Map<String, Object>> giftMap = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> detailMap = new ArrayList<Map<String, Object>>();
		
		JSONArray jgift = JSONArray.fromObject(request.getParameter("gift"));
		JSONArray jdetail = JSONArray.fromObject(request.getParameter("detail"));
		
		for(int i = 0; i < jgift.size(); i++) {
			giftMap.add(new ObjectMapper().readValue(jgift.get(i).toString(), Map.class));
			System.out.println(giftMap.toString());
		}
		for(int i = 0; i < jdetail.size(); i++) {
			detailMap.add(new ObjectMapper().readValue(jdetail.get(i).toString(), Map.class));
		}
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) {//로그인이 되지 않은 상태
			map.put("result", "logout");
		}else {
			for(Map<String, Object> g : giftMap) {
				logger.debug("삭제 시작");
				giftService.deleteDetail(pnum, g.get("name").toString());
				logger.debug("삭제 중");
			}
			logger.debug("삭제 완료");
			giftService.deleteGift(giftVO.getP_num());
			
			 logger.debug("<<이전 데이터 삭제 완료>>");
			
			for(Map<String, Object> m : giftMap) {
				System.out.println("현재 선물 : " + m.toString() + "\n\n");
				if(m != null) {
					giftVO.setNum(giftService.selectNum());
					
					//VO에 gift 내용 추가
					giftVO.setName((String)m.get("name"));
					giftVO.setPrice(Integer.parseInt(m.get("price").toString()));
					if("shipped".equals((String)m.get("ship")))
						giftVO.setDue_ship(1);
					else if("upshipped".equals((String)m.get("ship")))
						giftVO.setDue_ship(0);
					giftVO.setCom_cnt(Integer.parseInt(m.get("count").toString()));
					giftVO.setOptional(Integer.parseInt(m.get("optional").toString()));
					
					giftService.addGift(giftVO);
					
			       logger.debug("<<Gift 업데이트>>\n" + m);
				}
			}
			
			for(Map<String, Object> m : detailMap) {
				
				if(m != null) {
					giftVO.setGd_num(giftService.selectDNum());
					
					//VO에 detail 내용 추가
					giftVO.setGd_name((String)m.get("name"));
					if(m.get("count") != null)
						giftVO.setGd_count(Integer.parseInt(m.get("count").toString()));
					else
						giftVO.setGd_count(0);
					
					int gnum = giftService.selectGNum((String)m.get("gname"), giftVO.getP_num());
					giftVO.setNum(gnum);
					giftService.addDetail(giftVO);
				
			       logger.debug("<<Gift_Detail 업데이트>>\n" + m);
				}
			}
			
			map.put("result", "success");
		}
		return map;
	}
	
	@RequestMapping("/mypage/updateGift.do")
	public ModelAndView submitUpdateGift(GiftVO giftVO,
		HttpSession session, HttpServletRequest request, HttpServletResponse response, String p_name) throws IOException {
				
		ModelAndView mav = new ModelAndView();
				
		logger.debug("<<프로젝트 수정 폼 - GIFT 전송>>");
			
		Integer user_num = (Integer)session.getAttribute("user_num");
			
		if(user_num==null) {//로그인이 되지 않은 상태
			PrintWriter out = response.getWriter();
			out.println("<script>alert('로그인을 한 후에 가능합니다.');</script>");

			logger.debug("<<에러>> : 로그인되지 않은 상태");
			mav.setViewName("createGift");
		}else {
					
			logger.debug("<<프로젝트 정보>> : " + giftVO);
				
			mav.addObject("num", giftVO.getP_num());
			mav.addObject("name", p_name);
			mav.setViewName("updateView"); //작성된 프로젝트 보기
					
			logger.debug("<<이동 경로>> : " + mav.getViewName());
		}
		return mav;
	}
}









