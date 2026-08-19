<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pageland</title>
<style>
    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
    }

    body {
        display: flex;
        flex-direction: column;
    }

    .main-content {
        flex: 1;
        width: 100%;
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
        box-sizing: border-box;
    }
</style>
</head>
<body>
	<%@ include file="header.jsp" %>
	
	<main class="main-content">
		<table>
			<c:forEach var="best" items="${best}">
			    <tr onclick="location.href='/guest/bookDetail?bno=${best.bno}'" style="cursor:pointer;">
			    	<td><img src="${best.bimg}" width="100" height="100"></td>
			    	<td>${best.bname}</td>
			    	<td>${best.bprice}원</td>
			    </tr>
			</c:forEach>
		</table>
		
		<c:if test="${not empty sessionScope.overdueCount and sessionScope.overdueCount > 0}">
    		<script>
		        const overdueCount = "${sessionScope.overdueCount}";
		        const overdueFee = "${sessionScope.overdueFee}";
		        alert("⚠️ 현재 연체 중인 도서가 " + overdueCount + "권 있습니다.\n(총 연체료: " + overdueFee + "원)\n마이페이지에서 확인 및 반납을 진행해 주세요.");
    		</script>
		    <c:remove var="overdueCount" scope="session" />
		    <c:remove var="overdueFee" scope="session" />
		</c:if>
		
	</main>
	<%@ include file="footer.jsp" %>
</body>
</html>