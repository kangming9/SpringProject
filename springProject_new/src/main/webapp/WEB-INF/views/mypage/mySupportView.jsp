<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css" type="text/css">
<div>
	<div class="miniTitle_left">
	<b class="miniTitle_content">후원프로젝트</b>
	</div>
	<hr noshade="noshade" class="line">
</div>
<c:if test="${count == 0}">
	<div class="result-display">
		등록된 프로젝트가 없습니다.
	</div>
</c:if>
<div class="myPro_Container">
	<c:if test="${count > 0}">
		<c:forEach var="project" items="${list}">
			<div class="myPro__item">
				<c:if test="${project.photo == 'default_team.jpg'}">
				<a href="${pageContext.request.contextPath}/mypage/mysupportdetail.do?p_num=${project.p_num}&g_num=${project.g_num}&num=${project.num}">
					<img class="photo" src="${pageContext.request.contextPath}/resources/images/default_team.jpg" >
				</a>
				</c:if>
				<c:if test="${project.photo != 'default_team.jpg'}">
				<a href="${pageContext.request.contextPath}/mypage/mysupportdetail.do?p_num=${project.p_num}&g_num=${project.g_num}&num=${project.num}">
					<img class="photo" src="${pageContext.request.contextPath}/upload/${project.photo}">
				</a>
				</c:if>
				<div class="myPro__item_content" onclick="location.href='${pageContext.request.contextPath}/mypage/mysupportdetail.do?p_num=${project.p_num}&g_num=${project.g_num}&num=${project.num}'">
					<ul>
						<li>
						<b>${project.name}</b>
							<span>
								<c:if test="${project.category==0}"> | 온라인</c:if>
								<c:if test="${project.category==1}"> | 모바일</c:if>
								<c:if test="${project.category==2}"> | 보드</c:if>
								<c:if test="${project.category==3}"> | 카드</c:if>
							</span>
						</li>
						<li id="pro-summary">${project.summary}</li>
						<div id="pro-detail-content">
							<li>후원 번호 : ${project.num}</li>
							<li>후원 금액 : ${project.support_amount}</li>
							<li class="supTitle_left">결제예정일 : ${project.finish_date}</li>
							<li class="supTitle_right">
								<c:if test="${project.approval==-1}"><span id="mainDel">임시저장</span></c:if>
								<c:if test="${project.approval==0}"><span id="mainDel">심사대기</span></c:if>
								<c:if test="${project.approval==1}"><span id="mainDel">승인</span></c:if>
								<c:if test="${project.approval==2}"><span id="mainDel">반려</span></c:if>
							</li>
						</div>
					</ul>
				</div>
			</div>
		</c:forEach>
	</c:if>
</div>
<div class="align-center">${pagingHtml}</div>
