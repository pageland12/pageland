<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 구독권</title>
</head>
<body>
	<table>
		<c:forEach var="pass" items="${passes}" varStatus="status">
		    <tr onclick="location.href='/guest/passDetail?pno=${pass.pno}'">
		    	<td><img src="${pass.pimg}" width="100" height="100"></td>
		    	<td>${pass.pname}</td>
		    	<td>${pass.pprice}원</td>
		    </tr>
		</c:forEach>
	</table>
</body>
</html>