<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body onload="document.login.memail.focus()">
	<h3>로그인</h3>
	<form name="login" method="post" action="/j_spring_security_check">
		이메일 : <input type="text" name="memail" > <br>
		비밀번호 : <input type="password" name="mpasswd"> <br>
		<input type="submit" value="로그인">
		<input type="button" value="취소" onclick="history.back()">
	</form>
</body>
</html>