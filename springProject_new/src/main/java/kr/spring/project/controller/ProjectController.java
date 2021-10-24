package kr.spring.project.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.gift.service.GiftService;
import kr.spring.gift.vo.GiftVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.project.service.ProjectService;
import kr.spring.project.vo.ProjectVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;

@Controller
public class ProjectController {

	private static final Logger logger = LoggerFactory.getLogger(ProjectController.class);
	private int rowCount = 6;
	private int pageCount = 10;

	@Autowired
	private ProjectService projectService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private GiftService giftService;

	// 자바빈(VO) 초기화
	@ModelAttribute
	public ProjectVO initCommand() {
		return new ProjectVO();
	}

	// 프로젝트 창작 - 폼 호출
	@GetMapping("/create/create.do")
	public String createProject() {

		logger.debug("<<창작 폼 호출>>");

		return "create";
	}

	// 프로젝트 창작 - 프로젝트명 중복 체크(Ajax)	@RequestMapping("/create/confirmName.do")
	@ResponseBody
	public Map<String, String> process(@RequestParam String name) {
		logger.debug("<<프로젝트명>> : " + name);

		Map<String, String> map = new HashMap<String, String>();

		ProjectVO project = projectService.selectCheckProject(name);
		if (project != null) { // 프로젝트명 중복
			map.put("result", "nameDuplicated");
		} else {
			if (!Pattern.matches("^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\s]*$", name)) { // 패턴 불일치
				map.put("result", "notMatchPattern");
			} else { // 사용가능한 이름
				map.put("result", "nameNotFound");
			}
		}
		return map;
	}

	// 프로젝트 창작 - 프로젝트 전송
	@RequestMapping("/create/createProject.do")
	public ModelAndView submitCreate(@Valid ProjectVO projectVO, BindingResult result, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws IOException {

		ModelAndView mav = new ModelAndView();

		logger.debug("<<프로젝트 창작 폼 전송>>");
		Integer user_num = (Integer) session.getAttribute("user_num");
		if (user_num == null) {// 로그인이 되지 않은 상태
			PrintWriter out = response.getWriter();
			out.println("<script>alert('로그인을 한 후에 가능합니다.');</script>");

			logger.debug("<<에러>> : 로그인되지 않은 상태");
			mav.setViewName("create");
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

			projectVO.setNum(projectService.selectNum());
			projectVO.setM_num((Integer) session.getAttribute("user_num"));

			logger.debug("<<프로젝트 정보>> : " + projectVO);

			// 프로젝트 전송
			projectService.insertProject(projectVO);

			mav.addObject("num", projectVO.getNum());
			mav.addObject("name", projectVO.getName());
			mav.setViewName("createAdd");

			logger.debug("<<이동 경로>> : " + mav.getViewName());
		}
		return mav;
	}

	// ckeditor를 이용한 이미지 업로드
	@RequestMapping("/create/imageUploader.do")
	@ResponseBody
	public Map<String, Object> uploadImage(MultipartFile upload, HttpSession session, HttpServletRequest request)
			throws Exception {

		// 업로드할 폴더의 절대경로
		String realFolder = session.getServletContext().getRealPath("/resources/image_upload");
		// 업로드한 파일 이름
		String org_filename = upload.getOriginalFilename();
		String str_filename = System.currentTimeMillis() + org_filename; // 현재시간 + 원본 파일명으로 중복되지 않은 파일명 생성

		logger.debug("<<원본 파일명>> : " + org_filename);
		logger.debug("<<저장할 파일명> : " + str_filename);

		Integer user_num = (Integer) session.getAttribute("user_num");

		String filepath = realFolder + "\\" + user_num + "\\" + str_filename;
		logger.debug("<<파일 경로>> : " + filepath);

		File f = new File(filepath);
		if (!f.exists()) // 폴더가 존재하지 않으면
			f.mkdirs(); // 폴더 생성

		upload.transferTo(f); // 파일을 경로로 전송

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uploaded", true);
		map.put("url", request.getContextPath() + "/resources/image_upload/" + user_num + "/" + str_filename);

		return map;
	}

	// 대표이미지 전송
	@RequestMapping("/create/updateTeamPhoto.do")
	@ResponseBody

	public Map<String, String> uploadTeamImage(MultipartFile upload, HttpSession session, ProjectVO projectVO) throws Exception{

		logger.debug("<<updateTeamPhoto 호출>>");

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

	// 대표이미지 삭제
	@RequestMapping("/create/deleteTeamPhoto.do")
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

	// 프로젝트 창작 - ADD 전송
	@RequestMapping("/create/createProjectAdd.do")
	public ModelAndView submitCreateAdd(@ModelAttribute GiftVO giftVO, ProjectVO projectVO,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		ModelAndView mav = new ModelAndView();

		logger.debug("<<프로젝트 창작 폼 - ADD 전송>>");

		Integer user_num = (Integer) session.getAttribute("user_num");

		if (user_num == null) {// 로그인이 되지 않은 상태
			PrintWriter out = response.getWriter();
			out.println("<script>alert('로그인을 한 후에 가능합니다.');</script>");

			logger.debug("<<에러>> : 로그인되지 않은 상태");
			mav.setViewName("createAdd");
		} else {

			logger.debug("<<프로젝트 정보>> : " + projectVO);

			mav.addObject("num", projectVO.getNum());
			mav.addObject("name", projectVO.getName());
			mav.setViewName("createGift"); // 선물 구성 작성 폼으로 이동

			logger.debug("<<이동 경로>> : " + mav.getViewName());
		}
		return mav;
	}

	// 프로젝트 리스트
	@RequestMapping("/project/list.do")
	public ModelAndView process(@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
			@RequestParam(value = "category", defaultValue = "") String category,
			@RequestParam(value = "state", defaultValue = "") String state,
			@RequestParam(value = "order", defaultValue = "") String order,
			@RequestParam(value = "keyword", defaultValue = "") String keyword) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("category", category);
		map.put("state", state);
		map.put("order", order);
		map.put("keyword", keyword);

		logger.debug("======프로젝트 리스트 filter map=======: " + map.toString());

		int count = projectService.selectRowCount(map);

		String add = "&category="+category+"&state="+state+"&order="+order;
		PagingUtil page = new
		PagingUtil("",keyword,currentPage,count,rowCount,pageCount,"list.do",add);
		map.put("start", page.getStartCount()); 
		map.put("end", page.getEndCount());
		
		List<ProjectVO> list = null;
		if (count > 0) {
			list = projectService.selectList(map);
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("projectList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("pagingHtml", page.getPagingHtml());
		mav.addObject("category", category);
		mav.addObject("state", state);
		mav.addObject("order", order);
		mav.addObject("keyword", keyword);
		return mav;
	}

	// 프로젝트 상세
	@RequestMapping("/project/detail.do")
	public ModelAndView process(@RequestParam int num) {
		ProjectVO project = projectService.selectProject(num);
		int supporter = projectService.selectProjectSupporter(num);
		MemberVO member = memberService.selectMember(project.getM_num());
		int giftCnt = giftService.selectRowCount(num);
		List<GiftVO> giftList = giftService.selectList(num);
		List<GiftVO> comList = giftService.selectComList(num);

		// HTML 태그 불허
		project.setName(StringUtil.useNoHtml(project.getName()));

		ModelAndView mav = new ModelAndView();
		mav.setViewName("projectView");
		mav.addObject("project", project);
		mav.addObject("supporter", supporter);
		mav.addObject("creator", member);
		mav.addObject("giftCnt", giftCnt);
		mav.addObject("giftList", giftList);
		mav.addObject("comList", comList);

		return mav;
	}
	
	@RequestMapping("create/updateApproval.do")
	public ModelAndView updateApproval(HttpSession session, ProjectVO projectVO, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		ModelAndView mav = new ModelAndView();
		
		logger.debug("<<프로젝트 수정 완료 - approval 수정>>");
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num==null) {//로그인이 되지 않은 상태
			PrintWriter out = response.getWriter();
			out.println("<script>alert('로그인을 한 후에 가능합니다.');</script>");

			logger.debug("<<에러>> : 로그인되지 않은 상태");
			mav.setViewName("createGift");
		}else {
					
			logger.debug("<<프로젝트 정보>> : " + projectVO.getNum());
			
			projectService.updateApproval(projectVO.getNum());
			
			logger.debug("<<프로젝트 심사신청 완료>>");
			
			mav.addObject("num", projectVO.getNum());
			mav.setViewName("ApprovalView"); //작성된 프로젝트 보기
					
			logger.debug("<<이동 경로>> : " + mav.getViewName());
		}
		return mav;
	}
}
