<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 구독권 / 이용권 정보</title>
</head>
<body>

	<h2>주문 이용권 정보 (주문번호: ${param.olno})</h2>

	<c:if test="${empty passList}">
		<p>해당 주문에 대한 사용 중인 이용권 정보가 없습니다.</p>
	</c:if>

	<c:forEach var="pass" items="${passList}">
		<div>
			<c:if test="${not empty pass.pimg}">
				<img src="${pass.pimg}" alt="이용권 이미지">
			</c:if>
			
			<div>
				<h3>${pass.pname}</h3>
				
				<c:if test="${pass.ptype eq '횟수권'}">
					<p>구분: 횟수 차감형</p>
					<p>남은 횟수: ${pass.mpcount}회</p>
				</c:if>

				<c:if test="${pass.ptype eq '기간권'}">
					<p>구분: 정기 구독형</p>
					<p>
						남은 기간: 
						<c:choose>
							<c:when test="${pass.daysLeft > 0}">D-${pass.daysLeft} (${pass.daysLeft}일 남음)</c:when>
							<c:when test="${pass.daysLeft == 0}">D-Day (오늘 만료)</c:when>
							<c:otherwise>기간 만료</c:otherwise>
						</c:choose>
					</p>
					<p>
						이용 기간: 
						<fmt:formatDate value="${pass.mpstart}" pattern="yyyy.MM.dd"/> ~ 
						<fmt:formatDate value="${pass.mpend}" pattern="yyyy.MM.dd"/>
					</p>
				</c:if>
				
				<p>상태: ${pass.mpstatus}</p>
			</div>
		</div>
		<hr>
	</c:forEach>

	<button type="button" onclick="history.back()">뒤로 가기</button>

</body>
</html>