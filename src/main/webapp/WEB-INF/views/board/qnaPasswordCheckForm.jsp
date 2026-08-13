<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>
</head>
<body>
	* 비밀번호를 입력하세요. <br>
	<form name="qnaPasswordCheckForm" method="post" action="/board/qnaPasswordCheck">
		<input type="hidden" name="mode" value="${mode}">
		<input type="hidden" name="qno" value="${qno}">
		비밀번호 : <input type="password" name="qpasswd">
		<input type="submit" value="전송">
	</form>
	<c:if test="${not empty msg}">
		<p style="color:red; font-weight:bold">${msg}</p>
	</c:if>
</body>
</html>