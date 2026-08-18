<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 상세</title>
</head>
<body>
	<form name="bookCartForm" method="post" action="/member/cartInsert">
		<input type="hidden" value="${book.bno}" name="bno">
		<input type="hidden" value="" name="pno">
		<input type="hidden" value="book" name="ctype">
		<table>
			<tr>
				<td>제목</td>
				<td>${book.bname}</td>
			</tr>
			<tr>
				<td>연령</td>
				<td>${book.bage}</td>
			</tr>
			<tr>
				<td>출판사</td>
				<td>${book.bpublisher}</td>
			</tr>
			<tr>
				<td>분야</td>
				<td>${book.bgenre}</td>
			</tr>
			<tr>
				<td>이미지</td>
				<td><img alt="${book.bname}" src="${book.bimg}" width="200" height="200"></td>
			</tr>
			<tr>
				<td>상세 정보</td>
				<td><img alt="도서정보" src="${book.binfo}" width="200" height="400"></td>
			</tr>
			<tr>
				<td>가격</td>
				<td>${book.bprice}원</td>
			</tr>
			<tr>
				<td>재고수량</td>
				<td>${book.bstock}</td>
			</tr>
			<tr>
				<td>추천수</td>
				<td>${book.blike}</td>
			</tr>
		</table>
		<a href="/admin/bookUpdateForm?bno=${book.bno}">수정하기</a>
		<a href="/admin/bookDelete?bno=${book.bno}">삭제하기</a>
	</form>
	
</body>
</html>