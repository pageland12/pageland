<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록 구독권 관리</title>
</head>
<body>
	<table border=1 width=400>
		<tr>
			<td>구독권 이미지</td>
			<td>구독권 이름</td>
			<td>가격</td>				
		</tr>
		<c:forEach var="pass" items="${pass}">
			<tr>
				<td>
					<a href="/admin/passDetail?pno=${pass.pno}">
						<img src="${pass.pimg}" width="100" alt="구독권 이미지">
					</a>
				</td>
				<td>${pass.pname}</td>
				<td>${pass.pprice}</td>
			</tr>			
		</c:forEach>
	</table>
	<a href="/admin/adminMain">관리자페이지로 이동</a>
</body>
</html>