<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/projectView.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		$('#reason').hide();
		
		$('#return').click(function(){
	    	$('#reason').show();
	    	$('#confirm_project_form').submit(function(){
				if($('#reason').val().trim()==''){
		    		alert('반려사유는 필수 기재 사항입니다.');
		    		return false;
		    	}
    		});
	    });
		
		$('#approval').click(function(){
	    	$('#reason').hide();
	    	
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
			<div class="confirm-type">
			<h2>승인 여부 채택</h2>
			<form action="confirmResult.do" method="get" id="confirm_project_form">
				<ul class="confirm-type-radio">
					<li>
						<input type="hidden" value="${project.num}" name="num">
						<label><input type="radio" name="approval" id="approval" value="1">승인</label>
			  	  		<label><input type="radio" name="approval" id="return" value="2">반려</label>
			  	  	</li>
					<li class="confirm-return-reason">
			  	  		<textarea cols="30" rows="5" name="reason" id="reason" placeholder="프로젝트 반려 이유를 구체적으로 작성해주세요."></textarea>
					</li>
				</ul>
				<div class="confirm-result-submit">
					<input type="submit" value="심사결과 전송" class="confirm-result-submit">
				</div>
			</form>
			</div>
			<div class="explanation">
				<p><i class="far fa-flag icon"></i> 목표 금액 ${project.goal_amount_str} 원<br>
				<i class="far fa-flag icon"></i> 펀딩 기간 ${project.start_date} ~ ${project.finish_date}<br><br>
				목표 금액이 100% 이상 모이면 펀딩이 성공되며<br>
				결제는 펀딩마감일에 일괄적으로 진행됩니다.</p>
			</div>
			<c:if test="${project.during > 0}">
			<ul class="infomations">
				<li>
					<div>
						<div class="info-title">프로젝트 소개</div>
						<div  class="info-content">${project.summary}</div>
					</div>
				</li>
			</ul>
			<div class="explanation">
				<p><i class="far fa-flag icon"></i> 목표 금액 ${project.goal_amount_str} 원<br>
				<i class="far fa-flag icon"></i> 펀딩 기간 ${project.start_date} ~ ${project.finish_date}<br><br>
				목표 금액이 100% 이상 모이면 펀딩이 성공되며<br>
				결제는 펀딩마감일에 일괄적으로 진행됩니다.</p>
			</div>
			</c:if>
			<div class="btn-wrapper">
				<ul class="outline-btns">
					<c:if test="${project.during > 0}">
						<li><button class="during-btn" disabled='disabled' >${project.start_date}일 공개 예정</button></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
	<hr>
	<div class="nav_wrap">
		<ul>
			<li class="btn_project"><a>프로젝트 계획</a></li>
		</ul>
	</div>
	<hr>
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
							<form id="gift-form">
								<input type="hidden" value="${project.num}" name="p_num">
								<input type="hidden" value="${gift.num}" name="g_num">
								
								<span class="ginfo">
									<span class="price"><b>${gift.price_str}원</b></span>
									<span class="rest_cnt">${gift.rest_cnt}개 남음</span>
								</span>
								<div class="name ginfo">${gift.name}</div>
								<c:forEach var="component" items="${comList}">
									<c:if test="${component.num == gift.num}">
										<div class="component">- ${component.gd_name} x ${component.gd_count}</div>
									</c:if>
								</c:forEach>
								<c:if test="${gift.due_ship == 1}">
									<div class="ship">선물 배송 예정일: ${project.finish_date}</div>
								</c:if>
								<c:if test="${gift.optional == 1}">
									<div class="option-wrap">
										<div>옵션</div>
										<input type="text" class="optional" name="optional" placeholder="선물 소개를 참고하여 작성해주세요."> 
									</div>
								</c:if>
								<div class="donation-wrap">
									<div>추가 후원금(선택)</div>
									<c:if test="${gift.rest_cnt > 0}">
										<input type="number" class="donation" name="donation" value="0" min=0 max=200000000 placeholder="0"> 
									</c:if>
									<c:if test="${gift.rest_cnt <= 0}">
										<input type="number" class="donation" name="donation" value="0" min=0 max=200000000 placeholder="0" disabled> 
									</c:if>
								</div>
								<c:if test="${gift.rest_cnt > 0}">
									<button type="submit" class="supportButton">후원하기</button>
								</c:if>
								<c:if test="${gift.rest_cnt <= 0}">
									<button type="submit" class="supportButton disButton" disabled>후원하기</button>
								</c:if>
							</form>
						</div>
						</c:if>
						<c:if test="${project.deadline < 0}">
						<div class="gift-card deadline-card">
							<form id="gift-form">
								<input type="hidden" value="${project.num}" name="p_num">
								<input type="hidden" value="${gift.num}" name="g_num">
								
								<div class="price ginfo"><b>${gift.price_str}원</b></div>
								<div class="name ginfo">${gift.name}</div>
								<c:forEach var="component" items="${comList}">
									<c:if test="${component.num == gift.num}">
										<div class="component">- ${component.gd_name} x ${component.gd_count}</div>
									</c:if>
								</c:forEach>
								<c:if test="${gift.due_ship == 1}">
									<div class="ship">선물 배송 예정일<br>${project.finish_date}</div>
								</c:if>
							</form>
						</div>
						</c:if>
					</c:forEach>
				</c:if>
			</div>
		</div>
	</div>
	
	
</div>
<!-- 중앙 내용 끝 -->