<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css" type="text/css">
<div>
	<div class="miniTitle_left">
	<b class="miniTitle_content">후원프로젝트</b>
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
	<span class="top_supNum">후원번호 : ${support.num} 후원 날짜 : ${support.payment_date}</span>
	<table class="supDetailtable">
		<colgroup>
			<col style="width:55%;">
			<col style="width:15%;">
			<col style="width:10%;">
			<col style="width:10%;">
			<col style="width:10%;">
		</colgroup>
		<thead class="align-center">
			<tr><td colspan="5"><hr class="slimHr"></td></tr>
			<tr class="top_title">
				<th>프로젝트 정보</th>
				<th>선물 정보</th>
				<th>총 후원 금액</th>
				<th>배송</th>
				<th>진행상황</th>
			</tr>
		<thead>
		<tbody>
			<tr>
				<td colspan="5"><hr size=0.5></td>
			</tr>
			<tr>
			<td>
				<div class="plex_container align-left">
					<div class="plex_items">
						<c:if test="${support.photo == 'default_team.jpg'}">
							<a href="${pageContext.request.contextPath}/project/detail.do?num=${support.p_num}">
							<img class="detailPhoto" src="${pageContext.request.contextPath}/resources/images/default_team.jpg" >
							</a>
						</c:if>
						<c:if test="${support.photo != 'default_team.jpg'}">
							<a href="${pageContext.request.contextPath}/project/detail.do?num=${support.p_num}">
							<img class="detailPhoto" src="${pageContext.request.contextPath}/upload/${support.photo}">
							</a>
						</c:if>
					</div>
					<div class="plex_items" id="supPro_content">
						<p>
						<b>${support.name}</b>
						<span>
							<c:if test="${support.category==0}"> | 온라인</c:if>
							<c:if test="${support.category==1}"> | 모바일</c:if>
							<c:if test="${support.category==2}"> | 보드</c:if>
							<c:if test="${support.category==3}"> | 카드</c:if>
						</span>
						</p>
						<p id="pro-summary" class="subpro_detailContet">${support.summary}</p>
						<p class="subpro_detailContet">프로젝트 번호 : ${support.p_num}</p>
						<p class="subpro_detailContet">목표 금액 : <fmt:formatNumber value="${support.goal_amount}" pattern="#,###,###"/></p>
						<p class="subpro_detailContet">프로젝트 마감일 : ${support.finish_date}</p>
					</div>
				</div>
			</td>
			<td class="align-center">
					<p style="margin: 0; padding-bottom: 5px;">${support.name_1}</p>
					<c:forEach var="gift" items="${gift}">
						<p style="margin: 0 0 4px 0; padding: 0; font-size: 10px;">${gift.name} x ${gift.gd_count}</p>
					</c:forEach>
			</td>
			<td class="align-center">
			<fmt:formatNumber value="${support.support_amount}" pattern="#,###,###"/>
			</td>
			<td class="align-center">
				<c:if test="${support.due_ship==0}">배송없는 제품</c:if>
				<c:if test="${support.due_ship==1}">배송 예정</c:if>
			</td>
			<td class="align-center">
				<c:if test="${support.payment==0}">결제 대기중</c:if>
				<c:if test="${support.payment==1}">결제 완료</c:if>
				<c:if test="${support.payment==2}">결제 취소</c:if>
			</td>
			<tr>
			<tr><td colspan="5"><hr size=0.5></td></tr>
		</tbody>
	</table>
		<p>
		<span class="top_supNum">결제 정보</span>
		<table id="supPaymentDetailtable">
			<colgroup>
				<col style="width:30%;">
				<col style="width:30%;">
				<col style="width:40%;">
			</colgroup>
			<thead class="align-center">
				<tr class="top_title" class="align-items">
					<th><p>선물 금액</p></th>
					<th><p>추가 후원금액</p></th>
					<th><p>총 후원 금액</p></th>
				</tr>
			<thead>
			<tbody>
				<tr>
					<td class="align-center"><span class="supPamentContent"><fmt:formatNumber value="${support.price}" pattern="#,###,###"/></span>원</td>
					<td class="align-center"><span class="supPamentContent"><fmt:formatNumber value="${support.donation}" pattern="#,###,###"/></span>원</td>
					<td class="align-center"><span class="color supPamentContent"><fmt:formatNumber value="${support.support_amount}" pattern="#,###,###"/></span>원</td>
				<tr>
			</tbody>
		</table>
	<c:if test="${support.due_ship==1}">
		<span class="top_supNum">배송지 정보</span>
		<table class="supDetailtable">
			<colgroup>
				<col style="width:30%;">
				<col style="width:70%;">
			</colgroup>
			<thead class="align-center">
				<tr><td colspan="2"><hr class="slimHr"></td></tr>
			<thead>
			<tbody>
				<tr>
					<th class="align-center supDelTitle">받으시는분</th>
					<td colspan="2" class="supDelTitle_content supDel_padding">${delivery.name}</td>
				</tr>
				<tr><td colspan="2"><hr size=0.5></td></tr>
				<tr>
					<th class="align-center supDelTitle">휴대폰 번호</th>
					<td colspan="2" class="supDelTitle_content supDel_padding">${delivery.phone}</td>
				</tr>
				<tr><td colspan="2"><hr size=0.5></td></tr>
				<tr>
					<th class="align-center supDelTitle">배송지 주소</th>
					<td colspan="2" class="supDelTitle_content supDel_padding">[${delivery.zipcode}] ${delivery.address} ${delivery.address_detail}</td>
				</tr>
				<tr><td colspan="2"><hr size=0.5></td></tr>
			</tbody>
		</table>
	</c:if>
	<span class="top_supNum">결제 수단</span>
	<table class="supDetailtable">
		<colgroup>
			<col style="width:30%;">
			<col style="width:70%;">
		</colgroup>
		<thead class="align-center">
			<tr><td colspan="2"><hr class="slimHr"></td></tr>
		<thead>
		<tbody>
			<tr>
				<th class="align-center supDelTitle">결제 수단</th>
				<td colspan="2" class="supDelTitle_content supDel_padding">이니시스 간편결제</td>
			</tr>
			<tr><td colspan="2"><hr size=0.5></td></tr>
			<tr>
				<th class="align-center supDelTitle">결제 금액</th>
				<td colspan="2" class="supDelTitle_content supDel_padding"><fmt:formatNumber value="${support.support_amount}" pattern="#,###,###"/>원</td>
			</tr>
			<tr><td colspan="2"><hr size=0.5></td></tr>
			<tr>
				<th class="align-center supDelTitle">결제 상태</th>
				<td colspan="2" class="supDelTitle_content supDel_padding">${support.payment_date} 결제 예약</td>
			</tr>
			<tr><td colspan="2"><hr size=0.5></td></tr>
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
		
	</c:if>
</div>