<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" type="text/css">  
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css" type="text/css"> 
<!-- 상단 시작 -->
<h2 class="align-center"><a href="${pageContext.request.contextPath}/main/main.do" class="delete_line">Funding Adventure</a></h2>

<!doctype html>
<html lang='en'>
	<head>
		<meta charset="utf-8"/>
		<title>Header</title>
<style>


</style>
	</head>
	<body>

		<div class='menu'>
			<ul>
				<li>
					<a href="${pageContext.request.contextPath}" class="delete_line">소개</a>
				</li>
				<li class='active sub'>
					<a href='#'>가이드</a>
					<ul>
						<li>
							<a href="${pageContext.request.contextPath}/guide/creatorGuide.do" class="delete_line">창작자 가이드</a>
						</li>
						<li class='last'>
							<a href="${pageContext.request.contextPath}/guide/supporterGuide.do" class="delete_line">후원자 가이드</a>
						</li>
					</ul>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/project/list.do" class="delete_line">펀딩하기</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/create/create.do" class="delete_line">프로젝트창작</a>
				</li>
					
					<c:if test="${!empty user_num}">
						<li style="float: right" >
							
							<a href="${pageContext.request.contextPath}/member/logout.do" class="delete_line">Logout</a>
							
						</li>
						<li style="float: right">
						    <a>${user_nickname}</a>
						</li>
					</c:if>
					
					<!-- 관리자일떄 -->
					<c:if test="${!empty user_num && user_grade == 0}">
						<li style="float: right">
							<a href="${pageContext.request.contextPath}/mypage/adminPage.do" class="delete_line">
							<img src="${pageContext.request.contextPath}/resources/images/Admin.png" width="35" height="35" class="my-photo">
							</a>
						</li>
					</c:if>
					
					<!-- 일반회원일떄(사진 없을경우) -->
					<c:if test="${!empty user_num && empty user_photo && user_grade >= 2}">
						<li style="float: right">
							<a href="${pageContext.request.contextPath}/mypage/myPage.do" class="delete_line">
							<img src="${pageContext.request.contextPath}/resources/images/userimage.png" width="35" height="35" class="my-photo">
							</a>
						</li>
					</c:if>
					
					<!-- 일반회원일떄(사진 있을경우) -->
					<c:if test="${!empty user_num && !empty user_photo && user_grade >= 2}">
						<li style="float: right">
							<a href="${pageContext.request.contextPath}/mypage/myPage.do" class="delete_line">
							<img src="${pageContext.request.contextPath}/mypage/photoView.do" width="35" height="35" class="my-photo">
							</a>
							</li>
					</c:if>
					<c:if test="${empty user_num}">
						<li style="float: right">
							<a href="${pageContext.request.contextPath}/member/selectRegister.do" class="delete_line">회원가입</a>
						</li>
						<li style="float: right">
							<a href="${pageContext.request.contextPath}/member/login.do" class="delete_line">로그인</a>
						</li>
					</c:if>
			</ul>
		</div>
	</body>
</html>