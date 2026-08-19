<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>도서 상세</title>
    <!-- 실제 파일명인 detailCss.css로 변경 & c:url 적용 -->
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/detailCss.css'/>">
</head>
<body>
	<%@ include file="header.jsp" %>
	
	<div class="detail-container">
		<form name="bookCartForm" method="post" action="/member/cartInsert">
			<input type="hidden" value="${book.bno}" name="bno">
			<input type="hidden" value="" name="pno">
			<input type="hidden" value="book" name="ctype">
			
			<!-- 상단 2단 레이아웃 (좌: 이미지 / 우: 정보 및 옵션) -->
			<div class="product-top-section">
				
				<!-- 좌측 대표 썸네일 -->
				<div class="product-image-area">
					<img alt="${book.bname}" src="${book.bimg}">
				</div>
				
				<!-- 우측 상품 정보 -->
				<div class="product-info-area">
					<h1 class="product-title">${book.bname}</h1>
					
					<div class="info-row">
						<span class="info-label">추천수</span>
						<span class="info-value like-count">${book.blike}</span>
					</div>
					
					<div class="info-row">
						<span class="info-label">가격</span>
						<span class="info-value price">${book.bprice}원</span>
					</div>
					
					<div class="info-row">
						<span class="info-label">기간</span>
						<span class="info-value">
							<select name="cstock" required>
								<option value="">선택</option>
								<option value="1">15일</option>
								<option value="2">30일</option>
								<option value="4">60일</option>
							</select>
						</span>
					</div>
					
					<!-- 버튼 영역 -->
					<div class="button-group">
						<input type="submit" class="btn-cart" value="장바구니 담기">
						<input type="submit" class="btn-buy" formaction="/pay/payForm" value="바로 구매">
						<button type="button" class="btn-list" onclick="location.href='/guest/allBookList'">도서 목록</button>
					</div>
				</div>
			</div>
			
			<!-- 하단 상세 설명 이미지 -->
			<div class="product-detail-section">
				<h2 class="detail-title">상세 정보</h2>
				<img class="detail-content-img" alt="도서정보" src="${book.binfo}">
			</div>
		</form>
	</div>
	
	<c:if test="${not empty msg}">
		<script>
			alert("${msg}");
			<c:if test="${msg eq '장바구니에 담겼습니다.'}">
				if (confirm("장바구니로 이동하시겠습니까?")) {
					location.href = "/cart/cartList";
				}
			</c:if>
		</script>
	</c:if>
	
	<%@ include file="footer.jsp" %>
</body>
</html>