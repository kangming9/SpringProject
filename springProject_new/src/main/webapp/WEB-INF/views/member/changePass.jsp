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
		
		$('.submit-btn').submit(function(){
			//유효성 검사
			if($('#pass').val().trim()==''){
				$('#message_id').css('color','red').text('비밀번호를 입력하세요');
				$('#pass').val('').focus(); 
				return;
			}
			
			if($('#newPass').val().trim()==''){
				$('#message_id').css('color','red').text('비밀번호 확인을 입력하세요');
				$('#newPass').val('').focus(); 
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
		<form id="change_pass_form" action="changePass.do" method="post">
		<input type="hidden" value="${email}" name="email">
		<ul>
			<li>
				<label for="pass">비밀번호</label>
				<input type="password" name="pass" id="pass">
			</li>
			<li>
				<label for="newPass">비밀번호 확인</label>
				<input type="password" name="newPass" id="newPass">
			</li>
			<li>
				<span id="message_id"></span>
			</li>
		</ul>
		<div class="align-center">
			<input type="submit" class="submit-btn" value="비밀번호 재설정">
		</div>
	</form>
	</div>
	
</div>
</body>
</html>