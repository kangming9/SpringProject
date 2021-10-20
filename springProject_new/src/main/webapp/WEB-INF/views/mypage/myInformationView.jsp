<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css" type="text/css">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	//닉네임 수정
	$('#nickname_btn').click(function(){
		$('#nickname_choice').show();
		$(this).hide(); //수정버튼 숨김
	});
	//닉네임 수정 취소
	$('#nickname_reset').click(function(){
		$('#nickname').val('');
		$('#message_nickname').text('');
		$('#nickname_choice').hide();
		$('#nickname_btn').show();
	});
	//닉네임 수정 반영
	var check_pattern = /[0-9|a-zA-Z|가-힣]/;
	
	$('#nickname_submit').click(function(){
		if($('#nickname').val()==''){//파일 선택 안한 경우
			alert('닉네임을 입력해주세요.');
			$('#nickname').focus();
			return; //submit안하고 클릭했으니까 return
		}if(!check_pattern.test($('#nickname').val())) {
			alert('잘못된 형식입니다1.');
			$('#nickname').val('');
			return; 
		}if($('#nickname').val().length < 3 || $('#nickname').val().length > 20){
			alert('잘못된 형식입니다2.');
			$('#nickname').val('');
			return;
		}
		
		//닉네임 전송
		$.ajax({
			url:'${pageContext.request.contextPath}/mypage/nicknameUpdate.do',
			type:'post',
			data:{nickname:$('#nickname').val()},
			dataType:'json',
			cache:false,
			timeout:30000,
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요');
				}else if(param.result == 'nicknameDuplicated'){
					alert('이미 있는 닉네임입니다');
					$('#message_nickname').css('color','red').text('중복된 닉네임');
					$('#nickname').val('').focus();
				}else if(param.result == 'success'){
					location.reload();//페이지새로고침
					alert('닉네임이 변경되었습니다.');
					//초기화 작업
					$('#nickname').val(''); 
					$('#nickname_choice').hide();
					$('#nickname_btn').show();
				}else{
					alert('전송 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});
	//*************************************************************************
	//MyPage 프로필 사진 수정 : 마이페이지에서 프로필사진 수정 버튼 클릭했을 때
	$('#photo_btn').click(function(){
		$('#photo_choice').show();
		$(this).hide(); //수정버튼 숨김
	});

	//이미지파일 미리보기
	var photo_path;
	var my_photo;
	//프로필사진 다른사진으로 클릭시 파일 미리보기
	$('#upload').change(function(){
		var upload = document.getElementById('upload');
		my_photo = upload.files[0]; //파일 객체 받아서 넣어줌
		if(my_photo){
			var reader = new FileReader();
			
			reader.readAsDataURL(my_photo);
			
			reader.onload = function(){ //미리보기 하는 부분
				photo_path = $('.my-photo').attr('src');
				$('.my-photo').attr('src',reader.result); 
			};
		}
	});
	
	//ajax를 이용한 파일 전송
	$('#photo_submit').click(function(){
		if($('#upload').val()==''){//파일 선택 안한 경우
			alert('파일을 선택하세요');
			$('#upload').focus();
			return; //submit안하고 클릭했으니까 return
		}
		
		//파일 전송
		var form_data = new FormData();
		form_data.append('upload',my_photo)//전송시 파라미터 네임:upload, 업로드하는파일 객체:my_photo || 자동 매핑됨 -> 자바빈 저장 -> memberVO의 set upload메서드 찾음 blob이미지처리
		$.ajax({
			data:form_data,
			type:'post',
			url:'${pageContext.request.contextPath}/mypage/updateMyphoto.do',
			dataType:'json',
			cache:false,
			contentType:false,
			enctype:'multipart/form-data',
			processData:false,
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요');
				}else if(param.result == 'success'){
					alert('프로필 사진이 수정되었습니다.');
					//초기화 작업
					$('#upload').val(''); 
					$('#photo_choice').hide();
					$('#photo_btn').show();
				}else{
					alert('파일 전송 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});

	//프로필 사진 전송 취소
	$('#photo_reset').click(function(){
		$('.my-photo').attr('src',photo_path); //원래 이미지로 초기화
		$('#upload').val('');
		$('#photo_choice').hide();
		$('#photo_btn').show();
	});
	
	//*************************************************************************
	//연락처 수정
	$('#phone_btn').click(function(){
		$('#phone_choice').show();
		$('#phone').val('${member.phone}');
		$(this).hide(); //수정버튼 숨김
	});
	//연락처 수정 취소
	$('#phone_reset').click(function(){
		$('#phone').val('');
		$('#phone_choice').hide();
		$('#phone_btn').show();
	});
	//연락처 수정 반영
	var phonecheck_pattern = /[0-9]/;
	
	$('#phone_submit').click(function(){
		if($('#phone').val()==''){
			alert('연락처를 입력해주세요.');
			$('#phone').focus();
			return; 
		}if(!phonecheck_pattern.test($('#phone').val())) {
			alert('잘못된 형식입니다.');
			$('#phone').val('');
			return; 
		}if($('#phone').val().length < 9 || $('#phone').val().length > 13){
			alert('잘못된 형식입니다.');
			$('#phone').val('');
			return;
		}
		
		//연락처 전송
		$.ajax({
			url:'${pageContext.request.contextPath}/mypage/updateMyPhone.do',
			type:'post',
			data:{phone:$('#phone').val()},
			dataType:'json',
			cache:false,
			timeout:30000,
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요');
				}else if(param.result == 'success'){
					location.reload();//페이지새로고침
					alert('연락처가 변경되었습니다.');
					//초기화 작업
					$('#phone').val(''); 
					$('#phone_choice').hide();
					$('#phone_btn').show();
				}else{
					alert('전송 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});

	//*************************************************************************
	//비밀번호 수정
	$('#password_btn').click(function(){
		$('#password_choice').show();
		$(this).hide(); //수정버튼 숨김
	});
	//비밀번호 수정 취소
	$('#password_reset').click(function(){
		$('.pass').val('');
		$('#message_password').text('');
		$('#password_choice').hide();
		$('#password_btn').show();
	});
	//비밀번호 수정 반영
	var passwordcheck_pattern = /[A-Z|a-z|0-9]/;
	var br = document.createElement("br");
	
	$('#password_submit').click(function(){
		if($('.originpass').val()==''){
			alert('현재 비밀번호를 입력해주세요.');
			$('.originpass').focus();
			return; 
		}if($('.newpass').val()==''){
			alert('변경할 비밀번호를 입력해주세요.');
			$('.newpass').focus();
			return; 
		}if(!passwordcheck_pattern.test($('.pass').val())) {
			alert('잘못된 형식입니다.');
			var msg = $('#message_password').css('color','red').text('한글 및 특수문자 사용 불가\n');
			msg.html(msg.html().replace(/\n/g, '<br/>'));
			$('.pass').val('');
			return; 
		}if($('#new_password').val().length < 4 || $('#new_password').val().length > 12){
			alert('잘못된 형식입니다.');
			var msg2 = $('#message_password').css('color','red').text('4자 이상, 12자이하 이하로 입력하세요\n');
			msg2.html(msg2.html().replace(/\n/g, '<br/>'));
			$('.pass').val('');
			return;
		}if($('#new_password').val() != $('#newcheck_password').val()){
			alert('변경할 비밀번호가 일치하지 않습니다.');
			return;
		}
		
		//비밀번호 전송
		$.ajax({
			url:'${pageContext.request.contextPath}/mypage/updatePassword.do',
			type:'post',
			data:{pass:$('#origin_password').val(),
				  now_password:$('#new_password').val(),
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
					alert('현재 비밀번호가 일치하지 않습니다.')
				}else if(param.result == 'success'){
					location.reload();//페이지새로고침
					alert('비밀번호가 변경되었습니다.');
					//초기화 작업
					$('#password').val(''); 
					$('#password_choice').hide();
					$('#password_btn').show();
				}else{
					alert('전송 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});
});
</script>
<div>
	<div class="miniTitle_left">
	<b class="miniTitle_content" onclick="location.href='${pageContext.request.contextPath}/mypage/mySettings.do'">설정</b>
	</div>
	<div class="miniTitle_right">
		<br>
		<i class="fas fa-bell xs" id="notice_alarm"></i>
		나의 프로젝트 크레이지 아케이드 목표금액 달성
	</div>
	<hr noshade="noshade" class="line">
</div>
<div class="info_container">
	<p class="setthing_title">기본 정보</p>
<div class="info_item info_item_title">닉네임</div>
<div class="info_item info_item_content">
	${member.nickname}
<div class="align-left">
	<input type="button" value="수정" id="nickname_btn">
</div>
<div id="nickname_choice" style="display: none;">
	<input type="text" id="nickname" placeholder="4자이상 20자이하 특수문자 사용불가">
	<span id="message_nickname"></span>
	<input type="button" value="전송" id="nickname_submit">
	<input type="button" value="취소" id="nickname_reset">
</div>
</div>
<div class="info_item info_item_title">
	프로필
</div>
<div class="info_item info_item_content">
	<ul class="list_style">
		<li>
			<c:if test="${empty member.photo}">
			<img src="${pageContext.request.contextPath}/resources/images/userimage.png" width="100" height="100" class="my-photo">
			</c:if>
			<c:if test="${!empty member.photo}"> <!-- 사진있는경우 -->
			<img src="${pageContext.request.contextPath}/mypage/photoView.do" width="100" height="100" class="my-photo">
			</c:if>
		</li>
		<li>
			<div class="align-left">
				<input type="button" value="수정" id="photo_btn">
			</div>
			<div id="photo_choice" style="display:none;">
				<input type="file" id="upload" accept="image/gif,image/png,image/jpeg">
				<input type="button" value="전송" id="photo_submit">
				<input type="button" value="취소" id="photo_reset">
			</div>
		</li>
	</ul>
</div>
<div class="info_item info_item_title">
	연락처
</div>
<div class="info_item info_item_content">
	${member.phone}
<div class="align-left">
	<input type="button" value="수정" id="phone_btn">
</div>
<div id="phone_choice" style="display: none;">
	<input type="text" id="phone" placeholder="휴대폰 번호를 입력해주세요." value="${member.phone}">
	<input type="button" value="전송" id="phone_submit">
	<input type="button" value="취소" id="phone_reset">
</div>
</div>
<div class="info_item info_item_title">
	비밀번호
</div>
<div class="info_item info_item_content">
<div class="align-left">
	<input type="button" value="수정" id="password_btn">
</div>
<div id="password_choice" style="display: none;">
	<span id="message_password"></span>
	<span>현재 비밀번호</span><br>
	<input type="password" id="origin_password" placeholder="현재 비밀번호" class="pass originpass">
	<p>
	<span>변경할 비밀번호</span><br>
	<input type="password" id="new_password" placeholder="변경할 비밀번호" class="pass newpass"><br>
	<input type="password" id="newcheck_password" placeholder="변경할 비밀번호 확인" class="pass newpass"><br>
	<input type="button" value="전송" id="password_submit">
	<input type="button" value="취소" id="password_reset">
</div>
</div>
<div class="info_item info_item_title">회원 탈퇴</div>
<div class="info_item info_item_content">
	<input type="button" value="탈퇴" onclick="location.href='${pageContext.request.contextPath}/mypage/deleteform.do'">
</div>
</div>