<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 회원 관리</title>
</head>
<body>
	<table border="1" width="500">
		<tr>
			<td>회원번호</td>
			<td>이메일</td>
			<td>이름</td>
			<td>연락처</td>
		</tr>
		<c:forEach var="list" items="${list}">
			<tr>
				<td>${list.mno}</td>
				<td><a href="/admin/memberView?mno=${list.mno}">${list.memail}</a></td>
				<td>${list.mname}</td>
				<td>${list.mtel}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>