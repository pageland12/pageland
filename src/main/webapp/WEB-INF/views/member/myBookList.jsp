<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대여중인 도서 목록</title>
</head>
<body>
	<h2>대여중인 도서 목록</h2>
	<table border="1">
		<tr>
			<th>주문 번호</th>
			<th>도서 이미지</th>
			<th>도서명</th>
			<th>대여 시작일</th>
			<th>도서 반납일</th>
			<th>남은 대여일</th>
			<th colspan="2">대여 연장 신청</th>
			<th>반납 신청</th>
		</tr>
	<c:forEach var="book" items="${books}">
    <tr>
        <td>${book.olno}</td>
        <td>
            <c:if test="${not empty book.bimg}">
                <img src="${book.bimg}" width="50">
            </c:if>
        </td>
        <td>${book.bname}</td>
        <td>${book.mbstart}</td>
        <td>${book.mbend}</td>
        <td>
        	남은 기간: 
			<c:choose>
				<c:when test="${book.daysLeft > 0}">D-${book.daysLeft} (${book.daysLeft}일 남음)</c:when>
				<c:when test="${book.daysLeft == 0}">D-Day (오늘 만료)</c:when>
				<c:otherwise>기간 만료</c:otherwise>
			</c:choose>
        </td>
        <form name="extensionForm" method="post" action="/pay/extensionPayForm">
        	<input type="hidden" value="${book.bno}" name="bno">
        	<input type="hidden" value="${book.mbno}" name="mbno">
			<input type="hidden" value="" name="pno">
			<input type="hidden" value="book" name="ctype">
        	<td>
        		<select name="cstock" required>
        			<option value="">선택</option>
                    <option value="1">15일</option>
                    <option value="2">30일</option>
                    <option value="4">60일</option>
        		</select>
        	</td>
        	<td>
        		<input type="submit" value="연장하기">
        	</td>
        </form>
        <form name="returnForm" method="post" action="/member/returnBook" onsubmit="return confirm('${book.bname} 도서를 반납하시겠습니까?');">
        	<input type="hidden" value="${book.bno}" name="bno">
        	<td>
        		<input type="submit" value="반납하기">
        	</td>
        </form>
    </tr>
	</c:forEach>
</body>
</html>