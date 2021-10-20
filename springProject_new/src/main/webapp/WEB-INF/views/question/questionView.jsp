<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/question.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
		$(function(){
			//현재 페이지
			var currentPage;
			var count;
			var rowCount;
			
			//댓글 목록
			function selectData(pageNum,q_num){
				currentPage = pageNum;
				
				if(pageNum == 1){
					//처음 호출시는 해당 ID의 div의 내부 내용물을 제거
					$('#output').empty();
				}
				
				$('#loading').show();
				
				$.ajax({
					type:'post',
					data:{pageNum:pageNum,q_num:q_num},
					url:'listAnswer.do',
					dataType:'json',
					cache:false,
					timeout:30000,
					success:function(param){
						
						$('#loading').hide();
						count = param.count;
						rowCount = param.rowCount;
						
						$(param.list).each(function(index,item){
							var output = '<div class="item">';
							output += '<h4>' + item.nickname + '</h4>';
							output += '<div class="sub-item">';
							output +='   <p>' + item.a_content.replace(/</gi,'&lt;').replace(/>/gi,'&gt;') + '</p>';
							output += item.answer_date;
							//로그인한 회원 번호가 댓글 작성자 회원 번호와 같으면 보이는 버튼들
							if($('#m_num').val()==item.m_num){
								output += ' <input type="button" data-num="'+item.num+'" data-mem="'+item.m_num+'" value="수정" class="modify-btn">';
								output += ' <input type="button" data-num="'+item.num+'" data-mem="'+item.m_num+'" value="삭제" class="delete-btn">';
							}
							output += '  <hr size="1" noshade>';
							output += '</div>';
							output += '</div>';
							
							//문서 객체에 추가
							$('#output').append(output);						
						});//end of each
						
						//paging button 처리
						if(currentPage>=Math.ceil(count/rowCount)){
							//다음 페이지가 없음
							$('.paging-button').hide();
						}else{
							//다음 페이지가 존재
							$('.paging-button').show();
						}
						
					},
					error:function(){
						alert('네트워크 오류 발생 댓글 목록');
					}
				});
				
			}
			
			
			//다음 댓글 보기 버튼 클릭시 데이터 추가
			$('.paging-button input').click(function(){
				var pageNum = currentPage + 1;
				selectData(pageNum,$('#q_num').val());
			});
			
			
			//댓글 등록
			$('#answer_form').submit(function(event){
				if($('#a_content').val().trim()==''){
					alert('내용을 입력하세요!');
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
							alert('로그인해야 작성할 수 있습니다.');
						}else if(param.result == 'success'){
							//폼초기화
							initForm();
							//댓글 작성이 성공하면 새로 삽입한 글을 포함해서 첫번째 페이지의
							//게시글들을 다시 호출
							selectData(1,$('#q_num').val());
						}else{
							alert('댓글 등록시 오류 발생!');
						}
					},
					error:function(){
						alert('네트워크 오류 발생 댓글 등록');
					}
				});
				//기본 이벤트 제거
				event.preventDefault();
			}); 
			
			
			//댓글 작성 폼 초기화
			function initForm(){
				$('textarea').val('');
				$('#a_first .letter-count').text('300/300');
			}
			
			
			//textarea에 내용 입력시 글자수 체크
			$(document).on('keyup','textarea',function(){
				//남은 글자수를 구함
				var inputLength = $(this).val().length;
				
				if(inputLength>300){//300자를 넘어선 경우
					$(this).val($(this).val().substring(0,300));
				}else{//300자 이하인 경우
					var remain = 300 - inputLength;
					remain += '/300';
					if($(this).attr('id') == 'a_content'){
						//등록폼 글자수
						$('#a_first .letter-count').text(remain);
					}else{
						//수정폼 글자수
						$('#m_a_first .letter-count').text(remain);
					}
				}
			});
			
			//데이터(목록) 호출
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
	
	<!-- 댓글 폼 시작 -->
	<div id="answer_div">
		<span class="answer-title">댓글</span>
		<form id="answer_form">
			<input type="hidden" name="q_num" value="${question.num}" id="q_num">
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
	
	<!-- 댓글 폼 끝 -->
	<!-- 댓글 목록 출력 -->
	<div id="output"></div>
	<div class="paging-button" style="display:none;">
		<input type="button" value="다음글 보기">
	</div>
	<div id="loading" style="display:none;">
		<img src="${pageContext.request.contextPath}/resources/images/ajax-loader.gif">
	</div>
</div>


<!-- 중앙내용 끝 -->