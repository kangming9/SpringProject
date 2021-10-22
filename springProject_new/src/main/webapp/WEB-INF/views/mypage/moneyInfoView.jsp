<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/projectView.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<style>
	.ck-editor__editable_inline{
		min-height:500px;
	}
</style>
<script type="text/javascript" src="http://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/uploadAdapter.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/videoAdapter.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		var num = "${num}";
		
		$("#project_info_form").submit(function(){
			return false;
		});
		
		$("#support_info_form").submit(function(){
			return true;
		});
		
		$("#state_info_form").submit(function(){
			return true;
		});
		
		$("#money_info_form").submit(function(){
			return true;
		});
		
		$("#sendEmail").click(function(){
			var d = new Date();
			var now = d.getFullYear() + "년 " + (d.getMonth() + 1) + "월 " + d.getDate() + "일";
			
			var data = {
					service_id: 'service_8o9nbag',
					template_id: 'template_t0nrekt',
					user_id: 'user_J1kMwyQU1edw8mRCgTNy4',
					template_params: {
						'project' : "${name}",
						'email' : "16.ehee@gmail.com",
						'name': "${nickname}",
						'now' : now,
						'supporter' : $("#supporter").text(),
						'support' : $("#support").text(),
						'donation' : $("donation").text(),
						'tax' : $("#tax").text(),
						'tax_site' : $("#tax_site").text(),
						'tax_pay' : $("#tax_pay").text(),
						'money' : $("#money").text(),
						'date' : $("#date").text()
						}
			};
			
			$.ajax(
				'https://api.emailjs.com/api/v1.0/email/send', { 
					type: 'POST', 
					data: JSON.stringify(data), 
					contentType: 'application/json' 
				}).done(function() { 
					alert('메일로 후원금 정보가 전송되었습니다.');
				}).fail(function(error) { alert('메일 전송 오류 발생'); });
		});
		
	});
	
	
</script>

<!-- 중앙 내용 시작 -->
<div class="container">
	<h2>후원자 정보</h2>
	<div>
		<form:form id="project_info_form" action="projectInfo.do" modelAttribute="projectVO">
			<form:input type="hidden" path="name" value="${name}" />
			<form:input type="hidden" path="goal_amount_str" value="project" />
			<form:button>프로젝트 정보</form:button>
		</form:form>
		<form:form id="support_info_form" action="projectInfo.do" modelAttribute="projectVO">
			<form:input type="hidden" path="name" value="${name}" />
			<form:input type="hidden" path="goal_amount_str" value="support" />
			<form:button>후원자 정보</form:button>
		</form:form>
		<form:form id="state_info_form" action="projectInfo.do" modelAttribute="projectVO">
			<form:input type="hidden" path="name" value="${name}" />
			<form:input type="hidden" path="goal_amount_str" value="state" />
			<form:button>후원자 통계</form:button>
		</form:form>
		<form:form id="money_info_form" action="projectInfo.do" modelAttribute="projectVO">
			<form:input type="hidden" path="name" value="${name}" />
			<form:input type="hidden" path="goal_amount_str" value="money" />
			<form:button>후원금 정보</form:button>
		</form:form>
	</div>
	
	<div class="content">
		<div>
			<p>총 후원자 수</p>
			<p id = "supporter">${supportSum.m_num} 명</p>
		</div>
		<div>
			<p>총 후원 금액</p>
			<p id = "support">${supportSum.support_amount} 원</p>
		</div>
		<div>
			<p>총 추가 후원 금액</p>
			<p id = "donation">${supportSum.donation} 원</p>
		</div>
		<div>
			<p>수수료 내역</p>
			<p id = "tax"><fmt:formatNumber type="number"  pattern="0" value="${supportSum.donation * 0.085}" /> 원</p>
			<p>Funding Adventure</p>
			<p id = "tax_sizte"><fmt:formatNumber type="number"  pattern="0" value="${supportSum.donation * 0.05}" /> 원</p>
			<p>결제 수수료</p>
			<p id = "tax_pay"><fmt:formatNumber type="number"  pattern="0" value="${supportSum.donation * 0.035}" /> 원</p>
		</div>
		<div>
			<p>최종 수령액</p>
			<p id = "money"><fmt:formatNumber type="number"  pattern="0" value="${supportSum.donation * 0.915}" /> 원</p>
		</div>
		<div>
			<p>예상 정산 날짜</p>
			<p id = "date">${finish}</p>
		</div>
	</div>
	<div>
		<button id="sendEmail">메일로 전송</button>
	</div>
	
</div>