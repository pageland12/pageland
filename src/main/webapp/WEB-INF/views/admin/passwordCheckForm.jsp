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
	<h3>비밀번호 확인</h3>
	<form name="passwordCheckForm" method="post" action="/admin/passwordCheck">
		<input type="hidden" name="mode" value="${mode}">
		<input type="hidden" name="mno" value="${mno}">
		비밀번호 <input type="password" name="mpasswd"> <br>
		<input type="submit" value="전송">
	</form>
	<c:if test="${not empty msg }">
		<p style="color:red; font-weight:bold">${msg}</p>
	</c:if>
</body>
</html>