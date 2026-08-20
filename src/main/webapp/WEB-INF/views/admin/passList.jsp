<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 등록 구독권 관리</title>
<link rel="stylesheet" href="/css/adminList.css">
</head>
<body>

    <%@ include file="../guest/header.jsp" %>

    <div class="main-content">
        <div class="page-title">등록 구독권 관리</div>

        <!-- 상단 전체 개수 표시 영역 -->
        <div class="top-info-area">
            <div class="count-text">
                전체 구독권: <strong>${not empty totalCount ? totalCount : 0}개</strong>
            </div>
        </div>

        <!-- 구독권 목록 테이블 -->
        <table class="admin-table">
            <thead>
                <tr>
                    <th style="width: 15%;">번호</th>
                    <th style="width: 20%;">구독권 이미지</th>
                    <th style="width: 45%;">구독권 이름</th>
                    <th style="width: 20%;">가격</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="pass" items="${pass}">
                    <tr>
                        <td>${pass.pno}</td>
                        <td>
                            <img src="${pass.pimg}" alt="구독권 이미지" class="pass-thumb" onclick="location.href='/admin/passDetail?pno=${pass.pno}'">
                        </td>
                        <td class="title-td">
                            <span class="clickable-title" onclick="location.href='/admin/passDetail?pno=${pass.pno}'">${pass.pname}</span>
                        </td>
                        <td><fmt:formatNumber value="${pass.pprice}" type="number"/>원</td>
                    </tr>			
                </c:forEach>
            </tbody>
        </table>

        <!-- 하단 우측 구독권 등록 버튼 영역 -->
        <div class="bottom-btn-area">
            <a href="/admin/passWriteForm" class="btn-write">구독권 등록</a>
        </div>
    </div>

    <%@ include file="../guest/footer.jsp" %>

</body>
</html>