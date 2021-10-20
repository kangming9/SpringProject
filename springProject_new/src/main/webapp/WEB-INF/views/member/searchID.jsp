<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css">
</head>
<body>
<div class="container">
	<form id="select_id_form" action="searchId.do" method="post">
		<ul>
			<li>
				<label for="name">이름</label>
				<input name="name" id="name">
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
			<input type="submit" value="아이디 찾기">
		</div>
	</form>

</div>
</body>
</html>