<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css" type="text/css">
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
<div>
	<div class="miniTitle_left">
	<b class="miniTitle_content">문의</b>
	</div>
	<div class="miniTitle_right">
		<br>
		<i class="fas fa-bell xs" id="notice_alarm"></i>
		나의 프로젝트 크레이지 아케이드 목표금액 달성
	</div>
	<hr noshade="noshade" class="line">
</div>
<!-- 중앙 내용 시작 -->
<div class="q_container">
	<div class="q_box">
	<div class="q_list-title">
		<form id="search_form" action="list.do" method="get">
			<ul class="q_search">
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
		<div class="q_question-btn">
			<input type="button" value="문의 등록" onclick="location.href='${pageContext.request.contextPath}/question/register.do'" class="q_question-register-btn">
		</div>
	</c:if>
	<c:if test="${count==0}">
		<div class="result-display">
			등록된 게시물이 없습니다.
		</div>
	</c:if>
	<c:if test="${count > 0}">
		<table id="q_question-table" class="align-center">
			<tr>
				<th class="q_question-line">번호</th>
				<th width="250" class="q_question-line">제목</th>
				<th class="q_question-line">닉네임</th>
				<th class="q_question-line">작성일</th>
			</tr>
			<c:forEach var="question" items="${list}">
			<tr>
				<td class="q_question-line">${question.num}</td>
				<td class="q_question-line"><a class="deleteA" href="${pageContext.request.contextPath}/question/detail.do?num=${question.num}">${question.title}</a></td>
				<td class="q_question-line">${question.nickname}</td>
				<td class="q_question-line">${question.question_date}</td>
			</tr>
			</c:forEach>
			
		</table>
		<div class="align-center" style="font-size:16px;">${pagingHtml}</div>
	</c:if>
	</div>
</div>
<!-- 중앙 내용 시작 -->