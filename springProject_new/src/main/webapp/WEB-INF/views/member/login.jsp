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
<script src="https://apis.google.com/js/platform.js" async defer></script>
<meta name="google-signin-client_id" content="84497321586-98m97vpame2mb38rtfr3hntdovs1erqk.apps.googleusercontent.com">
 
 <body>
<script>
	/* 구글 */
	function onSignIn(googleUser) {
	  var profile = googleUser.getBasicProfile();
	  console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
	  console.log('Name: ' + profile.getName());
	  console.log('Image URL: ' + profile.getImageUrl());
	  console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
	  
	}

</script>
<!-- 로그인 시작 -->
<div class="container">

<div class="align-center">
	<div class="box">
		<h2>로그인</h2>
		<div class="sns">
			<div class="item">
				<div class="g-signin2" data-onsuccess="onSignIn" style="width:320px;height:44px;"></div>
			</div>
			<div class="item">
				카카오(구글도 아직 안돼요!)
			</div>
			<div class="item">
				네이버
			</div>
		</div>
		<hr size="1" style="margin:10px 20px;width:90%;" >
		<form:form id="login_form" action="login.do" modelAttribute="memberVO">
		<form:errors element="div" cssClass="error-color"/>
			<ul style="list-style:none;">
				<li class="form-li">
					<form:input path="id" placeholder="	아이디를 입력해주세요"/>
					<form:errors path="id" cssClass="error-color"/>
				</li>
				<li class="form-li">
					<form:password path="pass" placeholder="	비밀번호를 입력해주세요"/>
					<form:errors path="pass" cssClass="error-color"/>
				</li>
			</ul>
			<div class="align-center">
				<form:button class="submit-btn">로그인</form:button>
			</div>
		</form:form>
		<div class="sub-function">
			<p>
				<span>아직 계정이 없으신가요?	</span>
				<a href="${pageContext.request.contextPath}/member/selectRegister.do">회원가입</a>
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

<!-- 로그인 끝 -->
</body>
</html>