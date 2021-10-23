<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css" type="text/css">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<p>
<p>
<p>
<p>
<p>
<div>
	<div id="mypagePhotoWrap">
		<div class="justify-content">
			<c:if test="${empty member.photo}">
				<img src="${pageContext.request.contextPath}/resources/images/userimage.png" width="150" height="150" class="my-photo">
			</c:if>
			<c:if test="${!empty member.photo}"> <!-- 사진있는경우 -->
				<img src="${pageContext.request.contextPath}/mypage/photoView.do" width="150" height="150" class="my-photo">
			</c:if>
		</div>
		<div class="justify-content">
			<p style="font-size: 45px; margin: 0;"><b>MY PAGE</b></p>
		</div>
		<div class="justify-content">
			<span>${member.nickname}</span>
		</div>
	</div>
</div>
<div id="mypageTableWrap">
<table id="mypageTable">
	<colgroup>
		<col style="width:25%;">
		<col style="width:25%;">
		<col style="width:25%;">
		<col style="width:25%;">
	</colgroup>
	<thead>
		<tr><td colspan="4"><hr size="0.5"></td></tr>
		<tr class="mypageContentTitleWrap">
			<td>프로젝트</td>
			<td>문의</td>
			<td>정보관리</td>
			<td>로그아웃</td>
		</tr>
		<tr><td colspan="4"><hr size="0.5"></td></tr>
	</thead>
	<tbody>
		<tr class="mypageContentWrap">
			<td class="pointer" onclick="location.href='${pageContext.request.contextPath}/mypage/mySupport.do'">후원프로젝트 내역</td>
			<td class="pointer" onclick="location.href='${pageContext.request.contextPath}/mypage/myQuestion.do'">문의 내역</td>
			<td class="pointer" onclick="location.href='${pageContext.request.contextPath}/mypage/myInformation.do'">회원정보수정</td>
			<td class="pointer" onclick="location.href='${pageContext.request.contextPath}/member/logout.do'">로그아웃</td>
		</tr>
		<tr class="mypageContentWrap">
			<td class="pointer" onclick="location.href='${pageContext.request.contextPath}/mypage/myProject.do'">창작프로젝트 내역</td>
			<td></td>
			<td class="pointer" onclick="location.href='${pageContext.request.contextPath}/mypage/myDelivery.do'">배송지 관리</td>
			<td></td>
		</tr>
		<tr class="mypageContentWrap">
			<td></td>
			<td></td>
			<td class="pointer" onclick="location.href='${pageContext.request.contextPath}/mypage/deleteform.do'">회원 탈퇴</td>
			<td></td>
		</tr>
	</tbody>
</table>	
</div>

<%-- <div class="container">
	<div class="item" onclick="location.href='${pageContext.request.contextPath}/mypage/mySupport.do'">
	<b>후원 프로젝트</b>
	<p>
	후원한 프로젝트의 목록과 진행 상황에 대해 알아볼 수 있습니다.
	</div>
	<div class="item" onclick="location.href='${pageContext.request.contextPath}/mypage/myProject.do'">
	<b>나의 프로젝트</b>
	<p>
	내가 올린 프로젝트의 목록과 진행 상황에 대해 알아볼 수 있습니다.
	</div>
	<div class="item" onclick="location.href='${pageContext.request.contextPath}/mypage/myQuestion.do'">
	<b>문의</b>
	<p>
	프로젝트에 대해 문의하고 답변을 확인할 수 있습니다.
	</div>
	<div class="item" onclick="location.href='${pageContext.request.contextPath}/mypage/mySettings.do'">
	<b>설정</b>
	<p>
	회원정보 변경과 배송지 관리, 결제수단을 관리할 수 있습니다.
	</div>
</div> --%>
