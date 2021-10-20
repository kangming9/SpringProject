<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css" type="text/css">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<div>
	<div class="miniTitle_left">
		<c:if test="${empty member.photo}">
			<img src="${pageContext.request.contextPath}/resources/images/userimage.png" width="100" height="100" class="my-photo">
		</c:if>
		<c:if test="${!empty member.photo}"> <!-- 사진있는경우 -->
			<img src="${pageContext.request.contextPath}/mypage/photoView.do" width="100" height="100" class="my-photo">
		</c:if>
		<span>${member.nickname}님</span>
		<a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
		
	</div>
	<div class="miniTitle_right">
		<br><br><br><br><br><br>
		<i class="fas fa-bell xs" id="notice_alarm"></i>
		나의 프로젝트 크레이지 아케이드 목표금액 달성
	</div>
	<hr noshade="noshade" class="line">
</div>
<div class="container">
	<div class="item" onclick="location.href='${pageContext.request.contextPath}/mypage/mySupport.do'">
	<b>후원 프로젝트</b>
	<p>
	후원한 프로젝트의 목록과 진행 상황에 대해 알아볼 수 있습니다.
	</div>
	<div class="item" onclick="location.href='${pageContext.request.contextPath}/mypage/myProject.do'">
	<b>나의 프로젝트</b>
	<p>
	내가 올린 프로젝트의 목록과 진행 상황에 대해 알아볼 수 있습니다.
	</div>
	<div class="item" onclick="location.href='${pageContext.request.contextPath}/mypage/myQuestion.do'">
	<b>문의</b>
	<p>
	프로젝트에 대해 문의하고 답변을 확인할 수 있습니다.
	</div>
	<div class="item" onclick="location.href='${pageContext.request.contextPath}/mypage/mySettings.do'">
	<b>설정</b>
	<p>
	회원정보 변경과 배송지 관리, 결제수단을 관리할 수 있습니다.
	</div>
</div>
