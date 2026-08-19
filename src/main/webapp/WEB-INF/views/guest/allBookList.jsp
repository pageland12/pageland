<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 도서</title>
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
        padding: 100px 20px 20px 20px; /* 상단 패딩을 100px로 늘려서 헤더와 간격 확보 */
        box-sizing: border-box;
    }

    /* 좌측 상단 경로 (Breadcrumb) */
    .breadcrumb {
        display: flex;
        align-items: center;
        gap: 6px;
        font-size: 0.9rem;
        color: #555;
        margin-bottom: 20px;
    }

    .breadcrumb .home-icon {
        display: inline-flex;
        align-items: center;
        color: #333;
    }

    .breadcrumb .home-icon svg {
        width: 16px;
        height: 16px;
        stroke: currentColor;
        stroke-width: 2;
        fill: none;
        stroke-linecap: round;
        stroke-linejoin: round;
    }

    /* 상단 중앙 타이틀 & 좋아요 배지 */
    .header-section {
        text-align: center;
        margin-bottom: 35px;
    }

    .title-area {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 8px;
        margin-bottom: 10px;
    }

    .page-title {
        font-size: 1.6rem;
        font-weight: 800;
        margin: 0;
        color: #000;
    }

    .like-badge {
        display: inline-flex;
        justify-content: center;
        align-items: center;
        gap: 5px;
        padding: 4px 11px;
        border: 1px solid #e0e0e0;
        border-radius: 15px;
        font-size: 0.85rem;
        color: #555;
        background-color: #fff;
    }

    .like-badge svg {
        width: 14px;
        height: 14px;
        stroke: currentColor;
        stroke-width: 2;
        fill: none;
        stroke-linecap: round;
        stroke-linejoin: round;
    }

    /* DB 전체 도서 개수 표시 영역 */
    .count-section {
        font-size: 0.95rem;
        color: #666;
        margin-bottom: 15px;
    }

    .count-section strong {
        color: #000;
        font-weight: 800;
    }

    /* ---------------------------------------------------- */
    /* 4x4 상품 그리드 스타일 */
    /* ---------------------------------------------------- */
    .book-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 24px 20px;
        padding: 10px 0 20px 0;
    }

    .book-card {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        border: none;
        border-radius: 8px;
        padding: 0 0 15px 0; /* 좌우 padding을 제거하여 세로 라인 정렬 맞춤 */
        background-color: #fff;
        box-sizing: border-box;
    }

    /* 1:1 비율 정방형 이미지 박스 */
    .book-img-wrapper {
        width: 100%;
        aspect-ratio: 1 / 1; /* 1:1 비율 지정 */
        overflow: hidden;
        border-radius: 4px;
        margin-bottom: 12px;
        cursor: pointer;
    }

    .book-img-wrapper img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: filter 0.3s ease, opacity 0.3s ease;
    }

    .book-img-wrapper:hover img {
        filter: blur(3px);
        opacity: 0.85;
    }

    .book-info {
        text-align: left;
        width: 100%;
    }

    .book-title {
        font-size: 0.97rem;
        font-weight: 750;
        color: #000;
        margin-bottom: 6px;
        line-height: 1.4;
        word-break: break-word;
        cursor: pointer; /* 제목 클릭 가능 표시 */
    }

    .book-title:hover {
        text-decoration: underline;
    }

    .book-price {
        font-size: 0.92rem;
        font-weight: 500;
        color: #000;
        cursor: default;
    }

    /* ---------------------------------------------------- */
    /* 페이징 스타일 */
    /* ---------------------------------------------------- */
    .pagination-container {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 6px;
        margin-top: 30px;
        margin-bottom: 20px;
        font-size: 1rem;
    }

    .pagination-container a, 
    .pagination-container span {
        text-decoration: none;
        color: #333;
        padding: 0 4px;
    }

    .pagination-container a:hover {
        color: #000;
        font-weight: bold;
    }

    .pagination-container .active {
        font-weight: bold;
        color: red;
        font-size: 1.05rem;
    }

    .pagination-container .nav-btn {
        display: inline-flex;
        justify-content: center;
        align-items: center;
        width: 30px;
        height: 30px;
        border-radius: 50%;
        border: 1px solid #ddd;
        background-color: #fff;
        color: #555;
        transition: all 0.2s ease;
        margin: 0 4px;
        padding: 0;
    }

    .pagination-container .nav-btn svg {
        width: 14px;
        height: 14px;
        fill: currentColor;
    }

    .pagination-container .nav-btn:hover {
        border-color: #212529;
        color: #212529;
        background-color: #f8f9fa;
    }
</style>
</head>
<body>
	<%@ include file="header.jsp" %>

	<main class="main-content">
	    <!-- 상단 헤더 영역 -->
	    <div class="header-section">
	        <div class="title-area">
	            <h2 class="page-title">전체도서</h2>	           
	        </div>
	    </div>

	    <!-- DB 전체 도서 개수 표시 -->
	    <div class="count-section">
	        전체 <strong>${not empty totalCount ? totalCount : 0}개</strong>
	    </div>

	    <!-- 도서 목록 (4x4 그리드) -->
	    <div class="book-grid">
	        <c:forEach var="book" items="${books}">
	            <div class="book-card">
	                <div class="book-img-wrapper" onclick="location.href='/guest/bookDetail?bno=${book.bno}'">
	                    <img src="${book.bimg}" alt="${book.bname}">
	                </div>
	                <div class="book-info">
	                    <div class="book-title" onclick="location.href='/guest/bookDetail?bno=${book.bno}'">${book.bname}</div>
	                    <div class="book-price">${book.bprice}원</div>
	                </div>
	            </div>
	        </c:forEach>
	    </div>
	    
	    <!-- 페이징 영역 -->
	    <div class="pagination-container">
	        <%-- 이전 페이지 버튼 (<) --%>
	        <c:if test="${startPage > 1}">
	            <a href="/guest/allBookList?pageNum=${startPage - 1}" class="nav-btn" aria-label="이전 페이지">
	                <svg viewBox="0 0 24 24"><path d="M15.41 7.41L14 6l-6 6 6 6 1.41-1.41L10.83 12z"/></svg>
	            </a>
	        </c:if>

	        <%-- 페이지 번호 목록 --%>
	        <c:forEach begin="${startPage}" end="${endPage}" var="num">
	            <c:choose>
	                <c:when test="${pageNum == num}">
	                    <span class="active">${num}</span>
	                </c:when>
	                <c:otherwise>
	                    <a href="/guest/allBookList?pageNum=${num}">${num}</a>
	                </c:otherwise>
	            </c:choose>
	        </c:forEach>

	        <%-- 다음 페이지 버튼 (>) --%>
	        <c:if test="${endPage < totalPages}">
	            <a href="/guest/allBookList?pageNum=${endPage + 1}" class="nav-btn" aria-label="다음 페이지">
	                <svg viewBox="0 0 24 24"><path d="M10 6L8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6z"/></svg>
	            </a>
	        </c:if>
	    </div>
	</main>

	<%@ include file="footer.jsp" %>
</body>
</html>