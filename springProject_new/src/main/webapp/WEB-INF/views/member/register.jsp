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
<!-- 배송지 API -->
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.(나머지주소)
                    document.getElementById("address_detail").value = extraAddr;
                
                } else {
                    document.getElementById("address_detail").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address_detail").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
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
				<div>
				<label for="zipcode">우편번호</label>
				<input type="button" id="address-btn" onclick="sample2_execDaumPostcode()" value="우편번호">
				</div>
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



