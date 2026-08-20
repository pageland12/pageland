<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 도서 관리</title>
<link rel="stylesheet" href="/css/adminList.css">
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