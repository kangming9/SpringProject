<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css" type="text/css">
<div>
	<div class="miniTitle_left">
	<b class="miniTitle_content">나의 프로젝트</b>
	</div>
	<div class="miniTitle_right">
		<br>
		<i class="fas fa-bell xs" id="notice_alarm"></i>
		나의 프로젝트 크레이지 아케이드 목표금액 달성
	</div>
	<hr noshade="noshade" class="line">
</div>
<div class="">
	<c:if test="${support.num <= 0}">
		<div>
			창작한 프로젝트가 존재하지 않습니다.
		</div>
	</c:if>
	<c:if test="${support.num > 0}">
		<div class="">
			<c:if test="${support.photo == 'default_team.jpg'}">
				<img class="photo" src="${pageContext.request.contextPath}/resources/images/default_team.jpg" >
			</c:if>
			<c:if test="${support.photo != 'default_team.jpg'}">
				<img class="photo" src="${pageContext.request.contextPath}/upload/${support.photo}">
			</c:if>
			<div class="">
				<ul>
					<li>
					<b>${support.name}</b>
					<c:if test="${support.category==0}">온라인</c:if>
					<c:if test="${support.category==1}">모바일</c:if>
					<c:if test="${support.category==2}">보드</c:if>
					<c:if test="${support.category==3}">카드</c:if>
					</li>
					<p>
					<li>목표 금액 : ${support.goal_amount}</li>
					<li>종료일 : ${support.finish_date}</li>
					<c:if test="${support.approval==-1}"><li>임시저장</li></c:if>
					<c:if test="${support.approval==0}"><li>심사대기</li></c:if>
					<c:if test="${support.approval==1}"><li>승인</li></c:if>
					<c:if test="${support.approval==2}"><li>반려</li></c:if>
				</ul>
				<ul>
					후원정보
					<li>후원 날짜 : ${support.payment_date}</li>
					<li>후원 번호 : ${support.num}</li>
					<li>펀딩 마감일 : ${support.finish_date}</li>
				</ul>
				<ul>
					선물정보
					<li>선택 선물 : ${support.name_1}</li>
					<li>선물 금액 : ${support.price}</li>
					<li>후원 금액 : ${support.donation}</li>
					<li>총 금액 : ${support.support_amount}</li>
				</ul>
				<ul>
					결제정보
					<li>결제 상태 : ${support.payment}</li>
				</ul>
			</div>
		</div>
	</c:if>
</div>

num=11, 후원번호
m_num=4, 
p_num=0, 
payment_date=2021-10-21, 
payment=0, 
g_num=14, 
support_amount=100000, 
gift_option=null, 
donation=0, 
donation_str=0, 
support_amount_str=100,000, 
name=여덟시오십일분, 
category=0, 
finish_date=2021-10-31, 
photo=1634817120444cat8.jpg, 
ship=0, 
approval=1, 
goal_amount=3000000, 
name_1=집사, 
price=100000, 
due_ship=0, 
num_component=0