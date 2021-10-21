<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
		
		$("#summary").val("${summary}");
		$("#category").val("${category}").prop("selected", true);
		$("input:checkbox[name=" + "${ship}" +"]").prop("checked", true);
		
		//프로젝트명 중복 체크
		var checkName = 0;
		
		$("#confirmName").click(function(){
			if($("#name").val().trim() == ""){ //공백 외 문자가 없을 때
				$("#message_name").css("color", "red").text("프로젝트명 입력 필수");
				$("#id").val("").focus(); //공백 지우고 포커스
				return;
			}
			
			if($("#name").val() == "${name}"){
				$("#message_name").css("color", "#000").text("기존 프로젝트명");
				checkName = 1;
				return;
			}
			
			$.ajax({
				url:"confirmName.do",
				type:"post",
				data:{name:$("#name").val()},
				dataType:"json",
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == "nameNotFound"){
						$("#message_name").css("color", "#000").text("등록 가능");
						checkName = 1;
					}else if(param.result == "nameDuplicated"){
						$("#message_name").css("color", "red").text("중복된 프로젝트명");
						$("#name").val("").focus();
						checkName = 0;
					}else if(param.result == "notMatchPattern"){
						$("#message_name").css("color", "red").text("한글, 영문, 숫자만 사용 가능");
						$("#name").val("").focus();
						checkName = 0;
					}else{
						checkName = 0;
						alert("중복체크 오류");
					}
				},
				error:function(){
					checkName = 0;
					alert("네트워크 오류 발생");
				}
			});//end of ajax
		});//end of click
		
		//값을 입력하면 안내 메시지와 중복 값 초기화
		$("#create_project_form #name").keydown(function(){
			checkName = 0;
			$("#message_name").text("");
		});
		
		//중복 체크를 하지 않은 경우, submit 불가
		$("#create_project_form").submit(function(){
			if(checkName == 0){ //중복 체크를 했는지 확인
				$("#message_name").css("color", "red").text("중복체크 필수");
				if($("#name").val().trim() == ""){
					$("#name").val("").focus();
				}
				return false;
			}
			
			var goal = $("#goal_amount").val();
			
			if (goal < 100000){
				alert("목표 금액이 너무 적습니다.\n최소 금액은 10만원입니다.");
				return false;
			}else if(goal > 2000,000000){
				alert("목표 금액이 너무 많습니다.\n최대 금액은 20억원입니다.");
			}
			
			var startArr = $("#start_date").val().split('-'); //입력된 날짜를 -로 잘라 년,월,일을 배열로 저장
			var finishArr = $("#finish_date").val().split('-');
			var startdate = new Date(startArr[0], startArr[1] - 1, startArr[2]); //Date 객체로 변경
			var finishdate = new Date(finishArr[0], finishArr[1] - 1, finishArr[2]);
			var today = new Date();
			
			if(startdate.getTime() > finishdate.getTime()){ //시작 날짜가 종료 날짜보다 늦은 경우
				alert("시작 날짜 : " + startdate.getFullYear()+"/" + (startdate.getMonth() + 1) + "/" + startdate.getDate() + "\n종료 날짜 : " + finishdate.getFullYear()+"/" +(finishdate.getMonth() + 1) + "/" + finishdate.getDate() + "\n잘못된 종료 날짜.\n시작 날짜보다 앞선 날짜로 설정 불가능.");
				return false;
			}
			if(startdate.getTime() < today.getTime()){ //시작 날짜가 오늘 날짜보다 앞선 경우
				alert("오늘 날짜 : " + today.getTime() + "\n시작 날짜 : " + startdate.getTime() +"\n잘못된 시작 날짜.\n오늘 날짜 이후로 설정 가능.");
				return false;
			}
		});
		
		$("#home").click(function(){
			var answer;
			answer = confirm("지금까지 작성한 내용이 저장되지 않습니다.\n그래도 나가시겠습니까?");
			if(answer) document.location.href='${pageContext.request.contextPath}/main/main.do';
		});
	});
</script>

<!-- 중앙 내용 시작 -->
<div class="container">
	<h2>프로젝트 창작</h2>
	<div class="box">
	<c:if test="${approval == 2}">
		<div id ="approvalmessage">
			<h3>반려된 프로젝트</h3>
			<div>
				심사 결과, 반려된 페이지입니다.<br>
				<br>
				
				반려사유는 다음과 같습니다.<br>
				${reason}
				<hr>
			</div>
		</div>
	</c:if>
	<form:form id="create_project_form" action="updateProject.do" modelAttribute="projectVO" enctype="multipart/form-data">
		<ul>
			<li>
				<label for="name">프로젝트명</label><br>
				<form:input path="name" value="${name}" />
				<input type="button" id="confirmName" value="중복체크">
				<span id="message_name"></span>
				<form:errors path="name" cssClass="error-color"/>
			</li>
			<li>
				<label for="category">카테고리</label><br>
				<form:select path="category">
					<form:option value="0">온라인게임</form:option>
					<form:option value="1">모바일게임</form:option>
					<form:option value="2">보드게임</form:option>
					<form:option value="3">카드게임</form:option>
				</form:select>
			</li>
			<li>
				<label for="summary">프로젝트 요약</label><br>
				<form:textarea path="summary"/>
				<form:errors path="summary" cssClass="error-color"/>
			</li>
			<li>
				<label for="goal_amount">목표 금액</label><br>
				<form:input type="number" min="100000" max="2000000000" step="1000" path="goal_amount" value="${goal_amount}" />
				<form:errors path="goal_amount" cssClass="error-color"/>
			</li>
			<li>
				<label for="start_date">펀딩 날짜</label><br>
				<form:input type="date" path="start_date" id="start_date" value="${start_date}" />
				<form:input type="date" path="finish_date" id="finish_date" value="${finish_date}" />
				<form:errors path="start_date" cssClass="error-color"/>
				<form:errors path="finish_date" cssClass="error-color"/>
			</li>
			<li>
				<label for="ship">배송 여부</label><br>
				<form:radiobutton path="ship" value="0" name="0" label="온라인 상품"/>
				<form:radiobutton path="ship" value="1" name="1" label="배송 상품"/>
			</li>
			<li>
				<label>프로젝트 소개</label><br>
				<form:textarea id="intro" path="intro"/>
				<br>
				<label>프로젝트 정책</label>
				<form:textarea id="policy" path="policy"/>
				<script>
					function MyCustomUploadAdapterPlugin(editor){ //플러그인 설정
						editor.plugins.get("FileRepository").createUploadAdapter = (loader) => {
							return new UploadAdapter(loader);
						}
					}
					
					ClassicEditor.create(document.querySelector("#intro"),{
						extraPlugins:[MyCustomUploadAdapterPlugin] //플러그인 지정
					}).then(editor => {
						window.editor = editor;
					}).catch(error => {
						console.error(error);
					});
					
					ClassicEditor.create(document.querySelector("#policy"),{
						extraPlugins:[MyCustomUploadAdapterPlugin] //플러그인 지정
					}).then(editor => {
						window.editor = editor;
					}).catch(error => {
						console.error(error);
					});
					
					CKEDITOR.instances.intro.setData('${intro}');
					CKEDITOR.instances.policy.setData('${policy}');
				</script>
			</li>
		</ul>
		<div class="align-center">
			<form:button>다음</form:button>
			<input type="button" id="home" value="홈으로" >
		</div>
	</form:form>
	</div>
</div>
<!-- 중앙 내용 끝 -->