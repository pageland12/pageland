<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 목록</title>
</head>
<body>
	<h3>QnA 목록</h3>
	<table border=1>
		<tr>
			<td>제목</td>
			<td>작성자</td>
			<td>등록일</td>
			<td>조회수</td>
		</tr>
	<c:forEach var="list" items="${qnaList}">
		<tr>
			<th><a href="/board/qnaView?qno=${list.qno}">${list.qtitle}</a></th>
			<th>${list.mname}</th>
			<th><fmt:formatDate value="${list.qdate}" pattern="yyyy-MM-dd" /></th>
			<th>${list.qhit}</th>
		</tr>
	</c:forEach>
	</table>
</body>
</html>