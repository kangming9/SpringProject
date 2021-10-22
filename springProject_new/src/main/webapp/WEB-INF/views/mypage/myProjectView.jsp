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
<div class="myPro_Container">
	<c:if test="${count == 0}">
		<div>
			창작한 프로젝트가 존재하지 않습니다.
		</div>
	</c:if>
	<c:if test="${count > 0}">
		<c:forEach var="project" items="${list}">
			<div class="myPro__item">
				<c:if test="${project.photo == 'default_team.jpg'}">
				<a href="${pageContext.request.contextPath}/mypage/myProjectDetail.do?name=${project.name}">
					<img class="photo" src="${pageContext.request.contextPath}/resources/images/default_team.jpg" >
				</a>
				</c:if>
				<c:if test="${project.photo != 'default_team.jpg'}">
				<a href="${pageContext.request.contextPath}/mypage/myProjectDetail.do?name=${project.name}">
					<img class="photo" src="${pageContext.request.contextPath}/upload/${project.photo}">
				</a>
				</c:if>
				<div class="myPro__item_content">
					<ul>
						<li>
						<b><a href="${pageContext.request.contextPath}/mypage/myProjectDetail.do?name=${project.name}">${project.name}</a></b>
						<c:if test="${project.category==0}">온라인</c:if>
						<c:if test="${project.category==1}">모바일</c:if>
						<c:if test="${project.category==2}">보드</c:if>
						<c:if test="${project.category==3}">카드</c:if>
						</li>
						<p>
						<li>프로젝트 번호 : ${project.num}</li>
						<li>목표 금액 : ${project.goal_amount}</li>
						<li>종료일 : ${project.finish_date}</li>
						<c:if test="${project.approval==-1}"><li>임시저장</li></c:if>
						<c:if test="${project.approval==0}"><li>심사대기</li></c:if>
						<c:if test="${project.approval==1}"><li>승인</li></c:if>
						<c:if test="${project.approval==2}"><li>반려</li></c:if>
					</ul>
				</div>
			</div>
		</c:forEach>
	</c:if>
</div>
<div class="align-center">${pagingHtml}</div>
