<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css" type="text/css">
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
<div>
	<div class="miniTitle_left">
	<b class="miniTitle_content">회원 관리</b>
	</div>
	<hr noshade="noshade" class="line">
</div>
<div class="page-main align-center">
	<div class="page-container">
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
			<p>
		</div>
		<c:if test="${mem_count == 0}">
		<div class="result-display">
			등록된 회원이 없습니다.
		</div>
		</c:if>
		<c:if test="${mem_count > 0}">
		<div class="tb-container">
		<div>
			<div>
			<p>총 회원수</p>
			<p>총${allMem}</p>
			<p>진짜${realMem}</p>
			<p>후원자수${sMem}</p>
			<p>프로젝트창작자수${pMem}</p>
			</div>
			
		</div>
		<table class="manager_member_table">
			<thead class="tb-header">
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>전화번호</th>
					<th>가입일</th>
					<th>등급</th>
					<th>권한</th>
				</tr>
			</thead>
			<tbody class="tb-content">
			<c:forEach var="member" items="${list}">
			<tr class="manager_member_content">
				<td>
					${member.id}
				</td>
				<td>${member.name}</td>
				<td>${member.phone}</td>
				<td>${member.reg_date}</td>
				<td>
				<c:if test="${member.grade == 0}">관리자</c:if>
				<c:if test="${member.grade == 1}">탈퇴</c:if>
				<c:if test="${member.grade == 2}">일반회원</c:if>
				<c:if test="${member.grade == 3}">카카오</c:if>
				<c:if test="${member.grade == 4}">추방 회원</c:if>
				</td>
				<td>
					<button class="btnCss" onclick="location.href='${pageContext.request.contextPath}/member/outMember.do?num=${member.num}'">추방</button>
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







