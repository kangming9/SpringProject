<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/support.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>

	$(document).ready(function(){
		$(".updateGift").on("click", function(event) {
		    $("#giftList").show();
		    
		    var donation = $(".support_donation").text().replace(/[^0-9]/g,'');
		    $(".change-donation").val(donation);
		    
		    $("body").append('<div class="backon"></div>');
		    $(".menu").css("z-index",0);
		    
		    $(".disGift").attr('disabled', 'true');
		});
		
		$(".updateDelivery").on("click", function(event) {
		    $("#deliveryList").show();
		    
		    $("body").append('<div class="backon"></div>');
		    $(".menu").css("z-index",0);
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
				
				var checkOption = ".optional-"+check;
				$(".support_option").text($(checkOption).val());
				$("#gift_option").val($(checkOption).val());
				
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
				
				var checkAddress = ".daddress-"+check;
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
		
		$(".supportButton").on("click", function () {
			var existD = $("input[name='exist-del']").val();
			if(existD == 0){
				alert("배송지를 추가해주세요!");
				return false;
			}
			
			var title = '펀딩어드벤처:'+$(".support_name").text();
			var amount = $("#support_amount").val();
			var email = $(".semail").text();
			var name = $(".sname").text();
			var tel = $(".sphone").text();
			var addr = $(".daddress").text() + $(".daddress_detail").text();
			var postcode = $(".dzipcode").text();
			
			IMP.init('imp82739707');
		
			IMP.request_pay({
				pg: 'html5_inicis', 
				pay_method: 'card',
				merchant_uid: 'merchant_' + new Date().getTime(),
				name: title,
				amount: 100, //amount
				buyer_email: email,
				buyer_name: name,
				buyer_tel: tel,
				buyer_addr: addr,
				buyer_postcode: postcode,
			}, function (rsp) {
				if (rsp.success) {
					var num = $('#num').val();
					var g_num = $('#g_num').val();
					var p_num = $('#p_num').val();
					var d_num = $('#d_num').val();
					var gift_option = $('#gift_option').val();
					var support_amount = $('#support_amount').val();
					var donation = $('#donation').val();
					
					$.ajax({
						url:"insertSupport.do",
						type:"post",
						data: {
							"num" : num,
							"g_num" : g_num,
							"p_num" : p_num,
							"d_num" : d_num,
							"gift_option" : gift_option,
							"support_amount" : support_amount,
							"donation" : donation
						},
						dataType:"json",
						cache:false,
						timeout:30000,
						success:function(param){
							if(param.result == "logout"){
								alert("로그인이 필요한 서비스입니다.");
							}else if(param.result == "success"){
								$("#payment_form").submit();
							}else{
								alert("후원하기 오류:"+param.result);
							}
						},
						error:function(){
							alert('네트워크 오류 발생');
						}
					});
				} else {
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
				}
			});
		});
		 
	});

</script>
<!-- 중앙 내용 시작 -->
<div class="container">
	<div class="container-title"><span>후원하기</span></div>
	<form:form id="payment_form" action="result.do" modelAttribute="supportVO">
	<input type="hidden" id="num" value="${support.num}" name="num">
	<input type="hidden" id="gift_option" value="${support.gift_option}" name="gift_option">
	<input type="hidden" id="g_num" value="${gift.num}" name="g_num">
	<input type="hidden" id="p_num" value="${gift.p_num}" name="p_num">
	<%-- <input type="hidden" id="gift_option" value="${support.gift_option}" name="gift_option"> --%>
	<input type="hidden" id="support_amount" value="${support.support_amount}" name="support_amount">
	<input type="hidden" id="donation" value="${support.donation}" name="donation">
	<div class="support-info">
		<div class="info-title">선물 정보
		<a class="change-btn updateGift">변경</a>
		</div>
		<div id="giftList">
			<div>
				<div class="info-title">선물 리스트</div>
				<hr>
				<c:forEach var="gift" items="${giftList}">
					<div class="gift-card">
						<label>
							<c:if test="${gift.rest_cnt > 0}">
								<input type="radio" name="g_num" value="${gift.num}"/>
							</c:if>
							<c:if test="${gift.rest_cnt <= 0}">
								<input type="radio" name="g_num" class="disGift" value="${gift.num} "/>
							</c:if>
							<span class="name-${gift.num}">${gift.name}</span>
							<span class="card-wrap">
								<span class="price-${gift.num}">${gift.price_str}원</span>
								<c:forEach var="component" items="${comList}">
									<c:if test="${component.num == gift.num}">
										<span class="component">- ${component.gd_name} x ${component.gd_count}</span>
									</c:if>
								</c:forEach>
								<c:if test="${gift.optional==1}">
									<span class="info-con">
										<span>선물 옵션</span>
										<input type="text" class="optional-${gift.num}" name="optional" placeholder="선물 소개를 참고하여 작성해주세요."> 
									</span>
								</c:if>
								<span class="rest-${gift.num}">${gift.rest_cnt}개 남음
									<c:if test="${gift.rest_cnt <= 0}">
								 	 <span class="color">(선택불가)</span>
									</c:if>
								</span>
							</span>
						</label>
					</div>
					<hr>
				</c:forEach>
				<div class="donation-wrap">
					<div class="info-title">추가 후원금(선택)</div>
					<input type="number" class="change-donation" name="donation" value="0" min=0 max=200000000 placeholder="0"> 
				</div>
			</div>
			<div class="popup-btn">
				<div class="giftChangeBtn">변경</div>
				<div class="close">닫기</div>
			</div>
		</div>
		<div class="info-wrap">
			<div class="info-con">
				<span class="info-name">선물 이름</span>
				<span class="info-item support_name">${gift.name}</span>
			</div>
			<c:if test="${support.gift_option!=''}">
				<div class="info-con">
					<span class="info-name">선물 옵션</span>
					<span class="info-item support_option">${support.gift_option}</span>
				</div>
			</c:if>
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
				<span class="info-item sname">${member.name}</span>
			</div>
			<div class="info-con">
				<span class="info-name">연락처</span>
				<span class="info-item">${member.phone}</span>
			</div>
			<div class="info-con">
				<span class="info-name">이메일</span>
				<span class="info-item semail">${member.email}</span>
			</div>
		</div>
	</div>
	<c:if test="${gift.due_ship == 1}">
	<div class="support-info">
		<div class="info-title">배송지 
			<a class="change-btn updateDelivery">변경</a>
			<a class="change-btn" href='${pageContext.request.contextPath}/mypage/myDelivery.do'>추가</a>
		</div>
		<div id="deliveryList">
			<div>
				<div class="info-title">배송지 리스트</div>
				<hr>
				<c:forEach var="del" items="${deliveryList}">
					<div class="del_card">
						<label>
							<input type="radio" name="del_num" value="${del.num}"/>
							<span class="dname-${del.num}">${del.name}</span><c:if test="${del.address_check==1}">&nbsp;&nbsp;<span class="del-default">기본</span></c:if>
							<span class="card-wrap">
								<span>
									<span><b>주소</b></span><br>
									[<span class="dzipcode-${del.num}">${del.zipcode}</span>] 
									<span class="daddress-${del.num}">${del.address}</span> 
									<span class="daddress_detail-${del.num}">${del.address_detail}</span>
								</span>
								<span>
									<span><b>연락처</b></span><br>
									<span class="dphone-${del.num}">${del.phone}</span>
								</span>
							</span>
						</label>
					</div>
					<hr>
				</c:forEach>
			</div>
			<div class="popup-btn">
				<div class="delChangeBtn">변경</div>
				<div class="close">닫기</div>
			</div>
		</div>
		<c:if test="${deliveryCnt > 0}">
			<c:forEach var="delivery" items="${deliveryList}">
				<c:if test="${delivery.address_check==1}">
					<input type="hidden" name="exist-del" value="1">
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
			<input type="hidden" name="exist-del" value="0">
			<div class="info-wrap">
				배송지 정보가 없습니다.<br>
			</div>
		</c:if>
	</div>
	</c:if>
	<div class="btn-wrap"><div class="supportButton">결제 예약하기</div></div>
	</form:form>
</div>
<!-- 중앙 내용 끝 -->