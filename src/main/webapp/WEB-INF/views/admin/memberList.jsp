<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 전체 회원 관리</title>
<link rel="stylesheet" href="/css/adminList.css">
</head>
<body>

    <%@ include file="../guest/header.jsp" %>

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

    <%@ include file="../guest/footer.jsp" %>

</body>
</html>