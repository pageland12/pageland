<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
</head>
<body>	
	<h3>공지사항</h3>
	<table border=1>
		<tr>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	<c:forEach var="notice" items="${notice}">	
		<tr>
			<td><a href="/guest/abView?abno=${notice.abno}">${notice.abtitle}</a></td>
			<td>${notice.mname}</td>
			<td><fmt:formatDate value="${notice.abdate}" pattern="yyyy-MM-dd" /></td>
			<td>${notice.abhit}</td>
		</tr>
	</c:forEach>
	<sec:authorize access="hasRole('ADMIN')">
		<tr>
			<td colspan="4">	
				<a href="/admin/abWriteForm">공지사항 작성</a>					
			</td>
		</tr>
	</sec:authorize>
	</table>
</body>
</html>