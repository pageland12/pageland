<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 구독권</title>
<style>
    /* 공통 레이아웃 */
    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
    }
    
    body {
        display: flex;
        flex-direction: column;
        font-family: 'Pretendard', sans-serif;
    }
    
    .main-content {
        flex: 1;
        width: 100%;
        max-width: 1200px;
        margin: 0 auto;
        padding: 100px 20px 20px 20px;
        box-sizing: border-box;
    }

    /* 헤더 및 타이틀 */
    .header-section {
        text-align: center;
        margin-bottom: 35px;
    }
    
    .title-area {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 8px;
        margin-bottom: 25px;
    }
    
    .page-title {
        font-size: 1.6rem;
        font-weight: 800;
        margin: 0;
        color: #000;
    }

    /* 4x4 구독권 그리드 스타일 */
    .count-section {
        font-size: 0.95rem;
        color: #666;
        margin-bottom: 15px;
    }
    
    .count-section strong {
        color: #000;
        font-weight: 800;
    }
    
    .book-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 24px 20px;
        padding: 10px 0 20px 0;
    }
    
    .book-card {
        display: flex;
        flex-direction: column;
        cursor: pointer;
    }
    
    .book-img-wrapper {
        width: 100%;
        aspect-ratio: 1 / 1;
        overflow: hidden;
        border-radius: 4px;
        margin-bottom: 12px;
    }
    
    .book-img-wrapper img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: 0.3s;
    }
    
    .book-img-wrapper:hover img {
        filter: blur(3px);
        opacity: 0.85;
    }
    
    .book-title {
        font-size: 0.97rem;
        font-weight: 750;
        color: #000;
        margin-bottom: 4px;
        line-height: 1.4;
    }

    .pass-desc {
        font-size: 0.85rem;
        color: #666;
        margin-bottom: 6px;
    }
    
    .book-price {
        font-size: 0.92rem;
        color: #000;
        font-weight: 700;
    }

    /* 페이징 */
    .pagination-container {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 6px;
        margin-top: 30px;
        margin-bottom: 20px;
    }
    
    .nav-btn {
        display: flex;
        justify-content: center;
        align-items: center;
        width: 30px;
        height: 30px;
        border-radius: 50%;
        border: 1px solid #ddd;
        background: #fff;
        text-decoration: none;
    }
    
    .pagination-container a:not(.nav-btn) {
        text-decoration: none;
        color: #333;
        margin: 0 5px;
        font-size: 0.95rem;
    }
    
    .pagination-container .active {
        font-weight: bold;
        color: red !important;
        font-size: 1.05rem;
    }
</style>
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
                    <div class="pass-desc">
                        <c:choose>
                            <c:when test="${not empty pass.pperiod}">
                                ${pass.pperiod}일 무제한 이용
                            </c:when>
                            <c:when test="${not empty pass.pcount}">
                                총 ${pass.pcount}회 대여
                            </c:when>
                        </c:choose>
                    </div>
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