<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 하단 시작 -->
<div>
	<hr noshade="noshade" class="footer_line">
	<table style="width: 100%;">
		<tr>
			<th class="footer_title">이용안내</th>
			<th class="footer_title footer_margin">정책</th>
			<th class="footer_title">고객문의</th>
		</tr>
		<tr class="footer_content">
			<td><a href="${pageContext.request.contextPath}/guide/creatorGuide.do" class="delete_line">창작자 가이드</a></td>
			<td class="footer_margin" colspan="1"><a href="${pageContext.request.contextPath}/guide/termsOfUse.do" class="delete_line">이용약관</a></td>
			<td>평일 09:00 ~ 17:00(12:00~13:00 제외)</td>
		</tr>
		<tr class="footer_content">
			<td><a href="${pageContext.request.contextPath}/guide/supporterGuide.do" class="delete_line">후원자 가이드</a></td>
			<td class="footer_margin"><a href="${pageContext.request.contextPath}/guide/privacyPolicy.do" class="delete_line">개인정보 처리방침</a></td>
			
		</tr>
		<tr class="footer_content">
			<td colspan="3"><a href="${pageContext.request.contextPath}/guide/projectStandard.do" class="delete_line">프로젝트 심사 기준</a></td>
		</tr>
	</table>
<p>
	<div class="footer_content_address">
	회사명 펀딩어드벤처(주) 주소 서울특별시 강남구 테헤란로 123-12, 100층 대표 김길동 사업자 등록번호 123-12-12345<br>
	통신판매업 신고번호 2199-1234567-12-3-12345 대표번호 02-1234-1234<br>
	&copy; 2021 fundingAdventure Inc.
	</div>
	<div>
		<button id="footer_que_btn" onclick="location.href='${pageContext.request.contextPath}/question/list.do'">펀딩어드벤처에 문의하기</button>
	</div>
	<div style="clear: both;"></div>
</div>
<!-- 하단 끝 -->