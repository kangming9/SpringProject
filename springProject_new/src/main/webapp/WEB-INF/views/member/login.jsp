<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
</head>
        <a href="https://kauth.kakao.com/oauth/authorize?client_id=4234090cf188276e03ecdbf634a9c0b9&redirect_uri=http://localhost:8081/FundingAdventure2/member/snsLogin.do&response_type=code">
            <img src="${pageContext.request.contextPath}/resources/images/kakao_login.png">
            
        </a>
<div class="container">
		<div id="kakao-btn"></div>
		<div id="user_info" style="width:300px;"></div>
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

<!-- 로그인 끝 -->

</body>
</html>