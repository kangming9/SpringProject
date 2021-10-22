<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css" type="text/css">
<div>
	<div class="miniTitle_left">
	<b class="miniTitle_content">후원 프로젝트</b>
	</div>
	<div class="miniTitle_right">
		<br>
		<i class="fas fa-bell xs" id="notice_alarm"></i>
		나의 프로젝트 크레이지 아케이드 목표금액 달성
	</div>
	<hr noshade="noshade" class="line">
</div>
<div class="supDetail-container">
	<c:if test="${support.num == 0}">
		<div>
			창작한 프로젝트가 존재하지 않습니다.
		</div>
	</c:if>
	<c:if test="${support.num > 0}">
		<div class="myPro__item">
			<div class="myPro__item_content">
			<table style="width: 100%">
				<thead>
				<tr>
					<th>프로젝트 정보</th>
					<th>선물 정보</th>
					<th>총 후원 금액</th>
					<th>배송</th>
					<th>진행상황</th>
				</tr>
				<thead>
				<tbody>
					<td style="background-color: red;">
						<div class="supTitle_left">
							<c:if test="${support.photo == 'default_team.jpg'}">
								<img class="detailPhoto" src="${pageContext.request.contextPath}/resources/images/default_team.jpg" >
							</c:if>
							<c:if test="${support.photo != 'default_team.jpg'}">
								<img class="detailPhoto" src="${pageContext.request.contextPath}/upload/${support.photo}">
							</c:if>
						</div>
						<div class="supTitle_right">
							<b>${support.name}</b>
							<span>
								<c:if test="${support.category==0}"> | 온라인</c:if>
								<c:if test="${support.category==1}"> | 모바일</c:if>
								<c:if test="${support.category==2}"> | 보드</c:if>
								<c:if test="${support.category==3}"> | 카드</c:if>
							</span>
								<li>${support.summary}</li>
								<li>프로젝트 번호 : ${support.p_num}</li>
								<li>목표 금액 : ${support.goal_amount}</li>
								<li>프로젝트 마감일 : ${support.finish_date}</li>
						</div>
					</td>
					<td style="clear: both;">${support.name_1}</td>
					<td>${support.support_amount}</td>
					<td>${support.due_ship}</td>
					<td>
						<c:if test="${support.payment==0}">결제 대기중</c:if>
						<c:if test="${support.payment==1}">결제 완료</c:if>
						<c:if test="${support.payment==2}">결제 취소</c:if>
					</td>
					
				</tbody>
			</table>
				<%-- <ul>
					<li>
					
					</li>
					<li id="pro-summary">${support.summary}</li>
					<div id="pro-detail-content">
						<div>
							<li>프로젝트 번호 : ${support.p_num}</li>
							<li>목표 금액 : ${support.goal_amount}</li>
							<li id="supTitle_left">프로젝트 마감일 : ${support.finish_date}</li>
							<li class="supTitle_right">
								<c:if test="${support.approval==-1}"><span id="mainDel">임시저장</span></c:if>
								<c:if test="${support.approval==0}"><span id="mainDel">심사대기</span></c:if>
								<c:if test="${support.approval==1}"><span id="mainDel">승인</span></c:if>
								<c:if test="${support.approval==2}"><span id="mainDel">반려</span></c:if>
							</li>
						</div>
						<hr noshade="noshade" class="content_line">
						<div>
							<li><b>후원 정보</b></li>
							<li>후원 번호 : ${support.num}</li>
							<li>후원 날짜 : ${support.payment_date}</li>
							<li>펀딩 마감일 : ${support.finish_date}</li>
						</div>
						<div>
							<li><b>선물 정보</b></li>
							<li>선택한 선물 : ${support.name_1}</li>
							<li>선물 금액 : ${support.price}</li>
							<li>추가 후원금액 : 
								<c:if test="${support.donation==0}">없음</c:if>
							</li>
						</div>
						<div>
							<li><b>결제 정보</b></li>
							<li>결제 수단 : </li>
							<li>결제 금액 : ${support.support_amount}</li>
							<li>결제 상태 : 
								<c:if test="${support.payment==0}">결제 대기중</c:if>
								<c:if test="${support.payment==1}">결제 완료</c:if>
								<c:if test="${support.payment==2}">결제 취소</c:if>
							</li>
						</div>
					</div>
				</ul> --%>
			</div>
		</div>
	</c:if>
</div>