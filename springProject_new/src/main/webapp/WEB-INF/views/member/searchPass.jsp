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
		var checkUser = 0;
		
		if(checkUser == 0){
			$('.submit-btn').hide();
			$('#changePass').hide();
		}
		
		$('#check-info').click(function(){
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
			
			//비밀번호 재설정
			$.ajax({
				type:'post',
				data:{id:$('#id').val(),email:$('#email').val(),phone:$('#phone').val()},
				url:'checkPass.do',
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == 'alreadyUser'){
						$('#message_id').css('color','black').text('기존 유저');
						checkUser = 1;
						$('#changePass').show();
						$('.submit-btn').show();
					}else if(param.result == 'idNotFound'){
						checkUser = 0;
						$('#message_id').css('color','red').text('회원 정보가 없습니다');
					}else{
						checkUser = 0;
						alert('비밀번호 체크 오류');
						return;
					}
				},
				error:function(){
					alert('비밀번호 체크 중 네트워크 오류 발생');
				}
			});//ajax 끝
		});//click 이벤트 끝 
		
		
		$('.submit-btn').submit(function(){
			if($('#id').val().trim()==''){
				$('#message_pass').css('color','red').text('비밀번호를 입력하세요');
				$('#id').val('').focus(); 
				return false;
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
			<li>
			<div id="check-info">
				<input type="button" value="회원정보 확인">
			</div>
			</li>
			<li id="changePass">
				<label for="pass">새로운 비밀번호</label>
				<form:input path="pass" id="pass"/>
				<span id="message_pass"></span>
			</li>
		</ul>
		<div class="align-center">
			<form:button class="submit-btn">비밀번호 재설정</form:button>
		</div>
	</form:form>
	</div>
	
</div>
</body>
</html>