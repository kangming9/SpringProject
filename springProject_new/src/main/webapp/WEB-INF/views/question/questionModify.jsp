<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/question.css">
<div class="container">
	<div class="box">
	<div class="question-register-form">
	<div class="question-form-title">
	<h2>문의 수정</h2>
	<span>무엇이든 물어보세요!</span>
	</div>
	<form:form id="modify_form" action="modify.do" modelAttribute="questionVO">
	<form:hidden path="num"/>
	<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<label for="title">제목</label>
				<form:input path="title"/>
				<form:errors path="title" cssClass="error-color"/>
			</li>
			<li>
				<label for="content">내용</label>
				<form:textarea path="content"/>
				<form:errors path="content" cssClass="error-color"/>
			</li>
		</ul>
		<div class="align-center">
			<form:button class="btns-q-register">수정</form:button>
			<input type="button" value="목록" onclick="location.href='list.do'" class="btns">
		</div>
	</form:form>
		</div>
	</div>
</div>