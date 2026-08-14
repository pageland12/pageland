<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트</title>
</head>
<body>
	<h3>이벤트</h3>
	<table border=1>
		<tr>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	<c:forEach var="event" items="${event}">	
		<tr>
			<td><a href="/guest/abView?abno=${event.abno}">${event.abtitle}</a></td>
			<td>${event.mname}</td>
			<td><fmt:formatDate value="${event.abdate}" pattern="yyyy-MM-dd" /></td>
			<td>${event.abhit}</td>
		</tr>
	</c:forEach>
	<sec:authorize access="hasRole('ADMIN')">
		<tr>
			<td colspan="4">	
				<a href="/admin/abWriteForm">이벤트 작성</a>					
			</td>
		</tr>
	</sec:authorize>
	</table>
</body>
</html>