package kr.spring.gift.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tiles.request.Request;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.spring.gift.service.GiftService;
import kr.spring.gift.vo.GiftVO;
import kr.spring.project.service.ProjectService;
import kr.spring.project.vo.ProjectVO;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class GiftController {
	private static final Logger logger = LoggerFactory.getLogger(GiftController.class);
	
	@Autowired
	private GiftService giftService;
	@Autowired
	private ProjectService projectService;
	
	//자바빈(VO) 초기화
	@ModelAttribute
	public GiftVO initCommand() {
		return new GiftVO();
	}
	
	@RequestMapping("/create/addGift.do")
	@ResponseBody
	public Map<String, String> addGiftArr(HttpSession session, ProjectVO projectVO, GiftVO giftVO, HttpServletRequest request) throws Exception{
		
		logger.debug("<<addGift 호출>>");
		
		Map<String,String> map = new HashMap<String,String>();
		
		List<Map<String, Object>> giftMap = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> detailMap = new ArrayList<Map<String, Object>>();
		
		JSONArray jgift = JSONArray.fromObject(request.getParameter("gift"));
		JSONArray jdetail = JSONArray.fromObject(request.getParameter("detail"));

		giftVO.setP_num(giftVO.getP_num());
		
		for(int i = 0; i < jgift.size(); i++) {
			giftMap.add(new ObjectMapper().readValue(jgift.get(i).toString(), Map.class));
		}
		for(int i = 0; i < jdetail.size(); i++) {
			detailMap.add(new ObjectMapper().readValue(jdetail.get(i).toString(), Map.class));
		}
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) {//로그인이 되지 않은 상태
			map.put("result", "logout");
		}else {
			
			for(Map<String, Object> m : giftMap) {
				
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
	
	//프로젝트 창작 - ADD 전송
	@RequestMapping("/create/createGift.do")
	public ModelAndView submitCreateGift(GiftVO giftVO, ProjectVO projectVO,
		HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {
				
		ModelAndView mav = new ModelAndView();
				
		logger.debug("<<프로젝트 창작 폼 - GIFT 전송>>");
			
		Integer user_num = (Integer)session.getAttribute("user_num");
			
		if(user_num==null) {//로그인이 되지 않은 상태
			PrintWriter out = response.getWriter();
			out.println("<script>alert('로그인을 한 후에 가능합니다.');</script>");

			logger.debug("<<에러>> : 로그인되지 않은 상태");
			mav.setViewName("createGift");
		}else {
					
			logger.debug("<<선물 정보>> : " + giftVO);
			
			projectVO = projectService.selectCheckNumProject(giftVO.getP_num());
			logger.debug("<<프로젝트 정보>> : " + projectVO);
				
			mav.addObject("num", giftVO.getP_num());
			mav.addObject("name", projectVO.getName());
			mav.setViewName("createView"); //작성된 프로젝트 보기
					
			logger.debug("<<이동 경로>> : " + mav.getViewName());
		}
		return mav;
	}
	
}
