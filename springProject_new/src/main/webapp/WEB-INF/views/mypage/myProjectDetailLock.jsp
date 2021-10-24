<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/projectView.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/projectView.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myProject.css">
<style>
	.ck-editor__editable_inline{
		min-height:500px;
	}
</style>
<script type="text/javascript" src="http://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/uploadAdapter.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/videoAdapter.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		var num = "${num}";
		
		$("#project_info_form").submit(function(){
			return false;
		});
		
		$("#support_info_form").submit(function(){
			return true;
		});
		
		$("#state_info_form").submit(function(){
			return true;
		});
		
		$("#money_info_form").submit(function(){
			return true;
		});
		
	});
</script>

<!-- 중앙 내용 시작 -->
<div class="container">
	<div id="btndiv" class="info">
		<div class="btnform">
			<form:form id="project_info_form" action="projectInfo.do" modelAttribute="projectVO">
				<form:input type="hidden" path="name" value="${name}" />
				<form:input type="hidden" path="goal_amount_str" value="project" />
				<form:button>프로젝트 정보</form:button>
			</form:form>
		</div>
		<div class="btnform">
			<form:form id="support_info_form" action="projectInfo.do" modelAttribute="projectVO">
				<form:input type="hidden" path="name" value="${name}" />
				<form:input type="hidden" path="goal_amount_str" value="support" />
				<form:button>후원자 정보</form:button>
			</form:form>
		</div>
		<div class="btnform">
			<form:form id="state_info_form" action="projectInfo.do" modelAttribute="projectVO">
				<form:input type="hidden" path="name" value="${name}" />
				<form:input type="hidden" path="goal_amount_str" value="state" />
				<form:button>후원자 통계</form:button>
			</form:form>
		</div>
		<div class="btnform">
			<form:form id="money_info_form" action="projectInfo.do" modelAttribute="projectVO">
				<form:input type="hidden" path="name" value="${name}" />
				<form:input type="hidden" path="goal_amount_str" value="money" />
				<form:button>후원금 정보</form:button>
			</form:form>
		</div>
	</div>
	<div id="test" class="info">
		<div>
			<h2>테스트 페이지</h2>
			작성된 프로젝트를 기반으로 구성된 테스트 페이지입니다.<br>
			실제 프로젝트 펀딩 페이지와는 다소 차이가 있습니다.
		</div>
	</div>
	<hr>
	<br>
	<div class="projectTop">
		<div class="category">
			<c:if test="${category == '0'}">온라인</c:if>
			<c:if test="${category == '1'}">모바일</c:if>
			<c:if test="${category == '2'}">보드</c:if>
			<c:if test="${category == '3'}">카드</c:if>
		</div>
		<div class="name" id="name">${name}</div>
	</div>
	
	<div class="projectOutline">
		<div class="outline-left">
			<c:if test="${photo == 'default_team.jpg'}">
				<img class="photo" src="${pageContext.request.contextPath}/resources/images/default_team.jpg">
			</c:if>
			<c:if test="${photo != 'default_team.jpg'}">
				<img class="photo" src="${pageContext.request.contextPath}/upload/${photo}">
			</c:if>
		</div>
		<div class="outline-right">
			<ul class="infomations">
				<li>
					<div>
						<div class="info-title">모인금액</div>
						<div class="info-content"><b>0</b> 원 / <b>${goal_amount}</b> 원</div>
						<div class="progress-wrapper">
							<progress value="0" max="100"></progress>
							<div class="progressper info-content">&nbsp;<b>0%</b></div>
						</div>
					</div>
				</li>
				<li>
					<div>
						<div class="info-title">남은기간</div>
						<div class="info-content"><b>0</b> 일</div>
					</div>
				</li>
				<li>
					<div>
						<div class="info-title">후원자</div>
						<div  class="info-content"><b>0</b> 명</div>
					</div>
				</li>
			</ul>
			<div class="explanation">
				<p><i class="far fa-flag icon"></i> 목표 금액 ${goal_amount} 원<br>
				<i class="far fa-flag icon"></i> 펀딩 기간 ${start_date} ~ ${finish_date}<br><br>
				목표 금액이 100% 이상 모이면 펀딩이 성공되며<br>
				결제는 펀딩마감일에 일괄적으로 진행됩니다.</p>
			</div>
			<div class="btn-wrapper">
				<ul class="outline-btns">
					<li><button class="support-btn">프로젝트 후원하기</button></li>
				</ul>
			</div>
		</div>
	</div>
	<hr>
	<div class="nav_wrap">
		<ul>
			<li class="btn_project">프로젝트 계획</li>
		</ul>
	</div>
	<hr>
	<div class="content">
		<div class="content-right">
			<div id="intro" class="con-title">&nbsp;&nbsp;소개</div>
			<div class="intro">${intro}</div>
			<hr>
			<div id="policy" class="con-title">&nbsp;&nbsp;정책</div>
			<div class="policy">${policy}</div>
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
						<div class="gift-card">
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
									<div class="ship">선물 배송 예정일<br>${finish_date}</div>
								</c:if>
								<div class="donation-wrap">
									<div>추가 후원금(선택)</div>
									<input type="number" class="donation" name="donation" value="0" min=0 max=200000000 placeholder="0"> 
								</div>
								<button class="supportButton">후원하기</button>
						</div>
						
					</c:forEach>
				</c:if>
			</div>
		</div>
	</div>
</div>