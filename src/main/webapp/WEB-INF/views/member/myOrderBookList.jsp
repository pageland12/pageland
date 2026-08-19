<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 구매/대여 도서 목록</title>
</head>
<body>
	<h2>내가 주문한 도서 목록</h2>
	<table border="1">
		<tr>
			<th>주문상세번호</th>
			<th>도서 이미지</th>
			<th>도서명</th>
			<th>후기 작성</th>
		</tr>
		<c:forEach var="orderList" items="${orderLists}">
		    <tr>
		        <td>${orderList.odno}</td>
		        <td>
		            <c:if test="${not empty orderList.bimg}">
		                <img src="${orderList.bimg}" width="100" height="100">
		            </c:if>
		        </td>
		        <td width="600">${orderList.bname}</td>
		        <td>
		        	<c:if test="${orderList.cnt > 0}">
		                작성 완료
		            </c:if>
		            <c:if test="${orderList.cnt == 0}">
			            <button type="button" onclick="goRatingWrite('${orderList.odno}', '${orderList.bno}', '${orderList.bname}', '${orderList.bimg}')">
			                후기 작성
			            </button>
			        </c:if>
		        </td>
		    </tr>
		</c:forEach>
		<tr>
			<td colspan="4">
				<a href="/main">메인페이지</a> |
				<a href="/member/orderList">주문 목록</a>
			</td>
		</tr>
	</table>
	
	<!-- 페이지 번호 이동 영역 (최대 5개씩 표시) -->
	<div style="text-align: center; margin-top: 20px;">
    
    <%-- 이전 버튼 (첫 페이지 블록이 아닐 때만 표시) --%>
    <c:if test="${startPage > 1}">
        <a href="/member/myOrderBookList?pageNum=${startPage - 1}" style="margin-right: 5px; text-decoration: none; color: black;">[이전]</a>
    </c:if>

    <%-- 5개 단위 페이지 번호 출력 --%>
    <c:forEach begin="${startPage}" end="${endPage}" var="num">
        <c:choose>
            <c:when test="${pageNum == num}">
                <span style="font-weight: bold; color: red; margin: 0 5px; font-size: 16px;">${num}</span>
            </c:when>
            <c:otherwise>
                <a href="/member/myOrderBookList?pageNum=${num}" style="margin: 0 5px; text-decoration: none; color: black;">${num}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <%-- 다음 버튼 (마지막 페이지 블록이 아닐 때만 표시) --%>
    <c:if test="${endPage < totalPages}">
        <a href="/member/myOrderBookList?pageNum=${endPage + 1}" style="margin-left: 5px; text-decoration: none; color: black;">[다음]</a>
    </c:if>

	</div>
	
	<script>
	function goRatingWrite(odno, bno, bname, bimg) {
	    // 특수문자가 들어간 문자열을 안전하게 URL 인코딩
	    const encodedBname = encodeURIComponent(bname);
	    const encodedBimg = encodeURIComponent(bimg);
	    
	    location.href = "/board/ratingWriteForm?odno=" + odno 
	                  + "&bno=" + bno 
	                  + "&bname=" + encodedBname 
	                  + "&bimg=" + encodedBimg 
	}
	</script>
</body>
</html>