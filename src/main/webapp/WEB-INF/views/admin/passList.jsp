<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 등록 구독권 관리</title>
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
        text-align: center !important;
        color: #111111 !important;
    }

    /* 구독권명 클릭 스타일 (굵직하게 강조 및 밑줄) */
    .clickable-title {
        cursor: pointer;
        font-weight: 700;
        color: #000;
        -webkit-font-smoothing: antialiased;
        text-shadow: 0.1px 0.1px 0px rgba(0, 0, 0, 0.4);
    }
    .clickable-title:hover {
        text-decoration: underline;
    }

    .pass-thumb {
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

    /* 구독권 등록 버튼 (사각형 디자인 적용) */
    .btn-write {
        display: inline-flex;
        justify-content: center;
        align-items: center;
        background-color: #212529;
        color: #ffffff;
        padding: 9px 24px;
        border-radius: 4px; /* 각진 사각형 모서리 */
        text-decoration: none;
        font-size: 0.92rem;
        font-weight: 600;
        transition: background-color 0.2s;
    }
    .btn-write:hover {
        background-color: #444444;
    }
</style>
</head>
<body>

    <%@ include file="header.jsp" %>

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

    <%@ include file="footer.jsp" %>

</body>
</html>