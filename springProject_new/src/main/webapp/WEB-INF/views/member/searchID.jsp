<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		$('#select_id_form').submit(function(){
			//유효성 검사
			if($('#name').val().trim()==''){
				$('#message_id').css('color','red').text('이름을 입력하세요');
				$('#name').val('').focus(); 
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
		}); //아이디 찾기
		
	});
</script>
</head>
<body>
<div class="container">
	<div class="box">
	<h2>아이디 찾기</h2>
		<form:form id="select_id_form" action="searchID.do" modelAttribute="memberVO" method="post">
		<ul>
			<li>
				<label for="name">이름</label>
				<form:input path="name" id="name"/>
				<form:errors path="name" cssClass="error-color"/>
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
		</ul>
		<div class="align-center">
			<form:button class="submit-btn">아이디 찾기</form:button>
		</div>
	</form:form>
	</div>
	
</div>
</body>
</html>