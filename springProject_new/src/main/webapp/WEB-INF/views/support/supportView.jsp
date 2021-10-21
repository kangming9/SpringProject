<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/support.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script>

	$(document).ready(function(){
	});

</script>
<!-- 중앙 내용 시작 -->
<div class="container">
	<div class="container-title"><span>후원하기</span></div>
	<form:form id="register_form" action="result.do" modelAttribute="supportVO">
	<input type="hidden" value="${gift.num}" name="g_num">
	<input type="hidden" value="${gift.p_num}" name="p_num">
	<%-- <input type="hidden" value="${support.gift_option}" name="gift_option"> --%>
	<input type="hidden" value="${support.support_amount}" name="support_amount">
	<input type="hidden" value="${support.donation}" name="donation">
	<div class="support-info">
		<div class="info-title">선물 정보 <button class="change-btn">변경</button></div>
		<div class="info-wrap">
			<div class="info-con">
				<span class="info-name">선물 이름</span>
				<span class="info-item">${gift.name}</span>
			</div>
			<div class="info-con">
				<span class="info-name">선물 금액</span>
				<span class="info-item">${gift.price_str}원</span>
			</div>
			<div class="info-con">
				<span class="info-name">추가 후원금</span>
				<span class="info-item">${support.donation_str}원</span>
			</div>
			<div class="info-con">
				<span class="info-name support_amount">최종 후원금</span>
				<span class="info-item support_amount">${support.support_amount_str}원</span>
			</div>
		</div>
	</div>
	<div class="support-info">
		<div class="info-title">후원자 정보</div>
		<div class="info-wrap">
			<div class="info-con">
				<span class="info-name">이름</span>
				<span class="info-item">${member.name}</span>
			</div>
			<div class="info-con">
				<span class="info-name">연락처</span>
				<span class="info-item">${member.phone}</span>
			</div>
			<div class="info-con">
				<span class="info-name">이메일</span>
				<span class="info-item">${member.email}</span>
			</div>
		</div>
	</div>
	<c:if test="${gift.due_ship == 1}">
	<div class="support-info">
		<div class="info-title">배송지 <button class="change-btn" >변경</button></div>
		<c:if test="${deliveryCnt > 0}">
			<c:forEach var="delivery" items="${deliveryList}">
				<c:if test="${delivery.address_check==1}">
					<div class="info-wrap">
						<div class="info-con">
							<span class="info-name">받는사람</span>
							<span class="info-item">${delivery.name}</span>
						</div>
						<div class="info-con">
							<span class="info-name">주소</span>
							<span class="info-item">[${delivery.zipcode}] ${delivery.address} ${delivery.address_detail}</span>
						</div>
						<div class="info-con">
							<span class="info-name">연락처</span>
							<span class="info-item">${delivery.phone}</span>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</c:if>
		<c:if test="${deliveryCnt == 0}">
			<div class="info-wrap">
				배송지 정보가 없습니다.<br>
			</div>
		</c:if>
	</div>
	</c:if>
	<div class="support-info">
		<div class="info-title">결제수단 <button class="change-btn" >추가</button></div>
		<div class="info-wrap">
			<div class="info-con">
				<span class="info-name"></span>
				<span class="info-item"></span>
			</div>
		</div>
	</div>
	<div class="btn-wrap"><button type="submit" class="supportButton">결제하기</button></div>
	</form:form>
</div>
<!-- 중앙 내용 끝 -->