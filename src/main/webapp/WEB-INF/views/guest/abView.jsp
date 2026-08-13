<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 게시판 상세보기</title>
</head>
<body>
	<h3>관리자 게시판 상세보기</h3>
	<table border=1>
		<tr>
			<th>제목</th>
			<td>${view.abtitle}</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${view.mname}</td>
		</tr>
		<tr>
			<th>카테고리</th>
			<td>${view.abcategory}</td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td>
				<c:if test="${not empty view.abfiles}">
					<img src="/images/${view.abfiles}">
				</c:if>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${view.abcontent}</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td><fmt:formatDate value="${view.abdate}" pattern="yyyy-MM-dd" /></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${view.abhit}</td>
		</tr>
		<tr>
			<td colspan="2">
				<c:if test="${view.abcategory == 'NOTICE'}">
        			<a href="/guest/noticeList">목록</a>
    			</c:if>
    			<c:if test="${view.abcategory == 'EVENT'}">
        			<a href="/guest/eventList">목록</a>
    			</c:if> / 
				<sec:authorize access="hasRole('ADMIN')">
					<a href="/admin/abUpdateForm?abno=${view.abno}">수정</a> / 
					<a href="/admin/abDelete?abno=${view.abno}">삭제</a>
				</sec:authorize>
				 
				
			</td>
		</tr>
	</table>
</body>
</html>