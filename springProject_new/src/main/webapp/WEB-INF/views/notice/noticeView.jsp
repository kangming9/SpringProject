<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/question.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<!-- 중앙내용 시작 -->
<div class="container">
	<div class="box">
	
	<!-- 문의글 내용 시작 -->
	<div class="question-content">
	<span class="question-content-title-line">No. ${notice.num}</span>
	<h2>${notice.title}</h2>
	<h4 style="margin-left:10px;">작성자 : ${notice.nickname}</h4>
	<span class="question-content-title-line">${notice.not_date}</span><br>

	<hr size="1" width="100%">
	<p class="question-content-view">${notice.content}</p>
	<div class="align-right">
		<c:if test="${!empty user_num && user_num == notice.m_num}">
			<input type="button" value="수정" onclick="location.href='modify.do?num=${notice.num}'" class="btns">
			<input type="button" value="삭제" id="delete_btn" class="btns">
			<script type="text/javascript">
				var delet_btn = document.getElementById('delete_btn');
				delete_btn.onclick=function(){
					var choice = confirm('삭제하시겠습니까?');
					if(choice){
						location.replace('delete.do?num=${notice.num}');
					}
				};
			</script>
		</c:if>
		<input type="button" value="목록" onclick="location.href='list.do?p_num=${notice.p_num}'" class="btns"> 
	</div>
	<hr size="1" width="100%" noshade="noshade">
	</div>
	<!-- 문의글 내용 끝 -->
	
</div>
</div>
<!-- 중앙내용 끝 -->