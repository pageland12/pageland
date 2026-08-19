<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 도서 관리</title>
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
        background-color: #ffffff;
        color: #333333;
        font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
    }
    
    .main-content {
        flex: 1;
        width: 100%;
        max-width: 1200px;
        margin: 0 auto;
        padding: 100px 20px 40px 20px;
        box-sizing: border-box;
    }

    /* 페이지 타이틀 */
    .page-title {
        text-align: center;
        font-size: 1.6rem;
        font-weight: 800;
        color: #000;
        margin-bottom: 35px;
    }

    /* 상단 전체 개수 영역 */
    .top-info-area {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
    }

    .count-text {
        font-size: 0.95rem;
        color: #666666;
    }
    .count-text strong {
        color: #000;
        font-weight: 800;
    }

    /* 관리자 테이블 디자인 */
    .admin-table {
        width: 100%;
        border-collapse: collapse;
        font-size: 0.95rem;
    }
    .admin-table th {
        background-color: #f8f9fa;
        color: #111111;
        font-weight: 700;
        padding: 16px 10px;
        border-top: 1px solid #dee2e6;
        border-bottom: 1px solid #dee2e6;
        text-align: center;
    }
    .admin-table td {
        padding: 14px 10px;
        border-bottom: 1px solid #eee;
        color: #555555;
        text-align: center;
        vertical-align: middle;
    }

    .admin-table tr {
        transition: background-color 0.15s ease;
    }
    .admin-table tr:hover {
        background-color: #fcfcfc;
    }

    .title-td {
        text-align: left !important;
        color: #111111 !important;
    }

    /* 도서명 클릭 스타일 */
    .clickable-title {
        cursor: pointer;
        font-weight: 700;
        color: #000;
    }
    .clickable-title:hover {
        text-decoration: underline;
    }

    .book-thumb {
        width: 60px;
        height: 60px;
        object-fit: cover;
        border-radius: 4px;
        border: 1px solid #ddd;
        cursor: pointer;
    }

    /* 하단 버튼 영역 (오른쪽 아래 배치) */
    .bottom-btn-area {
        display: flex;
        justify-content: flex-end;
        margin-top: 20px;
    }

    /* 도서 등록 버튼 (사각형 디자인 적용) */
    .btn-write {
        display: inline-flex;
        justify-content: center;
        align-items: center;
        background-color: #212529;
        color: #ffffff;
        padding: 9px 24px;
        border-radius: 4px; /* 사각형 형태로 변경 */
        text-decoration: none;
        font-size: 0.92rem;
        font-weight: 600;
        transition: background-color 0.2s;
    }
    .btn-write:hover {
        background-color: #444444;
    }

    /* 페이징 스타일 */
    .pagination-container {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 6px;
        margin-top: 10px;
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

    <div class="main-content">
        <div class="page-title">등록 도서 관리</div>

        <!-- 상단 전체 개수 표시 영역 -->
        <div class="top-info-area">
            <div class="count-text">
                전체 도서: <strong>${not empty totalCount ? totalCount : 0}개</strong>
            </div>
        </div>

        <!-- 도서 목록 테이블 -->
        <table class="admin-table">
            <thead>
                <tr>
                    <th style="width: 10%;">번호</th>
                    <th style="width: 12%;">이미지</th>
                    <th style="width: 44%;">도서명</th>
                    <th style="width: 14%;">가격</th>
                    <th style="width: 10%;">재고</th>
                    <th style="width: 10%;">좋아요</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="book" items="${books}">
                    <tr>
                        <td>${book.bno}</td>
                        <td>
                            <img src="${book.bimg}" alt="${book.bname}" class="book-thumb" onclick="location.href='/admin/bookDetail?bno=${book.bno}'">
                        </td>
                        <td class="title-td">
                            <span class="clickable-title" onclick="location.href='/admin/bookDetail?bno=${book.bno}'">${book.bname}</span>
                        </td>
                        <td><fmt:formatNumber value="${book.bprice}" type="number"/>원</td>
                        <td>${book.bstock}권</td>
                        <td>${book.blike}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- 하단 우측 도서 등록 버튼 영역 -->
        <div class="bottom-btn-area">
            <a href="/admin/bookWriteForm" class="btn-write">도서 등록</a>
        </div>

        <!-- 페이징 영역 -->
        <div class="pagination-container">
            <%-- 이전 페이지 버튼 (<) --%>
            <c:if test="${startPage > 1}">
                <a href="/admin/bookList?pageNum=${startPage - 1}" class="nav-btn" aria-label="이전 페이지">
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
                        <a href="/admin/bookList?pageNum=${num}">${num}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <%-- 다음 페이지 버튼 (>) --%>
            <c:if test="${endPage < totalPages}">
                <a href="/admin/bookList?pageNum=${endPage + 1}" class="nav-btn" aria-label="다음 페이지">
                    <svg viewBox="0 0 24 24"><path d="M10 6L8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6z"/></svg>
                </a>
            </c:if>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

</body>
</html>