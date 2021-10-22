<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<!-- 메인 시작 -->
	<div class="container">
	<!-- 슬라이드 시작 -->
		<div class="slide">
		  <div class="s" id="s1"></div> 
		  <div class="s" id="s2"></div>
		  <div class="s" id="s3"></div>
		  <div class="s" id="s4"></div>
		  <div class="slider">
		  <div class="slide-full" 
		  	style="background-image:url(${pageContext.request.contextPath}/resources/images/slide05.png);
		  	width:500px;">
		  	<div class="slide-description">
				<h3 class="slide-description-title">소개</h3>
	      		<span class="slide-description-content">펀딩 어드벤처의 위대한 여정</span>
	      		<br>
	      		<button style="background-color:black;border:none;width:200px;height:75px;" onclick="location.href='#'"></button>
			</div>
		  </div>
		  <div class="slide-full"
		  style="background-image:url(${pageContext.request.contextPath}/resources/images/slide03.png);
		  	width:500px;">  
		    <div class="slide-description">
				<h3 class="slide-description-title">창작자 가이드</h3>
	      		<span class="slide-description-content">창작자라면 꼭 지켜주세요</span>
	      		<br>
	      		<button style="background-color:black;border:none;width:200px;height:75px;" onclick="location.href='${pageContext.request.contextPath}/guide/creatorGuide.do'"></button>
			</div>
			</div>
		 <div class="slide-full"
		 style="background-image:url(${pageContext.request.contextPath}/resources/images/slide02.png);
		  	width:500px;" onclick="location.href='#'"> 
		    <div class="slide-description">
				<h3 class="slide-description-title">후원자 가이드</h3>
	      		<span class="slide-description-content">후원자라면 꼭 지켜주세요</span>
	      		<br>
	      		<button style="background-color:black;border:none;width:200px;height:75px;" onclick="location.href='#'"></button>
			</div>
		</div>
		 <div class="slide-full"
		 style="background-image:url(${pageContext.request.contextPath}/resources/images/slide04.png);
		  	width:500px;" onclick="location.href='#'">  
			<div class="slide-description">
				<h3 class="slide-description-title">펀딩 심사기준</h3>
	      		<span class="slide-description-content">이것만 따르면 당신도 창작자!</span>
	      		<br>
	      		<button style="background-color:black;border:none;width:200px;height:75px;" onclick="location.href='#'"></button>
			</div>
			</div>
		  </div>
		  
		  <div class="bullets">
		    <a href="#s1">1</a>
		    <a href="#s2">2</a>
		    <a href="#s3">3</a>
		    <a href="#s4">4</a>
		  </div>
	</div>
	<!-- 슬라이드 끝 -->
	
	<!-- 인기 프로젝트 시작 -->
	<div class="project">
		<h2>인기 프로젝트</h2>
		<c:if test="${count2 == 0}">
			<div class="result-display">
				현재 등록된 프로젝트가 없습니다.
			</div>
		</c:if>
		<c:if test="${count2 > 0}">
		<!-- 인기 프로젝트 카드 섹션 시작 -->
		<div class="card-wrapper">
		<c:forEach var="popular" items="${list2}">
				<div class="card-shadow">
					<div class="card-image">
					<c:if test="${popular.photo == 'default_team.jpg'}">
						<a href="${pageContext.request.contextPath}/project/detail.do?num=${popular.num}">
							<img class="photo" src="${pageContext.request.contextPath}/resources/images/default_team.jpg" style="width:200px;height:200px;">
						</a>
					</c:if>
					<c:if test="${popular.photo != 'default_team.jpg'}">
						<a href="${pageContext.request.contextPath}/project/detail.do?num=${popular.num}">
							<img class="photo" src="${pageContext.request.contextPath}/upload/${popular.photo}" style="width:200px;height:200px;">
						</a>
					</c:if>
					</div>
					<div class="card-content">
						<div class="card_meta">
						<c:if test="${popular.category == 0 }">
							<span>온라인 </span>
						</c:if>
						<c:if test="${popular.category == 1 }">
							<span>모바일 </span>
						</c:if>
						<c:if test="${popular.category == 2 }">
							<span>보드 </span>
						</c:if>
						<c:if test="${popular.category == 3 }">
							<span>카드 </span>
						</c:if>
							<span> | </span>
							<span>${popular.nickname}</span>
						</div>
						<h3 style="margin-top:5px;"><a>${popular.name}</a></h3>
						<h4 style="color:#FF7878;">${popular.progress}%</h4>
					</div>
				</div>
		</c:forEach>
			</div>
		<!-- 인기 프로젝트 카드 섹션 끝 -->
		<!-- 더보기 버튼 시작 -->
		<div class="align-center">
			<div class="more-btn">
				<input type="button" value="인기 프로젝트 더보기" class="more-btn-main" onclick="location.href='${pageContext.request.contextPath}/project/list.do?state=&order=2'">
			</div>
		</div>
		
		<!-- 더보기 버튼 끝 -->
		</c:if>
	</div>
	
	<!-- 인기 프로젝트 끝 -->
	
	<!-- 최신 프로젝트 시작 -->
	<div class="project">
		<h2>최신 프로젝트</h2>
		<c:if test="${count == 0}">
			<div class="result-display">
				현재 등록된 프로젝트가 없습니다.
			</div>
		</c:if>
		<c:if test="${count > 0}">
		<!-- 인기 프로젝트 카드 섹션 시작 -->
		<div class="card-wrapper">
		<c:forEach var="latest" items="${list}">
				<div class="card-shadow">
					<div class="card-image">
					<c:if test="${latest.photo == 'default_team.jpg'}">
						<a href="${pageContext.request.contextPath}/project/detail.do?num=${latest.num}">
							<img class="photo" src="${pageContext.request.contextPath}/resources/images/default_team.jpg" style="width:200px;height:200px;">
						</a>
					</c:if>
					<c:if test="${latest.photo != 'default_team.jpg'}">
						<a href="${pageContext.request.contextPath}/project/detail.do?num=${latest.num}">
							<img class="photo" src="${pageContext.request.contextPath}/upload/${latest.photo}" style="width:200px;height:200px;">
						</a>
					</c:if>
					</div>
					<div class="card-content">
						<div class="card_meta">
							<c:if test="${latest.category == 0 }">
							<span>온라인 </span>
						</c:if>
						<c:if test="${latest.category == 1 }">
							<span>모바일 </span>
						</c:if>
						<c:if test="${latest.category == 2 }">
							<span>보드 </span>
						</c:if>
						<c:if test="${latest.category == 3 }">
							<span>카드 </span>
						</c:if>
							<span> | </span>
							<span>${latest.nickname}</span>
						</div>
						<h3 style="margin-top:5px;"><a>${latest.name}</a></h3>
						<h4 style="color:#FF7878;">${latest.progress}%</h4>
					</div>
				</div>
		</c:forEach>
			</div>
		<!-- 인기 프로젝트 카드 섹션 끝 -->
		<!-- 더보기 버튼 시작 -->
		<div class="align-center">
			<div class="more-btn">
				<input type="button" value="최신 프로젝트 더보기" class="more-btn-main" onclick="location.href='${pageContext.request.contextPath}/project/list.do?state=&order=1'">
			</div>
		</div>
		<!-- 더보기 버튼 끝 -->
		</c:if>
	</div>
	<!-- 최신 프로젝트 끝 -->
	
	</div>
<!-- 메인 끝 -->