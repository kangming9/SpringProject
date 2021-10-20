package kr.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter{
	
	private static final Logger logger = LoggerFactory.getLogger(LoginCheckInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object Handler) throws Exception {
		
		logger.debug("<<LoginCheckInterceptor 진입>>");
		
		HttpSession session = request.getSession();
		if(session.getAttribute("user_num")==null) {
			response.sendRedirect(request.getContextPath() + "/member/login.do");
		}
		    
		return true;
	}
	
}
