<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 상세보기</title>
</head>
<body>
	<h3>QnA 상세보기</h3>
	<table>
		<tr>
			<th>제목</th>
			<td>${view.qtitle}</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${view.mname}</td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td>
				<c:if test="${not empty view.qfiles}">
					<img src="/images/${view.qfiles}">
				</c:if>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${view.qcontent}</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td><fmt:formatDate value="${view.qdate}" pattern="yyyy-MM-dd" /></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${view.qhit}</td>
		</tr>
		<tr>
			<td colspan="2">
				<a href="/guest/qnaList">목록</a> / 
				<a href="/board/qnaPasswordCheckForm?qno=${view.qno}&mode=update">수정</a> / 
				<a href="/board/qnaPasswordCheckForm?qno=${view.qno}&mode=delete">삭제</a>
			</td>
		</tr>
	</table>
</body>
</html>