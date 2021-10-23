<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/question.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<div class="container">
	<div class="box">
		<div class="question-register-form">
		<div class="question-form-title">
		<h2>공지 등록</h2>
		<span>후원자에게 공지할 내용을 작성해주세요!</span>
		</div>
		<form:form id="register_form" action="register.do" modelAttribute="noticeVO">
		<form:hidden path="m_num" value="${user_num}"/>
		<form:hidden path="p_num" value="${p_num}"/>
			<ul>
				<li>
					<label for="title">공지 제목</label>
					<form:input path="title" placeholder="제목을 입력해주세요."/>
					<form:errors path="title" cssClass="error-color"/>
				</li>
				<li>
					<label for="content">공지 내용</label>
					<form:textarea path="content" placeholder="공지하고 싶은 내용을 자유롭게 작성해주세요."/>
					<form:errors path="content" cssClass="error-color"/>
				</li>
			</ul>
			<div class="align-center">
				<form:button class="btns-q-register">등록</form:button>
				<input type="button" value="목록" onclick="location.href='list.do?p_num=${p_num}'" class="btns">
			</div>
		</form:form>
		</div>
	</div>
</div>