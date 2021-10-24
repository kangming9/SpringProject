<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css" type="text/css">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<div >
<div>
	<div id="mypagePhotoWrap" class="systemPhoto-margin">
		<div class="justify-content">
			<c:if test="${empty member.photo}">
				<img src="${pageContext.request.contextPath}/resources/images/logo.PNG" width="150" height="150" class="system-photo">
			</c:if>
		</div>
		<div class="justify-content">
			<p style="font-size: 45px; margin: 0;"><b>SYSTEM</b></p>
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
			<td>전체회원</td>
			<td>활동회원</td>
			<td>창작자</td>
			<td>후원자</td>
		</tr>
		<tr><td colspan="4"><hr size="0.5"></td></tr>
	</thead>
	<tbody>
		<tr class="mypageContentWrap">
			<td ><span>총${allMem}</span>명</td>
			<td ><span>${realMem}</span>명</td>
			<td ><span>${pMem}</span>명</td>
			<td ><span>${sMem}</span>명</td>
		</tr>
		<tr><td colspan="4"><hr size="0.5"></td></tr>
	</tbody>
</table>	
</div>
<p>
<p>
<div class="del_container system-div-margin" id="del_list" onclick="location.href='${pageContext.request.contextPath}/member/memberList.do'">
		<div class="del_item">	
			<div id="del_hide_content">
				<ul class="del_item_css delChoice_btn">
					<li>
					<%-- <input type="button" value="회원관리" class="btnCss update_dle_btn" onclick="location.href='${pageContext.request.contextPath}/member/memberList.do'"> --%>
					</li>
				</ul>
				<ul class="del_item_css delContent">
					<li class="system-margin1"><i class="fas fa-user-cog fa-5x"></i></li>
					<li class="system-margin2">회원관리</li>
				</ul>
			</div>
		</div><!-- 아이템 -->
</div><!-- 컨테이너 -->
<div class="del_container system-div-margin" id="del_list" onclick="location.href='${pageContext.request.contextPath}/mypage/confirmProjectList.do'">
		<div class="del_item">	
			<div id="del_hide_content">
				<ul class="del_item_css delChoice_btn">
					<li>
					<%-- <input type="button" value="프로젝트관리" class="btnCss update_dle_btn" onclick="location.href='${pageContext.request.contextPath}/mypage/confirmProjectList.do'"> --%>
					</li>
				</ul>
				<ul class="del_item_css delContent">
					<li class="system-margin3"><i class="fas fa-ghost fa-5x"></i></li>
					<li class="system-margin4">프로젝트관리</li>
				</ul>
			</div>
		</div><!-- 아이템 -->
</div><!-- 컨테이너 -->
</div>
<%-- <div class="container">
	<div class="item" onclick="location.href='${pageContext.request.contextPath}/member/memberList.do'">
	<b>회원관리</b>
	<p>
	회원 정보조회 | 회원 정보수정
	</div>
	<div class="item" onclick="location.href='${pageContext.request.contextPath}/mypage/confirmProjectList.do'">
	<b>프로젝트 관리</b>
	<p>
	프로젝트 조회 | 프로젝트 통과 여부 결정
	</div>
</div> --%>