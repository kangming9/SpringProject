<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css" type="text/css">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<div>
	<div class="miniTitle_left">
	<b class="miniTitle_content" onclick="location.href='${pageContext.request.contextPath}/mypage/mySettings.do'">설정</b>
	</div>
	<div class="miniTitle_right">
		<br>
		<i class="fas fa-bell xs" id="notice_alarm"></i>
		나의 프로젝트 크레이지 아케이드 목표금액 달성
	</div>
	<hr noshade="noshade" class="line">
</div>
<div class="container">
	<div class="item" onclick="location.href='${pageContext.request.contextPath}/mypage/myInformation.do'">
	<b>기본정보</b>
	<p>
	프로필 | 연락처 | 비밀번호 | 회원탈퇴
	</div>
	<div class="item" onclick="location.href='${pageContext.request.contextPath}/mypage/myDelivery.do'">
	<b>배송지</b>
	<p>
	기본 배송지설정 | 배송지 추가 | 배송지 변경
	</div>
	<div class="item" onclick="location.href='${pageContext.request.contextPath}/mypage/myPayment.do'">
	<b>결제수단</b>
	<p>
	결제수단 추가 | 결제수단 삭제
	<c:if test="${user_grade == 0}">
		</div>
		<div class="item" onclick="location.href='${pageContext.request.contextPath}/member/memberList.do'">
		<b>회원관리</b>
		<p>
		회원목록 관리 | 프로젝트 관리
		</div>
	</c:if>
</div>