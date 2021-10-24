<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#update_approval_form").submit(function(){
		var check = confirm("수정을 완료하고 심사를 신청하시겠습니까?");
		return check;
	});
	
	$("#home").click(function(){
		document.location.href='${pageContext.request.contextPath}/mypage/main.do';
	});
});
</script>
<!-- 중앙 내용 시작 -->
<div class="container">
	<div class="align-center">
		<div>
			프로젝트 창작 완료!<br>
			<br>
			심사를 신청한 프로젝트는 더이상 수정하실 수 없으며<br>
			승인 과정을 거친 후, 설정하신 기간 동안 펀딩 페이지에 올라갑니다.<br>
			<br>
			또한 프로젝트에 올라가는 팀명은 여러분의 닉네임으로 올라가게 됩니다.<br>
			이 점을 참고하시어 마이페이지에서 확인 후, 수정해주세요.
		</div>
		
		<div class="align-center">
			<form:form id="update_approval_form" action="updateApproval.do" modelAttribute="projectVO">
				<form:input type="hidden" value="${num}" path="num" />
				<form:button>심사 신청</form:button>
			</form:form>
			<input type="button" id="home" value="홈으로" >
		</div>
	</div>
</div>
<!-- 중앙 내용 끝 -->