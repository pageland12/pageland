<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 상세</title>
</head>
<body>
	<form name="passCartForm" method="post" action="/member/cartInsert">
		<input type="hidden" value="${pass.pno}" name="pno">
		<input type="hidden" value="" name="bno">
		<input type="hidden" value="pass" name="ctype">
		<table>
			<tr>
				<td>제목</td>
				<td>${pass.pname}</td>
			</tr>
			<tr>
				<td>이미지</td>
				<td><img alt="${pass.pname}" src="${pass.pimg}" width="200" height="200"></td>
			</tr>
			<tr>
				<td>가격</td>
				<td>${pass.pprice}원</td>
			</tr>
			<tr>
				<td>상세 정보</td>
				<td><img alt="구독권정보" src="${pass.pinfo}" width="200" height="400"></td>
			</tr>
			<c:if test="${pass.ptype == '정기권'}">
				<tr>
					<td>기간</td>
					<td>
		                <select name="cstock">
		                    <option value="">선택</option>
		                    <option value="1">6개월</option>
		                    <option value="2">1년</option>
		                    <option value="4">2년</option>
		                </select>
		            </td>
				</tr>
			</c:if>
			<c:if test="${pass.ptype == 'N회권'}">
				<tr>
					<td>횟수</td>
					<td>
		                <select name="cstock">
		                    <option value="">선택</option>
		                    <option value="1">10회</option>
		                    <option value="2">20회</option>
		                    <option value="3">30회</option>
		                </select>
		            </td>
				</tr>
			</c:if>
		</table>
		
		<div>
		    <input type="submit" value="장바구니 담기">
		    <input type="submit" formaction="/pay/payForm" value="바로 구매">
		</div>
	</form>
	
	
</body>
</html>