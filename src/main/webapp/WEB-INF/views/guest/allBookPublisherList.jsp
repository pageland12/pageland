<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출판사별 도서</title>
<link rel="stylesheet" href="/css/guestBookList.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <main class="main-content">
        <!-- 상단 헤더 및 출판사 버튼 -->
        <div class="header-section">
            <div class="title-area">
                <h2 class="page-title">출판사별</h2>
            </div>

            <div class="category-container">
                <c:set var="publishers" value="전체,그레이트북스,아람북스,키즈스콜레,프뢰벨" />
                <c:forTokens items="${publishers}" delims="," var="p">
                    <a href="/guest/allBookPublisherList?publisher=${p}" 
                       class="category-btn ${selectedPublisher == p || (empty selectedPublisher && p == '전체') ? 'active' : ''}">
                       ${p}
                    </a>
                </c:forTokens>
            </div>
        </div>

        <!-- 도서 총 개수 -->
        <div class="count-section">
            전체 <strong>${not empty totalCount ? totalCount : 0}개</strong>
        </div>

        <!-- 도서 목록 4x4 그리드 -->
        <div class="book-grid">
            <c:forEach var="book" items="${books}">
                <div class="book-card" onclick="location.href='/guest/bookDetail?bno=${book.bno}'">
                    <div class="book-img-wrapper">
                        <img src="${book.bimg}" alt="${book.bname}">
                    </div>
                    <div class="book-title">${book.bname}</div>
                    <div class="book-price">${book.bprice}원</div>
                </div>
            </c:forEach>
        </div>
        
        <!-- 페이징 영역 -->
        <div class="pagination-container">
            <c:if test="${startPage > 1}">
                <a href="/guest/allBookPublisherList?publisher=${selectedPublisher}&pageNum=${startPage - 1}" class="nav-btn">
                    <svg width="14" height="14" viewBox="0 0 24 24"><path d="M15.41 7.41L14 6l-6 6 6 6 1.41-1.41L10.83 12z"/></svg>
                </a>
            </c:if>
            
            <c:forEach begin="${startPage}" end="${endPage}" var="num">
                <a href="/guest/allBookPublisherList?publisher=${selectedPublisher}&pageNum=${num}" 
                   class="${pageNum == num ? 'active' : ''}">
                   ${num}
                </a>
            </c:forEach>
            
            <c:if test="${endPage < totalPages}">
                <a href="/guest/allBookPublisherList?publisher=${selectedPublisher}&pageNum=${endPage + 1}" class="nav-btn">
                    <svg width="14" height="14" viewBox="0 0 24 24"><path d="M10 6L8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6z"/></svg>
                </a>
            </c:if>
        </div>
    </main>
    
    <%@ include file="footer.jsp" %>
</body>
</html>