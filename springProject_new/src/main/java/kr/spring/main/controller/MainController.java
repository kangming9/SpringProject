package kr.spring.main.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.project.service.ProjectService;
import kr.spring.project.vo.ProjectVO;
import kr.spring.util.PagingUtil;

@Controller
public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	@Autowired
	private ProjectService projectService;
	
	@RequestMapping("/main/main.do")
	public String main(Model model) {
		
		//최신순
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("category", "");
		map.put("state", "");
		map.put("order", "1");
		map.put("keyword", "");
		
		
		//인기순 
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("category", ""); 
		map2.put("state", ""); 
		map2.put("order", "2");
		map2.put("keyword", "");
		

		logger.debug("======list map=======: " + map.toString());

		logger.debug("======list map=======: " + map2.toString());
		
		//최신순
		int count = projectService.selectRowCount(map);
		logger.debug("======count=======: " + count);
		
		//인기순 
		int count2 = projectService.selectRowCount(map2);
		logger.debug("======count=======: " + count2);
		
		
		PagingUtil page = new PagingUtil("","",1,count,4,1,"");
		map.put("start", page.getStartCount());
		map.put("end", page.getEndCount());
		map2.put("start", page.getStartCount());
		map2.put("end", page.getEndCount());		 
		
		
		List<ProjectVO> list = null;
		if (count > 0) {
			list = projectService.selectList(map);
		}
		
		List<ProjectVO> list2 = null; 
		if (count2 > 0) { 
			list2 = projectService.selectList(map2);
		}
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("count2", count2);
		model.addAttribute("list2", list2);
		
		
		return "main";
	}
}