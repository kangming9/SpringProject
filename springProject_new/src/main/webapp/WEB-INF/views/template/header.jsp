<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css" type="text/css"> 
<!-- 상단 시작 -->
<h2 class="align-center"><a href="${pageContext.request.contextPath}/main/main.do" class="delete_line">Funding Adventure</a></h2>

<!doctype html>
<html lang='en'>
	<head>
		<meta charset="utf-8"/>
		<title>Nowstartwebdesign.com-  Pure CSS Horizontal Drop Down Menu Bar</title>
<style>
body {
  font-family: "Lucida Sans Typewriter", "Lucida Console", Monaco, "Bitstream Vera Sans Mono", monospace;
  margin: 0px;
  padding: 50px;
  
}
.menu {				//메뉴 하단 라인
  position: relative;
  height: 44px;
  background: #ffffff;
  width: auto;
}
.menu ul {
  list-style: none;
  padding: 0;
  margin: 0;
  line-height: 1;
}
.menu > ul {			//메뉴
  position: relative;
  display: block;
  background: #ffffff;
  width: 100%;
  z-index: 500;
}
.menu:after, .menu > ul:after {
  content: ".";
  display: block;
  clear: both;
  visibility: hidden;
  line-height: 0;
  height: 0;
}
.menu.align-right > ul > li {
  float: right;
}
.menu.align-center ul {
  text-align: center;
}
.menu.align-center ul ul {
  text-align: left;
}
.menu > ul > li {
  display: inline-block;
  position: relative;
  margin: 0;
  padding: 0;
}
.menu > ul > #menu-button {
  display: none;
}
.menu ul li a {
  display: block;
  font-family: Helvetica, sans-serif;
  text-decoration: none;
}
.menu > ul > li > a {		//메뉴 글자
  font-size: 14px;
  font-weight: bold;
  padding: 15px 20px;
  color: #2b2f3a;
  text-transform: uppercase;
  -webkit-transition: color 0.25s ease-out;
  -moz-transition: color 0.25s ease-out;
  -ms-transition: color 0.25s ease-out;
  -o-transition: color 0.25s ease-out;
  transition: color 0.25s ease-out;
}
.menu > ul > li.sub > a {
  padding-right: 32px;
}
.menu > ul > li:hover > a {		//마우스 포인터
  color: #ffffff;
}
.menu li.sub::after {
  display: block;
  content: "";
  position: absolute;
  width: 0;
  height: 0;
}
.menu > ul > li.sub::after {
  right: 10px;
  top: 20px;
  border: 5px solid transparent;
  border-top-color: #7a8189;
}
.menu > ul > li:hover::after {
  border-top-color: #ffffff;
}
.menu ul ul {
  position: absolute;
  left: -9999px;
  top: 70px;
  opacity: 0;
  -webkit-transition: opacity .3s ease, top .25s ease;
  -moz-transition: opacity .3s ease, top .25s ease;
  -ms-transition: opacity .3s ease, top .25s ease;
  -o-transition: opacity .3s ease, top .25s ease;
  transition: opacity .3s ease, top .25s ease;
  z-index: 1000;
}
.menu ul ul ul {
  top: 37px;
  padding-left: 5px;
}
.menu ul ul li {
  position: relative;
}
.menu > ul > li:hover > ul {
  left: auto;
  top: 44px;
  opacity: 1;
}
.menu.align-right > ul > li:hover > ul {
  left: auto;
  right: 0;
  opacity: 1;
}
.menu ul ul li:hover > ul {
  left: 170px;
  top: 0;
  opacity: 1;
}
.menu.align-right ul ul li:hover > ul {
  left: auto;
  right: 170px;
  top: 0;
  opacity: 1;
  padding-right: 5px;
}
.menu ul ul li a {
  width: 130px;
  border-bottom: 1px solid #eeeeee;
  padding: 10px 20px;
  font-size: 12px;
  color: #9ea2a5;
  background: #ffffff;
  -webkit-transition: all .35s ease;
  -moz-transition: all .35s ease;
  -ms-transition: all .35s ease;
  -o-transition: all .35s ease;
  transition: all .35s ease;
}
.menu.align-right ul ul li a {
  text-align: right;
}
.menu ul ul li:hover > a {
  background: #f2f2f2;
  color: #8c9195;
}
.menu ul ul li:last-child > a, .menu ul ul li.last > a {
  border-bottom: 0;
}
.menu > ul > li > ul::after {
  content: '';
  border: 6px solid transparent;
  width: 0;
  height: 0;
  border-bottom-color: #ffffff;
  position: absolute;
  top: -12px;
  left: 30px;
}
.menu.align-right > ul > li > ul::after {
  left: auto;
  right: 30px;
}
.menu ul ul li.sub::after {
  border: 4px solid transparent;
  border-left-color: #9ea2a5;
  right: 10px;
  top: 12px;
  -moz-transition: all .2s ease;
  -ms-transition: all .2s ease;
  -o-transition: all .2s ease;
  transition: all .2s ease;
  -webkit-transition: -webkit-transform 0.2s ease, right 0.2s ease;
}
.menu.align-right ul ul li.sub::after {
  border-left-color: transparent;
  border-right-color: #9ea2a5;
  right: auto;
  left: 10px;
}
.menu ul ul li.sub:hover::after {
  border-left-color: #ffffff;
  right: -5px;
  -webkit-transform: rotateY(180deg);
  -ms-transform: rotateY(180deg);
  -moz-transform: rotateY(180deg);
  -o-transform: rotateY(180deg);
  transform: rotateY(180deg);
}
.menu.align-right ul ul li.sub:hover::after {
  border-right-color: #ffffff;
  border-left-color: transparent;
  left: -5px;
  -webkit-transform: rotateY(180deg);
  -ms-transform: rotateY(180deg);
  -moz-transform: rotateY(180deg);
  -o-transform: rotateY(180deg);
  transform: rotateY(180deg);
}

</style>
	</head>
	<body>

		<div class='menu'>
			<ul>
				<li>
					<a href="${pageContext.request.contextPath}" class="delete_line">소개</a>
				</li>
				<li class='active sub'>
					<a href='#'>가이드</a>
					<ul>
						<li>
							<a href='#'>창작자 가이드</a>
						</li>
						<li class='last'>
							<a href='#'>후원자 가이드</a>
						</li>
					</ul>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/project/list.do" class="delete_line">펀딩하기</a>
				</li>
				<li>
					<a href="${pageContext.request.contextPath}/create/create.do" class="delete_line">프로젝트창작</a>
				</li>
				
					<c:if test="${!empty user_num && empty user_photo && user_grade >= 2}">
						<li style="float: right">
							<a href="${pageContext.request.contextPath}/mypage/myPage.do" class="delete_line">
							<img src="${pageContext.request.contextPath}/resources/images/userimage.png" width="35" height="35" class="my-photo">
							</a>
						</li>
					</c:if>
					<c:if test="${!empty user_num && !empty user_photo && user_grade >= 2}">
						<li style="float: right">
							<a href="${pageContext.request.contextPath}/mypage/myPage.do" class="delete_line">
							<img src="${pageContext.request.contextPath}/mypage/photoView.do" width="35" height="35" class="my-photo">
							</a>
							</li>
					</c:if>
					<c:if test="${empty user_num}">
						<li style="float: right">
							<a href="${pageContext.request.contextPath}/member/register.do" class="delete_line">회원가입</a>
						</li>
						<li style="float: right">
							<a href="${pageContext.request.contextPath}/member/login.do" class="delete_line">로그인</a>
						</li>
					</c:if>
					<c:if test="${!empty user_num}">
						<li style="float: right">
						    <span><b>${user_nickname}</b></span>
							<a href="${pageContext.request.contextPath}/member/logout.do" class="delete_line">로그아웃</a>
						</li>
					</c:if>


			</ul>
		</div>
	</body>
</html>