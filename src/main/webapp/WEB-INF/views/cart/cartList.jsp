<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 목록</title>
</head>
<body>
	<h2>장바구니 목록</h2>
	
	<table border = "1">
		<tr>
			<td>결제 선택</td>
			<td>상품 이미지</td>
			<td>상품명</td>
			<td>정가</td>
			<td>기간/횟수</td>
			<td>결제가</td>
			<td>장바구니 삭제</td>
		</tr>
		<form name="cartList" method="post" action="/pay/cartPayForm">
			<c:forEach var="cart" items="${carts}" varStatus="status">
			    <tr>
			    	<td><input type="checkbox" name="cnoList" value="${cart.cno}" checked></td>
			    	<c:if test="${cart.ctype eq 'book'}">
				    	<td><img src="${cart.bimg}" width="100" height="100"></td>
			    		<td>${cart.bname}</td>
			    		<td>정가: ${cart.bprice}원</td>
			    		<td>${cart.cstock * 15}일</td>
			    		<td>결제가: ${cart.bprice * cart.cstock}원</td>
				    </c:if>
				    <c:if test="${cart.ctype eq 'pass'}">
				    	<td><img src="${cart.pimg}" width="100" height="100"></td>
			    		<td>${cart.pname}</td>
			    		<td>정가: ${cart.pprice}원</td>
		    			<c:if test="${cart.ptype eq '정기권'}">
		    				<td>${cart.cstock * 6}개월</td>
		    			</c:if>
		    			<c:if test="${cart.ptype eq 'N회권'}">
		    				<td>${cart.cstock * 10}개</td>
		    			</c:if>
			    		<td>결제가: ${cart.pprice * cart.cstock}원</td>
				    </c:if>
				    <td><a href="/cart/cartDelete?cno=${cart.cno}">삭제하기</a></td>
			    </tr>
			</c:forEach>
			<tr>
				<td colspan=7>
					<a href="/main">메인페이지</a>
					<input type="submit" value="결제하기">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>