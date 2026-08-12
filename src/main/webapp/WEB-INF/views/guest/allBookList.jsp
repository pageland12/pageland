<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 도서</title>
</head>
<body>
	<table>
		<c:forEach var="book" items="${books}" varStatus="status">
		    <tr onclick="location.href='/guest/bookDetail?bno=${book.bno}'">
		    	<td><img src="${book.bimg}" width="100" height="100"></td>
		    	<td>${book.bname}</td>
		    	<td>${book.bprice}원</td>
		    </tr>
		</c:forEach>
	</table>
</body>
</html>