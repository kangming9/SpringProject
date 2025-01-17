<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/question.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		//검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim() == ''){
				alert('검색어를 입력하세요');
				$('#keyword').val('').focus();
				return false;
			}
		});
		
	});
</script>
<!-- 중앙 내용 시작 -->
<div class="container">
	<div class="box">
	<div class="list-title">
		<h2>문의게시판</h2>
		<span>무엇이든 물어보세요!</span>
		<form id="search_form" action="list.do" method="get">
			<ul class="search">
				<li>
					<select name="keyfield" id="keyfield">
						<option value="1">제목</option>
						<option value="2">ID</option>
						<option value="3">내용</option>
						<option value="4">제목 + 내용</option>
					</select>
					<input type="search" name="keyword" id="keyword">
					<input type="submit" value="찾기" class="btns">
				</li>
				
			</ul>
		</form>
	</div>
	
	
	<c:if test="${!empty user_num}">
		<div class="question-btn">
			<input type="button" value="문의 등록" onclick="location.href='register.do'" class="question-register-btn">
		</div>
	</c:if>
	<c:if test="${count==0}">
		<div class="result-display">
			등록된 문의글이 없습니다.
		</div>
	</c:if>
	<c:if test="${count > 0}">
		<table id="question-table" class="align-center">
			<tr>
				<th class="question-line">번호</th>
				<th width="250" class="question-line">제목</th>
				<th class="question-line">닉네임</th>
				<th class="question-line">작성일</th>
			</tr>
			<c:forEach var="question" items="${list}">
			<tr>
				<td class="question-line">${question.num}</td>
				<td class="question-line">
				
				<c:if test="${empty question.password}">
					<a href="detail.do?num=${question.num}">${question.title}</a> 
				</c:if>
				
				<c:if test="${!empty question.password}">
					<a href="qCheckPass.do?num=${question.num}">${question.title}</a> 
				</c:if>
				
				</td>
				<td class="question-line">${question.nickname}</td>
				<td class="question-line">${question.question_date}</td>
			</tr>
			</c:forEach>
			
		</table>
		<div class="align-center" style="font-size:16px;">${pagingHtml}</div>
	</c:if>
	</div>
</div>
<!-- 중앙 내용 시작 -->