<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 목록</title>
</head>
<body>
	<h2>주문 목록</h2>
	
	<table border = "1">
		<tr>
			<td>주문 번호</td>
			<td>주문금액</td>
			<td>배송비</td>
			<td>할인액</td>
			<td>결제액</td>
			<td>결제수단</td>
			<td>결제일</td>
		</tr>
		<c:forEach var="order" items="${orders}" varStatus="status">
		    <tr>
		    	<td>${order.olno}</td>
		    	<td>${order.olprice}</td>
		    	<td>${order.olfee}</td>
		    	<td>${order.olsale}</td>
		    	<td>${order.oltotal}</td>
		    	<td>${order.olpayment}</td>
		    	<td>${order.oldate}</td>
		    </tr>
		</c:forEach>
		<tr>
			<td colspan=7>
				<a href="/main">메인페이지</a> | 
				<a href="/member/myBookList">대여 중인 도서 목록</a> | 
				<a href="/member/myOrderBookList">대여한 도서 목록</a> | 
				<a href="/member/myPassList">구독권 조회</a>
			</td>
		</tr>
	</table>
</body>
</html>