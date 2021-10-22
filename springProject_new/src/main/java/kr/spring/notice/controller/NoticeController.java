package kr.spring.notice.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import kr.spring.notice.service.NoticeService;
import kr.spring.question.controller.QuestionController;

@Controller
public class NoticeController {
	private static final Logger logger = LoggerFactory.getLogger(QuestionController.class);
	private int rowCount = 10;
	private int pageCount = 10;
	
	@Autowired
	private NoticeService noticeService;

}
