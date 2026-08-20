<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 구독권</title>
<link rel="stylesheet" href="/css/guestPassList.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <main class="main-content">
        <!-- 상단 헤더 영역 -->
        <div class="header-section">
            <div class="title-area">
                <h2 class="page-title">구독권 서비스</h2>
            </div>
        </div>

        <!-- 구독권 총 개수 -->
        <div class="count-section">
            전체 <strong>${not empty totalCount ? totalCount : 0}개</strong>
        </div>

        <!-- 구독권 목록 4x4 그리드 -->
        <div class="book-grid">
            <c:forEach var="pass" items="${passes}">
                <div class="book-card" onclick="location.href='/guest/passDetail?pno=${pass.pno}'">
                    <div class="book-img-wrapper">
                        <img src="${pass.pimg}" alt="${pass.pname}">
                    </div>
                    <div class="book-title">${pass.pname}</div>
                    <div class="book-price"><fmt:formatNumber value="${pass.pprice}" type="number"/>원</div>
                </div>
            </c:forEach>
        </div>
        
        <!-- 페이징 영역 -->
        <div class="pagination-container">
            <c:if test="${startPage > 1}">
                <a href="/guest/allPassList?pageNum=${startPage - 1}" class="nav-btn">
                    <svg width="14" height="14" viewBox="0 0 24 24"><path d="M15.41 7.41L14 6l-6 6 6 6 1.41-1.41L10.83 12z"/></svg>
                </a>
            </c:if>
            
            <c:forEach begin="${startPage}" end="${endPage}" var="num">
                <a href="/guest/allPassList?pageNum=${num}" 
                   class="${pageNum == num ? 'active' : ''}">
                   ${num}
                </a>
            </c:forEach>
            
            <c:if test="${endPage < totalPages}">
                <a href="/guest/allPassList?pageNum=${endPage + 1}" class="nav-btn">
                    <svg width="14" height="14" viewBox="0 0 24 24"><path d="M10 6L8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6z"/></svg>
                </a>
            </c:if>
        </div>
    </main>
    
    <%@ include file="footer.jsp" %>
</body>
</html>