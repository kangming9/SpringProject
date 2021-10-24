<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/question.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<!-- 중앙내용 시작 -->
<div class="container">
	<div class="box">
	
	<!-- 문의글 내용 시작 -->
	<div class="question-content">
		<span>No. ${notice.num}</span>
		<h2>${notice.title}</h2>
		<div class="write-info">
			<div class="creator">
				<div class="profile">
					<c:if test="${empty creator.photo}">
						<img class="my-photo" src="${pageContext.request.contextPath}/resources/images/userimage.png" width="25" height="25">
					</c:if>
					<c:if test="${!empty creator.photo}">
						<img class="my-photo" src="${pageContext.request.contextPath}/mypage/mphotoView.do?num=${creator.num}" width="25" height="25">
					</c:if>
				</div>
				<div class="nickname">&nbsp;${creator.nickname}</div>
			</div>
			<div>
				<span class="question-content-title-line"><i class="fas fa-user-edit"></i> ${notice.not_date}</span>
				<span class="question-content-title-line"><i class="fas fa-history"></i> ${notice.mod_date}</span>
			</div>
		</div>
		<hr size="1" width="100%">
		<p class="question-content-view">${notice.content}</p>
		<hr size="1" width="100%" noshade="noshade">
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
	</div>
	<!-- 문의글 내용 끝 -->
	
</div>
</div>
<!-- 중앙내용 끝 -->