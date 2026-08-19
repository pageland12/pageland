<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 전체 회원 관리</title>
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

    /* 상단 컨트롤 영역 (전체 개수 표시) */
    .admin-btn-area {
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
        text-align: center !important;
        color: #111111 !important;
    }

    /* 이메일(회원명) 클릭 스타일 (굵직하게 강조 및 밑줄) */
    .clickable-title {
        cursor: pointer;
        font-weight: 700;
        color: #000;
        text-decoration: none;
        -webkit-font-smoothing: antialiased;
        text-shadow: 0.1px 0.1px 0px rgba(0, 0, 0, 0.4);
    }
    .clickable-title:hover {
        text-decoration: underline;
    }

    /* 페이징 컨테이너 감성 통일 */
    .pagination-container {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 6px;
        margin-top: 40px;
        margin-bottom: 20px;
    }
    
    .nav-btn {
        display: flex;
        justify-content: center;
        align-items: center;
        width: 32px;
        height: 32px;
        border-radius: 50%;
        border: 1px solid #ddd;
        background: #fff;
        text-decoration: none;
        color: #333;
        font-size: 0.9rem;
        transition: all 0.2s;
    }
    .nav-btn:hover {
        border-color: #999;
        color: #000;
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

    <div class="main-content">
        <div class="page-title">전체 회원 관리</div>

        <!-- 상단 컨트롤 영역 (전체 개수 표시) -->
        <div class="admin-btn-area">
            <div class="count-text">
                전체 회원: <strong>${not empty totalCount ? totalCount : 0}명</strong>
            </div>
        </div>

        <!-- 회원 목록 테이블 -->
        <table class="admin-table">
            <thead>
                <tr>
                    <th style="width: 15%;">회원번호</th>
                    <th style="width: 35%;">이메일</th>
                    <th style="width: 25%;">이름</th>
                    <th style="width: 25%;">연락처</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="list" items="${lists}">
                    <tr>
                        <td>${list.mno}</td>
                        <td class="title-td">
                            <a href="/admin/memberView?mno=${list.mno}" class="clickable-title">${list.memail}</a>
                        </td>
                        <td>${list.mname}</td>
                        <td>${list.mtel}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- 페이징 영역 -->
        <div class="pagination-container">
            <c:if test="${startPage > 1}">
                <a href="/admin/memberList?pageNum=${startPage - 1}" class="nav-btn">&lt;</a>
            </c:if>

            <c:forEach begin="${startPage}" end="${endPage}" var="num">
                <c:choose>
                    <c:when test="${pageNum == num}">
                        <span class="active">${num}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="/admin/memberList?pageNum=${num}">${num}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${endPage < totalPages}">
                <a href="/admin/memberList?pageNum=${endPage + 1}" class="nav-btn">&gt;</a>
            </c:if>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

</body>
</html>