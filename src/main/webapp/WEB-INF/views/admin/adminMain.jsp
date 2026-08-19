<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 메인페이지</title>
<style>
    /* 공통 레이아웃 구조 */
    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
    }
    
    body {
        display: flex;
        flex-direction: column;
        background-color: #ffffff;
        font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
    }
    
    /* 본문 영역 */
    .main-content {
        flex: 1;
        width: 100%;
        max-width: 1200px;
        margin: 0 auto;
        padding: 100px 20px 40px 20px;
        box-sizing: border-box;
    }

    /* 상단 타이틀 스타일 */
    .page-title {
        text-align: center;
        font-size: 1.7rem;
        font-weight: 900;
        color: #111;
        letter-spacing: -1px;
        margin-bottom: 40px;
    }

    /* 패널 박스: 테이블 테두리 및 배경톤(#f8f9fa) 적용 */
    .admin-panel {
        background-color: #f8f9fa;
        border: 1px solid #dee2e6;
        border-radius: 6px;
        padding: 60px 50px; /* 웅장한 세로 폭 유지 */
        width: 100%;
        max-width: 1050px;
        margin: 0 auto;
        box-sizing: border-box;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);
    }

    /* 3개씩 2줄 대칭형 그리드 시스템 */
    .admin-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 25px;
    }

    /* 각 링크 박스 디자인 */
    .admin-grid a {
        text-decoration: none;
    }

    /* 링크 카드: 순백색 배경으로 깔끔하게 대비 */
    .admin-card {
        background-color: #ffffff;
        border: 1px solid #ced4da;
        border-radius: 4px;
        height: 140px; /* 묵직한 높이 유지 */
        display: flex;
        justify-content: center;
        align-items: center;
        text-align: center;
        font-size: 1.15rem;
        font-weight: 800;
        color: #111111;
        transition: all 0.2s ease-in-out;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.02);
    }

    /* 마우스 오버 시 시크하게 반전 */
    .admin-card:hover {
        background-color: #111111;
        color: #ffffff;
        border-color: #111111;
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
    }
</style>
</head>
<body>

    <!-- 상단 헤더 포함 -->
    <%@ include file="header.jsp" %>

    <!-- 본문 영역 -->
    <main class="main-content">
        
        <div class="page-title">시스템 관리자 컨트롤 패널</div>

        <div class="admin-panel">
            <!-- 대칭형 3x2 그리드 영역 -->
            <div class="admin-grid">
                
                <a href="/admin/bookWriteForm">
                    <div class="admin-card">신규 도서 등록</div>
                </a>                
                
                <a href="/admin/passWriteForm">
                    <div class="admin-card">신규 구독권 등록</div>
                </a>                
                
                <a href="/admin/memberList">
                    <div class="admin-card">전체 회원 관리</div>
                </a>
                
                <a href="/admin/bookList">
                    <div class="admin-card">등록 도서 관리</div>
                </a>
                 
                <a href="/admin/passList">
                    <div class="admin-card">등록 구독권 관리</div>
                </a>                 
                                
                <a href="/main">
                    <div class="admin-card">메인 홈</div>
                </a>
                
            </div>
        </div>
        
    </main>

    <!-- 하단 푸터 포함 -->
    <%@ include file="footer.jsp" %>

</body>
</html>