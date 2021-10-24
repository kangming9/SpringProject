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
			<%-- <span>${member.nickname}</span> --%>
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
			<td class="pointer" onclick="location.href='${pageContext.request.contextPath}/mypage/mySupport.do'">후원프로젝트</td>
			<td class="pointer" onclick="location.href='${pageContext.request.contextPath}/mypage/myQuestion.do'">문의 내역</td>
			<td class="pointer" onclick="location.href='${pageContext.request.contextPath}/mypage/myInformation.do'">회원정보수정</td>
			<td class="pointer" onclick="location.href='${pageContext.request.contextPath}/member/logout.do'">로그아웃</td>
		</tr>
		<tr class="mypageContentWrap">
			<td class="pointer" onclick="location.href='${pageContext.request.contextPath}/mypage/myProject.do'">창작프로젝트</td>
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
		<tr><td colspan="4"><hr size="0.5"></td></tr>
	</tbody>
</table>	
</div>
<div class="mypage_intro">
	<p class="mypage_intro_title"><span class="mypage_intro_nickname">${member.nickname}</span>님 안녕하세요<i class="far fa-heart"></i></p>
	<p class="mypage_intro_content">후원한 프로젝트 <span><span class="mypage_intro_count color">${count}</span></span>건, 창작한 프로젝트<span><span class="mypage_intro_count color">${count2}</span></span>건 입니다.</p> 
</div>
<!-- 후원 프로젝트 목록 -->
<div>
	<span class="top_supNum">최근 후원 프로젝트</span>
	<span class="top_supNum_more"><a href="${pageContext.request.contextPath}/mypage/mySupport.do">More +</a></span>
	<hr class="slimHr">
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
									<c:if test="${project.payment==0}"><span id="mainDel">펀딩</span></c:if>
									<c:if test="${project.payment==1}"><span id="mainDel">결제완료</span></c:if>
									
								</li>
							</div>
						</ul>
					</div>
				</div>
			</c:forEach>
		</c:if>
	</div>
</div>
<!-- 창작 프로젝트 목록 -->
<div>
	<span class="top_supNum">최근 창작 프로젝트</span>
	<span class="top_supNum_more"><a href="${pageContext.request.contextPath}/mypage/myProject.do">More +</a></span>
	<hr class="slimHr">
	<c:if test="${count2 == 0}">
	<div class="result-display">
		등록된 프로젝트가 없습니다.
	</div>
</c:if>
<div class="myPro_Container">
	<c:if test="${count2 > 0}">
		<c:forEach var="project" items="${list2}">
			<div class="myPro__item">
				<c:if test="${project.photo == 'default_team.jpg'}">
				<a href="${pageContext.request.contextPath}/mypage/myProjectDetail.do?name=${project.name}">
					<img class="photo" src="${pageContext.request.contextPath}/resources/images/default_team.jpg" >
				</a>
				</c:if>
				<c:if test="${project.photo != 'default_team.jpg'}">
				<a href="${pageContext.request.contextPath}/mypage/myProjectDetail.do?name=${project.name}">
					<img class="photo" src="${pageContext.request.contextPath}/upload/${project.photo}">
				</a>
				</c:if>
				<div class="myPro__item_content" onclick="location.href='${pageContext.request.contextPath}/mypage/myProjectDetail.do?name=${project.name}'">
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
							<li>프로젝트 번호 : ${project.num}</li>
							<li>목표 금액 : ${project.goal_amount}</li>
							<li class="supTitle_left">프로젝트 마감일 : ${project.finish_date}</li>
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
</div>
