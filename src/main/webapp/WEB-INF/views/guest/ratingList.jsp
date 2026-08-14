<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 목록</title>
</head>
<body>
	<h3>후기 목록</h3>
	<table border=1>
		<tr>
			<th>첨부파일</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	<c:forEach var="list" items="${list}">	
		<tr>
			<td>
				<a href="/guest/ratingView?rno=${list.rno}">
					<c:if test="${not empty list.rfiles}">
						<img src="/images/${list.rfiles}" width="100" height="100">
					</c:if>
					<c:if test="${empty list.rfiles}">
						[NO IMAGE]
					</c:if>
				</a>
			</td>
			<td><a href="/guest/ratingView?rno=${list.rno}">${list.rtitle}</a></td>
			<td>${list.mname}</td>
			<td><fmt:formatDate value="${list.rdate}" pattern="yyyy-MM-dd" /></td>
			<td>${list.rhit}</td>
		</tr>
	</c:forEach>
	</table>
</body>
</html>