<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 도서</title>
<link rel="stylesheet" href="/css/guestBookList.css">
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