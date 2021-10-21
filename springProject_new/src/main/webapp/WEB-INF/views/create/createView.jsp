<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){
	$("#home").click(function(){
		var answer;
		answer = confirm("지금까지 작성한 내용이 저장되지 않습니다.\n그래도 나가시겠습니까?");
		if(answer) document.location.href='${pageContext.request.contextPath}/main/main.do';
	});
});
</script>
<!-- 중앙 내용 시작 -->
<div class="container">
	<div class="align-center">
		<div>
			프로젝트 창작 완료!<br>
			프로젝트 수정은 마이페이지를 통해 가능합니다.<br>
			심사를 신청한 프로젝트는 더이상 수정하실 수 없으며<br>
			승인 과정을 거친 후, 설정하신 기간 동안 펀딩 페이지에 올라갑니다.<br>
			<br>
			또한 프로젝트에 올라가는 팀명은 여러분의 닉네임으로 올라가게 됩니다.<br>
			이 점을 참고하시어 마이페이지에서 확인 후, 수정해주세요.
		</div>

		<input type="button" id="home" value="홈으로" >
	</div>
</div>
<!-- 중앙 내용 끝 -->