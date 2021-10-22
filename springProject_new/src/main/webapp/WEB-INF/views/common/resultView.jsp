<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${check == 'id' || check == 'question' || check=='notUser'}">
	<script>
		alert('${message}');
		location.href='${url}';
	</script>
</c:if>
