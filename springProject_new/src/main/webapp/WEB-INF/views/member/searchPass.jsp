<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css">
</head>
<body>
<div class="container">
	<form id="select_id_form" action="searchId.do" method="post">
		<ul>
			<li>
				<label for="id">아이디</label>
				<input name="id" id="id">
			</li>
			<li>
				<label for="email">이메일</label>
				<input name="email" id="email">
			</li>
			<li>
				<label for="phone">전화번호</label>
				<input name="phone" id="phone">
			</li>
		</ul>
		<div class="align-center">
			<input type="submit" value="비밀번호 재설정">
		</div>
	</form>

</div>
</body>
</html>