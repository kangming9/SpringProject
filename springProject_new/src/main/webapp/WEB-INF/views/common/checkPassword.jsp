<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 비밀번호 확인</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/question.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		//검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim() == ''){
				alert('검색어를 입력하세요');
				$('#keyword').val('').focus();
				return false;
			}
		});
		
	});
</script>
</head>
<body>
<div class="container">
	<form id="checkPass" action="checkPass.do" method="get">
			<ul class="checkPass">
				<li>
					<input type="password" name="checkPass" id="checkPass">
				</li>
				<li>
					<input type="submit" value="확인">
					<input type="button" value="main" onclick="location href='${pageContext.request.contextPath}/main/main.do'">
				</li>
			</ul>
		</form>
</div>
</body>
</html>