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
	</table>
	
	<!-- 페이지 번호 이동 영역 (최대 5개씩 표시) -->
	<div style="text-align: center; margin-top: 20px;">
    
    <%-- 이전 버튼 (첫 페이지 블록이 아닐 때만 표시) --%>
    <c:if test="${startPage > 1}">
        <a href="/member/orderList?pageNum=${startPage - 1}" style="margin-right: 5px; text-decoration: none; color: black;">[이전]</a>
    </c:if>

    <%-- 5개 단위 페이지 번호 출력 --%>
    <c:forEach begin="${startPage}" end="${endPage}" var="num">
        <c:choose>
            <c:when test="${pageNum == num}">
                <span style="font-weight: bold; color: red; margin: 0 5px; font-size: 16px;">${num}</span>
            </c:when>
            <c:otherwise>
                <a href="/member/orderList?pageNum=${num}" style="margin: 0 5px; text-decoration: none; color: black;">${num}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <%-- 다음 버튼 (마지막 페이지 블록이 아닐 때만 표시) --%>
    <c:if test="${endPage < totalPages}">
        <a href="/member/orderList?pageNum=${endPage + 1}" style="margin-left: 5px; text-decoration: none; color: black;">[다음]</a>
    </c:if>

	</div>
	
	<a href="/main">메인페이지</a> | 
	<a href="/member/myBookList">대여 중인 도서 목록</a> | 
	<a href="/member/myOrderBookList">대여한 도서 목록</a> | 
	<a href="/member/myPassList">구독권 조회</a>
</body>
</html>