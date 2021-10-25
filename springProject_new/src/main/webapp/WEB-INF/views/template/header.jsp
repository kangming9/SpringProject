<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" type="text/css">  
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css" type="text/css"> 
<!-- 상단 시작 -->
<div class="align-center header-title"><a href="${pageContext.request.contextPath}/main/main.do" class="delete_line">Funding Adventure</a></div>
	<div class='menu'>
			<ul class="header-page-menu">
				<li>
					<a href="${pageContext.request.contextPath}/guide/introMain.do" class="delete_line">소개</a>
				</li>
				<li class="dropdown">
					<a href='#'>가이드</a>
					<div class="dropdown-content">
						<a href="${pageContext.request.contextPath}/guide/creatorGuide.do" class="delete_line">창작자 가이드</a>
						<a href="${pageContext.request.contextPath}/guide/supporterGuide.do" class="delete_line">후원자 가이드</a>
					</div>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/project/list.do" class="delete_line">펀딩하기</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/create/create.do" class="delete_line">프로젝트창작</a>
				</li>
			</ul>
			<ul class="header-user-menu">
				<!-- 관리자일떄 -->
				<c:if test="${!empty user_num && user_grade == 0}">
					<li>
						<a href="${pageContext.request.contextPath}/mypage/adminPage.do" class="delete_line header-user-profile">
							<img src="${pageContext.request.contextPath}/resources/images/Admin.png" width="35" height="35" class="my-photo">
							<span>&nbsp;${user_nickname}</span>
						</a>
					</li>
				</c:if>
				<!-- 일반회원일떄(사진 없을경우) -->
				<c:if test="${!empty user_num && empty user_photo && user_grade >= 2}">
					<li>
						<a href="${pageContext.request.contextPath}/mypage/myPage.do" class="delete_line header-user-profile">
							<img src="${pageContext.request.contextPath}/resources/images/userimage.png" width="35" height="35" class="my-photo">
							<span>&nbsp;${user_nickname}</span>
						</a> 
					</li>
				</c:if>
				<!-- 일반회원일떄(사진 있을경우) -->
				<c:if test="${!empty user_num && !empty user_photo && user_grade >= 2}">
					<li>
						<a href="${pageContext.request.contextPath}/mypage/myPage.do" class="delete_line header-user-profile">
							<img src="${pageContext.request.contextPath}/mypage/photoView.do" width="35" height="35" class="my-photo">
							<span>&nbsp;${user_nickname}</span>
						</a>
					</li>
				</c:if>
				<c:if test="${!empty user_num}">
					<li>
						<a href="${pageContext.request.contextPath}/member/logout.do" class="delete_line">Logout</a>
					</li>
				</c:if>
				<c:if test="${empty user_num}">
					<li>
						<a href="${pageContext.request.contextPath}/member/login.do" class="delete_line">로그인</a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/member/selectRegister.do" class="delete_line">회원가입</a>
					</li>
				</c:if>
			</ul>	
		</div>