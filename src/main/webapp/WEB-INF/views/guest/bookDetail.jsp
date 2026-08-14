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
				<td>이미지</td>
				<td><img alt="${book.bname}" src="${book.bimg}" width="200" height="200"></td>
			</tr>
			<tr>
				<td>추천수</td>
				<td>${book.blike}</td>
			</tr>
			<tr>
				<td>가격</td>
				<td>${book.bprice}원</td>
			</tr>
			<tr>
				<td>상세 정보</td>
				<td><img alt="도서정보" src="${book.binfo}" width="200" height="400"></td>
			</tr>
			<tr>
				<td>기간</td>
				<td>
	                <select name="cstock">
	                    <option value="">선택</option>
	                    <option value="1">15일</option>
	                    <option value="2">30일</option>
	                    <option value="4">60일</option>
	                </select>
	            </td>
			</tr>
		</table>
		
		<div>
		    <input type="submit" value="장바구니 담기">
		    <input type="submit" formaction="/pay/payForm" value="바로 구매">
		</div>
	</form>
	
	
</body>
</html>