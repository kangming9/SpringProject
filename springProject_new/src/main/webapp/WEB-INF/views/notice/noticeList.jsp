<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/question.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice.css">
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
	<h2>프로젝트</h2>
	<div class="category">
		<c:if test="${project.category == 0}">온라인</c:if>
		<c:if test="${project.category == 1}">모바일</c:if>
		<c:if test="${project.category == 2}">보드</c:if>
		<c:if test="${project.category == 3}">카드</c:if>
	</div>
	<div class="projectOutline">
		<div class="outline-left">
			<c:if test="${project.photo == 'default_team.jpg'}">
				<a href="${pageContext.request.contextPath}/project/detail.do?num=${project.num}">
					<img class="photo" src="${pageContext.request.contextPath}/resources/images/default_team.jpg">
				</a>
			</c:if>
			<c:if test="${project.photo != 'default_team.jpg'}">
				<a href="${pageContext.request.contextPath}/project/detail.do?num=${project.num}">
					<img class="photo" src="${pageContext.request.contextPath}/upload/${project.photo}">
				</a>
			</c:if>
		</div>
		<div class="outline-right">
			<ul>
				<li>
					<div class="info-content">
						<a href="${pageContext.request.contextPath}/project/detail.do?num=${project.num}">
							<b>${project.name}</b>
						</a>
					</div>
				</li>
				<li>
					<div class="creator">
						<div class="profile">
							<c:if test="${empty creator.photo}">
								<img class="my-photo" src="${pageContext.request.contextPath}/resources/images/userimage.png" width="25" height="25">
							</c:if>
							<c:if test="${!empty creator.photo}">
								<img class="my-photo" src="${pageContext.request.contextPath}/mypage/mphotoView.do?num=${project.m_num}" width="25" height="25">
							</c:if>
						</div>
						<div class="nickname">&nbsp;${project.nickname}</div>
					</div>
				</li>
				<li>
					<div>
						<div>${project.summary}</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
	<hr>
	<div class="list-title">
		<h2>공지 게시판</h2>
		<span>프로젝트 공지사항을 확인하세요!</span>
		<form id="search_form" action="list.do" method="get">
			<input type="hidden" name="p_num" value="${p_num}">
			<ul class="search">
				<li>
					<select name="keyfield" id="keyfield">
						<option value="1">제목</option>
						<option value="2">내용</option>
						<option value="3">제목 + 내용</option>
					</select>
					<input type="search" name="keyword" id="keyword">
					<input type="submit" value="찾기" class="btns">
				</li>
			</ul>
		</form>
	</div>
	<c:if test="${!empty user_num && user_num==creator.num}">
		<div class="question-btn">
			<input type="button" value="공지 등록" onclick="location.href='register.do?p_num=${p_num}'" class="question-register-btn">
		</div>
	</c:if>
	<c:if test="${count==0}">
		<div class="result-display">
			등록된 게시물이 없습니다.
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
			<c:forEach var="notice" items="${list}">
			<tr>
				<td class="question-line">${notice.num}</td>
				<td class="question-line"><a href="detail.do?num=${notice.num}">${notice.title}</a></td>
				<td class="question-line">${notice.nickname}</td>
				<td class="question-line">${notice.not_date}</td>
			</tr>
			</c:forEach>
			
		</table>
		<div class="align-center" style="font-size:16px;">${pagingHtml}</div>
	</c:if>
	</div>
</div>
<!-- 중앙 내용 시작 -->