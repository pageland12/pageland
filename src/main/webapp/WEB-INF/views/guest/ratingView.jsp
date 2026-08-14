<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 상세보기</title>
</head>
<body>
	<h3>후기 상세보기</h3>
	<table border=1>
		<tr>
			<th>구매도서정보</th>
			<td><c:if test="${not empty list.bimg}">
					<img src="/images/${list.bimg}">
				</c:if>
				${view.bname}<br>
				${view.bprice}
			</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${view.rtitle}</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${view.mname}</td>
		</tr>
		<tr>
			<th>별점</th>
			<td>
				<c:if test="${view.rrate == 5.0}">
	            	★★★★★
		        </c:if>
		        <c:if test="${view.rrate == 4.0}">
		            ★★★★☆
		        </c:if>
		        <c:if test="${view.rrate == 3.0}">
		            ★★★☆☆
		        </c:if>
		        <c:if test="${view.rrate == 2.0}">
		            ★★☆☆☆
		        </c:if>
		        <c:if test="${view.rrate == 1.0}">
		            ★☆☆☆☆
		        </c:if>
		        ${view.rrate}점
			</td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td>
				<c:if test="${not empty view.rfiles}">
					<img src="/images/${view.rfiles}">
				</c:if>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${view.rcontent}</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td><fmt:formatDate value="${view.rdate}" pattern="yyyy-MM-dd" /></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${view.rhit}</td>
		</tr>
		<tr>
			<td colspan="2">
				<a href="/guest/ratingList">목록</a>
    			<sec:authorize access="hasRole('ADMIN')">
					<a href="/board/ratingDelete?rno=${view.rno}">삭제</a>
				</sec:authorize>
			</td>
		</tr>
	</table>
</body>
</html>