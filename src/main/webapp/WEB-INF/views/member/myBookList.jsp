<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
			<th>대여 상태</th>
			<th>연체일</th>
			<th>연체료</th>
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
	        <td>${book.mbstatus}</td>
	        <td>
	        	<c:choose>
	        		<c:when test="${book.mblatedate > 0}">
		        		${book.mblatedate}일
		        	</c:when>
		        	<c:otherwise>
		        		-
		        	</c:otherwise>
	        	</c:choose>
	        </td>
	        <td>
	        	<c:choose>
	        		<c:when test="${book.mblatedate > 0}">
		        		${book.mblatefee}원
		        	</c:when>
		        	<c:otherwise>
		        		-
		        	</c:otherwise>
	        	</c:choose>
	        </td>
	        <c:choose>
	        	<c:when test="${book.mblatedate > 0}">
	        		<td>
	        			<select disabled>
	        				<option>연장 불가</option>
	        			</select>
	        		</td>
	        		<td>
	        			<input type="button" value="연장 불가" disabled>
	        		</td>
	        		<td>
		        		<form name="overdueForm" method="post" action="/pay/lateFeePayForm" onsubmit="return confirm('연체: ${book.bname} 도서를 반납하시겠습니까?');">
				        	<input type="hidden" value="${book.bno}" name="bno">
				        	<input type="hidden" value="${book.mbno}" name="mbno">
				        	<input type="hidden" value="${book.mblatefee}" name="mblatefee">
							<input type="hidden" value="" name="pno">
							<input type="hidden" value="book" name="ctype">
				        	<input type="submit" value="반납하기">
				        </form>
			        </td>
	        	</c:when>
	        	<c:otherwise>
	        		<td colspan="2">
		        		<sec:authorize access="hasRole('NORMAL')">
		        			<form name="extensionForm" method="post" action="/pay/extensionPayForm">
					        	<input type="hidden" value="${book.bno}" name="bno">
					        	<input type="hidden" value="${book.mbno}" name="mbno">
								<input type="hidden" value="" name="pno">
								<input type="hidden" value="book" name="ctype">
					        		<select name="cstock" required>
					        			<option value="">선택</option>
					                    <option value="1">15일</option>
					                    <option value="2">30일</option>
					                    <option value="4">60일</option>
					        		</select>
					        	<input type="submit" value="연장하기">
					        </form>
		        		</sec:authorize>
		        		
		        		<sec:authorize access="hasRole('SUBSCRIBER')">
		        			<form name="extensionForm" method="post" action="/pay/extendBookFree" onsubmit="return confirm('구독자 혜택으로 무료 연장하시겠습니까?');">
					        	<input type="hidden" value="${book.mbno}" name="mbno">
					        		<select name="cstock" required>
					        			<option value="">선택</option>
					                    <option value="1">15일 (무료)</option>
					                    <option value="2">30일 (무료)</option>
					        		</select>
					        	<input type="submit" value="무료 연장">
					        </form>
		        		</sec:authorize>
			        </td>
			        <td>
				        <form name="returnForm" method="post" action="/member/returnBook" onsubmit="return confirm('${book.bname} 도서를 반납하시겠습니까?');">
				        	<input type="hidden" value="${book.bno}" name="bno">
				        	<input type="hidden" value="${book.mbno}" name="mbno">
				        	<input type="submit" value="반납하기">
				        </form>
			        </td>
	        	</c:otherwise>
	        </c:choose>
	    </tr>
		</c:forEach>
	</table>
	
	<c:if test="${not empty msg}">
	    <script>
	        alert("${msg}");
	    </script>
	</c:if>
</body>
</html>