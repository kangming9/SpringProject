<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		var team_photo;
		var default_path = "${pageContext.request.contextPath}/resources/images/default_team.jpg";
		var uploadphoto = 0;

		$('#upload').change(function(){
			var photo = document.getElementById('upload');
			team_photo = photo.files[0];
			if(team_photo){
				var reader = new FileReader();

				reader.readAsDataURL(team_photo); //team_photo에 저장된 upload의 이미지 파일의 URL을 읽어옴
				
				reader.onload=function(){
					$('#team-photo').attr('src',reader.result); //읽어온 URL을 team-photo의 src값으로 설정
				};
			}else{ //이미지 파일이 없는 경우 기본 이미지를 띄움
				document.getElementById("team_upload").src = default_path;
			}
		});
		
		$("#photo_submit").click(function(){
			if($("#upload").val() == ""){ //업로드한 파일이 없는 경우 return
				alert("파일을 선택하세요!");
				$("#upload").focus();
				return;
			}
			
			//파일 전송
			var formData = new FormData();

			formData.append("upload", team_photo); //현재 띄워진 이미지 파일
			formData.append("num", $('#num').val()) //프로젝트 num

			$.ajax({
				data: formData,
				type: "post",
				url:'updatePhoto.do',
				dataType:'json',
				cache:false,
				contentType:false,
				enctype:'multipart/form-data',
				processData:false,
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인 후 사용하세요');
					}else if(param.result == 'success'){
						uploadphoto = 1;
						
						alert('대표 이미지 수정 완료.');

						$('#upload').val('');
					}else{
						alert('파일 전송 오류 발생');
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});
		});		
		 
			//대표 이미지 등록 취소
		$('#photo_reset').click(function(){
			
			var num = $('#num').val();
			
			team_photo = null;
			$('#team-photo').attr('src', default_path); //기본 이미지로 변경
			$('#upload').val(''); //upload했던 파일 값 삭제
			
			$.ajax({
				data: {'num': num },
				type: "post",
				url:'deletePhoto.do',
				dataType:'json',
				cache:false,
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인 후 사용하세요');
					}else if(param.result == 'success'){
						uploadphoto = 0;
						
						alert('대표 이미지 삭제 완료.');

					}else{
						alert('삭제 오류 발생');
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});
		});

		$("#update_Add_form").submit(function(){
			if(uploadphoto == 0) {
				var answer = confirm("대표 이미지가 등록되지 않았습니다.\n그래도 다음 페이지로 이동하시겠습니까?");
			}
			return answer;
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
	<h2>프로젝트 수정 - 추가 정보</h2>
	<h3 id="projectname">${name}</h3>
	<div class="box">
		<ul>
			<li>
				<div>
				<label>프로젝트 대표 이미지</label>
				<c:if test="${project.photo == 'default_team.jpg'}">
					<img alt="프로젝트 대표 이미지" src="${pageContext.request.contextPath}/resources/images/default_team.jpg" id="team-photo">
				</c:if>
				<c:if test="${project.photo != 'default_team.jpg'}">
					<img alt="프로젝트 대표 이미지" src="${pageContext.request.contextPath}/upload/${project.photo}" id="team-photo">
				</c:if>
				</div>
				<br>
				<div>
					<input id="upload" type="file" name="team_upload" accept="image/gif,image/png,image/jpeg,image/jpg" />
					<input type="button" value="등록" id="photo_submit"/>
					<input type="button" value="취소" id="photo_reset"/>
				</div>
			</li>
		</ul>
		
		<form:form id="update_Add_form" action="updateProjectAdd.do" modelAttribute="projectVO">
		
			<form:input type="hidden" value="${project.num}" path="num" id="num"/>
			<form:input type="hidden" value="${project.name}" path="name" id="name"/>
			
			<div class="align-center">
				<form:button>다음</form:button>
				<input type="button" id="home" value="홈으로" >
			</div>
		</form:form>
	</div>
</div>
<!-- 중앙 내용 끝 -->



