<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>도서 상세</title>
    <link rel="stylesheet" href="/css/GuestdetailCss.css">
</head>
<body>
	<%@ include file="header.jsp" %>
	
	<div class="detail-container">
		<form name="bookCartForm" method="post" action="/member/cartInsert">
			<input type="hidden" value="${book.bno}" name="bno">
			<input type="hidden" value="" name="pno">
			<input type="hidden" value="book" name="ctype">
			
			<div class="product-top-section">
				<div class="product-image-area">
					<img alt="${book.bname}" src="${book.bimg}">
				</div>
				
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
						<span class="info-label">재고수량</span>
						<span class="info-value">
							<c:choose>
								<c:when test="${book.bstock <= 0}">
									<span class="soldout-text">품절</span>
								</c:when>
								<c:otherwise>
									${book.bstock}개
								</c:otherwise>
							</c:choose>
						</span>
					</div>
					
					<div class="info-row">
						<span class="info-label">기간</span>
						<span class="info-value">
							<select name="cstock" <c:if test="${book.bstock <= 0}">disabled</c:if> required>
								<option value="">선택</option>
								<option value="1">15일</option>
								<option value="2">30일</option>
								<option value="4">60일</option>
							</select>
						</span>
					</div>
					
					<!-- 버튼 영역 (8:2 비율) -->
					<div class="button-group">
						<c:choose>
							<c:when test="${book.bstock <= 0}">
								<div class="btn-soldout">품절된 상품입니다</div>
								<button type="button" class="btn-list" onclick="location.href='/guest/allBookList'">도서 목록</button>
							</c:when>
							<c:otherwise>
								<input type="submit" class="btn-cart" value="장바구니 담기">
								<input type="submit" class="btn-buy" formaction="/pay/payForm" value="바로 구매">
								<button type="button" class="btn-list" onclick="location.href='/guest/allBookList'">도서 목록</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
			
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