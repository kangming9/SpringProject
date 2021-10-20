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
			<div class="item">
			</div>
			<div class="item">
				카카오(구글도 아직 안돼요!)
			</div>
			<div class="item">
				네이버
			</div>
		</div>
		<hr size="1" style="margin:10px 20px;width:90%;" >
		<div class="email_register">
			<button value="일반회원 가입하기" onclick="location.href='${pageContext.request.contextPath}/member/register.do'">일반 회원가입하기</button>
		</div>
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