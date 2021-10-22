<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		$('.submit-btn').on('click',function(){
			//유효성 검사
			if($('#id').val().trim()==''){
				$('#message_id').css('color','red').text('아이디를 입력하세요');
				$('#id').val('').focus(); 
				return;
			}
			
			if($('#email').val().trim()==''){
				$('#message_id').css('color','red').text('이메일을 입력하세요');
				$('#email').val('').focus(); 
				return;
			}
			
			if($('#phone').val().trim()==''){
				$('#message_id').css('color','red').text('전화번호를 입력하세요');
				$('#phone').val('').focus(); 
				return;
			}
		});
		
	});
</script>
</head>
<body>
<div class="container">
	<div class="box">
	<h2>비밀번호 재설정</h2>
		<form:form id="select_pass_form" action="searchPass.do" modelAttribute="memberVO" method="post">
		<ul>
			<li>
				<label for="id">아이디</label>
				<form:input path="id" id="id"/>
				<form:errors path="id" cssClass="error-color"/>
			</li>
			<li>
				<label for="email">이메일</label>
				<form:input path="email" id="email"/>
				<form:errors path="email" cssClass="error-color"/>
			</li>
			<li>
				<label for="phone">전화번호</label>
				<form:input path="phone" id="phone"/>
				<form:errors path="phone" cssClass="error-color"/>
			</li>
			<li>
				<span id="message_id"></span>
			</li>
		</ul>
		<div class="align-center">
			<form:button class="submit-btn">회원정보 확인</form:button>
		</div>
	</form:form>
	</div>
	
</div>
</body>
</html>