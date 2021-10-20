<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/question.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		var currentPage;
		var count;
		var rowCount;
		
		//댓글목록
		function selectData(pageNum,board_num){
			
		}
		
		//다음 댓글 보기 버튼 클릭시 데이터 추가
		//댓글 등록
		$('#answer_form').submit(function(event){
			if($('#a_content').val().trim()==''){
				alert('내용을 입력하세요');
				$('#a_content').val('').focus();
				return false;
			}
			var data = $(this).serialize();
			//등록
			$.ajax({
				type:'post',
				data:data,
				url:'writeAnswer.do',
				dataType:'json',
				cache:false,
				timeout:30000,
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인 해야 작성할 수 있습니다.');
					}else if(param.result == 'success'){
						initForm();
						//댓글 작성 성공시 새로 삽입한 글 포함 첫번째 페이지의 게시글들을 다시 호출
						selectData(1,${'#q_num'});
					}else{
						alert('댓글 등록시 오류 발생');
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});
			//기본 이벤트 제거
			event.preventDefault();
		});
		//댓글 작성폼 초기화
		function initForm(){
			$('textarea').val('');
			$('#a_first .letter-count').text('300/300');	
		}
		//textarea 내용 입력시 글자수 체크
		//댓글 수정 버튼 클릭시 수정폼 노출
		//수정 폼에서 취소 버튼 클릭시 수정 폼 초기화
		//댓글 수정 폼 초기화
		//댓글 수정
		//댓글 삭제
		//초기 데이터(목록) 호출
		selectData(1,$('#q_num').val());
		
		
		
		
	});
</script>
<!-- 중앙내용 시작 -->
<div class="container">
	<c:if test="${!empty question.password}">
		
	</c:if>
	<h2>${quesiton.title}</h2>
	<input type="hidden" value="${question.password}">
	<ul>
		<li>제목 : ${question.title}</li>
		<li>번호 : ${question.num}</li>
		<li>작성자 : ${question.id}</li>
		<li>작성일 : ${question.question_date}</li>
	</ul>
	<hr size="1" width="100%">
	<p>${question.content}</p>
	<hr size="1" width="100%">
	<div class="align-right">
		<c:if test="${!empty user_num && user_num == question.m_num}">
			<input type="button" value="수정" onclick="location.href='modify.do?num=${question.num}'">
			<input type="button" value="삭제" id="delete_btn">
			<script type="text/javascript">
				var delet_btn = document.getElementById('delete_btn');
				delete_btn.onclick=function(){
					var choice = confirm('삭제하시겠습니까?');
					if(choice){
						location.replace('delete.do?num=${question.num}');
					}
				};
			</script>
		</c:if>
		<input type="button" value="목록" onclick="location.href='list.do'">
	</div>
	<hr size="1" width="100%" noshade="noshade">
	<div id="answer_div">
		<span class="answer-title">댓글 달기</span>
		<form id="answer_form">
			<input type="hidden" name="q_num" value="${q_num} id="q_num">
			<input type="hidden" name="m_num" value="${user_num}" id="m_num">
			<textarea rows="3" cols="50" name="a_content" id="a_content" class="a_content" 
			<c:if test="${empty user_num}">disabled="disabled"</c:if>
			><c:if test="${empty user_num}">로그인 해야 작성할 수 있습니다.</c:if></textarea>
			<c:if test="${!empty user_num }">
				<div id="a_first">
					<span class="letter-count">300/300</span>
				</div>
				<div id="a_second" class="align-right">
					<input type="submit" value="전송">
				</div>
			</c:if>
		</form>
	</div>
	<!-- 댓글 목록 출력 -->
	<div id="output">
		<div class="paging-button" style="display:none;">
			<input type="button" value="다음글 보기">
		</div>
		<div id="loading" style="display:none;">
			<img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
		</div>
	</div>
	
	
</div>


<!-- 중앙내용 끝 -->