<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의글 비밀번호 확인</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/question.css">
<script type="text/javascript">
	$(document).ready(function(){
		
		//유효성 검사
		$('#qpass_form').submit(function(){
			if($('#password').val().trim()==''){
				$('#password').val('').focus();
				return false;
			}
		});
	});

</script>
</head>
<body>

<div class="container">
	<div class="box">
		<h2>문의글 확인</h2>
		<form action="qCheckPass.do" method="post" id="qpass_form">
			<input type="hidden" value="${question.num}" name="num">
			<ul>
				<li>
					<label for="pass">비밀번호</label>
					<input type="password" id="password" name="password">
				</li>
			</ul>
			<div class="align-center">
				<input type="submit" value="문의 확인" class="question-register-btn">
				<input type="button" value="목록" onclick="location.href='list.do'" class="btns">
			</div>
	</form>
</div>

</div>

</body>
</html>