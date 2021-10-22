<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/support.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<!-- 중앙 내용 시작 -->
<div class="container">
	<div class="container-title"><span>후원완료</span></div>
	<div class="result-wrap">
		<div class="title bold result">축하드립니다</div>
		<div class="bold result"><span class="color">${supporter}</span>번째 공식 서포터가 되셨습니다.</div>
		<div class="result">
			<b>${project.finish_date}</b> 까지 프로젝트의 모금액이 목표금액 100%이상 모여야만 자동 결제가 진행됩니다.
		</div>
		<div class="result">
			모금액이 100%이상 모이지 않고 펀딩이 마감되면 결제가 자동 취소됩니다.
		</div>
		<div class="result">후원한 프로젝트는 <b>마이페이지 > 후원 프로젝트</b> 에서 확인 하실 수 있습니다.</div>
		<div class="result">
			<button class="mysupport btn" onclick="location.href='${pageContext.request.contextPath}/mypage/mySupport.do'">후원 프로젝트 보기</button>
			<button class="home btn" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">확인</button>
		</div>
	</div>
</div>
<!-- 중앙 내용 끝 -->