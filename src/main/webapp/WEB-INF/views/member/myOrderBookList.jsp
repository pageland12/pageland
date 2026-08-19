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
	<c:forEach var="orderList" items="${orderList}">
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
	</table>
</body>
</html>