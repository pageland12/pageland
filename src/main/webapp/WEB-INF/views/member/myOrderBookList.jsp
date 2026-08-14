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
			<th>가격</th>
			<th>작성</th>
		</tr>
	<c:forEach var="orderList" items="${orderList}">
    <tr>
        <td>${orderList.odno}</td>
        <td>
            <c:if test="${not empty orderList.bimg}">
                <img src="${orderList.bimg}" width="50">
            </c:if>
        </td>
        <td>${orderList.bname}</td>
        <td>${orderList.bprice}원</td>
        <td>
        	<c:if test="${orderList.cnt > 0}">
                작성 완료
            </c:if>
            <c:if test="${orderList.cnt == 0}">
	            <button type="button" onclick="goRatingWrite('${orderList.odno}', '${orderList.bno}', '${orderList.bname}', '${orderList.bimg}', '${orderList.bprice}')">
	                후기 작성
	            </button>
	        </c:if>
        </td>
    </tr>
	</c:forEach>

	<script>
	function goRatingWrite(odno, bno, bname, bimg, bprice) {
	    // 특수문자가 들어간 문자열을 안전하게 URL 인코딩
	    const encodedBname = encodeURIComponent(bname);
	    const encodedBimg = encodeURIComponent(bimg);
	    
	    location.href = "/board/ratingWriteForm?odno=" + odno 
	                  + "&bno=" + bno 
	                  + "&bname=" + encodedBname 
	                  + "&bimg=" + encodedBimg 
	                  + "&bprice=" + bprice;
	}
	</script>
	</table>
</body>
</html>