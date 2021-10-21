<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${check==true}">
	<script type="text/javascript">
		alert('회원정보 수정이 완료되었습니다.');
		location.href='memberList.do';
	</script>
</c:if>
<c:if test="${check==false}">
	<script type="text/javascript">
		alert('관리자 권한이 없습니다.');
		history.go(-1);
	</script>
</c:if>