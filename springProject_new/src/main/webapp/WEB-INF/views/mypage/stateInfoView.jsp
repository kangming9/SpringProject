<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/projectView.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myProject.css">
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
			return true;
		});
		
		$("#state_info_form").submit(function(){
			return false;
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
		if(typeof garr[i] != "undefined")
			arr[i + 1][0] = garr[i];
	}
	
	var arr2 = [["선물", "후원 금액"]];
	<c:forEach items="${giftSupport}" var="item">
		var inarr = new Array(2);
		inarr[0] = "${item.name}";
		inarr[1] = ${item.support_amount};
		arr2.push(inarr);
	</c:forEach>
	
	google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);
    google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawStuff);

    function drawChart() {

      var data1 = google.visualization.arrayToDataTable(arr);

      var options = {
        title: ''
      };

      var chart = new google.visualization.PieChart(document.getElementById('supportChart'));

      chart.draw(data1, options);
    }
    
    function drawStuff(){
    	
    	var data2 = google.visualization.arrayToDataTable(arr2);
    	
    	var options = {
    	          width: 800,
    	          legend: { position: 'none' },
    	          chart: {
    	            title: '' },
    	          axes: {
    	            x: {
    	              0: { side: 'bottom', label: '후원 금액'} // x-axis.
    	            }
    	          },
    	          bar: { groupWidth: "90%" }
    	        };

    	var chart = new google.charts.Bar(document.getElementById('giftChart'));

		var fm = new google.visualization.NumberFormat({surfix: '원', pattern: '###,###'});
		fm.format(data2, 1);
    	        
    	chart.draw(data2, google.charts.Bar.convertOptions(options));
    }
    
    
	
</script>

<!-- 중앙 내용 시작 -->
<div class="container">
	<div id="btndiv" class="info">
		<div class="btnform">
			<form:form id="project_info_form" action="projectInfo.do" modelAttribute="projectVO">
				<form:input type="hidden" path="name" value="${name}" />
				<form:input type="hidden" path="goal_amount_str" value="project" />
				<form:button>프로젝트 정보</form:button>
			</form:form>
		</div>
		<div class="btnform">
			<form:form id="support_info_form" action="projectInfo.do" modelAttribute="projectVO">
				<form:input type="hidden" path="name" value="${name}" />
				<form:input type="hidden" path="goal_amount_str" value="support" />
				<form:button>후원자 정보</form:button>
			</form:form>
		</div>
		<div class="btnform">
			<form:form id="state_info_form" action="projectInfo.do" modelAttribute="projectVO">
				<form:input type="hidden" path="name" value="${name}" />
				<form:input type="hidden" path="goal_amount_str" value="state" />
				<form:button>후원자 통계</form:button>
			</form:form>
		</div>
		<div class="btnform">
			<form:form id="money_info_form" action="projectInfo.do" modelAttribute="projectVO">
				<form:input type="hidden" path="name" value="${name}" />
				<form:input type="hidden" path="goal_amount_str" value="money" />
				<form:button>후원금 정보</form:button>
			</form:form>
		</div>
	</div>
	<h2>후원자 통계</h2>
	<hr>
	<div id="chart">
		<h3>선물별 후원자 수</h3>
		<div id="supportChart" style="width: 900px; height: 400px;"></div>
		<h3>선물별 후원 금액</h3>
		<div id="giftChart" style="width: 900px; height: 500px;"></div>
	</div>
</div>