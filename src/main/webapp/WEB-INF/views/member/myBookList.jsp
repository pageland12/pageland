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
	<h2>내가 주문한 도서 목록</h2>
	<table border="1">
		<tr>
			<th>주문 번호</th>
			<th>도서 이미지</th>
			<th>도서명</th>
			<th>대여 시작일</th>
			<th>도서 반납일</th>
			<th colspan="2">대여 연장 신청</th>
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
        <form name="extensionForm" method="post" action="/pay/extensionPayForm">
        	<input type="hidden" value="${book.bno}" name="bno">
			<input type="hidden" value="" name="pno">
			<input type="hidden" value="book" name="ctype">
        	<td>
        		<select name="cstock">
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
    </tr>
	</c:forEach>
</body>
</html>