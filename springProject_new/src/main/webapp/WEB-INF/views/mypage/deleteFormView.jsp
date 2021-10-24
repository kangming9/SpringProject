<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css" type="text/css">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	//탈퇴버튼
	$('#delete_btn').click(function(){
		if($('#check_content').is(":checked")==true){
			$('#delete_choice').show();
			$(this).hide(); //수정버튼 숨김	
		}else{
			alert('안내사항을 확인해주시기 바랍니다.');
			$('#check_content').focus();
		}
	});
	//탈퇴 버튼 취소
	$('#delete_reset').click(function(){
		$('#delete').val('');
		$('#message_password').text('');
		$('#delete_choice').hide();
		$('#delete_btn').show();
	});
	//탈퇴
	var br = document.createElement("br");
	
	$('#delete_submit').click(function(){
		if($('#delete').val()==''){
			alert('비밀번호를 입력해주세요.');
			$('#delete').focus();
			return; 
		}
		check = confirm('펀딩어드벤처를 탈퇴합니다.');
		if(check){
			//탈퇴 전송
			$.ajax({
				url:'${pageContext.request.contextPath}/mypage/deleteform.do',
				type:'post',
				data:{pass:$('#delete').val(),
					  num:('${user_num}')
					 },
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인 후 사용하세요');
					}else if(param.result == 'differentUser'){
						alert('잘못된 경로입니다.');
					}else if(param.result == 'passNotFound'){
						alert('비밀번호가 일치하지 않습니다.');
						$('#delete').val(''); 
					}else if(param.result == 'success'){
						alert('이용해 주셔서 감사합니다.');
						//초기화 작업
						$('#delete').val(''); 
						$('#delete_choice').hide();
						$('#delete_btn').show();
						
						location.href='${pageContext.request.contextPath}/main/main.do';
					}else{
						alert('전송 오류 발생');
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});//탈퇴전송 ajax
		}//end check
	});
});
</script>
<div>
	<div class="miniTitle_left">
	<b class="miniTitle_content" onclick="location.href='${pageContext.request.contextPath}/mypage/mySettings.do'">설정</b>
	</div>
	<hr noshade="noshade" class="line">
</div>
<div class="delete_margin">
		<p class="setthing_title">회원 탈퇴</p>
	<div>
		<p class="delete_title">탈퇴 관련 유의사항 안내</p>
		<span class="delete_content">후원한 프로젝트 또는 나의 펀딩이 아직 진행중인 경우 탈퇴할 수 없습니다.</span>
	</div>
	<div class="delete_detailContent">
		1. 탈퇴후 동일 아이디 재가입 불가<br>
		2. 탈퇴후 개인정보 일괄 삭제<br>
		3. 탈퇴후 작성한 게시물 삭제 불가<br>
	</div>
	<input type="checkbox" id="check_content">상기 펀딩어드벤처 탈퇴 시 유의 사항을 확인했습니다.
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div>
		<form action="/mypage/deleteform.do">
		<p class="delete_title">탈퇴</p>
		<span class="delete_content">안전한 탈퇴를 위해 본인 인증 후 탈퇴가 가능합니다. 인증 버튼을 클릭해 주세요.</span>
		<input type="button" value="인증" id="delete_btn">
		<div id="delete_choice" style="display: none;">
			<input type="text" value="${member.id}"><br>
			<input type="password" placeholder="비밀번호 확인" id="delete"><br>
			<input type="button" value="취소" id="delete_reset"><br>
			<input type="button" value="회원탈퇴" id="delete_submit">
		</div>
		</form>
	</div>
</div>