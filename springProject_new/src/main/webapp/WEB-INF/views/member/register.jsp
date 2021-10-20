<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var checkId = 0;
		
		//아이디 중복 체크;
		$('#confirmId').click(function(){
			if($('#id').val().trim()==''){
				$('#message_id').css('color','red').text('아이디를 입력하세요');
				$('#id').val('').focus(); 
				return;
			}
			
			$.ajax({
				url:'confirmId.do',
				type:'post',
				data:{id:$('#id').val()},
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == 'idNotFound'){
						$('#message_id').css('color','#000').text('등록 가능한 ID');
						checkId = 1;
					}else if(param.result == 'idDuplicated'){
						$('#message_id').css('color','red').text('중복된 ID');
						$('#id').val('').focus();
						checkId = 0;
					}else{
						checkId = 0;
						alert('ID 중복체크 오류');
					}
				},
				error:function(){
					checkId = 0;
					alert('네트워크 오류 발생');
				}
			}); 
		}); //중복체크
		
		//아이디 중복 안내 메시지 초기화 및 아이디 중복값 초기화
		$('#register_form #id').keydown(function(){
			checkId = 0;
			$('#message_id').text('');
		});
		
		//체크박스 전체 동의
        var checkAll = document.querySelector('#checkAll');
        var chkbox = document.querySelectorAll('.chkbox');

        var chk1 = document.querySelector('#chk1');
        var chk2 = document.querySelector('#chk2');
        var chk3 = document.querySelector('#chk3');
        var chk4 = document.querySelector('#chk4');

        // 전체선택 클릭시 체크/해제
        checkAll.onclick = function(){
            if(checkAll.checked == false){
                for(var i=0; i<chkbox.length; i++){ chkbox[i].checked = false; }
            }else{
                for(var i=0; i<chkbox.length; i++){ chkbox[i].checked = true; }
            }
        };

        //하위요소 해제시 전체선택 해제
        for(var i=0; i<chkbox.length; i++){
            chkbox[i].onclick = function(){
                if( this.checked == false ){ 
                	checkAll.checked = false; 
                }
                
             	if(chkbox[0].checked == true && chkbox[1].checked == true && chkbox[2].checked == true && chkbox[3].checked == true){
             		checkAll.checked = true;
             	}
            }
        }
        

		//submit 이벤트 발생시 아이디 중복 체크 여부 확인
		$('#register_form').submit(function(){
			if(checkId==0){
				$('#message_id').css('color','red').text('아이디 중복 체크 필수');
				if($('#id').val().trim()==''){
					$('#id').val('').focus();
				}
				return false;
			}
			
			if(chk1.checked == false || chk2.checked == false || chk3.checked == false){
				alert('필수 약관을 동의해주세요.');
				return false;
			}
			

			if(chk4.checked == true){
				alert('마케팅 수신 동의를 선택하셨습니다.');
			}
			
			
		});
		
	});
</script>
<!-- 중앙 내용 시작 -->
<div class="container">
	<div class="box">
	<h2>회원가입</h2>
	<form:form id="register_form" action="register.do" modelAttribute="memberVO">
		<ul>
			<li class="form-li">
				<div>
					<label for="id">아이디</label>
					<input type="button" id="confirmId" value="ID중복체크">
				</div>
				<form:input path="id" placeholder="4~12자 영문,숫자만 허용"/>
				<form:errors path="id" cssClass="error-color"/>
				<span id="message_id"></span>
			</li>
			<li class="form-li">
				<label for="name">이름</label>
				<form:input path="name"/>
				<form:errors path="name" cssClass="error-color"/>
			</li>
			<li class="form-li">
				<label for="pass">비밀번호</label>
				<form:password path="pass" />
				<form:errors path="pass" cssClass="error-color"/>
			</li>
			<li class="form-li">
				<label for="phone">전화번호</label>
				<form:input path="phone"/>
				<form:errors path="phone" cssClass="error-color"/>
			</li>
			<li class="form-li">
				<label for="email">이메일</label>
				<form:input path="email"/>
				<form:errors path="email" cssClass="error-color"/>
			</li>
			<li class="form-li">
				<label for="zipcode">우편번호</label>
				<form:input path="zipcode"/>
				<form:errors path="zipcode" cssClass="error-color"/>
			</li>
			<li class="form-li">
				<label for="address">주소</label>
				<form:input path="address"/>
				<form:errors path="address" cssClass="error-color"/>
			</li>
			<li class="form-li">
				<label for="address_detail">나머지 주소</label>
				<form:input path="address_detail"/>
				<form:errors path="address_detail" cssClass="error-color"/>
			</li>
		</ul>
		<!-- 동의 체크박스 시작 -->
		<div class="checkbox">
			<label class="label_check">
	    		<input type="checkbox" id="checkAll"><span class="ipBox">전체동의</span>
			</label>
			<hr size="1" style="height:0.1px;margin:0;">
			<label class="label_check">
	    		<input type="checkbox" id="chk1" name="chk1" value="chk1" class="chkbox"><span>펀딩 어드벤처 약관 동의</span>
	    		<a href="#" class="view-content">내용보기</a>
			</label>
			<label class="label_check">
		    	<input type="checkbox" id="chk2" name="chk2" value="chk2" class="chkbox"><span>개인정보 수집, 이용 동의</span>
		    	<a href="#" class="view-content">내용보기</a>
			</label>
			<label class="label_check">
		    	<input type="checkbox" id="chk3" name="chk3" value="chk3" class="chkbox"><span>만 14세 이상입니다</span>
			</label>
			<label class="label_check">
		    	<input type="checkbox" id="chk4" name="chk4" value="chk4" class="chkbox"><span>마케팅 수신 정보 동의(선택)</span>
			</label>
		</div>
		<!-- 동의 체크박스 끝 -->
		<div class="align-center">
			<form:button class="submit-btn">회원가입</form:button>
		</div>
	</form:form>
	<div class="sub-function">
		<div class="align-center">
			<p>
				<span>이미 계정이 있으신가요?	</span>
				<a href="${pageContext.request.contextPath}/member/login.do">로그인</a>
			</p>
			<p class="search-btn">
				<input type="button" value="아이디 찾기" onclick="location.href='${pageContext.request.contextPath}/member/searchID.do'">
				<span>	|	</span>
				<input type="button" value="비밀번호 재설정" onclick="location.href='${pageContext.request.contextPath}/member/searchPass.do'">
			</p>
		</div>
		</div>
	</div>
</div>
<!-- 중앙 내용 끝 -->



