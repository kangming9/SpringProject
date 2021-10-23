<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/guide.css" type="text/css">  
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css" type="text/css"> 



<div class='menu'>
	<ul>
			
		<!-- if문 걸어서 현재 페이지에 따라 현재 링크 나오도록 -->
		<li>
			<a href="${pageContext.request.contextPath}" class="delete_line">이용안내</a>
		</li>
				
		<li style="float: right">
		<a href="${pageContext.request.contextPath}/guide/projectStandard.do" class="delete_line">프로젝트 심사 기준</a>
		</li>	
		<li style="float: right">
		<a href="${pageContext.request.contextPath}/guide/supporterGuide.do" class="delete_line">후원자 가이드</a>
		</li>	
		<li style="float: right">
		<a href="${pageContext.request.contextPath}/guide/creatorGuide.do" class="delete_line">창작자 가이드</a>
		</li>
	</ul>
</div>

<a>"안녕2"</a>
<a>"반가워2"</a>
