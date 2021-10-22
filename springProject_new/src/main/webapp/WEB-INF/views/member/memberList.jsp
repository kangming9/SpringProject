<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${check==false}">
	<script>
		alert('관리자 권한이 없습니다.');
		history.go(-1);
	</script>
</c:if>


<!DOCTYPE html>

<html>

<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style_memList.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('#search_form').submit(function(){
			if($('#keyword').val().trim()==''){
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
</head>
<body>
<div class="page-main">
	<div class="page-container">
	<span class="page-name">회원 목록</span>
	<div class="list-container">
		<div class="top">
			<form id="search_form" action="memberList.do" method="get">
			<div class="search" style="float: middle">
				<select name="keyfield">
						<option value="1">아이디</option>
						<option value="2">이름</option>
				</select>
				<input type="search" size="25" name="keyword" id="keyword">
				<input type="submit" value="검색" class="submit btns">
			</div>
			</form>
			<div class="btn-container">
				<input type="button" value="목록" class="cancel btns" onclick="location.href='memberList.do'">
				<input type="button" value="마이페이지" class="home btns" onclick="location.href='myPage.do'">
			</div>
		</div>
		<c:if test="${mem_count == 0}">
		<div class="result-display">
			등록된 회원이 없습니다.
		</div>
		</c:if>
		<c:if test="${mem_count > 0}">
		<div class="tb-container">
		<table>
			<thead class="tb-header">
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>전화번호</th>
					<th>가입일</th>
					<th>등급</th>
				</tr>
			</thead>
			<tbody class="tb-content">
			<c:forEach var="member" items="${list}">
			<tr>
				<td>
					<c:if test="${!(member.grade == 1)}">
					<a href="detailUserForm.do?mem_num=${member.num}">${member.id}</a>
					</c:if>
					<c:if test="${member.grade == 1}">
					${member.id}
					</c:if>
				</td>
				<td>${member.name}</td>
				<td>${member.phone}</td>
				<td>${member.reg_date}</td>
				<td>
				<c:if test="${member.grade == 0}">관리자</c:if>
				<c:if test="${member.grade == 1}">탈퇴</c:if>
				<c:if test="${member.grade == 2}">일반회원</c:if>
				<c:if test="${member.grade == 3}">구글</c:if>
				<c:if test="${member.grade == 4}">카카오</c:if>
				<c:if test="${member.grade == 5}">네이버</c:if>
				</td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		</div>
		<div class="align-center memlist">
			${pagingHtml}
		</div>
		</c:if>
	</div>
	</div>

</div>
</body>
</html>







