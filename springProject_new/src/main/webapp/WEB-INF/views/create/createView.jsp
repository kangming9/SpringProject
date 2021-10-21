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
			프로젝트 창작 완료!
			프로젝트 수정은 마이페이지를 통해 가능합니다.
			심사를 신청한 프로젝트는 더이상 수정하실 수 없으며
			승인 과정을 거친 후, 설정하신 기간 동안 펀딩 페이지에 올라갑니다.
		</div>

		<input type="button" id="home" value="홈으로" >
	</div>
</div>
<!-- 중앙 내용 끝 -->