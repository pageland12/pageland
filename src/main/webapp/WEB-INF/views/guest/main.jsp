<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pageland</title>
<link rel="stylesheet" href="/css/guestBookList.css">
</head>
<body>
	<%@ include file="header.jsp" %>
	
	<main class="main-content">
	    <!-- 상단 헤더 영역 -->
	    <div class="header-section">
	        <div class="title-area">
	            <h2 class="page-title">베스트 도서</h2>
	        </div>
	    </div>

		<div class="book-grid">
			<c:forEach var="best" items="${best}">
				<div class="book-card">
					<!-- 1. 이미지 (클릭 가능 + 마우스 호버 시 뿌옇게) -->
					<div class="book-img-wrapper" onclick="location.href='/guest/bookDetail?bno=${best.bno}'">
						<img src="${best.bimg}" alt="${best.bname}">
					</div>
					
					<!-- 2. 제목 & 가격 그룹 -->
					<div class="book-info">
						<!-- 제목만 클릭 가능 -->
						<div class="book-title" onclick="location.href='/guest/bookDetail?bno=${best.bno}'">${best.bname}</div>
						<!-- 가격 (클릭 불가) -->
						<div class="book-price">${best.bprice}원</div>
					</div>
				</div>
			</c:forEach>
		</div>
		
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