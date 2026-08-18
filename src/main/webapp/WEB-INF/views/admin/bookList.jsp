<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 도서 관리</title>
<style>
    /* 테이블 기본 스타일 등 필요시 추가 */
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
    }
</style>
</head>
<body>

    <!-- 상단 이동 링크 -->
    <div style="text-align: right; margin-bottom: 10px;">
        <a href="/" style="text-decoration: none; color: #555; font-size: 14px;">🏠 홈으로 이동</a>
    </div>

    <!-- 헤더 타이틀 -->
    <h2>등록 도서 관리</h2>

    <hr>

    <!-- 관리자 도서 목록 테이블 -->
    <table>
        <thead>
            <tr>
                <th>이미지</th>
                <th>도서명</th>
                <th>가격</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="book" items="${books}">
                <tr onclick="location.href='/admin/bookDetail?bno=${book.bno}'" style="cursor:pointer;">
                    <td><img src="${book.bimg}" width="80" height="80"></td>
                    <td>${book.bname}</td>
                    <td>${book.bprice}원</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- 관리자 페이지 번호 이동 영역 (최대 5개씩 표시) -->
    <div style="text-align: center; margin-top: 20px;">
        
        <%-- [이전] 버튼 --%>
        <c:if test="${startPage > 1}">
            <a href="/admin/bookList?pageNum=${startPage - 1}" style="margin-right: 5px; text-decoration: none; color: black;">[이전]</a>
        </c:if>

        <%-- 페이지 번호 (5개 단위) --%>
        <c:forEach begin="${startPage}" end="${endPage}" var="num">
            <c:choose>
                <c:when test="${pageNum == num}">
                    <span style="font-weight: bold; color: red; margin: 0 5px; font-size: 16px;">${num}</span>
                </c:when>
                <c:otherwise>
                    <a href="/admin/bookList?pageNum=${num}" style="margin: 0 5px; text-decoration: none; color: black;">${num}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <%-- [다음] 버튼 --%>
        <c:if test="${endPage < totalPages}">
            <a href="/admin/bookList?pageNum=${endPage + 1}" style="margin-left: 5px; text-decoration: none; color: black;">[다음]</a>
        </c:if>

    </div>

</body>
</html>