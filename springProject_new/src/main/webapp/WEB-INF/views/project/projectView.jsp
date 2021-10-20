<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/projectView.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/JavaScript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>

	$(document).ready(function(){
		
	    $(".support-btn").click(function(){
	    	var offset = $('#gift').offset();
        	$('html').animate({scrollTop : offset.top}, 400);
	    });
	       
	    $(".share-btn").click(function() {
	    	$(".popup_box").show();
	    }); 
	        
	    $(".btn_close").click(function() {
	    	$(".popup_box").hide();
	   	});
	        
	    // 팝업 중앙 정렬 
	   	var $layerPopup = $(".popup_box"); 
	    var left = ($(window).scrollLeft() + ($(window).width() - $layerPopup.width()) / 2); 
	    var top = ($(window).scrollTop() + ($(window).height() - $layerPopup.height()) / 2 ); 
	    $layerPopup.css({ "left": left, "top":top, "position": "absolute" }); 
	    $("body").css("position", "relative").append($layerPopup);


	    $(".intro-btn").click(function(){
	    	var offset = $('#intro').offset();
        	$('html').animate({scrollTop : offset.top}, 400);
	    });
	    
	    $(".policy-btn").click(function(){
	    	var offset = $('#policy').offset();
        	$('html').animate({scrollTop : offset.top}, 400);
	    });
	    
	    var name = document.getElementById('name').innerText;
	    Kakao.init('270eccb7a827787cdc99e45e3c8037a5'); // JS key
	    $("#kakao-link-btn").click(function () {
	    	var path = window.location.pathname + window.location.search;
	        Kakao.Link.sendCustom({
	        	templateId: 63125,   // 템플릿 ID
	        	templateArgs: {
	        		title: name,
	        		description: "펀딩어드벤처에서 펀딩하고 선물받자!!",
	        		url : path,
	        	},
	        });
	    });
	    
	    $("#clip-link-btn").click(function () {
	    	var url = '';
	    	var textarea = document.createElement("textarea");
	    	document.body.appendChild(textarea);
	    	url = window.document.location.href;
	    	textarea.value = url;
	    	textarea.select();
	    	document.execCommand("copy");
	    	document.body.removeChild(textarea);
	    	alert("URL이 복사되었습니다.")
	   	});

	});

</script>
<!-- 중앙 내용 시작 -->
<div class="container">
	<div class="projectTop">
		<div class="category">
			<c:if test="${project.category == 0}">온라인</c:if>
			<c:if test="${project.category == 1}">모바일</c:if>
			<c:if test="${project.category == 2}">보드</c:if>
			<c:if test="${project.category == 3}">카드</c:if>
		</div>
		<div class="name" id="name">${project.name}</div>
		<div class="creator">
			<div class="profile">
			<c:if test="${empty creator.photo}">
				<img class="my-photo" src="${pageContext.request.contextPath}/resources/images/userimage.png" width="25" height="25">
			</c:if>
			<c:if test="${!empty creator.photo}">
				<img class="my-photo" src="${pageContext.request.contextPath}/mypage/mphotoView.do?num=${project.m_num}" width="25" height="25">
			</c:if>
			</div>
			<div class="nickname">&nbsp;${project.nickname}</div>
		</div>
	</div>
	
	<div class="projectOutline">
		<div class="outline-left">
			<c:if test="${project.photo == 'default_team.jpg'}">
				<img class="photo" src="${pageContext.request.contextPath}/resources/images/default_team.jpg">
			</c:if>
			<c:if test="${project.photo != 'default_team.jpg'}">
				<img class="photo" src="${pageContext.request.contextPath}/upload/${project.photo}">
			</c:if>
		</div>
		<div class="outline-right">
			<ul class="infomations">
				<li>
					<div>
						<div class="info-title">모인금액</div>
						<div class="info-content"><b>${project.amount}</b> 원 / <b>${project.goal_amount_str}</b> 원</div>
						<div class="progress-wrapper">
							<progress value="${project.progress}" max="100"></progress>
							<div class="progressper info-content">&nbsp;<b>${project.progress}%</b></div>
						</div>
					</div>
				</li>
				<li>
					<div>
						<div class="info-title">남은기간</div>
						<c:if test="${project.deadline < 0}">
							<div class="info-content">마감</div>
						</c:if>
						<c:if test="${project.deadline >= 0}">
							<div class="info-content"><b>${project.deadline}</b> 일</div>
						</c:if>
					</div>
				</li>
				<li>
					<div>
						<div class="info-title">후원자</div>
						<div  class="info-content"><b>${supporter}</b> 명</div>
					</div>
				</li>
			</ul>
			<div class="explanation">
				<p><i class="far fa-flag icon"></i> 목표 금액 ${project.goal_amount_str} 원<br>
				<i class="far fa-flag icon"></i> 펀딩 기간 ${project.start_date} ~ ${project.finish_date}<br><br>
				목표 금액이 100% 이상 모이면 펀딩이 성공되며<br>
				결제는 펀딩마감일에 일괄적으로 진행됩니다.</p>
			</div>
			<div class="btn-wrapper">
				<ul class="outline-btns">
					<c:if test="${project.deadline >= 0}">
						<li><button class="support-btn">후원하기</button></li>
						<li><button class="share-btn" data-name="open_tooltip"><i class="fas fa-share-alt"></i></button></li>
					</c:if>
					<c:if test="${project.deadline < 0}">
						<li><button class="deadline-btn" disabled='disabled' >펀딩이 마감되었습니다.</button></li>
					</c:if>
				</ul>
			</div>
			<div class="popup_box"> 
	            <button type="button" class="btn_close">X</button> 
	            <div class="popup_cont"> 
	               <div>공유하기</div>
	               <button id="kakao-link-btn" class="s-btn" type="button">
	                     <img src="//developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png" height="40" width="40"/>
	                  </button>
	               <button id="clip-link-btn" class="s-btn" type="button"><i class="far fa-clipboard"></i></button>
	            </div> 
            </div>
		</div>
	</div>
	<hr>
	<div class="nav_wrap">
		<ul>
			<li class="btn_project"><a href="">프로젝트 계획</a></li>
			<li class="btn_notice"><a href="">공지사항</a></li>
			<li class="btn_qna"><a href="${pageContext.request.contextPath}/question/register.do?p_num=${project.num}">문의하기</a></li>
		</ul>
	</div>
	<hr>
	<div class="nav_project">
		<ul>
			<li><button class="intro-btn">소개</button></li>
			<li><button class="policy-btn">정책</button></li>
		</ul>
	</div>
	<div class="content">
		<div class="content-right">
			<div id="intro" class="con-title">&nbsp;&nbsp;소개</div>
			<div class="intro">${project.intro}</div>
			<hr>
			<div id="policy" class="con-title">&nbsp;&nbsp;정책</div>
			<div class="policy">${project.policy}</div>
		</div>
		<div class="content-left">
			<div id="gift" class="content-left-name"><b>선물 선택</b></div>
			<div>
				<c:if test="${giftCnt == 0}">
					<div>
						<br>등록된 선물이 없습니다.
					</div>
				</c:if>
				<c:if test="${giftCnt > 0}">
					<c:forEach var="gift" items="${giftList}">
						<c:if test="${project.deadline >= 0}">
						<div class="gift-card">
							<a href="${pageContext.request.contextPath}/support/support.do?num=${project.num}&g_num=${gift.num}">
								<span class="price ginfo"><b>${gift.price_str}원</b></span>
								<span class="name ginfo">${gift.name}</span>
								<c:forEach var="component" items="${comList}">
									<c:if test="${component.num == gift.num}">
										<span class="component">- ${component.gd_name} x ${component.gd_count}</span>
									</c:if>
								</c:forEach>
								<c:if test="${gift.due_ship == 1}">
									<span class="ship">선물 배송 예정일<br>${project.finish_date}</span>
								</c:if>
							</a>
						</div>
						</c:if>
						<c:if test="${project.deadline < 0}">
						<div class="gift-card deadline-card">
							<a>
								<span class="price ginfo"><b>${gift.price_str}원</b></span>
								<span class="name ginfo">${gift.name}</span>
								<c:forEach var="component" items="${comList}">
									<c:if test="${component.num == gift.num}">
										<span class="component">- ${component.gd_name} x ${component.gd_count}</span>
									</c:if>
								</c:forEach>
								<c:if test="${gift.due_ship == 1}">
									<span class="ship">선물 배송 예정일<br>${project.finish_date}</span>
								</c:if>
							</a>
						</div>
						</c:if>
					</c:forEach>
				</c:if>
			</div>
		</div>
	</div>
</div>
<!-- 중앙 내용 끝 -->