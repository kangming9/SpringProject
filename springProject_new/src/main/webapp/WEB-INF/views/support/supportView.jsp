<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/support.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script>

	$(document).ready(function(){
		$(".updateGift").on("click", function(event) {
		    $("#giftList").show();
		    
		    var donation = $(".support_donation").text().replace(/[^0-9]/g,'');
		    $(".change-donation").val(donation);
		    
		    $("body").append('<div class="backon"></div>');
		});
		
		$(".updateDelivery").on("click", function(event) {
		    $("#deliveryList").show();
		    
		    $("body").append('<div class="backon"></div>');
		});
		
		$('.giftChangeBtn').on("click", function(event) {
			if($('input:radio[name="g_num"]:checked').length < 1){
				alert("선물을 선택하세요!");
				return false;
			}else{
				$("#giftList").hide();
				$(".backon").hide();
				
				var check = $('input:radio[name="g_num"]:checked').val();
				$("#g_num").val(check);
				
				var checkName = ".name-"+check;
				$(".support_name").text($(checkName).text());
				
				var checkPrice = ".price-"+check;
				var price = $(checkPrice).text().replace(/[^0-9]/g,''); 
				$(".support_price").text($(checkPrice).text());
				
				var checkDonation = $(".change-donation").val().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				$(".support_donation").text(checkDonation);
				
				checkDonation = $(".change-donation").val();
				$("#donation").val(Number(checkDonation));
				
				var amount = Number(price) + Number(checkDonation);
				$("#support_amount").val(amount);
				
				amount = String(amount).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				$(".support_amount").text(amount);
			}
		});
		
		$('.delChangeBtn').on("click", function(event) {
			if($('input:radio[name="del_num"]:checked').length < 1){
				alert("배송지를 선택하세요!");
				return false;
			}else{
				$("#deliveryList").hide();
				$(".backon").hide();
				
				var check = $('input:radio[name="del_num"]:checked').val();
				$("#d_num").val(check);
				
				var checkName = ".dname-"+check;
				$(".dname").text($(checkName).text());
				
				var checkZipcode = ".dzipcode-"+check;
				$(".dzipcode").text($(checkZipcode).text());
				
				var checkAddress = ".dAddress-"+check;
				$(".daddress").text($(checkAddress).text());
				
				var checkAddrDetail = ".daddress_detail-"+check;
				$(".daddress_detail").text($(checkAddrDetail).text());
				
				var checkPhone = ".dphone-"+check;
				$(".dphone").text($(checkPhone).text());
		
			}
		});
		    
		$("body").on("click", function(event) {
			if(event.target.className == 'close' || event.target.className == 'backon'){
				$("#giftList").hide();
				$("#deliveryList").hide();
				$(".backon").hide();
		    }
		});
		 
	});

</script>
<!-- 중앙 내용 시작 -->
<div class="container">
	<div class="container-title"><span>후원하기</span></div>
	<form:form id="register_form" action="result.do" modelAttribute="supportVO">
	<input type="hidden" id="g_num" value="${gift.num}" name="g_num">
	<input type="hidden" value="${gift.p_num}" name="p_num">
	<%-- <input type="hidden" value="${support.gift_option}" name="gift_option"> --%>
	<input type="hidden" id="support_amount" value="${support.support_amount}" name="support_amount">
	<input type="hidden" id="donation" value="${support.donation}" name="donation">
	<div class="support-info">
		<div class="info-title">선물 정보
		<a class="change-btn updateGift">변경</a>
		</div>
		<div id="giftList">
			<div>
				<c:forEach var="gift" items="${giftList}">
					<div class="gift-card">
						<label>
							<input type="radio" name="g_num" value="${gift.num}"/>
							<span class="name-${gift.num}">${gift.name}</span>
						</label>
						<div class="price-${gift.num} ginfo">${gift.price_str}원</div>
						<c:forEach var="component" items="${comList}">
							<c:if test="${component.num == gift.num}">
								<div class="component">- ${component.gd_name} x ${component.gd_count}</div>
							</c:if>
						</c:forEach>
					</div>
				</c:forEach>
				<div class="donation-wrap">
					<div>추가 후원금(선택)</div>
					<input type="number" class="change-donation" name="donation" value="0" min=0 max=200000000 placeholder="0"> 
				</div>
			</div>
			<div class="giftChangeBtn">변경</div>
			<div class="close">닫기</div>
		</div>
		<div class="info-wrap">
			<div class="info-con">
				<span class="info-name">선물 이름</span>
				<span class="info-item support_name">${gift.name}</span>
			</div>
			<div class="info-con">
				<span class="info-name">선물 금액</span>
				<span class="info-item support_price">${gift.price_str}원</span>
			</div>
			<div class="info-con">
				<span class="info-name">추가 후원금</span>
				<span class="info-item support_donation">${support.donation_str}원</span>
			</div>
			<div class="info-con">
				<span class="info-name color">최종 후원금</span>
				<span class="info-item color support_amount">${support.support_amount_str}원</span>
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
		<div class="info-title">배송지 
			<a class="change-btn updateDelivery">변경</a>
			<a class="change-btn" href='${pageContext.request.contextPath}/mypage/myDeliveryUpdateForm.do'>추가</a>
		</div>
		<div id="deliveryList">
			<div>
				<c:forEach var="del" items="${deliveryList}">
					<div class="del_item">
						<label>
							<input type="radio" name="del_num" value="${del.num}"/>
							<span class="dname-${del.num}">${del.name}</span><c:if test="${del.address_check==1}">&nbsp;&nbsp;<span id="mainDel">기본</span></c:if>
						</label>
						<div>[<span class="dzipcode-${del.num}">${del.zipcode}</span>] <span class="daddress-${del.num}">${del.address}</span> <span class="daddress_detail-${del.num}">${del.address_detail}</span></div>
						<div class="dphone-${del.num}">${del.phone}</div>
					</div>
				</c:forEach>
			</div>
			<div class="delChangeBtn">변경</div>
			<div class="close">닫기</div>
		</div>
		<c:if test="${deliveryCnt > 0}">
			<c:forEach var="delivery" items="${deliveryList}">
				<c:if test="${delivery.address_check==1}">
					<input type="hidden" id="d_num" value="${delivery.num}" name="d_num">
					<div class="info-wrap">
						<div class="info-con">
							<span class="info-name">받는사람</span>
							<span class="info-item dname">${delivery.name}</span>
						</div>
						<div class="info-con">
							<span class="info-name">주소</span>
							<span class="info-item">[<span class="dzipcode">${delivery.zipcode}</span>] <span class="daddress">${delivery.address}</span> <span class="daddress_detail">${delivery.address_detail}</span></span>
						</div>
						<div class="info-con">
							<span class="info-name">연락처</span>
							<span class="info-item dphone">${delivery.phone}</span>
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
		<div class="info-title">결제수단 <a class="change-btn">추가</a></div>
		<div class="info-wrap">
			<div class="info-con">
				<span class="info-name"></span>
				<span class="info-item"></span>
			</div>
		</div>
	</div>
	<div class="btn-wrap"><button type="submit" class="supportButton">결제 예약하기</button></div>
	</form:form>
</div>
<!-- 중앙 내용 끝 -->