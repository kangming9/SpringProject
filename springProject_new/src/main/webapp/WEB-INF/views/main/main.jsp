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
		    <div class="slide-description">
				<h3 class="slide-description-title">소개</h3>
	      		<span class="slide-description-content">펀딩 어드벤처의 위대한 여정</span>
			</div>
		    <div class="slide-description">
				<h3 class="slide-description-title">창작자 가이드</h3>
	      		<span class="slide-description-content">창작자라면 꼭 지켜주세요</span>
			</div>
		    <div class="slide-description">
				<h3 class="slide-description-title">후원자 가이드</h3>
	      		<span class="slide-description-content">후원자라면 꼭 지켜주세요</span>
			</div>
			<div class="slide-description">
				<h3 class="slide-description-title">펀딩 심사기준</h3>
	      		<span class="slide-description-content">이것만 따르면 당신도 창작자!</span>
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
						<a href="${pageContext.request.contextPath}/project/detail.do?num=${popular.num}"><img src="${popular.photo}" style="width:200px;"></a>
					</div>
					<div class="card-content">
						<div class="card_meta">
							<span>${popular.category}</span>
							<span> | </span>
							<span>${popular.nickname}</span>
						</div>
						<h3><a>${popular.name}</a></h3>
						<h6>${popular.progress}</h6>
					</div>
				</div>
		</c:forEach>
			</div>
		<!-- 인기 프로젝트 카드 섹션 끝 -->
		<!-- 더보기 버튼 시작 -->
		<div class="align-center">
			<div class="more-btn">
				<input type="button" value="인기 프로젝트 더보기">
			</div>
		</div>
		
		<!-- 더보기 버튼 끝 -->
		</c:if>
	</div>
	
	<!-- 인기 프로젝트 끝 -->
	
	<!-- 최신 프로젝트 시작 -->
	<div class="project2">
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
						<a href="${pageContext.request.contextPath}/project/detail.do?num=${latest.num}"><img src="${latest.photo}" style="width:200px;"></a>
					</div>
					<div class="card-content">
						<div class="card_meta">
							<span>${latest.category}</span>
							<span> | </span>
							<span>${latest.nickname}</span>
						</div>
						<h3><a>${latest.name}</a></h3>
						<h6>${latest.progress}</h6>
					</div>
				</div>
		</c:forEach>
			</div>
		<!-- 인기 프로젝트 카드 섹션 끝 -->
		<!-- 더보기 버튼 시작 -->
		<div class="align-center">
			<div class="more-btn">
				<input type="button" value="최신 프로젝트 더보기">
			</div>
		</div>
		<!-- 더보기 버튼 끝 -->
		</c:if>
	</div>
	<!-- 최신 프로젝트 끝 -->
	
	</div>
<!-- 메인 끝 -->