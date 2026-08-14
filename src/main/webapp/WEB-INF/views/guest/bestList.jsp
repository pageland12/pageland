<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Best 추천 상품</title>
</head>
<body>
	<table>
		<c:forEach var="best" items="${best}" varStatus="status">
		    <tr onclick="location.href='/guest/bookDetail?bno=${best.bno}'">
		    	<td><img src="${best.bimg}" width="100" height="100"></td>
		    	<td>${best.bname}</td>
		    	<td>${best.bprice}원</td>
		    </tr>
		</c:forEach>
	</table>
</body>
</html>