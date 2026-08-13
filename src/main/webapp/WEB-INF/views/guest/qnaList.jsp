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
			<th>제목</th>
			<th>작성자</th>
			<th>등록일</th>
			<th>조회수</th>
		</tr>
	<c:forEach var="list" items="${qnaList}">
		<tr>
			<td>
				<c:if test="${list.qsecret == '비밀글'}">
					<a href="/board/qnaPasswordCheckForm?qno=${list.qno}&mode=view">🔒비밀글</a>
				</c:if>
				<c:if test="${list.qsecret == '공개글'}">
					<a href="/guest/qnaView?qno=${list.qno}">${list.qtitle}</a>
				</c:if>
			</td>
			<td>${list.mname}</td>
			<td><fmt:formatDate value="${list.qdate}" pattern="yyyy-MM-dd" /></td>
			<td>${list.qhit}</td>
		</tr>
	</c:forEach>
		<tr>
			<td colspan="4">
				<a href="/board/qnaWriteForm">QnA 작성</a>
			</td>
		</tr>
	</table>
</body>
</html>