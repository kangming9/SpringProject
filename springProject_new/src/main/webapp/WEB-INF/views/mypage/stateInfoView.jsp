<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/projectView.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<style>
	.ck-editor__editable_inline{
		min-height:500px;
	}
</style>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		var num = "${num}";			
		  
		$("#project_info_form").submit(function(){
			return true;
		});
		
		$("#support_info_form").submit(function(){
			return false;
		});
		
		$("#state_info_form").submit(function(){
			return true;
		});
		
		$("#money_info_form").submit(function(){
			return true;
		});
		
	});
	
	var arr = [["선물", "후원자 수"]];
	<c:forEach items="${supportList}" var="item">
		var inarr = new Array(2);
		inarr[0] = "";
		inarr[1] = ${item};
		arr.push(inarr);
	</c:forEach>
	var garr =new Array();
	<c:forEach items="${giftList}" var="item">
		garr.push("${item.name}");
	</c:forEach>
	for(var i = 0; i < arr.length; i++){
		arr[1][0] = garr[i];
	}
	
	google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {

      var data = google.visualization.arrayToDataTable(arr);

      var options = {
        title: '선물별 후원자 수'
      };

      var chart = new google.visualization.PieChart(document.getElementById('supportChart'));

      chart.draw(data, options);
    }
	
</script>

<!-- 중앙 내용 시작 -->
<div class="container">
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
	<div id="supportChart" style="width: 900px; height: 500px;"></div>
</div>