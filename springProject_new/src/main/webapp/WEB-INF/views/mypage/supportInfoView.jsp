<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<table>
			<tr>
				<th>번호</th>
				<th>후원자</th>
				<th>후원 선물</th>
				<th>후원 선물 금액</th>
				<th>추가 후원 금액</th>
				<th>총 후원 금액</th>
				<th>후원 날짜</th>
			</tr>
			<c:forEach var="supporter" items="${supporterList}">
			<tr>
				<td>${supporter.num}</td>
				<td>${supporter.nickname}</td>
				<td>${supporter.name}</td>
				<td>${supporter.price}</td>
				<td>${supporter.donation}</td>
				<td>${supporter.support_amount}</td>
				<td>${supporter.payment_date_str}</td>
			</tr>
			</c:forEach>
		</table>
	</div>
</div>