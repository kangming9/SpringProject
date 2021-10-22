<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css">
</head>
<body>
<script>
	
</script>
<!-- 로그인 시작 -->
<div class="container">
<div class="align-center">
	<div class="box">
		<h2>회원가입</h2>
		<div class="sns">
			<a href="https://kauth.kakao.com/oauth/authorize?client_id=4234090cf188276e03ecdbf634a9c0b9&redirect_uri=http://localhost:8081/FundingAdventure2/member/snsLogin.do&response_type=code">
	            <img src="${pageContext.request.contextPath}/resources/images/kakao_login.png">
	        </a>
		</div>
		<hr size="1" style="margin:10px 20px;width:90%;" >
		
			<button style="margin-top:15px;" class="submit-btn" value="일반회원 가입하기" onclick="location.href='${pageContext.request.contextPath}/member/register.do'">일반 회원가입하기</button>

		<div class="sub-function">
		<div class="align-center">
			<p>
				<span>이미 계정이 있으신가요?	</span>
				<a href="${pageContext.request.contextPath}/member/login.do">로그인</a>
			</p>
			<p class="search-btn">
				<input type="button" value="아이디 찾기" onclick="location.href='${pageContext.request.contextPath}/member/searchID.do'">
				<span>	|	</span>
				<input type="button" value="비밀번호 재설정" onclick="location.href='${pageContext.request.contextPath}/member/searchPass.do'">
			</p>
		</div>
		</div>
	</div>
</div>
</div>

<!-- 로그인 끝 -->
</body>
</html>